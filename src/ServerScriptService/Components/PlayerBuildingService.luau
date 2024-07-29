local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BuildSystemEvents = ReplicatedStorage.Events.BuildSystem

local PlayerBuildingService = {}

function PlayerBuildingService.OnStart()
	local RequestData = BuildSystemEvents.RequestData
	local PlaceObject = BuildSystemEvents.PlaceObject
	local _RenameSlot = BuildSystemEvents.RenameSlot
	local _SaveSlot = BuildSystemEvents.SaveSlot
	local _LoadSlot = BuildSystemEvents.LoadSlot
	local _DestroyNode = BuildSystemEvents.DestroyNode

	RequestData.OnServerInvoke(function(_player) end)

	PlaceObject.OnServerInvoke(function(_player) end)
end

return PlayerBuildingService
