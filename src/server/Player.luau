local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local Player = {}

local characterCollisions = false

if characterCollisions == false then
	PhysicsService:RegisterCollisionGroup("Player")
	PhysicsService:CollisionGroupSetCollidable("Player", "Player", false)
end

local attsToAdd = {
	-- ["Playtime"] = 0, -- can be used to track playtime
}

local function AddAttributes(player: Player)
	for attName, value in attsToAdd do
		player:SetAttribute(attName, value)
	end
end

local function CharacterCollisions(player: Player)
	player.CharacterAdded:Connect(function(newCharacter)
		player.CharacterAppearanceLoaded:Wait() -- wait until all parts loaded...
		for i, part: BasePart | MeshPart in newCharacter:GetDescendants() do
			if part:IsA("BasePart") or part:IsA("MeshPart") then
				part.CollisionGroup = "Player"
			end
		end
	end)
end

local function PlayerAdded(player: Player)
	task.spawn(AddAttributes, player)
	if not characterCollisions then
		task.spawn(CharacterCollisions, player)
	end
end

function Player.Init()
	for _, player in Players:GetPlayers() do
		task.spawn(PlayerAdded, player)
	end
	Players.PlayerAdded:Connect(PlayerAdded)
end

return Player
