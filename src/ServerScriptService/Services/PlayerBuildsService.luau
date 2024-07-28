--* Script has a long name but that is literally what it does
-- Used Player Data Example From https://devforum.roblox.com/t/suphis-datastore-module/2425597

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataStoreModule = require(ServerScriptService.Packages.Datastore)

local BuildsFolder = Workspace.Builds
local Props = ReplicatedStorage.Models.Props

local IsPartInside = require(ServerScriptService.Components.IsPartInside)

local BuildSystemEvents = ReplicatedStorage.Events.BuildSystem

local RequestData = BuildSystemEvents.RequestData
local PlaceObject = BuildSystemEvents.PlaceObject
local RenameSlot = BuildSystemEvents.RenameSlot
local SaveSlot = BuildSystemEvents.SaveSlot
local LoadSlot = BuildSystemEvents.LoadSlot
local DestroyNode = BuildSystemEvents.DestroyNode

local PlayerBuildsService = {
	DefaultSlotTemplate = {},
	_DevMode = RunService:IsStudio(),
	PlayerBuildsFolders = {},
	OwnedNodes = {},
}

function PlayerBuildsService.OnStart()
	local BuildSlots = 5

	-- add build slots to template
	for i = 1, BuildSlots do
		local Slot = { Name = "Slot" .. i }
		table.insert(PlayerBuildsService.DefaultSlotTemplate, Slot)
	end

	-- player join and leave event listeners
	Players.PlayerAdded:Connect(PlayerBuildsService._HandleCreate)
	Players.PlayerRemoving:Connect(PlayerBuildsService._HandleDestroy)

	RequestData.OnServerInvoke(PlayerBuildsService.GetAllSlotData)
	RenameSlot.OnServerInvoke(PlayerBuildsService.RenameSlot)
	PlaceObject.OnServerInvoke(PlayerBuildsService.PlaceObject)
	SaveSlot.OnServerInvoke(PlayerBuildsService.SaveSlot)
	LoadSlot.OnServerInvoke(PlayerBuildsService.LoadSlot)
	DestroyNode.OnServerInvoke(PlayerBuildsService.DestroyNode)
end

-- TODO: BuildsDOA:Save() ? PlayerBuildDOAs[player] [PlayerBuild Object?]
function PlayerBuildsService.GetAllSlotData(player: Player): SharedTable
	local dataStore = DataStoreModule.find("Builds", tostring(player.UserId))
	return dataStore.Value
end

function PlayerBuildsService.RenameSlot(player: Player, slotIndex: number, newName: string): boolean
	local dataStore = DataStoreModule.find("Builds", tostring(player.UserId))
	if not (slotIndex and newName and dataStore) then
		return false
	end

	local dataSlot = dataStore.Value[slotIndex]
	if not dataSlot then
		return false
	end

	dataSlot.Name = newName
	dataStore:Save()

	return true
end

function PlayerBuildsService.PlaceObject(player: Player, propId: string, cFrame: CFrame): boolean
	if not propId then
		warn("PropId is nil")
		return false
	end
	if not cFrame then
		warn("CFrame is nil")
		return false
	end

	local buildFolder = PlayerBuildsService.PlayerBuildsFolders[player.Name]
	if not buildFolder then
		warn("Player does not have a build folder")
		return false
	end

	local propReference = Props:FindFirstChild(propId)
	if not propReference then
		warn("Invalid propId")
		return false
	end

	if propId == "Node" then
		local currentNode = PlayerBuildsService.OwnedNodes[player.Name]
		if currentNode then
			return false, "You can only have one node."
		end

		local node = propReference:Clone()
		node:PivotTo(cFrame)

		local touchingParts = {}
		for _, touchingpart in ipairs(game.Workspace:GetPartsInPart(node)) do
			touchingParts[touchingpart.Name] = touchingpart
		end
		if touchingParts["Node"] then
			return false, "You can not build a node in another existing node."
		end

		node.Parent = buildFolder
		PlayerBuildsService.OwnedNodes[player.Name] = node
		return true, "NodeSuccessfully placed."
	else
		local parts = {}
		for _, part in ipairs(game.Workspace:GetPartBoundsInBox(cFrame, Vector3.new(1, 1, 1))) do
			parts[part.Name] = part
		end
		local node = parts["Node"]
		if not node then
			return false, "Must be Place inside a node"
		end

		-- validate build permissions temp broken
		if player.Name ~= node.Parent.Name then
			return false, "You are not permitted to build in this node."
		end

		local prop = propReference:Clone()
		prop:PivotTo(cFrame)

		if not IsPartInside(prop, node) then
			prop:Destroy()
			prop = nil
			return false, "Must be placed completely inside a node."
		end
		prop.Parent = buildFolder

		return true, "Part successfully played."
	end
end

function PlayerBuildsService.SaveSlot(player: Player, slotIndex: number)
	if not slotIndex then
		return false
	end

	local buildFolder = PlayerBuildsService.PlayerBuildsFolders[player.Name]
	if not buildFolder then
		warn("Player does not have a build folder")
		return false
	end

	local dataStore = DataStoreModule.find("Builds", tostring(player.UserId))
	if not dataStore then
		warn("Player data save data")
		return false
	end

	local playerNode = PlayerBuildsService.OwnedNodes[player.Name]
	if not playerNode then
		warn("Player does not have a node")
		return false, "There is no current Node"
	end

	local dataSlot = dataStore.Value[slotIndex]
	if not dataSlot then
		return false
	end

	local nodePivot = playerNode:GetPivot()
	local nodePosition = nodePivot.Position
	local eulerX, eulerY, eulerZ = nodePivot:ToEulerAngles()

	dataSlot.Node = {
		posX = nodePosition.X,
		posY = nodePosition.Y,
		posZ = nodePosition.Z,
		rotX = eulerX,
		rotY = eulerY,
		rotZ = eulerZ,
	}

	local newSave = {}

	for _, child in ipairs(buildFolder:GetChildren()) do
		if not (child:IsA("BasePart") or child:IsA("Model")) then
			continue
		end
		if child.Name == "Node" then
			continue
		end

		local childPivot = nodePivot:ToObjectSpace(child:GetPivot())
		local childPosition = childPivot.Position
		--! local eulerX, eulerY, eulerZ = childPivot:ToEulerAngles()

		local newprop = {
			id = child.Name,
			posX = childPosition.X,
			posY = childPosition.Y,
			posZ = childPosition.Z,
			rotX = eulerX,
			rotY = eulerY,
			rotZ = eulerZ,
		}

		table.insert(newSave, newprop)
	end

	dataSlot.Props = newSave

	dataStore:Save()

	return true, "Build Successfully Saved"
end

function PlayerBuildsService.LoadSlot(player, slotIndex: number, nodeCFrame: CFrame): boolean
	if not slotIndex then
		return false
	end

	local buildFolder = PlayerBuildsService.PlayerBuildsFolders[player.Name]
	if not buildFolder then
		warn("Player does not have a build folder")
		return false
	end

	local dataStore = DataStoreModule.find("Builds", tostring(player.UserId))
	if not dataStore then
		warn("Player data save data")
		return false
	end

	local playerNode = PlayerBuildsService.OwnedNodes[player.Name]
	if playerNode then
		return false, "Destroy your previous Node."
	end

	local dataSlot = dataStore.Value[slotIndex]
	if not dataSlot then
		return false
	end

	local nodeData = dataSlot.Node
	if not dataSlot.Node then
		return false, "Slot is Empty"
	end

	local propsData = dataSlot.Props
	if not propsData then
		return false
	end

	local node = Props:FindFirstChild("Node"):Clone()

	if not nodeCFrame then
		nodeCFrame = CFrame.new(nodeData.posX, nodeData.posY, nodeData.posZ)
			* CFrame.fromEulerAnglesXYZ(nodeData.rotX, nodeData.rotY, nodeData.rotZ)
	end

	node:PivotTo(nodeCFrame)

	local touchingParts = {}
	for _, touchingpart in ipairs(game.Workspace:GetPartsInPart(node)) do
		touchingParts[touchingpart.Name] = touchingpart
	end
	if touchingParts["Node"] then
		return false, "You can not build a node in another existing node."
	end

	node.Parent = buildFolder

	for _, propData in ipairs(propsData) do
		task.wait()

		local propReference = Props:FindFirstChild(propData.id)
		if not propReference then
			continue
		end

		local prop = propReference:Clone()

		local propCFrame = CFrame.new(propData.posX, propData.posY, propData.posZ)
			* CFrame.fromEulerAnglesXYZ(propData.rotX, propData.rotY, propData.rotZ)

		prop:PivotTo(nodeCFrame * propCFrame)
		prop.Parent = buildFolder
	end

	PlayerBuildsService.OwnedNodes[player.Name] = node

	return true, "Build Successfully Loaded"
end

function PlayerBuildsService.DestroyNode(player: Player): boolean
	local buildFolder = PlayerBuildsService.PlayerBuildsFolders[player.Name]
	if not buildFolder then
		warn("Player does not have a build folder")
		return false
	end

	local playerNode = PlayerBuildsService.OwnedNodes[player.Name]
	if not playerNode then
		warn("Player does not have a node")
		return false, "There is no current Node"
	end

	for _, child in pairs(buildFolder:GetChildren()) do
		task.wait()
		child:Destroy()
	end
	PlayerBuildsService.OwnedNodes[player.Name] = nil

	return true, "Build Successfully Destroyed"
end

function PlayerBuildsService._HandleCreate(player)
	local buildsDataStore = DataStoreModule.new("Builds", player.UserId)
	buildsDataStore.StateChanged:Connect(PlayerBuildsService._StateChanged)
	PlayerBuildsService._StateChanged(buildsDataStore.State, buildsDataStore)

	if PlayerBuildsService._DevMode then -- disable auto save on leave
		buildsDataStore.SaveInterval = 0
		buildsDataStore.SaveOnClose = false
	end

	local playerFolder = Instance.new("Folder", BuildsFolder)
	playerFolder.Name = player.Name
	PlayerBuildsService.PlayerBuildsFolders[player.Name] = playerFolder
end

function PlayerBuildsService._HandleDestroy(player)
	local buildsDataStore = DataStoreModule.find("Builds", player.UserId)
	if buildsDataStore ~= nil then
		buildsDataStore:Destroy() -- If the player leaves datastore object is destroyed allowing the retry loop to stop
	end

	local playerFolder = PlayerBuildsService.PlayerBuildsFolders[player.Name]
	playerFolder:Destroy()
	PlayerBuildsService.PlayerBuildsFolders[player.Name] = nil

	PlayerBuildsService.OwnedNodes[player.Name] = nil
end

function PlayerBuildsService._StateChanged(state, datastore)
	while datastore.State == false do -- Keep trying to re-open if the state is closed
		if datastore:Open(PlayerBuildsService.DefaultSlotTemplate) ~= "Success" then
			task.wait(6)
		end
	end
end

return PlayerBuildsService
