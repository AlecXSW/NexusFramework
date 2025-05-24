local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replica = require(ReplicatedStorage.Packages.Replica)

Replica.OnNew("PlayerData", function(replica)
	print(replica.Data)
end)
