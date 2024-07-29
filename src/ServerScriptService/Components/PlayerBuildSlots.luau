local PlayerBuildSlots = {}
PlayerBuildSlots.__index = PlayerBuildSlots

function PlayerBuildSlots.new()
  local self = setmetatable({}, PlayerBuildSlots)

  return self
end

return PlayerBuildSlots
