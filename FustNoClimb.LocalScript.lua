--!native
-- Path: FustNoClimb.LocalScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v_u_3 = v1.LocalPlayer
local v_u_4 = nil
task.spawn(function()
	-- upvalues: (ref) v_u_4
	local function v7()
		-- upvalues: (ref) v_u_4
		local v5 = game:GetService("ReplicatedStorage"):WaitForChild("Fust"):WaitForChild("Features", 30)
		if v5 then
			v5 = require(v5)
		end
		if type(v5) == "table" then
			local v6 = v5.Saturday2
			if type(v6) == "function" then
				v_u_4 = v5
			end
		end
	end
	pcall(v7)
end)
local v_u_8 = OverlapParams.new()
v_u_8.FilterType = Enum.RaycastFilterType.Exclude
v_u_8.MaxParts = 40
local v_u_9 = {
	["hum"] = nil,
	["root"] = nil,
	["enabled"] = nil,
	["acc"] = 0
}
local function v_u_12(p_u_10) -- name: setClimb
	-- upvalues: (copy) v_u_9
	local v_u_11 = v_u_9.hum
	if v_u_11 and v_u_9.enabled ~= p_u_10 then
		v_u_9.enabled = p_u_10
		pcall(function()
			-- upvalues: (copy) v_u_11, (copy) p_u_10
			v_u_11:SetStateEnabled(Enum.HumanoidStateType.Climbing, p_u_10)
		end)
		if not p_u_10 and v_u_11:GetState() == Enum.HumanoidStateType.Climbing then
			pcall(function()
				-- upvalues: (copy) v_u_11
				v_u_11:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
	end
end
local function v_u_18(p_u_13) -- name: nearLadder
	-- upvalues: (ref) v_u_4, (copy) v_u_8
	if not v_u_4 or v_u_4.Saturday2() ~= true then
		return true
	end
	local function v14()
		-- upvalues: (copy) p_u_13, (ref) v_u_8
		return workspace:GetPartBoundsInRadius(p_u_13.Position, 4.5, v_u_8)
	end
	local v15, v16 = pcall(v14)
	if not v15 then
		return true
	end
	for _, v17 in ipairs(v16) do
		if not v17:IsA("TrussPart") then
			continue
		end
		return true
	end
	return false
end
local function v25(p19) -- name: onCharacter
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_8, (copy) v_u_12, (copy) v_u_18
	local v20 = v_u_9
	local v21 = v_u_9
	v_u_9.hum = nil
	v20.root = nil
	v21.enabled = nil
	local v22 = p19:WaitForChild("Humanoid", 15)
	local v23 = p19:WaitForChild("HumanoidRootPart", 15)
	if v22 and (v22:IsA("Humanoid") and (v23 and v23:IsA("BasePart"))) then
		if v_u_3.Character == p19 then
			v_u_8.FilterDescendantsInstances = { p19 }
			local v24 = v_u_9
			v_u_9.hum = v22
			v24.root = v23
			v_u_12((v_u_18(v23)))
		end
	else
		return
	end
end
v2.Heartbeat:Connect(function(p26)
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_18
	local v27 = v_u_9
	v27.acc = v27.acc + p26
	if v_u_9.acc >= 0.2 then
		v_u_9.acc = 0
		local v28 = v_u_9.root
		if v28 and (v28.Parent and (v_u_9.hum and v_u_9.hum.Parent)) then
			v_u_12((v_u_18(v28)))
		end
	end
end)
v_u_3.CharacterAdded:Connect(v25)
if v_u_3.Character then
	task.spawn(v25, v_u_3.Character)
end
