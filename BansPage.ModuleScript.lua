--!native
-- Path: BansPage.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v_u_1 = require(script.Parent.Buttons)
local v_u_2 = {
	["VIEWS"] = { "bans", "requests" },
	["FILTERS"] = {
		"active",
		"perm",
		"timed",
		"ended",
		"all"
	},
	["ACTIONS"] = {
		"unban",
		"lookup",
		"again",
		"approve",
		"deny"
	},
	["SEARCH_WAIT"] = 0.35,
	["TEXT_MAX"] = 40
}
local function v_u_6(p3, p4) -- name: find
	for _, v5 in ipairs(p4) do
		p3 = p3:FindFirstChild(v5)
		if p3 then
			continue
		end
		error("bans page template is missing " .. table.concat(p4, "/"))
	end
	return p3
end
function v_u_2.mount(p7, p8, p_u_9) -- name: mount
	-- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_2
	local v10 = p7:FindFirstChild("Pages")
	if v10 then
		v10 = v10:FindFirstChild("Bans")
	end
	if not (v10 and v10:IsA("Frame")) then
		return nil
	end
	local v_u_11 = v_u_1.P
	local v_u_12 = v10:Clone()
	local function v13(...) -- name: f
		-- upvalues: (ref) v_u_6, (copy) v_u_12
		return v_u_6(v_u_12, { ... })
	end
	local v_u_14 = v13("List", "Views")
	local v_u_15 = v13("List", "Find", "Box")
	local v16 = v13("List", "Find", "Go")
	local v_u_17 = v13("List", "Search")
	local v_u_18 = v13("List", "Filters")
	local v_u_19 = v13("List", "Status")
	local v_u_20 = v13("List", "Rows")
	local v_u_21 = v13("List", "Rows", "Empty")
	local v_u_22 = v13("List", "Rows", "More")
	local v_u_23 = v13("Detail", "None")
	local v_u_24 = v13("Detail", "Info")
	local v_u_25 = v13("Detail", "Info", "Head", "Name")
	local v26 = v13("Detail", "Info", "Head", "Right", "Copy")
	local v_u_27 = v13("Detail", "Info", "Head", "Tapes", "State")
	local v_u_28 = v13("Detail", "Info", "Head", "Tapes", "Roblox")
	local v_u_29 = v13("Detail", "Info", "Head")
	local v_u_30 = v13("Detail", "Info", "Head", "Sub")
	local v_u_31 = v13("Detail", "Info", "Watch")
	local v_u_32 = v13("Detail", "Info", "Body")
	local v_u_33 = v13("Detail", "Info", "Body", "Text")
	local v_u_34 = v13("Detail", "Info", "Actions")
	local v_u_35 = v13("Templates")
	local v_u_36 = v_u_1.set()
	local v_u_37 = {}
	local v_u_38 = 0
	local v_u_39 = ""
	local v_u_40 = false
	local v_u_41 = true
	local v_u_42 = {}
	local v_u_43 = {}
	for _, v_u_44 in ipairs(v_u_2.VIEWS) do
		local v45 = v_u_14:FindFirstChild(v_u_44)
		local v46
		if v45 then
			v46 = v45:IsA("TextButton")
		else
			v46 = v45
		end
		local v47 = "bans page button missing " .. v_u_44
		assert(v46, v47)
		local v48 = v45.Activated
		table.insert(v_u_37, v48:Connect(function()
			-- upvalues: (copy) p_u_9, (copy) v_u_44
			p_u_9.view(v_u_44)
		end))
	end
	for _, v_u_49 in ipairs(v_u_2.FILTERS) do
		local v50 = v_u_18:FindFirstChild(v_u_49)
		local v51
		if v50 then
			v51 = v50:IsA("TextButton")
		else
			v51 = v50
		end
		local v52 = "bans page button missing " .. v_u_49
		assert(v51, v52)
		local v53 = v50.Activated
		table.insert(v_u_37, v53:Connect(function()
			-- upvalues: (copy) p_u_9, (copy) v_u_49
			p_u_9.filter(v_u_49)
		end))
	end
	local v54 = p_u_9.undo
	if type(v54) == "function" then
		local v55 = v_u_18:FindFirstChild("all")
		local v56
		if v55 then
			v56 = v55:IsA("TextButton")
		else
			v56 = v55
		end
		assert(v56, "bans page button missing all")
		local v57 = v55:Clone()
		v57.Name = "undo"
		v57.Text = "UNDO"
		v57.LayoutOrder = 999
		v57.AutomaticSize = Enum.AutomaticSize.X
		v57.BackgroundColor3 = Color3.fromHex("9E3527")
		v57.TextColor3 = Color3.fromHex("ECE6DA")
		v57.Parent = v_u_18
		local v_u_58 = p_u_9.undo
		local v59 = v57.Activated
		table.insert(v_u_37, v59:Connect(function()
			-- upvalues: (copy) v_u_58
			v_u_58()
		end))
	end
	local v_u_60 = v_u_14:FindFirstChild("mass")
	local v61 = p_u_9.mass
	if v_u_60 and v61 then
		local v62 = v_u_60.Activated
		table.insert(v_u_37, v62:Connect(v61))
	end
	local v63 = v_u_15:GetPropertyChangedSignal("Text")
	local function v67()
		-- upvalues: (copy) v_u_15, (ref) v_u_2
		if #v_u_15.Text > v_u_2.TEXT_MAX then
			local v64 = v_u_15
			local v65 = v_u_15.Text
			local v66 = v_u_2.TEXT_MAX
			v64.Text = string.sub(v65, 1, v66)
		end
	end
	table.insert(v_u_37, v63:Connect(v67))
	local v68 = v_u_17:GetPropertyChangedSignal("Text")
	local function v72()
		-- upvalues: (copy) v_u_17, (ref) v_u_2
		if #v_u_17.Text > v_u_2.TEXT_MAX then
			local v69 = v_u_17
			local v70 = v_u_17.Text
			local v71 = v_u_2.TEXT_MAX
			v69.Text = string.sub(v70, 1, v71)
		end
	end
	table.insert(v_u_37, v68:Connect(v72))
	local v73 = v16.Activated
	table.insert(v_u_37, v73:Connect(function() -- name: submitFind
		-- upvalues: (copy) v_u_15, (copy) p_u_9
		local v74 = string.match(v_u_15.Text, "^%s*(.-)%s*$") or ""
		if v74 ~= "" then
			p_u_9.find(v74)
		end
	end))
	local v75 = v_u_15.FocusLost
	table.insert(v_u_37, v75:Connect(function(p76)
		-- upvalues: (copy) v_u_15, (copy) p_u_9
		if p76 then
			local v77 = string.match(v_u_15.Text, "^%s*(.-)%s*$") or ""
			if v77 ~= "" then
				p_u_9.find(v77)
			end
		end
	end))
	local v78 = v_u_17:GetPropertyChangedSignal("Text")
	local function v81()
		-- upvalues: (ref) v_u_40, (ref) v_u_38, (copy) v_u_17, (ref) v_u_2, (ref) v_u_41, (copy) p_u_9
		if not v_u_40 then
			v_u_38 = v_u_38 + 1
			local v_u_79 = v_u_38
			local v_u_80 = v_u_17.Text
			task.delay(v_u_2.SEARCH_WAIT, function()
				-- upvalues: (ref) v_u_41, (copy) v_u_79, (ref) v_u_38, (ref) p_u_9, (copy) v_u_80
				if v_u_41 and v_u_79 == v_u_38 then
					p_u_9.search(v_u_80)
				end
			end)
		end
	end
	table.insert(v_u_37, v78:Connect(v81))
	local v82 = v_u_22.Activated
	local v83 = p_u_9.more
	table.insert(v_u_37, v82:Connect(v83))
	local v84 = v26.Activated
	local v85 = p_u_9.copy
	table.insert(v_u_37, v84:Connect(v85))
	v_u_36.wire(v_u_31, p_u_9.watch)
	for _, v_u_86 in ipairs(v_u_2.ACTIONS) do
		local v87 = v_u_36.wire
		local v88 = v_u_34:FindFirstChild(v_u_86)
		local v89
		if v88 then
			v89 = v88:IsA("TextButton")
		else
			v89 = v88
		end
		local v90 = "bans page button missing " .. v_u_86
		assert(v89, v90)
		v87(v88, function()
			-- upvalues: (copy) p_u_9, (copy) v_u_86
			p_u_9.action(v_u_86)
		end)
	end
	local v141 = {
		["renderList"] = function(p91) -- name: renderList
			-- upvalues: (ref) v_u_41, (ref) v_u_2, (copy) v_u_14, (copy) v_u_11, (copy) v_u_60, (copy) v_u_17, (copy) v_u_18, (copy) v_u_19, (copy) v_u_20, (copy) v_u_43, (copy) v_u_35, (copy) v_u_42, (copy) p_u_9, (ref) v_u_1, (copy) v_u_21, (copy) v_u_22
			if v_u_41 then
				for _, v92 in ipairs(v_u_2.VIEWS) do
					local v93 = v_u_14:FindFirstChild(v92)
					local v94
					if v93 then
						v94 = v93:IsA("TextButton")
					else
						v94 = v93
					end
					local v95 = "bans page button missing " .. v92
					assert(v94, v95)
					local v96
					if p91.view == v92 then
						v96 = v_u_11.rust
					else
						v96 = v_u_11.raised
					end
					v93.BackgroundColor3 = v96
				end
				local v97 = v_u_14:FindFirstChild("requests")
				local v98
				if v97 then
					v98 = v97:IsA("TextButton")
				else
					v98 = v97
				end
				assert(v98, "bans page button missing requests")
				v97.Text = p91.requests
				local v99 = v_u_14:FindFirstChild("requests")
				local v100
				if v99 then
					v100 = v99:IsA("TextButton")
				else
					v100 = v99
				end
				assert(v100, "bans page button missing requests")
				v99.Visible = p91.requests ~= ""
				if v_u_60 then
					v_u_60.Visible = p91.mass == true
				end
				v_u_14.Visible = p91.requests ~= "" and true or p91.mass == true
				local v101 = p91.view == "bans"
				v_u_17.Visible = v101
				v_u_18.Visible = v101
				local v102 = v101 and 128 or 66
				v_u_19.Position = UDim2.fromOffset(0, v102)
				v_u_20.Position = UDim2.fromOffset(0, v102 + 22)
				v_u_20.Size = UDim2.new(1, 0, 1, -(v102 + 22))
				for _, v103 in ipairs(v_u_2.FILTERS) do
					local v104 = v_u_18:FindFirstChild(v103)
					local v105
					if v104 then
						v105 = v104:IsA("TextButton")
					else
						v105 = v104
					end
					local v106 = "bans page button missing " .. v103
					assert(v105, v106)
					local v107
					if p91.filter == v103 then
						v107 = v_u_11.rust
					else
						v107 = v_u_11.raised
					end
					v104.BackgroundColor3 = v107
				end
				v_u_19.Text = p91.status
				local v108 = {}
				for v109, v110 in ipairs(p91.rows) do
					v108[v110.key] = true
					local v111 = v_u_43[v110.key]
					if not v111 then
						v111 = v_u_35:FindFirstChild("Row"):Clone()
						v111.Visible = true
						local v_u_112 = v110.key
						v_u_42[v_u_112] = v111.Activated:Connect(function()
							-- upvalues: (ref) p_u_9, (copy) v_u_112
							p_u_9.select(v_u_112)
						end)
						v111.Parent = v_u_20
						v_u_43[v_u_112] = v111
					end
					v111.LayoutOrder = v109
					local v113
					if v110.selected then
						v113 = v_u_11.hover
					else
						v113 = v_u_11.raised
					end
					v111.BackgroundColor3 = v113
					v111:FindFirstChild("Mark").Visible = v110.selected
					v111:FindFirstChild("Name").Text = v110.name
					local v114 = v111:FindFirstChild("Tapes"):FindFirstChild("State")
					local v115 = v110.state
					local v116 = v110.stateTone
					v114.Text = v115
					v114.BackgroundColor3 = v_u_11[v116] or v_u_11.hover
					v114.TextColor3 = v_u_1.ink(v116)
					v111:FindFirstChild("Sub").Text = v110.sub
				end
				for v117 in pairs(v_u_43) do
					if v108[v117] then
						continue
					end
					local v118 = v_u_43[v117]
					if v118 then
						v118:Destroy()
					end
					v_u_43[v117] = nil
					local v119 = v_u_42[v117]
					if v119 then
						v119:Disconnect()
					end
					v_u_42[v117] = nil
				end
				v_u_21.Visible = #p91.rows == 0
				v_u_21.Text = p91.empty
				v_u_22.Visible = p91.more
			end
		end,
		["renderDetail"] = function(p120) -- name: renderDetail
			-- upvalues: (ref) v_u_41, (copy) v_u_23, (copy) v_u_24, (copy) v_u_25, (copy) v_u_30, (copy) v_u_27, (copy) v_u_11, (ref) v_u_1, (copy) v_u_28, (copy) v_u_33, (ref) v_u_39, (copy) v_u_32, (copy) v_u_36, (copy) v_u_31, (ref) v_u_2, (copy) v_u_34, (copy) v_u_29
			if v_u_41 then
				if p120.none then
					v_u_23.Text = p120.none
					v_u_23.Visible = true
					v_u_24.Visible = false
				else
					v_u_23.Visible = false
					v_u_24.Visible = true
					v_u_25.Text = p120.name
					v_u_30.Text = p120.sub
					local v121 = v_u_27
					local v122 = p120.state
					local v123 = p120.stateTone
					v121.Text = v122
					v121.BackgroundColor3 = v_u_11[v123] or v_u_11.hover
					v121.TextColor3 = v_u_1.ink(v123)
					v_u_28.Visible = p120.roblox ~= nil
					if p120.roblox then
						local v124 = v_u_28
						local v125 = p120.roblox
						local v126 = p120.robloxTone
						v124.Text = v125
						v124.BackgroundColor3 = v_u_11[v126] or v_u_11.hover
						v124.TextColor3 = v_u_1.ink(v126)
					end
					if v_u_33.Text ~= p120.body then
						v_u_33.Text = p120.body
					end
					if v_u_39 ~= p120.name .. p120.sub then
						v_u_39 = p120.name .. p120.sub
						v_u_32.CanvasPosition = Vector2.zero
					end
					v_u_36.paint(v_u_31, p120.watch, "rust")
					local v127 = 0
					for _, v128 in ipairs(v_u_2.ACTIONS) do
						local v129 = v_u_34:FindFirstChild(v128)
						local v130
						if v129 then
							v130 = v129:IsA("TextButton")
						else
							v130 = v129
						end
						local v131 = "bans page button missing " .. v128
						assert(v130, v131)
						local v132 = p120.actions[v128]
						if v132 then
							v_u_36.paint(v129, v132, (v128 == "again" or v128 == "approve") and "rust" or "raised")
							if not v132.visible then
								continue
							end
							v127 = v127 + 1
						else
							v129.Visible = false
						end
					end
					local v133 = v127 / 3
					local v134 = math.ceil(v133)
					v_u_34.Size = UDim2.new(1, 0, 0, v134 * 32)
					v_u_34.Visible = v127 > 0
					local v135 = v_u_29.Size.Y.Offset + 8 + (p120.watch.visible and 32 or 0) + (v127 <= 0 and 0 or v134 * 32 + 4)
					v_u_32.Size = UDim2.new(1, 0, 1, -v135)
				end
			else
				return
			end
		end,
		["setSearch"] = function(p136) -- name: setSearch
			-- upvalues: (ref) v_u_40, (copy) v_u_17
			v_u_40 = true
			v_u_17.Text = p136
			v_u_40 = false
		end,
		["clearFind"] = function() -- name: clearFind
			-- upvalues: (copy) v_u_15
			v_u_15.Text = ""
		end,
		["destroy"] = function() -- name: destroy
			-- upvalues: (ref) v_u_41, (copy) v_u_36, (copy) v_u_37, (copy) v_u_43, (copy) v_u_42, (copy) v_u_12
			if v_u_41 then
				v_u_41 = false
				v_u_36.destroy()
				for _, v137 in ipairs(v_u_37) do
					v137:Disconnect()
				end
				table.clear(v_u_37)
				for v138 in pairs(v_u_43) do
					local v139 = v_u_43[v138]
					if v139 then
						v139:Destroy()
					end
					v_u_43[v138] = nil
					local v140 = v_u_42[v138]
					if v140 then
						v140:Disconnect()
					end
					v_u_42[v138] = nil
				end
				v_u_12:Destroy()
			end
		end,
		["alive"] = function() -- name: alive
			-- upvalues: (ref) v_u_41
			return v_u_41
		end
	}
	local v142 = p7.Destroying
	local v143 = v141.destroy
	table.insert(v_u_37, v142:Connect(v143))
	v_u_12.Visible = true
	v_u_12.Parent = p8
	return v141
end
return v_u_2
