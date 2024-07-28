local function getCorners(cf, size)
	local corners = {}
	local frontFaceCenter = (cf + cf.LookVector * size.Z / 2)
	local backFaceCenter = (cf - cf.LookVector * size.Z / 2)
	local topFrontEdgeCenter = frontFaceCenter + frontFaceCenter.UpVector * size.Y / 2
	local bottomFrontEdgeCenter = frontFaceCenter - frontFaceCenter.UpVector * size.Y / 2
	local topBackEdgeCenter = backFaceCenter + backFaceCenter.UpVector * size.Y / 2
	local bottomBackEdgeCenter = backFaceCenter - backFaceCenter.UpVector * size.Y / 2
	corners.topFrontRight = (topFrontEdgeCenter + topFrontEdgeCenter.RightVector * size.X / 2).Position
	corners.topFrontLeft = (topFrontEdgeCenter - topFrontEdgeCenter.RightVector * size.X / 2).Position
	corners.bottomFrontRight = (bottomFrontEdgeCenter + bottomFrontEdgeCenter.RightVector * size.X / 2).Position
	corners.bottomFrontLeft = (bottomFrontEdgeCenter - bottomFrontEdgeCenter.RightVector * size.X / 2).Position
	corners.topBackRight = (topBackEdgeCenter + topBackEdgeCenter.RightVector * size.X / 2).Position
	corners.topBackLeft = (topBackEdgeCenter - topBackEdgeCenter.RightVector * size.X / 2).Position
	corners.bottomBackRight = (bottomBackEdgeCenter + bottomBackEdgeCenter.RightVector * size.X / 2).Position
	corners.bottomBackLeft = (bottomBackEdgeCenter - bottomBackEdgeCenter.RightVector * size.X / 2).Position
	return corners
end

local function isInsideBrick(position, brick)
	local v3 = brick.CFrame:PointToObjectSpace(position)
	return (math.abs(v3.X) <= brick.Size.X / 2)
		and (math.abs(v3.Y) <= brick.Size.Y / 2)
		and (math.abs(v3.Z) <= brick.Size.Z / 2)
end

local function isPartInside(checkPart, wholeContainer)
	local corners
	if checkPart:IsA("Model") then
		corners = getCorners(checkPart:GetBoundingBox())
	else
		corners = getCorners(checkPart.CFrame, checkPart.Size)
	end
	for _, corner in pairs(corners) do
		if not isInsideBrick(corner, wholeContainer) then
			return false
		end
	end
	return true
end

return isPartInside
