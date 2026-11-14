--!native
-- Path: FustFpsProbe.LocalScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = {
	["MENUS"] = nil,
	["MEASURE"] = 3,
	["GAP"] = 120,
	["BUCKETS"] = 4,
	["WORLD_EVERY"] = 120,
	["WORLD_SKIP"] = 60,
	["WORLD_MIN"] = 30,
	["STALL"] = 0.08,
	["SLOW"] = 0.05,
	["STARTS_MAX"] = 600,
	["MENUS"] = {
		["FustInventory"] = "inv",
		["FustCrafting"] = "craft"
	}
}
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = {}
local v_u_8 = {
	["n"] = 0,
	["t"] = 0
}
local v_u_9 = nil
local v_u_10 = nil
local function v_u_11() -- name: newWorld
	return {
		["n"] = 0,
		["t"] = 0,
		["slow"] = 0,
		["stall"] = 0,
		["worst"] = 0,
		["starts"] = nil,
		["asleep"] = 0,
		["menu"] = 0,
		["starts"] = {}
	}
end
v3.RenderStepped:Connect(function(p12)
	-- upvalues: (ref) v_u_10, (copy) v_u_4, (ref) v_u_8, (copy) v_u_7, (ref) v_u_9
	local v13 = v_u_10
	if v13 then
		v13.n = v13.n + 1
		v13.t = v13.t + p12
		if v_u_4.SLOW <= p12 then
			v13.slow = v13.slow + 1
			if v_u_4.STALL <= p12 then
				v13.stall = v13.stall + 1
				if #v13.starts < v_u_4.STARTS_MAX then
					local v14 = v13.starts
					local v15 = os.clock
					table.insert(v14, v15())
				end
			end
			if v13.worst < p12 then
				v13.worst = p12
			end
		end
	end
	local v16 = v_u_8
	v16.n = v16.n + 1
	local v17 = v_u_8
	v17.t = v17.t + p12
	if v_u_8.t >= 1 then
		local v18 = v_u_7
		local v19 = v_u_8
		table.insert(v18, v19)
		if #v_u_7 > v_u_4.BUCKETS then
			table.remove(v_u_7, 1)
		end
		v_u_8 = {
			["n"] = 0,
			["t"] = 0
		}
	end
	local v20 = v_u_9
	if v20 then
		v20.n = v20.n + 1
		v20.t = v20.t + p12
		if v20.worst < p12 then
			v20.worst = p12
		end
	end
end)
local function v_u_24(p21) -- name: icons
	local v22 = 0
	for _, v23 in ipairs(p21:GetDescendants()) do
		if not (v23:IsA("ViewportFrame") and (v23.Visible and (v23:FindFirstChildWhichIsA("Model") or v23:FindFirstChildWhichIsA("BasePart")))) then
			continue
		end
		v22 = v22 + 1
	end
	return v22
end
local v_u_25 = {}
local v_u_26 = false
local function v_u_43(p27, p28) -- name: onOpen
	-- upvalues: (ref) v_u_26, (copy) v_u_25, (copy) v_u_4, (copy) v_u_7, (ref) v_u_9, (copy) v_u_24, (copy) v_u_2
	if v_u_26 or os.clock() - (v_u_25[p28] or (-1 / 0)) < v_u_4.GAP then
		return
	else
		local v29 = 0
		local v30 = 0
		for _, v31 in ipairs(v_u_7) do
			v29 = v29 + v31.n
			v30 = v30 + v31.t
		end
		local v32
		if v30 > 0.5 then
			v32 = v29 / v30
		else
			v32 = nil
		end
		if v32 then
			v_u_26 = true
			v_u_25[p28] = os.clock()
			task.wait(0.25)
			v_u_9 = {
				["n"] = 0,
				["t"] = 0,
				["worst"] = 0
			}
			local v33 = os.clock()
			while os.clock() - v33 < v_u_4.MEASURE do
				task.wait(0.25)
				if p27:GetAttribute("Open") ~= true then
					v_u_9 = nil
					v_u_26 = false
					return
				end
			end
			local v34 = v_u_9
			v_u_9 = nil
			local v35 = v_u_24(p27)
			v_u_26 = false
				if v34.t > 0 and v34.n >= 2 then
					local v_u_36 = 0
					local function v37()
						-- upvalues: (ref) v_u_36
						v_u_36 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
					end
					pcall(v37)
					local v38 = v_u_2:FindFirstChild("Fust")
					if v38 then
						v38 = v_u_2.Fust:FindFirstChild("Remotes")
					end
					if v38 then
						v38 = v38:FindFirstChild("FpsProbe")
					end
					if v38 and v38:IsA("RemoteEvent") then
						local v39 = {
							["m"] = p28
						}
						local v40 = v32 * 10 + 0.5
						v39.b = math.floor(v40) / 10
						local v41 = v34.n / v34.t * 10 + 0.5
						v39.o = math.floor(v41) / 10
						local v42 = v34.worst * 1000 + 0.5
						v39.w = math.floor(v42)
						v39.v = v35
						v39.q = v_u_36
						v38:FireServer(v39)
					end
				end
		else
			return
		end
	end
end
local v_u_44 = v_u_10
for v_u_45, v_u_46 in pairs(v_u_4.MENUS) do
	task.spawn(function()
		-- upvalues: (copy) v_u_6, (copy) v_u_45, (copy) v_u_46, (copy) v_u_43
		local v_u_47 = v_u_6:WaitForChild(v_u_45, 120)
		if v_u_47 then
			local v_u_48 = v_u_46
			v_u_47:GetAttributeChangedSignal("Open"):Connect(function()
				-- upvalues: (copy) v_u_47, (ref) v_u_43, (copy) v_u_48
				if v_u_47:GetAttribute("Open") == true then
					task.spawn(v_u_43, v_u_47, v_u_48)
				end
			end)
		end
	end)
end
local function v_u_51() -- name: anyMenuOpen
	-- upvalues: (copy) v_u_4, (copy) v_u_6
	for v49 in pairs(v_u_4.MENUS) do
		local v50 = v_u_6:FindFirstChild(v49)
		if not v50 or v50:GetAttribute("Open") ~= true then
			continue
		end
		return true
	end
	return false
end
local function v_u_64(p52) -- name: gaps
	if #p52 < 4 then
		return nil, nil
	end
	local v53 = {}
	for v54 = 2, #p52 do
		local v55 = p52[v54] - p52[v54 - 1]
		table.insert(v53, v55)
	end
	table.sort(v53)
	local v56 = (#v53 + 1) / 2
	local v57 = v53[math.floor(v56)]
	if v57 <= 0 then
		return nil, nil
	end
	local v58 = 0
	for _, v59 in ipairs(v53) do
		local v60 = v59 - v57
		if math.abs(v60) > v57 * 0.25 then
			continue
		end
		v58 = v58 + 1
	end
	local v61 = v57 * 1000 + 0.5
	local v62 = math.floor(v61)
	local v63 = v58 / #v53 * 100 + 0.5
	return v62, math.floor(v63)
end
local function v_u_75(p65) -- name: sendWorld
	-- upvalues: (copy) v_u_4, (copy) v_u_64, (copy) v_u_2
	if p65.t >= v_u_4.WORLD_MIN and p65.n >= 2 then
		local v66, v67 = v_u_64(p65.starts)
		local v_u_68 = 0
		local function v69()
			-- upvalues: (ref) v_u_68
			v_u_68 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
		end
		pcall(v69)
		local v70 = v_u_2:FindFirstChild("Fust")
		if v70 then
			v70 = v_u_2.Fust:FindFirstChild("Remotes")
		end
		if v70 then
			v70 = v70:FindFirstChild("FpsProbe")
		end
		if v70 and v70:IsA("RemoteEvent") then
			local v71 = {
				["m"] = "world",
				["f"] = nil,
				["s"] = nil,
				["n50"] = nil,
				["n80"] = nil,
				["w"] = nil,
				["i"] = nil,
				["r"] = nil,
				["a"] = nil,
				["c"] = nil,
				["q"] = nil
			}
			local v72 = p65.n / p65.t * 10 + 0.5
			v71.f = math.floor(v72) / 10
			local v73 = p65.t + 0.5
			v71.s = math.floor(v73)
			v71.n50 = p65.slow
			v71.n80 = p65.stall
			local v74 = p65.worst * 1000 + 0.5
			v71.w = math.floor(v74)
			v71.i = v66
			v71.r = v67
			v71.a = p65.asleep
			v71.c = p65.menu
			v71.q = v_u_68
			v70:FireServer(v71)
		end
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_44, (copy) v_u_11, (copy) v_u_5, (copy) v_u_51, (copy) v_u_75
	task.wait(v_u_4.WORLD_SKIP)
	v_u_44 = v_u_11()
	local v76 = os.clock()
	while true do
		task.wait(1)
		local v77 = v_u_44
		if v_u_5:GetAttribute("Asleep") == true then
			v77.asleep = v77.asleep + 1
		end
		if v_u_51() then
			v77.menu = v77.menu + 1
		end
		if os.clock() - v76 < v_u_4.WORLD_EVERY then
			continue
		end
		v_u_44 = v_u_11()
		v76 = os.clock()
		local v78 = v_u_75
		pcall(v78, v77)
	end
end)
