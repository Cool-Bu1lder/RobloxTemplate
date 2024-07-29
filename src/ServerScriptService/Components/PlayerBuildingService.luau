local ReplicatedStorage = game:GetService("ReplicatedStorage")

local _BuildSystemEvents = ReplicatedStorage.Events.BuildSystem

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
end

return PlayerBuildingService
