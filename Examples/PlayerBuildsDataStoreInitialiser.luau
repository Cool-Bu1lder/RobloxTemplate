--* Script has a long name but that is literally what it does
-- Used Player Data Example From https://devforum.roblox.com/t/suphis-datastore-module/2425597

local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local DataStoreModule = require(ServerScriptService.Packages.Datastore)

local DefaultSlotTemplate = {}

local BuildSlots = 5

-- add build slots to template
for i = 1, BuildSlots do
	local Slot = { Name = "Slot" .. i }
	table.insert(DefaultSlotTemplate, Slot)
end

local function StateChanged(state, datastore)
	while datastore.State == false do -- Keep trying to re-open if the state is closed
		if datastore:Open(DefaultSlotTemplate) ~= "Success" then
			task.wait(6)
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	local buildsDataStore = DataStoreModule.new("Builds", player.UserId)
	buildsDataStore.StateChanged:Connect(StateChanged)
	StateChanged(buildsDataStore.State, buildsDataStore)

	if RunService:IsStudio() == true then
		buildsDataStore.SaveInterval = 0
		buildsDataStore.SaveOnClose = false
	end
end)

Players.PlayerRemoving:Connect(function(player)
	local buildsDataStore = DataStoreModule.find("Builds", player.UserId)
	if buildsDataStore ~= nil then
		buildsDataStore:Destroy() -- If the player leaves datastore object is destroyed allowing the retry loop to stop
	end
end)
