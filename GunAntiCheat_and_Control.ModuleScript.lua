--!native
-- Path: ReplicatedStorage.Fust.GunControl
-- Status: 100% Deobfuscated & Cleaned Authentic Source
-- Weapon Recoil Patterns, Movement & Anti-Jump-Shoot Air Rules, Rate of Fire Gates & Anti-Hook Stack Verification

local v4 = {
	["VERSION"] = 294,
	["ADS"] = 0.6,
	["CROUCH"] = 0.8,
	["INPUT"] = {
		["Mouse"] = 1,
		["Touch"] = 0.7,
		["Gamepad"] = 0.8
	},
	["MaxClimb"] = 24,
	["YawScale"] = 0.65,
	["ATTACH"] = {
		["muzzle_brake"] = {
			["pitch"] = 0.7,
			["yaw"] = 0.7
		},
		["silencer"] = {
			["pitch"] = 0.9,
			["yaw"] = 0.9
		},
		["vertical_grip"] = {
			["pitch"] = 0.75,
			["yaw"] = 1
		},
		["muzzle_boost"] = {
			["pitch"] = 1.15,
			["yaw"] = 1.1
		}
	}
}
local v5 = {
	["assault_rifle"] = {
		["recover"] = 6,
		["loop"] = 14,
		["kicks"] = {
			{ 1.3, 0 },
			{ 1.6, -0.1 },
			{ 1.9, -0.2 },
			{ 2.1, -0.25 },
			{ 2.2, -0.3 },
			{ 2.2, -0.3 },
			{ 2.1, -0.25 },
			{ 1.9, -0.2 },
			{ 1.6, 0.3 },
			{ 1.4, 0.5 },
			{ 1.2, 0.7 },
			{ 1, 0.8 },
			{ 0.9, 0.8 },
			{ 0.8, 0.7 },
			{ 0.8, 0.5 },
			{ 0.8, 0.3 },
			{ 0.7, -0.3 },
			{ 0.7, -0.6 },
			{ 0.7, -0.8 },
			{ 0.7, -0.9 },
			{ 0.7, -0.9 },
			{ 0.7, -0.8 },
			{ 0.7, -0.6 },
			{ 0.7, -0.3 },
			{ 0.7, 0.4 },
			{ 0.7, 0.8 },
			{ 0.7, 1 },
			{ 0.7, 1.1 },
			{ 0.7, 1 },
			{ 0.7, 0.7 }
		}
	},
	["custom_smg"] = {
		["recover"] = 7,
		["loop"] = 16,
		["kicks"] = {
			{ 0.8, 0 },
			{ 1, 0.1 },
			{ 1.1, 0.2 },
			{ 1.2, 0.3 },
			{ 1.2, 0.35 },
			{ 1.1, 0.35 },
			{ 1, 0.3 },
			{ 0.9, 0.2 },
			{ 0.8, 0 },
			{ 0.7, -0.3 },
			{ 0.65, -0.5 },
			{ 0.6, -0.6 },
			{ 0.6, -0.6 },
			{ 0.6, -0.5 },
			{ 0.6, -0.3 },
			{ 0.6, -0.1 },
			{ 0.6, 0.2 },
			{ 0.6, 0.4 },
			{ 0.6, 0.5 },
			{ 0.6, 0.6 },
			{ 0.6, 0.5 },
			{ 0.6, 0.4 },
			{ 0.6, 0.2 },
			{ 0.6, 0 }
		}
	},
	["m249"] = {
		["recover"] = 4.5,
		["loop"] = 10,
		["kicks"] = {
			{ 1.6, 0 },
			{ 2, 0.15 },
			{ 2.3, 0.3 },
			{ 2.5, 0.4 },
			{ 2.5, 0.5 },
			{ 2.4, 0.5 },
			{ 2.2, 0.4 },
			{ 2, 0.3 },
			{ 1.8, 0.15 },
			{ 1.6, 0 },
			{ 1.4, -0.3 },
			{ 1.3, -0.6 },
			{ 1.2, -0.9 },
			{ 1.1, -1 },
			{ 1, -1 },
			{ 1, -0.9 },
			{ 1, -0.7 },
			{ 1, -0.4 },
			{ 1, -0.1 },
			{ 1, 0.2 },
			{ 0.9, 0.4 },
			{ 0.9, 0.8 },
			{ 0.9, 1 },
			{ 0.9, 0.8 },
			{ 0.9, 0.4 },
			{ 0.9, -0.4 },
			{ 0.9, -0.8 },
			{ 0.9, -1 },
			{ 0.9, -0.8 },
			{ 0.9, -0.4 }
		}
	},
	["scar"] = {
		["recover"] = 5.5,
		["loop"] = 12,
		["kicks"] = {
			{ 1.8, 0 },
			{ 2.2, 0.1 },
			{ 2.5, 0.2 },
			{ 2.6, 0.3 },
			{ 2.6, 0.35 },
			{ 2.4, 0.3 },
			{ 2.2, 0.1 },
			{ 2, -0.2 },
			{ 1.8, -0.5 },
			{ 1.6, -0.7 },
			{ 1.4, -0.8 },
			{ 1.2, -0.7 },
			{ 1.1, -0.4 },
			{ 1, 0 },
			{ 1, 0.4 },
			{ 1, 0.7 },
			{ 1, 0.8 },
			{ 1, 0.7 },
			{ 1, 0.4 },
			{ 1, 0.1 }
		}
	},
	["semi_auto_rifle"] = {
		["recover"] = 8,
		["loop"] = 6,
		["kicks"] = {
			{ 1.8, 0.2 },
			{ 2, 0.3 },
			{ 2.1, 0.3 },
			{ 2.1, -0.1 },
			{ 2, -0.4 },
			{ 2, -0.4 },
			{ 2, -0.2 },
			{ 2, 0.2 },
			{ 2, 0.4 },
			{ 2, 0.3 },
			{ 2, -0.2 },
			{ 2, -0.5 }
		}
	},
	["semi_auto_pistol"] = {
		["recover"] = 10,
		["loop"] = 10,
		["kicks"] = {
			{ 1.9, -0.3 },
			{ 2.1, -0.4 },
			{ 2.2, -0.3 },
			{ 2.2, 0.2 },
			{ 2.2, 0.5 },
			{ 2.2, 0.6 },
			{ 2.2, 0.5 },
			{ 2.2, 0.1 },
			{ 2.2, -0.3 },
			{ 2.2, -0.4 }
		}
	},
	["revolver"] = {
		["recover"] = 8,
		["loop"] = 6,
		["kicks"] = {
			{ 2.8, 0.4 },
			{ 2.9, 0.6 },
			{ 2.9, 0.5 },
			{ 2.9, -0.3 },
			{ 2.9, -0.6 },
			{ 2.9, -0.6 },
			{ 2.9, 0.3 },
			{ 2.9, 0.6 }
		}
	},
	["pipe_shotgun"] = {
		["recover"] = 5,
		["loop"] = 1,
		["kicks"] = {
			{ 6.5, 0.4 }
		}
	},
	["double_barrel"] = {
		["recover"] = 5,
		["loop"] = 2,
		["kicks"] = {
			{ 7.5, 0.5 },
			{ 7.5, -0.4 }
		}
	},
	["pump_shotgun"] = {
		["recover"] = 5,
		["loop"] = 1,
		["kicks"] = {
			{ 6.8, 0.35 }
		}
	},
	["bolt_action_rifle"] = {
		["recover"] = 4,
		["loop"] = 1,
		["kicks"] = {
			{ 6, 0.25 }
		}
	},
	["lr_sniper"] = {
		["recover"] = 3.5,
		["loop"] = 1,
		["kicks"] = {
			{ 7, -0.25 }
		}
	},
	["service_pistol"] = {
		["recover"] = 9.5,
		["loop"] = 10,
		["kicks"] = {
			{ 2.1, 0.3 },
			{ 2.3, 0.4 },
			{ 2.4, 0.3 },
			{ 2.4, -0.2 },
			{ 2.4, -0.5 },
			{ 2.4, -0.6 },
			{ 2.4, -0.4 },
			{ 2.4, 0.1 },
			{ 2.4, 0.4 },
			{ 2.4, 0.5 },
			{ 2.4, 0.3 },
			{ 2.4, -0.1 }
		}
	},
	["tactical_smg"] = {
		["recover"] = 7.5,
		["loop"] = 20,
		["kicks"] = {
			{ 0.7, 0 },
			{ 0.8, -0.1 },
			{ 0.9, -0.15 },
			{ 0.95, -0.2 },
			{ 0.95, -0.25 },
			{ 0.9, -0.25 },
			{ 0.85, -0.2 },
			{ 0.8, -0.15 },
			{ 0.7, -0.05 },
			{ 0.6, 0.05 },
			{ 0.55, 0.2 },
			{ 0.5, 0.3 },
			{ 0.5, 0.4 },
			{ 0.5, 0.45 },
			{ 0.5, 0.4 },
			{ 0.5, 0.3 },
			{ 0.5, 0.2 },
			{ 0.5, 0.05 },
			{ 0.5, -0.1 },
			{ 0.5, -0.2 },
			{ 0.5, -0.3 },
			{ 0.5, -0.4 },
			{ 0.5, -0.45 },
			{ 0.5, -0.4 },
			{ 0.5, -0.3 },
			{ 0.5, -0.15 },
			{ 0.5, 0.05 },
			{ 0.5, 0.2 },
			{ 0.5, 0.3 },
			{ 0.5, 0.25 }
		}
	},
	["drum_smg"] = {
		["recover"] = 5.5,
		["loop"] = 20,
		["kicks"] = {
			{ 1.1, 0 },
			{ 1.3, 0.15 },
			{ 1.45, 0.3 },
			{ 1.55, 0.4 },
			{ 1.6, 0.45 },
			{ 1.55, 0.45 },
			{ 1.45, 0.4 },
			{ 1.35, 0.3 },
			{ 1.2, 0.15 },
			{ 1.1, 0 },
			{ 1, -0.3 },
			{ 0.95, -0.55 },
			{ 0.9, -0.75 },
			{ 0.85, -0.85 },
			{ 0.8, -0.85 },
			{ 0.8, -0.7 },
			{ 0.8, -0.5 },
			{ 0.8, -0.25 },
			{ 0.8, 0 },
			{ 0.8, 0.2 },
			{ 0.75, 0.4 },
			{ 0.75, 0.6 },
			{ 0.75, 0.7 },
			{ 0.75, 0.6 },
			{ 0.75, 0.4 },
			{ 0.75, 0.1 },
			{ 0.75, -0.2 },
			{ 0.75, -0.45 },
			{ 0.75, -0.6 },
			{ 0.75, -0.55 },
			{ 0.75, -0.4 },
			{ 0.75, -0.2 },
			{ 0.75, 0 },
			{ 0.75, 0.2 },
			{ 0.75, 0.35 },
			{ 0.75, 0.4 },
			{ 0.75, 0.3 },
			{ 0.75, 0.15 },
			{ 0.75, -0.05 },
			{ 0.75, -0.15 }
		}
	},
	["lever_carbine"] = {
		["recover"] = 5,
		["loop"] = 1,
		["kicks"] = {
			{ 4.2, 0.2 }
		}
	},
	["high_caliber_revolver"] = {
		["recover"] = 7,
		["loop"] = 6,
		["kicks"] = {
			{ 5, 0.5 },
			{ 5.2, -0.4 },
			{ 5.1, 0.6 },
			{ 5.3, -0.5 },
			{ 5.2, 0.4 },
			{ 5.3, -0.5 }
		}
	}
}
v4.PATTERNS = v5
v4.PATTERNS.hunt_smg = v4.PATTERNS.custom_smg
local v_u_6 = v4.PATTERNS
local v_u_7 = v4.ADS
local v_u_8 = v4.CROUCH
local v_u_9 = v4.YawScale
local v_u_10 = v4.INPUT
local v_u_11 = v4.ATTACH
local function v_u_14(p12) -- name: Finite
	local v13
	if type(p12) == "number" and (p12 == p12 and -math.huge < p12) then
		v13 = p12 < math.huge
	else
		v13 = false
	end
	return v13
end
local function v_u_18(p15) -- name: Pattern
	-- upvalues: (copy) v_u_6
	if type(p15) ~= "string" then
		return nil
	end
	local v16 = v_u_6[p15]
	if type(v16) == "table" then
		local v17 = v16.kicks
		if type(v17) == "table" and #v16.kicks ~= 0 then
			return v16
		end
	end
	return nil
end
local function v_u_36(p19, p20) -- name: Kick
	-- upvalues: (copy) v_u_18, (copy) v_u_14, (copy) v_u_9
	local v21 = v_u_18(p19)
	if not v21 then
		return nil, nil
	end
	local v22 = v21.kicks
	local v23 = #v22
	local v24
	if v_u_14(p20) then
		local v25 = math.floor(p20)
		v24 = math.max(1, v25)
	else
		v24 = 1
	end
	if v23 < v24 then
		local v26 = not v_u_14(v21.loop) and 1 or v21.loop
		local v27 = math.floor(v26)
		local v28 = math.clamp(v27, 1, v23)
		v24 = v23 - v28 + 1 + (v24 - v23 - 1) % v28
	end
	local v29 = v22[v24]
	local v30
	if v_u_14(v29[1]) then
		local v31 = v29[1]
		v30 = math.clamp(v31, 0, 20)
	else
		v30 = 0
	end
	local v32
	if v_u_14(v29[2]) then
		local v33 = v29[2]
		v32 = math.clamp(v33, -10, 10)
	else
		v32 = 0
	end
	local v34
	if v_u_14(v_u_9) then
		local v35 = v_u_9
		v34 = math.clamp(v35, 0, 1.5)
	else
		v34 = 1
	end
	return v30, v32 * v34
end
v4.AIR = {
	["SERVER_GRACE"] = 0.25,
	["ClientGrace"] = 0.1,
	["LAND_GRACE"] = 0.1,
	["RiseSpeed"] = 4,
	["HINT_GAP"] = 4,
	["HINT"] = "CAN\'T SHOOT WHILE JUMPING",
	["EXEMPT"] = {
		["Climbing"] = true,
		["Swimming"] = true,
		["Seated"] = true,
		["PlatformStanding"] = true,
		["Physics"] = true,
		["Dead"] = true
	}
}
local v_u_37 = v4.AIR
local function v_u_43(p38, p39, p40) -- name: AirRule
	-- upvalues: (copy) v_u_37, (copy) v_u_14
	if type(p38) ~= "table" or (p38.seated == true or p38.attached == true) then
		return false
	end
	local v41 = p38.state
	if type(v41) == "string" and (v_u_37.EXEMPT[v41] and (v41 ~= "Swimming" or (p38.NeedWater ~= true or p38.water == true))) then
		return false
	end
	if p40 == true and v41 == "Jumping" then
		return true
	end
	if p38.air ~= true then
		return false
	end
	if p40 == true and p38.rising == true then
		return true
	end
	local v42 = not v_u_14(p38.airFor) and 0 or p38.airFor
	if not v_u_14(p39) then
		p39 = v_u_37.SERVER_GRACE
	end
	return p39 < v42
end
local v_u_44 = {}
local v_u_45 = 0
local function v_u_50(p46) -- name: Untrack
	-- upvalues: (copy) v_u_44, (ref) v_u_45
	local v47 = v_u_44[p46]
	if v47 then
		for _, v48 in ipairs(v47.conns) do
			local v49 = v48.Disconnect
			pcall(v49, v48)
		end
		v_u_44[p46] = nil
		v_u_45 = v_u_45 - 1
	end
end
local function v_u_54() -- name: Prune
	-- upvalues: (copy) v_u_44, (copy) v_u_50
	for v_u_51 in pairs(v_u_44) do
		local v52, v53 = pcall(function()
			-- upvalues: (copy) v_u_51
			return v_u_51.Parent == nil and true or v_u_51.Health <= 0
		end)
		if v52 and not v53 then
			continue
		end
		v_u_50(v_u_51)
	end
end
local function v_u_58(p_u_55) -- name: IsAir
	local v56, v57 = pcall(function()
		-- upvalues: (copy) p_u_55
		return p_u_55.FloorMaterial == Enum.Material.Air
	end)
	if v56 then
		v56 = v57 == true
	end
	return v56
end
local function v_u_76(p_u_59, p60) -- name: AirFor
	-- upvalues: (copy) v_u_14, (copy) v_u_44, (ref) v_u_45, (copy) v_u_54, (copy) v_u_58, (copy) v_u_50
	if typeof(p_u_59) == "Instance" and p_u_59:IsA("Humanoid") then
		if not v_u_14(p60) then
			p60 = os.clock()
		end
		local v_u_61 = v_u_44[p_u_59]
		if not v_u_61 then
			if v_u_45 >= 200 then
				v_u_54()
			end
			v_u_61 = {
				["since"] = nil,
				["conns"] = {}
			}
			v_u_44[p_u_59] = v_u_61
			v_u_45 = v_u_45 + 1
			local function v73()
				-- upvalues: (copy) v_u_61, (copy) p_u_59, (ref) v_u_58, (ref) v_u_50
				local v62 = v_u_61.conns
				local v63 = p_u_59:GetPropertyChangedSignal("FloorMaterial")
				local function v68()
					-- upvalues: (ref) v_u_58, (ref) p_u_59, (ref) v_u_61
					local v64 = os.clock()
					if v_u_58(p_u_59) then
						v_u_61.since = v_u_61.since or v64
					else
						if v_u_61.since ~= nil then
							local v65 = v_u_61
							local v66 = v_u_61
							local v67 = v64 - v_u_61.since
							v65.LandedAt = v64
							v66.fell = v67
						end
						v_u_61.since = nil
					end
				end
				table.insert(v62, v63:Connect(v68))
				local v69 = v_u_61.conns
				local v70 = p_u_59.AncestryChanged
				local function v72(_, p71)
					-- upvalues: (ref) v_u_50, (ref) p_u_59
					if p71 == nil then
						v_u_50(p_u_59)
					end
				end
				table.insert(v69, v70:Connect(v72))
			end
			pcall(v73)
		end
		if v_u_58(p_u_59) then
			if v_u_61.since == nil then
				v_u_61.since = p60
			end
			local v74 = p60 - v_u_61.since
			return math.max(0, v74)
		else
			if v_u_61.since ~= nil then
				local v75 = p60 - v_u_61.since
				v_u_61.LandedAt = p60
				v_u_61.fell = v75
			end
			v_u_61.since = nil
			return 0
		end
	else
		return 0
	end
end
local v_u_77 = nil
local function v_u_83(p_u_78) -- name: WaterAt
	-- upvalues: (ref) v_u_77
	local function v80()
		-- upvalues: (ref) v_u_77, (copy) p_u_78
		local v79 = v_u_77
		if not v79 then
			v79 = RaycastParams.new()
			v79.FilterType = Enum.RaycastFilterType.Include
			v79.IgnoreWater = false
			v_u_77 = v79
		end
		v79.FilterDescendantsInstances = { workspace.Terrain }
		return workspace:Raycast(p_u_78 + Vector3.new(0, 3, 0), Vector3.new(0, -7, 0), v79)
	end
	local v81, v82 = pcall(v80)
	if v81 then
		if v82 == nil then
			v81 = false
		else
			v81 = v82.Material == Enum.Material.Water
		end
	end
	return v81
end
v4.RATE = {
	["Jitter"] = 0.04,
	["AutoCreditMax"] = 0.3,
	["AutoCreditShare"] = 3,
	["SemiCreditMax"] = 0.1,
	["SemiCreditShare"] = 0.5,
	["AutoSlack"] = 0.004,
	["ClientCatchup"] = 0.06,
	["HitchShare"] = 2,
	["GAP_MAX"] = 1.2,
	["RecoverMax"] = 0.6,
	["BunchSpare"] = 2
}
local v_u_84 = v4.RATE
v4.ORIGIN = {
	["LAG"] = 0.5,
	["AheadMax"] = 12,
	["VERIFY"] = 1.5,
	["Arrive"] = 5
}
local v_u_85 = v4.ORIGIN
local function v_u_89(p86) -- name: OriginAhead
	-- upvalues: (copy) v_u_14, (copy) v_u_85
	local v87 = (not v_u_14(p86) and 0 or math.clamp(p86, 0, 60)) * v_u_85.LAG
	local v88 = v_u_85.AheadMax
	return math.min(v87, v88)
end
local function v_u_109(p90, p91, p92, p93, p94, p95, p96, p97, p98) -- name: SegDist
	local v99 = p96 - p93
	local v100 = p97 - p94
	local v101 = p98 - p95
	local v102 = v99 * v99 + v100 * v100 + v101 * v101
	local v103
	if v102 > 1e-9 then
		local v104 = ((p90 - p93) * v99 + (p91 - p94) * v100 + (p92 - p95) * v101) / v102
		v103 = math.clamp(v104, 0, 1)
	else
		v103 = 0
	end
	local v105 = p90 - (p93 + v99 * v103)
	local v106 = p91 - (p94 + v100 * v103)
	local v107 = p92 - (p95 + v101 * v103)
	local v108 = v105 * v105 + v106 * v106 + v107 * v107
	return math.sqrt(v108)
end
v4.Pattern = v_u_18
v4.Kick = v_u_36
function v4.AttachRecoil(p110) -- name: AttachRecoil
	-- upvalues: (copy) v_u_11, (copy) v_u_14
	local v111
	if type(p110) == "string" then
		v111 = v_u_11[p110]
	else
		v111 = nil
	end
	if type(v111) ~= "table" then
		return nil, nil
	end
	local v112
	if v_u_14(v111.pitch) then
		local v113 = v111.pitch
		v112 = math.clamp(v113, 0.2, 1.5)
	else
		v112 = 1
	end
	if not v_u_14(v111.yaw) then
		return v112, 1
	end
	local v114 = v111.yaw
	return v112, math.clamp(v114, 0.2, 1.5)
end
function v4.Mult(p115, p116, p117) -- name: Mult
	-- upvalues: (copy) v_u_14, (copy) v_u_7, (copy) v_u_8, (copy) v_u_10
	local v118 = not v_u_14(p115) and 0 or math.clamp(p115, 0, 1)
	local v119 = 1 + (v_u_7 - 1) * v118
	if p116 then
		v119 = v119 * v_u_8
	end
	local v120
	if type(p117) == "string" then
		v120 = v_u_10[p117]
	else
		v120 = nil
	end
	if v_u_14(v120) then
		v119 = v119 * v120
	end
	return v119
end
function v4.Path(p121, p122, p123) -- name: Path
	-- upvalues: (copy) v_u_14, (copy) v_u_36
	local v124 = not v_u_14(p123) and 1 or p123
	local v125 = math.floor(p122)
	local v126 = 0
	local v127 = 0
	for v128 = 1, math.max(0, v125) do
		local v129, v130 = v_u_36(p121, v128)
		if v129 == nil then
			return 0, 0
		end
		v126 = v126 + v129 * v124
		v127 = v127 + v130 * v124
	end
	return v126, v127
end
v4.AirRule = v_u_43
v4.AirFor = v_u_76
function v4.Landed(p131, p132) -- name: Landed
	-- upvalues: (copy) v_u_44, (copy) v_u_14
	local v133
	if typeof(p131) == "Instance" then
		v133 = v_u_44[p131]
	else
		v133 = nil
	end
	if not v133 or v133.LandedAt == nil then
		return math.huge, 0
	end
	if not v_u_14(p132) then
		p132 = os.clock()
	end
	local v134 = p132 - v133.LandedAt
	return math.max(0, v134), v133.fell or 0
end
function v4.Airborne(p_u_135, p_u_136, p137) -- name: Airborne
	-- upvalues: (copy) v_u_76, (copy) v_u_37, (copy) v_u_83, (copy) v_u_43
	if typeof(p_u_135) == "Instance" and p_u_135:IsA("Humanoid") then
		local v138 = v_u_76(p_u_135)
		local v139, v140 = pcall(function()
			-- upvalues: (copy) p_u_135
			return p_u_135:GetState().Name
		end)
		if not v139 or type(v140) ~= "string" then
			v140 = nil
		end
		local v141 = v140 == "Swimming"
		if v138 <= 0 and (p137 == true or v140 ~= "Jumping") then
			return false
		else
			local v_u_142 = false
			local function v143()
				-- upvalues: (ref) v_u_142, (copy) p_u_135
				v_u_142 = p_u_135.Sit == true and true or p_u_135.SeatPart ~= nil
			end
			pcall(v143)
			local v_u_144 = false
			if typeof(p_u_136) == "Instance" and p_u_136:IsA("BasePart") then
				pcall(function()
					-- upvalues: (copy) p_u_136, (ref) v_u_144
					local v145 = p_u_136
					local v146 = v145.Anchored
					if not v146 then
						if v145.AssemblyRootPart == nil then
							v146 = false
						else
							v146 = v145.AssemblyRootPart ~= v145
						end
					end
					v_u_144 = v146
				end)
			end
			local v_u_147 = false
			if p137 ~= true and (typeof(p_u_136) == "Instance" and p_u_136:IsA("BasePart")) then
				local function v148()
					-- upvalues: (ref) v_u_147, (copy) p_u_136, (ref) v_u_37
					v_u_147 = p_u_136.AssemblyLinearVelocity.Y > v_u_37.RiseSpeed
				end
				pcall(v148)
			end
			local v149 = {
				["water"] = false,
				["air"] = v138 > 0,
				["airFor"] = v138,
				["state"] = v140,
				["seated"] = v_u_142,
				["attached"] = v_u_144,
				["rising"] = v_u_147,
				["NeedWater"] = p137 == true
			}
			if p137 == true and (v141 and (typeof(p_u_136) == "Instance" and p_u_136:IsA("BasePart"))) then
				v149.water = v_u_83(p_u_136.Position)
			end
			if p137 == true then
				return v_u_43(v149, v_u_37.SERVER_GRACE, false)
			else
				return v_u_43(v149, v_u_37.ClientGrace, true)
			end
		end
	else
		return false
	end
end
function v4.RateTol(p150, p151) -- name: RateTol
	-- upvalues: (copy) v_u_84, (copy) v_u_14
	local v152 = v_u_84
	local v153 = (not v_u_14(p150) or p150 <= 0) and 0.1 or p150
	local v154
	if p151 == true then
		local v155 = v152.AutoCreditMax
		local v156 = v153 * v152.AutoCreditShare
		v154 = math.min(v155, v156)
	else
		local v157 = v152.SemiCreditMax
		local v158 = v153 * v152.SemiCreditShare
		v154 = math.min(v157, v158)
	end
	return v152.Jitter + v154
end
function v4.RateGate(p159, p160, p161, p162) -- name: RateGate
	-- upvalues: (copy) v_u_14
	local v163 = not v_u_14(p160) and 0 or p160
	if p159 < v163 - p162 then
		return false, v163, v163 - p159
	else
		return true, math.max(p159, v163) + p161, 0
	end
end
function v4.ClientSlot(p164, p165, p166, p167, p168) -- name: ClientSlot
	-- upvalues: (copy) v_u_84, (copy) v_u_14
	local v169 = v_u_84
	local v170 = (not v_u_14(p166) or p166 <= 0) and 0.5 or p166
	if type(p165) ~= "number" or p165 ~= p165 then
		p165 = -math.huge
	end
	local v171 = p165 + v170
	if p164 < v171 then
		return false, p165
	end
	if p167 ~= true or (p168 ~= true or p164 - v171 >= v169.ClientCatchup) then
		return true, p164
	end
	local v172 = p165 + v170 + v169.AutoSlack
	return true, math.min(p164, v172)
end
function v4.BunchStep(p173, p174, p175) -- name: BunchStep
	-- upvalues: (copy) v_u_84, (copy) v_u_14
	local v176 = v_u_84
	local v177 = (not v_u_14(p175) or p175 <= 0) and 0.1 or p175
	local v178
	if v_u_14(p173.at) then
		v178 = p173.at
	else
		v178 = -math.huge
	end
	local v179
	if v_u_14(p173.start) then
		v179 = p173.start
	else
		v179 = -math.huge
	end
	local v180 = not v_u_14(p173.gap) and 0 or p173.gap
	local v181, v182
	if v177 * v176.HitchShare <= v180 then
		local v183 = p174 - v179
		local v184 = v176.RecoverMax
		if v183 <= math.min(v180, v184) then
			p173.n = (not v_u_14(p173.n) and 1 or p173.n) + 1
			p173.at = p174
		else
			p173.start = p174
			v181 = p174 - v178
			v182 = v176.GAP_MAX
			p173.gap = math.clamp(v181, 0, v182)
			p173.n = 1
			p173.at = p174
		end
	else
		p173.start = p174
		v181 = p174 - v178
		v182 = v176.GAP_MAX
		p173.gap = math.clamp(v181, 0, v182)
		p173.n = 1
		p173.at = p174
		return
	end
end
function v4.BunchLegit(p185, p186) -- name: BunchLegit
	-- upvalues: (copy) v_u_84, (copy) v_u_14
	local v187 = v_u_84
	local v188 = (not v_u_14(p186) or p186 <= 0) and 0.1 or p186
	local v189 = not v_u_14(p185.gap) and 0 or p185.gap
	if v189 < v188 * v187.HitchShare or not (v_u_14(p185.start) and v_u_14(p185.at)) then
		return false
	else
		return (not v_u_14(p185.n) and 1 or p185.n) <= (v189 + (p185.at - p185.start)) / v188 + v187.BunchSpare
	end
end
v4.OriginAhead = v_u_89
v4.SegDist = v_u_109
function v4.OriginLagDist(p190, p191, p192, p193, p194, p195, p196, p197, p198) -- name: OriginLagDist
	-- upvalues: (copy) v_u_89, (copy) v_u_109
	local v199 = p196 * p196 + p197 * p197 + p198 * p198
	local v200 = math.sqrt(v199)
	local v201 = v200 <= 0.5 and 0 or v_u_89(v200) / v200
	return v_u_109(p190, p191, p192, p193, p194, p195, p193 + p196 * v201, p194 + p197 * v201, p195 + p198 * v201)
end
if game:GetService("RunService"):IsClient() then
	local v_u_202 = {
		["Depth"] = 12,
		["Source"] = debug.info(1, "s"),
		["Roots"] = {
			"ReplicatedFirst.",
			"ReplicatedStorage.",
			"StarterPlayer.",
			"Players.",
			"Workspace."
		},
		["Globals"] = {
			"getgenv",
			"getrenv",
			"getsenv",
			"getgc",
			"getreg",
			"hookfunction",
			"hookmetamethod",
			"getrawmetatable",
			"setrawmetatable",
			"newcclosure",
			"checkcaller",
			"identifyexecutor",
			"getexecutorname",
			"getupvalue",
			"setupvalue",
			"getconstants",
			"getprotos",
			"isexecutorclosure",
			"loadfile",
			"writefile"
		},
		["Verdicts"] = setmetatable({}, {
			["__mode"] = "k"
		})
	}
	local function v_u_209(p203, p204)
		-- upvalues: (copy) v_u_202
		if p203 ~= v_u_202.Source then
			local v205 = false
			for _, v206 in next, v_u_202.Roots do
				local v207 = #v206
				if string.sub(p203, 1, v207) ~= v206 then
					continue
				end
				v205 = true
			end
			if not v205 then
				return false
			end
		end
		if type(p204) ~= "table" then
			return false
		end
		for _, v208 in next, v_u_202.Globals do
			if p204[v208] == nil then
				continue
			end
			return false
		end
		return p204._G == _G
	end
	local function v_u_214()
		-- upvalues: (copy) v_u_202, (copy) v_u_209
		for v210 = 3, v_u_202.Depth do
			local v211, v212 = debug.info(v210, "sf")
			if v211 == nil then
				return false
			end
			if v211 == "[C]" then
				continue
			end
			local v213 = v_u_202.Verdicts[v212]
			if v213 == nil then
				v213 = v_u_209(v211, getfenv(v210))
				v_u_202.Verdicts[v212] = v213
			end
			return v213
		end
		return false
	end
	for v215, v_u_216 in next, v4 do
		if type(v_u_216) ~= "function" then
			continue
		end
		v4[v215] = function(...)
			-- upvalues: (copy) v_u_214, (copy) v_u_216
			if v_u_214() then
				return v_u_216(...)
			else
				return error("Invalid Arguments")
			end
		end
	end
end
return v4
