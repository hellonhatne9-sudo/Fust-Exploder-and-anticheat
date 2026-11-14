--!native
-- Path: FustShieldGate.LocalScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v1 = { "FustAnimShield", "FustCharSync" }
local v2 = game:GetService("ReplicatedStorage"):WaitForChild("Fust", 60)
if v2 then
	local v3 = os.clock() + 120
	while v2:GetAttribute("ClientShield") == nil and os.clock() < v3 do
		task.wait(0.25)
	end
	if v2:GetAttribute("ClientShield") == true then
		for _, v4 in ipairs(v1) do
			local v5 = script.Parent:FindFirstChild(v4)
			if not v5 or (not v5:IsA("LocalScript") or v5.Enabled) then
				continue
			end
			v5.Enabled = true
		end
	end
else
	return
end
