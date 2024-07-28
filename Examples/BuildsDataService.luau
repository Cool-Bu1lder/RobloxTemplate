--* Script has a long name but that is literally what it does
-- Used Player Data Example From https://devforum.roblox.com/t/suphis-datastore-module/2425597

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local DataStoreModule = require(ServerScriptService.Packages.Datastore)

local BuildsDataService = {
	DefaultSlotTemplate = {},
	_DevMode = RunService:IsStudio(),
}

function BuildsDataService.OnStart()
	local BuildSlots = 5

	-- add build slots to template
	for i = 1, BuildSlots do
		local Slot = { Name = "Slot" .. i }
		table.insert(BuildsDataService.DefaultSlotTemplate, Slot)
	end

	-- player join and leave event listeners
	Players.PlayerAdded:Connect(BuildsDataService._HandleCreate)
	Players.PlayerRemoving:Connect(BuildsDataService._HandleDestroy)
end

function BuildsDataService._HandleCreate(player)
	local buildsDataStore = DataStoreModule.new("Builds", player.UserId)
	buildsDataStore.StateChanged:Connect(BuildsDataService._StateChanged)
	BuildsDataService._StateChanged(buildsDataStore.State, buildsDataStore)

	if BuildsDataService._DevMode then -- disable auto save on leave
		buildsDataStore.SaveInterval = 0
		buildsDataStore.SaveOnClose = false
	end
end

function BuildsDataService._HandleDestroy(player)
	local buildsDataStore = DataStoreModule.find("Builds", player.UserId)
	if buildsDataStore ~= nil then
		buildsDataStore:Destroy() -- If the player leaves datastore object is destroyed allowing the retry loop to stop
	end
end

function BuildsDataService._StateChanged(state, datastore)
	while datastore.State == false do -- Keep trying to re-open if the state is closed
		if datastore:Open(BuildsDataService.DefaultSlotTemplate) ~= "Success" then
			task.wait(6)
		end
	end
end

return BuildsDataService
