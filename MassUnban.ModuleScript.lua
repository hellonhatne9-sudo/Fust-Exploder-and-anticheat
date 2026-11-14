--!native
-- Path: MassUnban.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v_u_1 = {}
local v2 = Color3.fromHex
local v_u_3 = v2("222624")
local v_u_4 = v2("C2502A")
local v_u_5 = v2("D9A441")
local v_u_6 = v2("ECE6DA")
local v_u_7 = v2("0F1110")
local v_u_8 = v2("A3A79F")
local v_u_9 = v2("6E736C")
local v_u_10 = {
	["bad"] = v2("E0745A"),
	["good"] = v2("6FA35A"),
	["amber"] = v_u_5,
	["muted"] = v_u_8
}
v_u_1.CARD = Vector2.new(800, 560)
v_u_1.EDGE = 24
v_u_1.KINDS = { "auto", "staff", "wave" }
v_u_1.WHENS = {
	"1",
	"6",
	"24",
	"72",
	"any"
}
v_u_1.LENGTHS = { "any", "perm", "timed" }
v_u_1.BOXES = {
	"Words",
	"From",
	"To",
	"Min",
	"Max",
	"Player",
	"By",
	"Note"
}
local function v_u_14(p11, p12) -- name: need
	for _, v13 in p12 do
		p11 = p11:FindFirstChild(v13)
		if p11 then
			continue
		end
		error("mass unban template is missing " .. table.concat(p12, "/"))
	end
	return p11
end
function v_u_1.mount(p15, p_u_16) -- name: mount
	-- upvalues: (copy) v_u_14, (copy) v_u_1, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_8, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_5
	local v_u_17 = p15:FindFirstChild("Overlays")
	if v_u_17 then
		v_u_17 = v_u_17:FindFirstChild("MassUnban")
	end
	if not (v_u_17 and v_u_17:IsA("Frame")) then
		return nil
	end
	local function v18(...) -- name: f
		-- upvalues: (ref) v_u_14, (copy) v_u_17
		return v_u_14(v_u_17, { ... })
	end
	local v_u_19 = {}
	local v_u_20 = true
	local v21 = v18("Card")
	local v_u_22 = v18("Card", "Fit")
	local v_u_23 = v18("Card", "Sub")
	local v24 = v18("Card", "Filters")
	local v_u_25 = v18("Card", "Filters", "Kinds")
	local v_u_26 = v18("Card", "Filters", "Reasons")
	local v_u_27 = v18("Card", "Filters", "Reasons", "None")
	local v_u_28 = v18("Card", "Filters", "Whens")
	local v_u_29 = v18("Card", "Filters", "Lengths")
	local v_u_30 = v18("Card", "Filters", "LengthRange")
	local v_u_31 = v18("Card", "Filters", "Opts")
	local v_u_32 = v18("Card", "Preview", "Count")
	local v_u_33 = v18("Card", "Preview", "CountSub")
	local v_u_34 = v18("Card", "Preview", "Rows")
	local v_u_35 = v18("Card", "Preview", "Rows", "Empty")
	local v_u_36 = v18("Card", "Preview", "Foot", "Status")
	local v_u_37 = v18("Card", "Preview", "Foot", "Buttons", "Run")
	local v_u_38 = v18("Card", "Preview", "Foot", "Job")
	local v_u_39 = v18("Card", "Preview", "Foot", "Job", "Text")
	local v_u_40 = v18("Card", "Preview", "Foot", "Job", "Act")
	local v41 = v18("Templates")
	local v_u_42 = v_u_14(v41, { "Chip" })
	local v_u_43 = v_u_14(v41, { "Toggle" })
	local v_u_44 = v_u_14(v41, { "Row" })
	local v_u_45 = {
		["Words"] = v18("Card", "Filters", "Words"),
		["From"] = v18("Card", "Filters", "WhenRange", "From"),
		["To"] = v18("Card", "Filters", "WhenRange", "To"),
		["Min"] = v18("Card", "Filters", "LengthRange", "Min"),
		["Max"] = v18("Card", "Filters", "LengthRange", "Max"),
		["Player"] = v18("Card", "Filters", "Player"),
		["By"] = v18("Card", "Filters", "By"),
		["Note"] = v18("Card", "Preview", "Foot", "Note")
	}
	local v_u_46 = {}
	local v_u_47 = {}
	local v_u_48 = {}
	local v_u_49 = {}
	local v_u_50 = {}
	local v_u_51 = {}
	local v_u_52 = nil
	local function v56() -- name: shut
		-- upvalues: (ref) v_u_20, (copy) v_u_17, (ref) v_u_52, (copy) v_u_19, (copy) v_u_46, (copy) v_u_48, (copy) v_u_50
		if v_u_20 then
			v_u_20 = false
			v_u_17.Visible = false
			if v_u_52 then
				v_u_52:Disconnect()
				v_u_52 = nil
			end
			for _, v53 in v_u_19 do
				v53:Disconnect()
			end
			table.clear(v_u_19)
			for _, v54 in { v_u_46, v_u_48, v_u_50 } do
				for _, v55 in v54 do
					v55:Destroy()
				end
				table.clear(v54)
			end
		end
	end
	local function v_u_62() -- name: relayout
		-- upvalues: (copy) v_u_22, (ref) v_u_1
		local v57 = workspace.CurrentCamera
		local v58
		if v57 then
			v58 = v57.ViewportSize
		else
			v58 = Vector2.new(1280, 720)
		end
		local v59 = v_u_22
		local v60 = (v58.X - v_u_1.EDGE) / v_u_1.CARD.X
		local v61 = (v58.Y - v_u_1.EDGE) / v_u_1.CARD.Y
		v59.Scale = math.min(1, v60, v61)
	end
	local function v70() -- name: watchCamera
		-- upvalues: (ref) v_u_52, (copy) v_u_62, (copy) v_u_22, (ref) v_u_1
		if v_u_52 then
			v_u_52:Disconnect()
		end
		local v63 = workspace.CurrentCamera
		local v64
		if v63 then
			v64 = v63:GetPropertyChangedSignal("ViewportSize"):Connect(v_u_62)
		else
			v64 = nil
		end
		v_u_52 = v64
		local v65 = workspace.CurrentCamera
		local v66
		if v65 then
			v66 = v65.ViewportSize
		else
			v66 = Vector2.new(1280, 720)
		end
		local v67 = v_u_22
		local v68 = (v66.X - v_u_1.EDGE) / v_u_1.CARD.X
		local v69 = (v66.Y - v_u_1.EDGE) / v_u_1.CARD.Y
		v67.Scale = math.min(1, v68, v69)
	end
	local v71 = workspace:GetPropertyChangedSignal("CurrentCamera")
	table.insert(v_u_19, v71:Connect(v70))
	if v_u_52 then
		v_u_52:Disconnect()
	end
	local v72 = workspace.CurrentCamera
	if v72 then
		v_u_52 = v72:GetPropertyChangedSignal("ViewportSize"):Connect(v_u_62)
	else
		v_u_52 = nil
	end
	local v73 = workspace.CurrentCamera
	local v74
	if v73 then
		v74 = v73.ViewportSize
	else
		v74 = Vector2.new(1280, 720)
	end
	local v75 = (v74.X - v_u_1.EDGE) / v_u_1.CARD.X
	local v76 = (v74.Y - v_u_1.EDGE) / v_u_1.CARD.Y
	v_u_22.Scale = math.min(1, v75, v76)
	local v77 = v18("Shade").Activated
	local v78 = p_u_16.close
	table.insert(v_u_19, v77:Connect(v78))
	local v79 = v18("Card", "Close").Activated
	local v80 = p_u_16.close
	table.insert(v_u_19, v79:Connect(v80))
	local v81 = v18("Card", "Preview", "Foot", "Buttons", "Cancel").Activated
	local v82 = p_u_16.close
	table.insert(v_u_19, v81:Connect(v82))
	local v83 = v_u_37.Activated
	local v84 = p_u_16.run
	table.insert(v_u_19, v83:Connect(v84))
	local v85 = v_u_40.Activated
	local v86 = p_u_16.act
	table.insert(v_u_19, v85:Connect(v86))
	local v87 = v18("Card", "Preview", "Bulk", "None").Activated
	table.insert(v_u_19, v87:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16.bulk(false)
	end))
	local v88 = v18("Card", "Preview", "Bulk", "All").Activated
	table.insert(v_u_19, v88:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16.bulk(true)
	end))
	local v89 = p15.Destroying
	table.insert(v_u_19, v89:Connect(v56))
	local v_u_90 = v_u_20
	for _, v_u_91 in v_u_1.KINDS do
		local v92 = v_u_14(v_u_25, { v_u_91 }).Activated
		table.insert(v_u_19, v92:Connect(function()
			-- upvalues: (copy) p_u_16, (copy) v_u_91
			p_u_16.kind(v_u_91)
		end))
	end
	for _, v_u_93 in v_u_1.WHENS do
		local v94 = v_u_14(v_u_28, { v_u_93 }).Activated
		table.insert(v_u_19, v94:Connect(function()
			-- upvalues: (copy) p_u_16, (copy) v_u_93
			p_u_16.when(v_u_93)
		end))
	end
	for _, v_u_95 in v_u_1.LENGTHS do
		local v96 = v_u_14(v_u_29, { v_u_95 }).Activated
		table.insert(v_u_19, v96:Connect(function()
			-- upvalues: (copy) p_u_16, (copy) v_u_95
			p_u_16.length(v_u_95)
		end))
	end
	local v97 = v_u_45.Words.FocusLost
	table.insert(v_u_19, v97:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.words(v_u_45.Words.Text)
	end))
	local v98 = v_u_45.From.FocusLost
	table.insert(v_u_19, v98:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.range(v_u_45.From.Text, v_u_45.To.Text)
	end))
	local v99 = v_u_45.To.FocusLost
	table.insert(v_u_19, v99:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.range(v_u_45.From.Text, v_u_45.To.Text)
	end))
	local v100 = v_u_45.Min.FocusLost
	table.insert(v_u_19, v100:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.lengthRange(v_u_45.Min.Text, v_u_45.Max.Text)
	end))
	local v101 = v_u_45.Max.FocusLost
	table.insert(v_u_19, v101:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.lengthRange(v_u_45.Min.Text, v_u_45.Max.Text)
	end))
	local v102 = v_u_45.Player.FocusLost
	table.insert(v_u_19, v102:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.player(v_u_45.Player.Text)
	end))
	local v103 = v_u_45.By.FocusLost
	table.insert(v_u_19, v103:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.by(v_u_45.By.Text)
	end))
	local v104 = v_u_45.Note.FocusLost
	table.insert(v_u_19, v104:Connect(function()
		-- upvalues: (copy) p_u_16, (copy) v_u_45
		p_u_16.note(v_u_45.Note.Text)
	end))
	local function v165(p105) -- name: render
		-- upvalues: (ref) v_u_90, (copy) v_u_23, (ref) v_u_1, (ref) v_u_14, (copy) v_u_25, (ref) v_u_4, (ref) v_u_3, (ref) v_u_6, (ref) v_u_8, (copy) v_u_28, (copy) v_u_29, (copy) v_u_30, (copy) v_u_46, (copy) v_u_42, (copy) v_u_26, (copy) v_u_47, (copy) p_u_16, (copy) v_u_19, (copy) v_u_27, (copy) v_u_50, (copy) v_u_43, (copy) v_u_31, (copy) v_u_51, (ref) v_u_7, (copy) v_u_32, (copy) v_u_33, (copy) v_u_48, (copy) v_u_44, (copy) v_u_34, (copy) v_u_49, (ref) v_u_9, (copy) v_u_35, (copy) v_u_36, (ref) v_u_10, (copy) v_u_37, (ref) v_u_5, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40
		if v_u_90 then
			v_u_23.Text = p105.sub
			for _, v106 in v_u_1.KINDS do
				local v107 = v_u_14(v_u_25, { v106 })
				local v108 = p105.kinds[v106] == true
				local v109
				if v108 then
					v109 = v_u_4
				else
					v109 = v_u_3
				end
				v107.BackgroundColor3 = v109
				local v110
				if v108 then
					v110 = v_u_6
				else
					v110 = v_u_8
				end
				v107.TextColor3 = v110
			end
			for _, v111 in v_u_1.WHENS do
				local v112 = v_u_14(v_u_28, { v111 })
				local v113 = p105.when == v111
				local v114
				if v113 then
					v114 = v_u_4
				else
					v114 = v_u_3
				end
				v112.BackgroundColor3 = v114
				local v115
				if v113 then
					v115 = v_u_6
				else
					v115 = v_u_8
				end
				v112.TextColor3 = v115
			end
			for _, v116 in v_u_1.LENGTHS do
				local v117 = v_u_14(v_u_29, { v116 })
				local v118 = p105.length == v116
				local v119
				if v118 then
					v119 = v_u_4
				else
					v119 = v_u_3
				end
				v117.BackgroundColor3 = v119
				local v120
				if v118 then
					v120 = v_u_6
				else
					v120 = v_u_8
				end
				v117.TextColor3 = v120
			end
			v_u_30.Visible = p105.length == "timed"
			for v_u_121, v122 in p105.reasons do
				local v123 = v_u_46[v_u_121]
				if not v123 then
					v123 = v_u_42:Clone()
					v123.Name = "Chip" .. v_u_121
					v123.Visible = true
					v123.LayoutOrder = v_u_121
					v123.Parent = v_u_26
					v_u_46[v_u_121] = v123
					local v124 = v123.Activated
					local function v126()
						-- upvalues: (ref) v_u_47, (copy) v_u_121, (ref) p_u_16
						local v125 = v_u_47[v_u_121]
						if v125 then
							p_u_16.reason(v125)
						end
					end
					local v127 = v_u_19
					table.insert(v127, v124:Connect(v126))
				end
				v_u_47[v_u_121] = v122.key
				v123.Text = v122.text
				v123.Visible = true
				local v128 = v122.on
				local v129
				if v128 then
					v129 = v_u_4
				else
					v129 = v_u_3
				end
				v123.BackgroundColor3 = v129
				local v130
				if v128 then
					v130 = v_u_6
				else
					v130 = v_u_8
				end
				v123.TextColor3 = v130
			end
			for v131 = #p105.reasons + 1, #v_u_46 do
				v_u_46[v131].Visible = false
				v_u_47[v131] = nil
			end
			v_u_27.Visible = #p105.reasons == 0
			for v_u_132, v133 in p105.opts do
				local v134 = v_u_50[v_u_132]
				if not v134 then
					v134 = v_u_43:Clone()
					v134.Name = "Opt" .. v_u_132
					v134.Visible = true
					v134.LayoutOrder = v_u_132
					v134.Parent = v_u_31
					v_u_50[v_u_132] = v134
					local v135 = v134.Activated
					local function v137()
						-- upvalues: (ref) v_u_51, (copy) v_u_132, (ref) p_u_16
						local v136 = v_u_51[v_u_132]
						if v136 then
							p_u_16.opt(v136)
						end
					end
					local v138 = v_u_19
					table.insert(v138, v135:Connect(v137))
				end
				v_u_51[v_u_132] = v133.key
				local v139 = v134:FindFirstChild("Box")
				local v140 = v134:FindFirstChild("Text")
				local v141
				if v133.on then
					v141 = v_u_4
				else
					v141 = v_u_7
				end
				v139.BackgroundColor3 = v141
				v140.Text = v133.text
				local v142
				if v133.on then
					v142 = v_u_6
				else
					v142 = v_u_8
				end
				v140.TextColor3 = v142
				v134.Size = UDim2.new(1, 0, 0, #v133.text > 38 and 44 or 30)
			end
			v_u_32.Text = p105.count
			v_u_33.Text = p105.countSub
			for v_u_143, v144 in p105.rows do
				local v145 = v_u_48[v_u_143]
				if not v145 then
					v145 = v_u_44:Clone()
					v145.Name = "Row" .. v_u_143
					v145.Visible = true
					v145.LayoutOrder = v_u_143
					v145.Parent = v_u_34
					v_u_48[v_u_143] = v145
					local v146 = v145.Activated
					local function v148()
						-- upvalues: (ref) v_u_49, (copy) v_u_143, (ref) p_u_16
						local v147 = v_u_49[v_u_143]
						if v147 then
							p_u_16.row(v147)
						end
					end
					local v149 = v_u_19
					table.insert(v149, v146:Connect(v148))
				end
				v_u_49[v_u_143] = v144.key
				local v150 = v145:FindFirstChild("Box")
				local v151 = v145:FindFirstChild("Name")
				local v152 = v145:FindFirstChild("Sub")
				v145.Visible = true
				local v153
				if v144.out then
					v153 = v_u_7
				else
					v153 = v_u_4
				end
				v150.BackgroundColor3 = v153
				v151.Text = v144.name
				local v154
				if v144.out then
					v154 = v_u_9
				else
					v154 = v_u_6
				end
				v151.TextColor3 = v154
				v152.Text = v144.sub
				local v155
				if v144.out then
					v155 = v_u_9
				else
					v155 = v_u_8
				end
				v152.TextColor3 = v155
				v145.BackgroundTransparency = v144.out and 0.85 or 0.5
			end
			for v156 = #p105.rows + 1, #v_u_48 do
				v_u_48[v156].Visible = false
				v_u_49[v156] = nil
			end
			v_u_35.Visible = #p105.rows == 0
			v_u_35.Text = p105.empty
			v_u_36.Text = p105.status
			v_u_36.TextColor3 = v_u_10[p105.statusTone] or v_u_8
			v_u_37.Text = p105.run.text
			v_u_37.Active = p105.run.on
			v_u_37.AutoButtonColor = false
			local v157 = v_u_37
			local v158
			if p105.run.armed then
				v158 = v_u_5
			elseif p105.run.on then
				v158 = v_u_4
			else
				v158 = v_u_3
			end
			v157.BackgroundColor3 = v158
			local v159 = v_u_37
			local v160
			if p105.run.armed then
				v160 = v_u_7
			elseif p105.run.on then
				v160 = v_u_6
			else
				v160 = v_u_9
			end
			v159.TextColor3 = v160
			v_u_38.Visible = p105.job.visible
			v_u_39.Text = p105.job.text
			v_u_40.Visible = p105.job.act ~= nil
			v_u_40.Text = p105.job.act or ""
			local v161 = v_u_40
			local v162
			if p105.job.armed then
				v162 = v_u_5
			elseif p105.job.actOn then
				v162 = v_u_3
			else
				v162 = v_u_7
			end
			v161.BackgroundColor3 = v162
			local v163 = v_u_40
			local v164
			if p105.job.armed then
				v164 = v_u_7
			elseif p105.job.actOn then
				v164 = v_u_6
			else
				v164 = v_u_9
			end
			v163.TextColor3 = v164
		end
	end
	v_u_17.Visible = true
	v21.Visible = true
	v24.CanvasPosition = Vector2.zero
	v_u_34.CanvasPosition = Vector2.zero
	for _, v166 in v_u_45 do
		v166.Text = ""
	end
	return {
		["render"] = v165,
		["setText"] = function(p167, p168) -- name: setText
			-- upvalues: (copy) v_u_45, (ref) v_u_90
			local v169 = v_u_45[p167]
			if v169 and (v_u_90 and not v169:IsFocused()) then
				v169.Text = p168
			end
		end,
		["text"] = function(p170) -- name: text
			-- upvalues: (copy) v_u_45
			local v171 = v_u_45[p170]
			return not v171 and "" or v171.Text
		end,
		["close"] = v56,
		["alive"] = function() -- name: alive
			-- upvalues: (ref) v_u_90
			return v_u_90
		end
	}
end
return v_u_1
