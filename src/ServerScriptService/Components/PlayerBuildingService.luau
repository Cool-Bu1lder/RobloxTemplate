local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BuildSystemEvents = ReplicatedStorage.Events.BuildSystem2

local PlayerBuildingService = {}

function PlayerBuildingService.OnStart()
	--[[local RequestData = BuildSystemEvents.RequestData
	local PlaceObject = BuildSystemEvents.PlaceObject
	local _RenameSlot = BuildSystemEvents.RenameSlot
	local _SaveSlot = BuildSystemEvents.SaveSlot
	local _LoadSlot = BuildSystemEvents.LoadSlot
	local _DestroyNode = BuildSystemEvents.DestroyNode

	RequestData.OnServerInvoke(function(_player) end)

	PlaceObject.OnServerInvoke(function(_player) end)]]

	-- Place Node [player, position] -- Node must not already exist
	-- client side to check if node already exists for message?

	-- Place Object [player, position, object] -- Node must exist, position must be valid, object must be valid

	-- Destroy Node [player] -- Node must already exist

	-- Rename Slot [player, slotIndex, name] -- Name must be valid

	-- Save Node To Slot [player, slotIndex] -- Node must already exist

	-- Load Node from slot [player, slotIndex] -- Node must already exist

	local PlaceNode = BuildSystemEvents.PlaceNode
	local PlaceObject = BuildSystemEvents.PlaceObject
	local DestroyNode = BuildSystemEvents.DestroyNode
	local RenameSlot = BuildSystemEvents.RenameSlot
	local SaveNodeToSlot = BuildSystemEvents.SaveNodeToSlot
	local LoadNodeFromSlot = BuildSystemEvents.LoadNodeFromSlot

	PlaceNode.OnServerInvoke(function(player: Player, position: Vector3)
		print(player)
		print(position)
	end)

	PlaceObject.OnServerInvoke(function(player: Player, position: Vector3, object: string)
		print(player)
		print(position)
		print(object)
	end)

	DestroyNode.OnServerInvoke(function(player: Player)
		print(player)
	end)
end

return PlayerBuildingService
