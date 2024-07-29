local _PlayerBuildSlots = require(game:GetService("ServerScriptService").Components.PlayerBuildSlots)

local _DataStoreModule = require(game:GetService("ServerScriptService").Packages.Datastore)

--[=[
    @class PlayerBuildSlotsDOA

    Object that handle the CRUD operations
    for the PlayerBuildSlots class with the datastore.
]=]
local PlayerBuildSlotsDOA = {}

--[=[
    Adds a new set of player build slots to the datastore.

    @param BuildSlots -- The Builds Slots that you want to add which belong to a player
]=]
function PlayerBuildSlotsDOA.AddPlayerBuildSlots(BuildSlots: SharedTable)
	--local dataStore = DataStoreModule.find("Builds", tostring(player.UserId))
	print(BuildSlots)
end

--[=[
    Updates an existing set of player build slots in the datastore.

    @param BuildSlots -- The Builds Slots that you want to update.
]=]
function PlayerBuildSlotsDOA.UpdatePlayerBuildSlots(BuildSlots: SharedTable)
	print(BuildSlots)
end

--[=[
    Deletes an existing set of player build slots in the datastore.

    @param BuildSlots -- The Builds Slots that you want to delete.
]=]
function PlayerBuildSlotsDOA.DeletePlayerBuildSlots(BuildSlots: SharedTable)
	print(BuildSlots)
end

--[=[
    Retrieves a set of player build slots from the datastore.

    @param UserID -- The `UserID` of the BuildSlots you want to retrieve.
    @return {} -- returns a PlayerBuildSlots object that belongs to `UserID` 
]=]
function PlayerBuildSlotsDOA.GetPlayerBuildSlotsByUserID(UserID: number): {}
	print(UserID)
	return {}
end

return PlayerBuildSlotsDOA
