--!native
-- Path: Reach.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local function __set_list(target, start, items)
	for i, v in ipairs(items) do
		target[start + i - 1] = v
	end
	return target
end

local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
v_u_1.MAX_CASTS = 6
v_u_1.STEPS = 3
v_u_1.SHRINK = 0.85
v_u_1.UP = 0.35
v_u_1.NUDGE = 0.05
v_u_1.CACHE_TTL = 0.25
v_u_1.NOTIFY_GAP = 1
v_u_1.MESSAGE = "You can\'t reach that"
v_u_1.BLOCKERS = { "Buildings", "Map" }
v_u_1.WALL_TAG = "FustHighWall"
v_u_1.CORE_ATTR = "ReachCore"
v_u_1.CORE_UP = 0.6
function v_u_1.Points(p3, p4, p5) -- name: Points
	-- upvalues: (copy) v_u_1
	local v6 = p5 * (0.5 * v_u_1.SHRINK)
	local v7 = p4:PointToObjectSpace(p3)
	local v8 = v7.X
	local v9 = -v6.X
	local v10 = v6.X
	local v11 = math.clamp(v8, v9, v10)
	local v12 = v7.Y
	local v13 = -v6.Y
	local v14 = v6.Y
	local v15 = math.clamp(v12, v13, v14)
	local v16 = v7.Z
	local v17 = -v6.Z
	local v18 = v6.Z
	local v19 = math.clamp(v16, v17, v18)
	local v20 = p4:PointToWorldSpace((Vector3.new(v11, v15, v19)))
	local v21 = p5.Y * v_u_1.UP
	local v22 = p4:PointToWorldSpace((Vector3.new(0, v21, 0)))
	return { v20, p4.Position, v22 }
end
function v_u_1.CorePoints(p23) -- name: CorePoints
	-- upvalues: (copy) v_u_1
	local v24 = {}
	local v25 = v_u_1.CORE_UP
	__set_list(v24, 1, {p23, p23 + Vector3.new(0, v25, 0)})
	return v24
end
function v_u_1.SamplePoints(p26, p27, p28, p29) -- name: SamplePoints
	-- upvalues: (copy) v_u_1
	if p29 == nil then
		return v_u_1.Points(p26, p27, p28)
	else
		return v_u_1.CorePoints(p29)
	end
end
local function v_u_42(p30, p31, p32) -- name: exitDistance
	if not p30:IsA("BasePart") or p30:IsA("Terrain") then
		return 0
	end
	local v33 = p30.CFrame
	local v34 = p30.Size * 0.5
	local v35 = v33:PointToObjectSpace(p31)
	local v36 = v33:PointToObjectSpace(p31 + p32) - v35
	local v37 = (1 / 0)
	for _, v38 in ipairs({ "X", "Y", "Z" }) do
		local v39 = v36[v38]
		if math.abs(v39) <= 1e-9 then
			continue
		end
		local v40
		if v39 > 0 then
			v40 = v34[v38]
		else
			v40 = -v34[v38]
		end
		local v41 = (v40 - v35[v38]) / v39
		v37 = math.min(v37, v41)
	end
	return (v37 == (1 / 0) or v37 < 0) and 0 or v37
end
v_u_1.exitDistance = v_u_42
function v_u_1.Trace(p43, p44, p45, p46, p47) -- name: Trace
	-- upvalues: (copy) v_u_1, (copy) v_u_42
	local v48 = p44 - p43
	local v49 = v48.Magnitude
	if v49 < 0.02 then
		return true, 0
	end
	local v50 = v48 / v49
	local v51 = 0
	local v52 = 0
	for _ = 1, v_u_1.STEPS do
		if p47 <= v51 then
			return false, v51
		end
		v51 = v51 + 1
		local v53 = p45(p43 + v50 * v52, v50 * (v49 - v52))
		if not v53 then
			return true, v51
		end
		local v54 = v53.Instance
		local v55 = v54 ~= nil and (not p46(v54) and v54:IsA("BasePart"))
		if v55 then
			if v54.CanCollide == false then
				v55 = true
			elseif typeof(v54) == "Instance" then
				v55 = v54:GetAttribute("ReachPass") == true
			else
				v55 = false
			end
		end
		if not v55 then
			return false, v51
		end
		local v56 = (v53.Position - p43):Dot(v50)
		v52 = math.max(v52, v56) + v_u_42(v54, v53.Position, v50) + v_u_1.NUDGE
		if v49 - 0.02 > v52 then
			continue
		end
		return true, v51
	end
	return false, v51
end
function v_u_1.ClearPoints(p57, p58, p59, p60) -- name: ClearPoints
	-- upvalues: (copy) v_u_1
	local v61 = v_u_1.MAX_CASTS
	for _, v62 in ipairs(p58) do
		if v61 <= 0 then
			return false
		end
		local v63, v64 = v_u_1.Trace(p57, v62, p59, p60, v61)
		if v63 then
			return true
		end
		v61 = v61 - v64
	end
	return false
end
local v_u_65 = nil
local v_u_66 = {}
local function v_u_75() -- name: blockerParams
	-- upvalues: (ref) v_u_65, (copy) v_u_1, (ref) v_u_66
	local v67 = v_u_65 ~= nil
	local v68 = {}
	local v69 = workspace:FindFirstChildOfClass("Terrain")
	if v69 then
		table.insert(v68, v69)
	end
	for _, v70 in ipairs(v_u_1.BLOCKERS) do
		local v71 = workspace:FindFirstChild(v70)
		if not v71 then
			continue
		end
		table.insert(v68, v71)
	end
	if v67 and #v68 == #v_u_66 then
		for v72, v73 in ipairs(v68) do
			if v_u_66[v72] == v73 then
				continue
			end
			v67 = false
		end
	else
		v67 = false
	end
	if not (v67 and v_u_65) then
		local v_u_74 = RaycastParams.new()
		v_u_74.FilterType = Enum.RaycastFilterType.Include
		v_u_74.FilterDescendantsInstances = v68
		v_u_74.IgnoreWater = true
		pcall(function()
			-- upvalues: (copy) v_u_74
			v_u_74.RespectCanCollide = true
		end)
		v_u_65 = v_u_74
		v_u_66 = v68
	end
	return v_u_65
end
local v_u_82 = {
	["dirty"] = true,
	["hooked"] = false,
	["cached"] = nil,
	["params"] = function() -- name: params
		-- upvalues: (copy) v_u_82, (copy) v_u_2, (copy) v_u_1
		if not v_u_82.hooked then
			v_u_82.hooked = true
			local function v77()
				-- upvalues: (ref) v_u_82, (ref) v_u_2, (ref) v_u_1
				local function v76() -- name: mark
					-- upvalues: (ref) v_u_82
					v_u_82.dirty = true
				end
				v_u_2:GetInstanceAddedSignal(v_u_1.WALL_TAG):Connect(v76)
				v_u_2:GetInstanceRemovedSignal(v_u_1.WALL_TAG):Connect(v76)
			end
			pcall(v77)
		end
		if v_u_82.dirty then
			v_u_82.dirty = false
			local function v78()
				-- upvalues: (ref) v_u_2, (ref) v_u_1
				return v_u_2:GetTagged(v_u_1.WALL_TAG)
			end
			local v79, v80 = pcall(v78)
			if v79 and (type(v80) == "table" and #v80 > 0) then
				local v_u_81 = RaycastParams.new()
				v_u_81.FilterType = Enum.RaycastFilterType.Include
				v_u_81.FilterDescendantsInstances = v80
				v_u_81.IgnoreWater = true
				pcall(function()
					-- upvalues: (copy) v_u_81
					v_u_81.RespectCanCollide = true
				end)
				v_u_82.cached = v_u_81
			else
				v_u_82.cached = nil
			end
		end
		return v_u_82.cached
	end
}
local function v_u_88(p83, p84) -- name: worldCast
	-- upvalues: (copy) v_u_75, (copy) v_u_82
	local v85 = workspace:Raycast(p83, p84, (v_u_75()))
	local v86 = v_u_82.params()
	if v86 then
		local v87 = workspace:Raycast(p83, p84, v86)
		if v87 and (not v85 or v87.Distance < v85.Distance) then
			return v87
		end
	end
	return v85
end
function v_u_1.CoreOf(p_u_89) -- name: CoreOf
	-- upvalues: (copy) v_u_1
	if typeof(p_u_89) == "Instance" then
		if p_u_89 and p_u_89:IsA("ProximityPrompt") then
			p_u_89 = v_u_1.TargetOf(p_u_89)
		end
		if p_u_89 and (p_u_89:IsA("Model") and p_u_89:GetAttribute(v_u_1.CORE_ATTR) == true) then
			local v90 = p_u_89:FindFirstChild("HumanoidRootPart")
			if v90 and v90:IsA("BasePart") then
				return v90.Position
			else
				local v91, v92 = pcall(function()
					-- upvalues: (copy) p_u_89
					return p_u_89:GetBoundingBox()
				end)
				if v91 and typeof(v92) == "CFrame" then
					return v92.Position
				else
					return nil
				end
			end
		else
			return nil
		end
	else
		return nil
	end
end
function v_u_1.BoxOf(p93) -- name: BoxOf
	if typeof(p93) == "Vector3" then
		return CFrame.new(p93), Vector3.new(0, 0, 0)
	elseif typeof(p93) == "Instance" then
		local v94 = p93
		local v_u_95 = not v94:IsA("ProximityPrompt") or v94.Parent
		if v_u_95 then
			if v_u_95:IsA("Model") then
				local v96, v97, v98 = pcall(function()
					-- upvalues: (ref) v_u_95
					return v_u_95:GetBoundingBox()
				end)
				if v96 and typeof(v97) == "CFrame" and typeof(v98) == "Vector3" then
					return v97, v98
				else
					return nil, nil
				end
			elseif v_u_95:IsA("BasePart") then
				return v_u_95.CFrame, v_u_95.Size
			elseif v_u_95:IsA("Attachment") then
				return CFrame.new(v_u_95.WorldPosition), Vector3.new(0, 0, 0)
			else
				return nil, nil
			end
		else
			return nil, nil
		end
	else
		return nil, nil
	end
end
local function v_u_102(p99) -- name: pieceOf
	local v100 = workspace:FindFirstChild("Buildings")
	if not v100 then
		return nil
	end
	for _ = 1, 6 do
		if p99 == nil then
			return nil
		end
		local v101 = p99.Parent
		if v101 == v100 then
			return p99
		end
		p99 = v101
	end
	return nil
end
local function v_u_112(p_u_103, p104) -- name: ownTest
	-- upvalues: (copy) v_u_102
	if typeof(p_u_103) ~= "Instance" then
		p_u_103 = nil
	end
	if p_u_103 and p_u_103:IsA("ProximityPrompt") then
		p_u_103 = p_u_103.Parent
	end
	local v_u_105
	if p_u_103 and p_u_103:IsA("Model") then
		v_u_105 = p_u_103:GetAttribute("DoorwayId")
	else
		v_u_105 = nil
	end
	local v_u_106
	if type(p104) == "table" then
		local v107 = p104.ignore
		if type(v107) == "table" then
			v_u_106 = p104.ignore
		else
			v_u_106 = nil
		end
	else
		v_u_106 = nil
	end
	return function(p108)
		-- upvalues: (ref) p_u_103, (copy) v_u_106, (ref) v_u_105, (ref) v_u_102
		if p_u_103 and (p108 == p_u_103 or p108:IsDescendantOf(p_u_103)) then
			return true
		end
		if v_u_106 then
			for _, v109 in ipairs(v_u_106) do
				if typeof(v109) ~= "Instance" or p108 ~= v109 and not p108:IsDescendantOf(v109) then
					continue
				end
				return true
			end
		end
		local v110 = v_u_105
		if type(v110) == "string" then
			local v111 = v_u_102(p108)
			if v111 and v111:GetAttribute("Id") == v_u_105 then
				return true
			end
		end
		return false
	end
end
function v_u_1.Clear(p113, p114, p115) -- name: Clear
	-- upvalues: (copy) v_u_1, (copy) v_u_88, (copy) v_u_112
	local v116
	if typeof(p113) == "Vector3" then
		local v117 = p113.X
		local v118 = p113.Y
		local v119 = p113.Z
		if v117 == v117 and (v118 == v118 and (v119 == v119 and (math.abs(v117) < 1000000 and math.abs(v118) < 1000000))) then
			v116 = math.abs(v119) < 1000000
		else
			v116 = false
		end
	else
		v116 = false
	end
	if not v116 then
		return false
	end
	local v120, v121 = v_u_1.BoxOf(p114)
	if not (v120 and v121) then
		return true
	end
	local v122, v123
	if type(p115) == "table" then
		local v124 = p115.cast
		if type(v124) == "function" then
			v122 = p115.cast
			v123 = v_u_112(p114, p115)
			return v_u_1.ClearPoints(p113, v_u_1.SamplePoints(p113, v120, v121, v_u_1.CoreOf(p114)), v122, v123)
		else
			v122 = v_u_88
			v123 = v_u_112(p114, p115)
			return v_u_1.ClearPoints(p113, v_u_1.SamplePoints(p113, v120, v121, v_u_1.CoreOf(p114)), v122, v123)
		end
	else
		v122 = v_u_88
		v123 = v_u_112(p114, p115)
		return v_u_1.ClearPoints(p113, v_u_1.SamplePoints(p113, v120, v121, v_u_1.CoreOf(p114)), v122, v123)
	end
end
local v_u_125 = setmetatable({}, {
	["__mode"] = "k"
})
local v_u_126 = setmetatable({}, {
	["__mode"] = "k"
})
function v_u_1.PlayerCanReach(p127, p128, p129) -- name: PlayerCanReach
	-- upvalues: (copy) v_u_125, (copy) v_u_1, (copy) v_u_88, (copy) v_u_112
	local v130 = p127.Character
	local v131
	if v130 then
		v131 = v130:FindFirstChild("HumanoidRootPart")
	else
		v131 = v130
	end
	if not (v131 and v131:IsA("BasePart")) then
		return false
	end
	local v132 = os.clock()
	local v133 = v_u_125[p127]
	if v133 and (v133.target == p128 and (v132 - v133.at < v_u_1.CACHE_TTL and p129 == nil)) then
		return v133.ok
	end
	local v134, v135
	if type(p129) == "table" then
		local v136 = p129.cast
		if type(v136) == "function" then
			v134 = p129.cast
			v135 = v130:FindFirstChild("Head")
			v143 = true
			if not (v135 and v135:IsA("BasePart")) then
				v142 = v131.Position + Vector3.new(0, 1.5, 0)
				if v143 then
					v143 = v_u_1.Clear(v142, p128, p129)
				end
				if p129 == nil then
					v_u_125[p127] = {
						["target"] = p128,
						["at"] = v132,
						["ok"] = v143
					}
				end
				return v143
			end
		else
			v134 = v_u_88
			v135 = v130:FindFirstChild("Head")
			v143 = true
			if not (v135 and v135:IsA("BasePart")) then
				v142 = v131.Position + Vector3.new(0, 1.5, 0)
				if v143 then
					v143 = v_u_1.Clear(v142, p128, p129)
				end
				if p129 == nil then
					v_u_125[p127] = {
						["target"] = p128,
						["at"] = v132,
						["ok"] = v143
					}
				end
				return v143
			end
		end
	else
		v134 = v_u_88
		v135 = v130:FindFirstChild("Head")
		v143 = true
		if not (v135 and v135:IsA("BasePart")) then
			v142 = v131.Position + Vector3.new(0, 1.5, 0)
			if v143 then
				v143 = v_u_1.Clear(v142, p128, p129)
			end
			if p129 == nil then
				v_u_125[p127] = {
					["target"] = p128,
					["at"] = v132,
					["ok"] = v143
				}
			end
			return v143
		end
	end
	local v137 = v135.Position
	local v138
	if typeof(v137) == "Vector3" then
		local v139 = v137.X
		local v140 = v137.Y
		local v141 = v137.Z
		if v139 == v139 and (v140 == v140 and (v141 == v141 and (math.abs(v139) < 1000000 and math.abs(v140) < 1000000))) then
			v138 = math.abs(v141) < 1000000
		else
			v138 = false
		end
	else
		v138 = false
	end
	if not v138 then
		v142 = v131.Position + Vector3.new(0, 1.5, 0)
		if v143 then
			v143 = v_u_1.Clear(v142, p128, p129)
		end
		if p129 == nil then
			v_u_125[p127] = {
				["target"] = p128,
				["at"] = v132,
				["ok"] = v143
			}
		end
		return v143
	end
	local v142 = v135.Position
	local v143 = v_u_1.Trace(v131.Position, v142, v134, v_u_112(p128, p129), 2)
	if v143 then
		v143 = v_u_1.Clear(v142, p128, p129)
	end
	if p129 == nil then
		v_u_125[p127] = {
			["target"] = p128,
			["at"] = v132,
			["ok"] = v143
		}
	end
	return v143
end
function v_u_1.Guard(p144, p145, p146, p147) -- name: Guard
	-- upvalues: (copy) v_u_1, (copy) v_u_126
	if v_u_1.PlayerCanReach(p144, p145, p147) then
		return true
	end
	local v148 = os.clock()
	if p146 and v148 - (v_u_126[p144] or (-1 / 0)) >= v_u_1.NOTIFY_GAP then
		v_u_126[p144] = v148
		local v149 = v_u_1.MESSAGE
		pcall(p146, p144, v149)
	end
	return false
end
function v_u_1.TargetOf(p150) -- name: TargetOf
	local v151 = p150.Parent
	if not v151 then
		return nil
	end
	local v152 = v151
	local v153 = nil
	for _ = 1, 8 do
		if v151 == nil or v151 == workspace then
			break
		end
		if v151:IsA("Model") then
			if v151:GetAttribute("Id") ~= nil then
				return v151
			end
			v153 = v153 or v151
		end
		v151 = v151.Parent
	end
	return v153 or v152
end
return v_u_1
