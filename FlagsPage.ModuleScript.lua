--!native
-- Path: FlagsPage.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v_u_1 = require(script.Parent.Buttons)
local v_u_2 = {
	["MORE"] = {
		"clear",
		"watch",
		"aim",
		"esp",
		"freeze",
		"live",
		"trial",
		"evidence",
		"save",
		"watchlist"
	},
	["ACTIONS"] = {
		"goto",
		"spectate",
		"replay",
		"ban",
		"more"
	},
	["FILTERS"] = {
		"all",
		"online",
		"here",
		"canban",
		"watch"
	},
	["KINDS"] = {
		"any",
		"movement",
		"aim",
		"combat",
		"base",
		"other"
	},
	["VIEWS"] = {
		"flags",
		"hits",
		"inv",
		"intel",
		"replays"
	}
}
local v_u_3 = v_u_1.P
local v_u_4 = v_u_1.DARK_TEXT
local function v_u_8(p5, p6) -- name: find
	for _, v7 in ipairs(p6) do
		p5 = p5:FindFirstChild(v7)
		if p5 then
			continue
		end
		error("flags page template is missing " .. table.concat(p6, "/"))
	end
	return p5
end
function v_u_2.mount(p9, p10, p_u_11) -- name: mount
	-- upvalues: (copy) v_u_8, (copy) v_u_1, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v12 = p9:FindFirstChild("Pages")
	if v12 then
		v12 = v12:FindFirstChild("Flags")
	end
	if not (v12 and v12:IsA("Frame")) then
		return nil
	end
	local v_u_13 = v12:Clone()
	local function v14(...) -- name: f
		-- upvalues: (ref) v_u_8, (copy) v_u_13
		return v_u_8(v_u_13, { ... })
	end
	local v_u_15 = v14("List", "Search")
	local v_u_16 = v14("List", "Sort")
	local v_u_17 = v14("List", "Filters")
	local v_u_18 = v_u_13:FindFirstChild("List")
	if v_u_18 then
		v_u_18 = v_u_13.List:FindFirstChild("Kinds")
	end
	local v_u_19 = v14("List", "Status")
	local v20 = v14("List", "Tools", "Guide")
	local v_u_21 = v14("List", "Tools", "ClearAll")
	local v_u_22 = v14("List", "Rows")
	local v_u_23 = v14("List", "Rows", "Empty")
	local v_u_24 = v14("List", "Watch")
	local v_u_25 = v14("List", "Watch", "Empty")
	local v_u_26 = v14("Detail", "None")
	local v_u_27 = v14("Detail", "Info")
	local v_u_28 = v14("Detail", "Info", "Head", "Name")
	local v_u_29 = v14("Detail", "Info", "Head", "Score")
	local v_u_30 = v14("Detail", "Info", "Head", "Sub")
	local v_u_31 = v14("Detail", "Info", "Meters")
	local v_u_32 = v14("Detail", "Info", "Actions")
	local v_u_33 = v14("Detail", "Info", "Views")
	local v_u_34 = v14("Detail", "Info", "Body")
	local v_u_35 = v14("Detail", "Info", "Body", "Empty")
	local v_u_36 = v14("Detail", "Info", "Intel")
	local v_u_37 = v14("Detail", "Info", "Intel", "Watch", "Status")
	local v_u_38 = v14("Detail", "Info", "Intel", "Watch", "Note")
	local v_u_39 = v14("Detail", "Info", "Intel", "Watch", "Buttons", "Save")
	local v_u_40 = v14("Detail", "Info", "Intel", "Watch", "Buttons", "Remove")
	local v41 = v14("Detail", "Info", "Intel", "Lines")
	local v_u_42 = v14("Detail", "More")
	local v_u_43 = v14("Templates")
	local v_u_44 = {}
	local v_u_45 = v_u_1.set()
	local v_u_46 = v_u_45.paint
	local v_u_47 = v_u_45.press
	local v48 = v_u_45.wire
	local v_u_52 = v_u_1.pool(v41, function()
		-- upvalues: (copy) v_u_43
		local v49 = v_u_43:FindFirstChild("Text")
		local v50
		if v49 then
			v50 = v49:IsA("GuiObject")
		else
			v50 = v49
		end
		assert(v50, "flags page template missing Text")
		local v51 = v49:Clone()
		v51.Visible = true
		return v51
	end)
	local v_u_56 = v_u_1.pool(v_u_34, function()
		-- upvalues: (copy) v_u_43
		local v53 = v_u_43:FindFirstChild("Line")
		local v54
		if v53 then
			v54 = v53:IsA("GuiObject")
		else
			v54 = v53
		end
		assert(v54, "flags page template missing Line")
		local v55 = v53:Clone()
		v55.Visible = true
		return v55
	end)
	local v57 = v_u_15:GetPropertyChangedSignal("Text")
	table.insert(v_u_44, v57:Connect(function()
		-- upvalues: (copy) v_u_15, (copy) p_u_11
		local v58 = v_u_15.Text
		if #v58 > 40 then
			v_u_15.Text = string.sub(v58, 1, 40)
		else
			p_u_11.search(v58)
		end
	end))
	local v59 = v_u_16.Activated
	local v60 = p_u_11.sort
	table.insert(v_u_44, v59:Connect(v60))
	local v_u_61 = {}
	local v_u_62 = {}
	local v_u_63 = {}
	local v_u_64 = {}
	local v_u_65 = {}
	local v_u_66 = true
	local v_u_67 = nil
	local v_u_68 = {}
	for _, v_u_69 in ipairs(v_u_2.FILTERS) do
		local v70 = v_u_17:FindFirstChild(v_u_69)
		local v71
		if v70 then
			v71 = v70:IsA("TextButton")
		else
			v71 = v70
		end
		local v72 = "flags page button missing " .. v_u_69
		assert(v71, v72)
		local v73 = v70.Activated
		table.insert(v_u_44, v73:Connect(function()
			-- upvalues: (copy) p_u_11, (copy) v_u_69
			p_u_11.filter(v_u_69)
		end))
	end
	if v_u_18 and p_u_11.kind then
		for _, v_u_74 in ipairs(v_u_2.KINDS) do
			local v75 = v_u_18:FindFirstChild(v_u_74)
			if not (v75 and v75:IsA("TextButton")) then
				continue
			end
			local v76 = v75.Activated
			table.insert(v_u_44, v76:Connect(function()
				-- upvalues: (copy) p_u_11, (copy) v_u_74
				p_u_11.kind(v_u_74)
			end))
		end
	end
	local v77 = v20.Activated
	local v78 = p_u_11.guide
	table.insert(v_u_44, v77:Connect(v78))
	v_u_45.state(v_u_21, {
		["text"] = "Clear all",
		["on"] = true,
		["visible"] = false,
		["tone"] = "hover",
		["confirm"] = "Clear every flag?"
	})
	v48(v_u_21, p_u_11.clearAll)
	for _, v_u_79 in ipairs(v_u_2.ACTIONS) do
		local v80 = v_u_32:FindFirstChild(v_u_79)
		local v81
		if v80 then
			v81 = v80:IsA("TextButton")
		else
			v81 = v80
		end
		local v82 = "flags page button missing " .. v_u_79
		assert(v81, v82)
		if v_u_79 == "more" then
			local v83 = v80.Activated
			table.insert(v_u_44, v83:Connect(function()
				-- upvalues: (copy) v_u_42
				v_u_42.Visible = not v_u_42.Visible
			end))
		else
			v48(v80, function()
				-- upvalues: (copy) p_u_11, (copy) v_u_79
				p_u_11.action(v_u_79)
			end)
		end
	end
	if not v_u_42:FindFirstChild("save") then
		local v84 = v_u_42:FindFirstChild("evidence")
		if v84 and v84:IsA("TextButton") then
			local v85 = v84:Clone()
			v85.Name = "save"
			v85.LayoutOrder = v84.LayoutOrder + 1
			v85.Parent = v_u_42
		end
	end
	for _, v_u_86 in ipairs(v_u_2.MORE) do
		local v87 = v_u_42:FindFirstChild(v_u_86)
		local v88
		if v87 then
			v88 = v87:IsA("TextButton")
		else
			v88 = v87
		end
		local v89 = "flags page button missing " .. v_u_86
		assert(v88, v89)
		v48(v87, function()
			-- upvalues: (copy) v_u_42, (copy) p_u_11, (copy) v_u_86
			v_u_42.Visible = false
			p_u_11.action(v_u_86)
		end)
	end
	for _, v_u_90 in ipairs(v_u_2.VIEWS) do
		local v91 = v_u_33:FindFirstChild(v_u_90)
		local v92
		if v91 then
			v92 = v91:IsA("TextButton")
		else
			v92 = v91
		end
		local v93 = "flags page button missing " .. v_u_90
		assert(v92, v93)
		local v94 = v91.Activated
		table.insert(v_u_44, v94:Connect(function()
			-- upvalues: (copy) v_u_42, (copy) p_u_11, (copy) v_u_90
			v_u_42.Visible = false
			p_u_11.view(v_u_90)
		end))
	end
	v48(v_u_39, function()
		-- upvalues: (copy) p_u_11, (copy) v_u_38
		p_u_11.watchSave(v_u_38.Text)
	end)
	v48(v_u_40, p_u_11.watchRemove)
	local v95 = v_u_38:GetPropertyChangedSignal("Text")
	table.insert(v_u_44, v95:Connect(function()
		-- upvalues: (copy) v_u_38
		if #v_u_38.Text > 200 then
			local v96 = v_u_38
			local v97 = v_u_38.Text
			v96.Text = string.sub(v97, 1, 200)
		end
	end))
	local function v_u_101(p98) -- name: dropRow
		-- upvalues: (copy) v_u_65, (copy) v_u_61
		local v99 = v_u_65[p98]
		if v99 then
			v99:Destroy()
		end
		v_u_65[p98] = nil
		for _, v100 in ipairs(v_u_61[p98] or {}) do
			v100:Disconnect()
		end
		v_u_61[p98] = nil
	end
	local function v_u_106(p102, p103) -- name: clearList
		for _, v104 in ipairs(p103) do
			v104:Disconnect()
		end
		table.clear(p103)
		for _, v105 in ipairs(p102) do
			v105:Destroy()
		end
		table.clear(p102)
	end
	local v216 = {
		["renderList"] = function(p107) -- name: renderList
			-- upvalues: (ref) v_u_66, (copy) v_u_16, (ref) v_u_2, (copy) v_u_17, (ref) v_u_3, (copy) v_u_18, (copy) v_u_19, (copy) v_u_46, (copy) v_u_21, (copy) v_u_22, (copy) v_u_24, (copy) v_u_106, (copy) v_u_64, (copy) v_u_62, (copy) v_u_43, (copy) p_u_11, (copy) v_u_45, (copy) v_u_47, (copy) v_u_25, (copy) v_u_65, (copy) v_u_61, (copy) v_u_101, (copy) v_u_23
			if v_u_66 then
				v_u_16.Text = p107.sort == "score" and "Score" or "Newest"
				for _, v108 in ipairs(v_u_2.FILTERS) do
					local v109 = v_u_17:FindFirstChild(v108)
					local v110
					if v109 then
						v110 = v109:IsA("TextButton")
					else
						v110 = v109
					end
					local v111 = "flags page button missing " .. v108
					assert(v110, v111)
					local v112
					if p107.filter == v108 then
						v112 = v_u_3.rust
					else
						v112 = v_u_3.raised
					end
					v109.BackgroundColor3 = v112
				end
				if v_u_18 then
					for _, v113 in ipairs(v_u_2.KINDS) do
						local v114 = v_u_18:FindFirstChild(v113)
						if not (v114 and v114:IsA("TextButton")) then
							continue
						end
						local v115
						if (p107.kind or "any") == v113 then
							v115 = v_u_3.rust
						else
							v115 = v_u_3.raised
						end
						v114.BackgroundColor3 = v115
					end
				end
				v_u_19.Text = p107.status
				v_u_46(v_u_21, {
					["text"] = "Clear all",
					["on"] = true,
					["visible"] = nil,
					["tone"] = "hover",
					["confirm"] = "Clear every flag?",
					["visible"] = p107.clearAll
				}, "hover")
				local v116 = p107.watch ~= nil
				v_u_22.Visible = not v116
				v_u_24.Visible = v116
				if v116 then
					v_u_106(v_u_64, v_u_62)
					for v117, v118 in ipairs(p107.watch) do
						local v119 = v_u_43:FindFirstChild("WatchRow")
						local v120
						if v119 then
							v120 = v119:IsA("GuiObject")
						else
							v120 = v119
						end
						assert(v120, "flags page template missing WatchRow")
						local v121 = v119:Clone()
						v121.Visible = true
						v121.LayoutOrder = v117
						local v122
						if v118.selected then
							v122 = v_u_3.hover
						else
							v122 = v_u_3.raised
						end
						v121.BackgroundColor3 = v122
						v121:FindFirstChild("Name").Text = v118.name
						local v123 = v121:FindFirstChild("Note")
						v123.Text = v118.note
						v123.TextColor3 = v_u_3[v118.noteTone] or v_u_3.text
						v121:FindFirstChild("Sub").Text = v118.sub
						local v_u_124 = v118.uid
						local v125 = v121:FindFirstChild("Jump")
						local v_u_126 = v121:FindFirstChild("Remove")
						local v127 = v_u_62
						local v128 = v125.Activated
						local function v129()
							-- upvalues: (ref) p_u_11, (copy) v_u_124
							p_u_11.watchJump(v_u_124)
						end
						table.insert(v127, v128:Connect(v129))
						v_u_45.state(v_u_126, {
							["text"] = "Remove",
							["on"] = true,
							["visible"] = true,
							["tone"] = "hover",
							["confirm"] = "Sure?"
						})
						local v130 = v_u_62
						local v131 = v_u_126.Activated
						local function v132()
							-- upvalues: (ref) v_u_47, (copy) v_u_126, (ref) p_u_11, (copy) v_u_124
							v_u_47(v_u_126, function()
								-- upvalues: (ref) p_u_11, (ref) v_u_124
								p_u_11.watchDrop(v_u_124)
							end)
						end
						table.insert(v130, v131:Connect(v132))
						v121.Parent = v_u_24
						local v133 = v_u_64
						table.insert(v133, v121)
					end
					v_u_25.Visible = #p107.watch == 0
					v_u_25.Text = p107.empty
				else
					local v134 = {}
					for v135, v136 in ipairs(p107.rows) do
						v134[v136.uid] = true
						local v137 = v_u_65[v136.uid]
						if not v137 then
							local v138 = v_u_43:FindFirstChild("Row")
							local v139
							if v138 then
								v139 = v138:IsA("GuiObject")
							else
								v139 = v138
							end
							assert(v139, "flags page template missing Row")
							v137 = v138:Clone()
							v137.Visible = true
							local v_u_140 = v136.uid
							v_u_61[v_u_140] = { v137.Activated:Connect(function()
									-- upvalues: (ref) p_u_11, (copy) v_u_140
									p_u_11.select(v_u_140)
								end) }
							v137.Parent = v_u_22
							v_u_65[v_u_140] = v137
						end
						v137.LayoutOrder = v135
						v137.BackgroundColor3 = v_u_3[v136.bg] or v_u_3.raised
						v137:FindFirstChild("Name").Text = v136.name
						local v141 = v137:FindFirstChild("Score")
						v141.Text = v136.score
						v141.TextColor3 = v_u_3[v136.scoreTone] or v_u_3.muted
						v137:FindFirstChild("Sub").Text = v136.sub
						local v142 = v137:FindFirstChild("Mark")
						v142.Visible = v136.mark ~= nil
						if v136.mark then
							v142.BackgroundColor3 = v_u_3[v136.mark] or v_u_3.rust
						end
						local v143 = v137:FindFirstChild("Track"):FindFirstChild("Fill")
						local v144 = UDim2.fromScale
						local v145 = v136.fill
						v143.Size = v144(math.clamp(v145, 0, 1), 1)
						v143.BackgroundColor3 = v_u_3[v136.fillTone] or v_u_3.amber
					end
					for v146 in pairs(v_u_65) do
						if v134[v146] then
							continue
						end
						v_u_101(v146)
					end
					v_u_23.Visible = #p107.rows == 0
					v_u_23.Text = p107.empty
				end
			else
				return
			end
		end,
		["renderDetail"] = function(p147) -- name: renderDetail
			-- upvalues: (ref) v_u_66, (copy) v_u_26, (copy) v_u_27, (copy) v_u_42, (copy) v_u_28, (copy) v_u_29, (ref) v_u_3, (copy) v_u_30, (copy) v_u_31, (ref) v_u_2, (copy) v_u_32, (copy) v_u_46, (copy) v_u_33, (copy) v_u_36, (copy) v_u_34, (copy) v_u_37, (ref) v_u_67, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40, (copy) v_u_52, (copy) v_u_63, (copy) v_u_43, (copy) v_u_68, (copy) p_u_11, (ref) v_u_4, (copy) v_u_35, (copy) v_u_56
			if v_u_66 then
				if p147.none then
					v_u_26.Text = p147.none
					v_u_26.Visible = true
					v_u_27.Visible = false
					v_u_42.Visible = false
					return
				else
					v_u_26.Visible = false
					v_u_27.Visible = true
					v_u_28.Text = p147.name
					v_u_29.Text = p147.score
					v_u_29.TextColor3 = v_u_3[p147.scoreTone] or v_u_3.muted
					v_u_30.Text = p147.sub
					local v148 = p147.meters
					v_u_31.Visible = v148 ~= nil
					if v148 then
						for v149, v150 in ipairs({
							"Kick",
							"Strict",
							"Ban",
							"Sure"
						}) do
							local v151 = v_u_31:FindFirstChild(v150)
							local v152 = v148[v149]
							if not (v151 and v152) then
								continue
							end
							v151:FindFirstChild("Label").Text = v152.label
							local v153 = v151:FindFirstChild("Track"):FindFirstChild("Fill")
							local v154 = UDim2.fromScale
							local v155 = v152.fill
							v153.Size = v154(math.clamp(v155, 0, 1), 1)
							v153.BackgroundColor3 = v_u_3[v152.tone] or v_u_3.amber
						end
					end
					for _, v156 in ipairs(v_u_2.ACTIONS) do
						local v157 = v_u_32:FindFirstChild(v156)
						local v158
						if v157 then
							v158 = v157:IsA("TextButton")
						else
							v158 = v157
						end
						local v159 = "flags page button missing " .. v156
						assert(v158, v159)
						local v160 = p147.actions[v156]
						if v160 then
							v_u_46(v157, v160, v156 == "ban" and "rust" or "raised")
						elseif v156 == "more" then
							local v161 = false
							for _, v162 in pairs(p147.more) do
								v161 = v161 or v162.visible
							end
							v157.Visible = v161
							local v163
							if v_u_42.Visible then
								v163 = v_u_3.hover
							else
								v163 = v_u_3.raised
							end
							v157.BackgroundColor3 = v163
						else
							v157.Visible = false
						end
					end
					for _, v164 in ipairs(v_u_2.MORE) do
						local v165 = v_u_42:FindFirstChild(v164)
						local v166
						if v165 then
							v166 = v165:IsA("TextButton")
						else
							v166 = v165
						end
						local v167 = "flags page button missing " .. v164
						assert(v166, v167)
						local v168 = p147.more[v164]
						if v168 then
							v_u_46(v165, v168, "hover")
						else
							v165.Visible = false
						end
					end
					for _, v169 in ipairs(v_u_2.VIEWS) do
						local v170 = v_u_33:FindFirstChild(v169)
						local v171
						if v170 then
							v171 = v170:IsA("TextButton")
						else
							v171 = v170
						end
						local v172 = "flags page button missing " .. v169
						assert(v171, v172)
						v170.Visible = p147.views[v169] == true
						local v173
						if p147.view == v169 then
							v173 = v_u_3.rust
						else
							v173 = v_u_3.raised
						end
						v170.BackgroundColor3 = v173
					end
					local v174 = p147.intel
					v_u_36.Visible = v174 ~= nil
					v_u_34.Visible = v174 == nil
					if v174 then
						v_u_37.Text = v174.status
						if v174.note ~= nil and v_u_67 ~= p147.name then
							v_u_67 = p147.name
							v_u_38.Text = v174.note
						end
						v_u_46(v_u_39, v174.save, "rust")
						v_u_46(v_u_40, v174.remove, "hover")
						for v175, v176 in ipairs(v174.lines) do
							v_u_52.take(v175).Text = v176
						end
						v_u_52.trim(#v174.lines)
					else
						v_u_67 = nil
						local v177 = {}
						if p147.flags then
							for v178, v179 in ipairs(p147.flags) do
								v177[v179.key] = true
								local v180 = v_u_63[v179.key]
								if not v180 then
									local v181 = v_u_43:FindFirstChild("FlagRow")
									local v182
									if v181 then
										v182 = v181:IsA("GuiObject")
									else
										v182 = v181
									end
									assert(v182, "flags page template missing FlagRow")
									local v_u_183 = v181:Clone()
									v_u_183.Visible = true
									local v_u_184 = v179.key
									local v_u_185 = v_u_183:FindFirstChild("Detail")
									local v189 = v_u_183.Activated:Connect(function()
										-- upvalues: (ref) v_u_68, (copy) v_u_184, (copy) v_u_183, (copy) v_u_185
										v_u_68[v_u_184] = not v_u_68[v_u_184] or nil
										local v186 = v_u_68[v_u_184] == true
										local v187 = v_u_183
										local v188
										if v186 then
											v188 = Enum.AutomaticSize.Y
										else
											v188 = Enum.AutomaticSize.None
										end
										v187.AutomaticSize = v188
										v_u_183.Size = UDim2.new(1, 0, 0, 22)
										v_u_185.Visible = v186
									end)
									local v190 = v_u_68[v_u_184] == true
									local v191
									if v190 then
										v191 = Enum.AutomaticSize.Y
									else
										v191 = Enum.AutomaticSize.None
									end
									v_u_183.AutomaticSize = v191
									v_u_183.Size = UDim2.new(1, 0, 0, 22)
									v_u_185.Visible = v190
									local v192 = v_u_183:FindFirstChild("Watch")
									local v193
									if v192 and v192:IsA("TextButton") then
										v193 = v192.Activated:Connect(function()
											-- upvalues: (ref) v_u_63, (copy) v_u_184, (ref) p_u_11
											local v194 = v_u_63[v_u_184]
											local v195 = p_u_11.watchFlag
											if v194 and (v194.replay and v195) then
												v195(v194.replay, v194.at)
											end
										end)
									else
										v193 = nil
									end
									v_u_183.Parent = v_u_34
									v180 = {
										["row"] = v_u_183,
										["conn"] = v189,
										["watch"] = v193
									}
									v_u_63[v_u_184] = v180
								end
								local v196 = v179.replay
								local v197 = v179.replayAt
								v180.replay = v196
								v180.at = v197
								local v198 = v180.row
								v198.LayoutOrder = v178
								local v_u_199 = v198:FindFirstChild("Watch")
								local v_u_200
								if v_u_199 == nil or v179.replay == nil then
									v_u_200 = false
								else
									v_u_200 = p_u_11.watchFlag ~= nil
								end
								if v_u_199 then
									v_u_199.Visible = v_u_200
								end
								v198:FindFirstChild("Ago").Text = v179.ago
								local v_u_201 = v198:FindFirstChild("Label")
								v_u_201.Text = v179.label
								v198:FindFirstChild("Points").Text = v179.points
								local v_u_202 = v198:FindFirstChild("Tape")
								v_u_202.Visible = v179.tape ~= nil
								v_u_202.Position = UDim2.new(1, not (v_u_200 and v_u_199) and -52 or -56 - v_u_199.Size.X.Offset, 0, 3)
								if v179.tape then
									local v203 = v179.tapeTone or "rust"
									v_u_202.Text = v179.tape
									v_u_202.BackgroundColor3 = v_u_3[v203] or v_u_3.rust
									local v204
									if v_u_4[v203] then
										v204 = v_u_3.slot
									else
										v204 = v_u_3.text
									end
									v_u_202.TextColor3 = v204
								end
								v198:FindFirstChild("Detail").Text = v179.detail
								task.defer(function()
									-- upvalues: (copy) v_u_202, (copy) v_u_200, (copy) v_u_199, (copy) v_u_201
									local v205 = 110 + (not v_u_202.Visible and 0 or v_u_202.AbsoluteSize.X + 8) + (not (v_u_200 and v_u_199) and 0 or v_u_199.Size.X.Offset + 4)
									v_u_201.Size = UDim2.new(1, -v205, 0, 22)
								end)
							end
						end
						for v206, v207 in pairs(v_u_63) do
							if v177[v206] then
								continue
							end
							v207.conn:Disconnect()
							if v207.watch then
								v207.watch:Disconnect()
							end
							v207.row:Destroy()
							v_u_63[v206] = nil
						end
						if p147.flags then
							v_u_35.Visible = p147.empty ~= nil
						elseif p147.lines then
							for v208, v209 in ipairs(p147.lines) do
								local v210 = v_u_56.take(v208)
								v210:FindFirstChild("Left").Text = v209.left
								v210:FindFirstChild("Right").Text = v209.right or ""
								local v211 = v210:FindFirstChild("Sub")
								v211.Text = v209.sub or ""
								v211.Visible = v209.sub ~= nil
							end
						end
						v_u_56.trim(p147.lines and #p147.lines or 0)
						v_u_35.Visible = p147.empty ~= nil
						v_u_35.Text = p147.empty or ""
					end
				end
			else
				return
			end
		end,
		["setSearch"] = function(p212) -- name: setSearch
			-- upvalues: (copy) v_u_15
			if v_u_15.Text ~= p212 then
				v_u_15.Text = p212
			end
		end,
		["focusNote"] = function() -- name: focusNote
			-- upvalues: (copy) v_u_38
			v_u_38:CaptureFocus()
		end,
		["destroy"] = function() -- name: destroy
			-- upvalues: (ref) v_u_66, (copy) v_u_45, (copy) v_u_63, (copy) v_u_44, (copy) v_u_65, (copy) v_u_101, (copy) v_u_106, (copy) v_u_64, (copy) v_u_62, (copy) v_u_13
			if v_u_66 then
				v_u_66 = false
				v_u_45.destroy()
				for _, v213 in pairs(v_u_63) do
					v213.conn:Disconnect()
					if not v213.watch then
						continue
					end
					v213.watch:Disconnect()
				end
				table.clear(v_u_63)
				for _, v214 in ipairs(v_u_44) do
					v214:Disconnect()
				end
				table.clear(v_u_44)
				for v215 in pairs(v_u_65) do
					v_u_101(v215)
				end
				v_u_106(v_u_64, v_u_62)
				v_u_13:Destroy()
			end
		end,
		["alive"] = function() -- name: alive
			-- upvalues: (ref) v_u_66
			return v_u_66
		end
	}
	local v217 = p9.Destroying
	local v218 = v216.destroy
	table.insert(v_u_44, v217:Connect(v218))
	v_u_13.Visible = true
	v_u_13.Parent = p10
	return v216
end
return v_u_2
