--!native
-- Path: FlagGuide.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local v_u_1 = {}
local v2 = Color3.fromHex
local v3 = {
	["rust"] = {
		["bg"] = v2("C2502A"),
		["fg"] = v2("ECE6DA")
	},
	["amber"] = {
		["bg"] = v2("D9A441"),
		["fg"] = v2("0F1110")
	},
	["raised"] = {
		["bg"] = v2("2C312E"),
		["fg"] = v2("ECE6DA")
	},
	["dim"] = {
		["bg"] = v2("1B1E1C"),
		["fg"] = v2("A3A79F")
	}
}
v_u_1.TONES = v3
local v_u_4 = v2("D9A441")
local v_u_5 = v2("C2502A")
local v_u_6 = v2("B8452F")
local v_u_7 = v2("6E736C")
local v_u_8 = {
	["conns"] = nil,
	["built"] = nil,
	["kit"] = nil,
	["conns"] = {}
}
function v_u_1.pretty(p9) -- name: pretty
	local v10 = string.gsub(p9, "_", " ")
	return string.upper((string.sub(v10, 1, 1))) .. string.sub(v10, 2)
end
function v_u_1.label(p11, p12) -- name: label
	-- upvalues: (copy) v_u_1
	if p11 then
		p11 = p11.kinds[p12]
	end
	if p11 then
		return p11.label
	else
		return v_u_1.pretty(p12)
	end
end
function v_u_1.tapesOf(p13, p14, p15) -- name: tapesOf
	local v16 = {}
	if not p13 then
		return v16
	end
	local v17 = p13.kinds[p14]
	local v18 = not v17 and {} or table.clone(v17.tapes)
	if p15 and not table.find(v18, "strict") then
		table.insert(v18, "strict")
	end
	for _, v19 in ipairs(p13.tapeOrder) do
		if not (table.find(v18, v19) and p13.tapes[v19]) then
			continue
		end
		local v20 = p13.tapes[v19]
		table.insert(v16, v20)
	end
	return v16
end
v_u_1.ROW_PRIORITY = {
	"note",
	"review",
	"ban",
	"second",
	"strict"
}
function v_u_1.rowTapes(p21, p22, p23, p24) -- name: rowTapes
	-- upvalues: (copy) v_u_1
	local v25 = {}
	if not p21 then
		return v25
	end
	local v26 = p21.kinds[p22]
	local v27 = not v26 and {} or table.clone(v26.tapes)
	if p23 and not table.find(v27, "strict") then
		table.insert(v27, "strict")
	end
	for _, v28 in ipairs(v_u_1.ROW_PRIORITY) do
		if p24 <= #v25 then
			break
		end
		if not (table.find(v27, v28) and p21.tapes[v28]) then
			continue
		end
		local v29 = p21.tapes[v28]
		table.insert(v25, v29)
	end
	return v25
end
function v_u_1.tape(p30, p31, p32, p33) -- name: tape
	-- upvalues: (copy) v_u_1
	local v34 = p30:Clone()
	local v35 = v_u_1.TONES[p31.tone] or v_u_1.TONES.raised
	v34.Text = p31.text
	v34.BackgroundColor3 = v35.bg
	v34.TextColor3 = v35.fg
	v34.LayoutOrder = p33
	v34.Visible = true
	v34.Parent = p32
	return v34
end
function v_u_1.templates(p36) -- name: templates
	local v37 = p36:FindFirstChild("Legend")
	if v37 then
		v37 = v37:FindFirstChild("Templates")
	end
	if v37 and v37:IsA("Folder") then
		return v37
	else
		return nil
	end
end
function v_u_1.atom(p38, p39) -- name: atom
	local v40 = p38:FindFirstChild("Atoms")
	if v40 then
		v40 = v40:FindFirstChild(p39)
	end
	if not (v40 and v40:IsA("GuiObject")) then
		return nil
	end
	local v41 = v40:Clone()
	v41.Visible = true
	return v41
end
local function v_u_44(p42) -- name: clearBody
	for _, v43 in ipairs(p42:GetChildren()) do
		if not v43:IsA("GuiObject") then
			continue
		end
		v43:Destroy()
	end
end
local function v_u_84(p45, p_u_46) -- name: fill
	-- upvalues: (copy) v_u_1, (copy) v_u_44
	local v47 = p45:FindFirstChild("Legend"):FindFirstChild("Card"):FindFirstChild("Body")
	local v48 = v_u_1.templates(p45)
	local v49 = v48:FindFirstChild("Tape")
	v_u_44(v47)
	local v50 = 0
	local v51 = v50
	for _, v52 in ipairs(p_u_46.legend) do
		local v53 = v48:FindFirstChild("Section"):Clone()
		local v54 = v53:FindFirstChild("Tape")
		local v55 = v53:FindFirstChild("Text")
		v54.Text = string.upper(v52.title)
		v55.Text = v52.body
		v50 = v51 + 1
		v53.LayoutOrder = v50
		v53.Visible = true
		v53:SetAttribute("Fixed", true)
		v53.Parent = v47
		v51 = v50
	end
	local v56 = v48:FindFirstChild("Group"):Clone()
	v56.Text = "The tapes"
	v50 = v51 + 1
	v56.LayoutOrder = v50
	v56.Visible = true
	v56:SetAttribute("Fixed", true)
	v56.Parent = v47
	local v57 = v50
	for _, v58 in ipairs(p_u_46.tapeOrder) do
		local v59 = p_u_46.tapes[v58]
		if not v59 then
			continue
		end
		local v60 = v48:FindFirstChild("TapeKey"):Clone()
		local v61 = v_u_1.TONES[v59.tone] or v_u_1.TONES.raised
		local v62 = v60:FindFirstChild("Tape")
		local v63 = v60:FindFirstChild("Text")
		v62.Text = v59.text
		v62.BackgroundColor3 = v61.bg
		v62.TextColor3 = v61.fg
		v63.Text = v59.meaning
		v50 = v57 + 1
		v60.LayoutOrder = v50
		v60.Visible = true
		v60:SetAttribute("Fixed", true)
		v60.Parent = v47
		v57 = v50
	end
	for _, v64 in ipairs(p_u_46.groups) do
		local v65 = {}
		for v66, v67 in pairs(p_u_46.kinds) do
			if v67.group ~= v64.id then
				continue
			end
			table.insert(v65, v66)
		end
		table.sort(v65, function(p68, p69)
			-- upvalues: (copy) p_u_46
			return p_u_46.kinds[p68].label < p_u_46.kinds[p69].label
		end)
		if #v65 <= 0 then
			break
		end
		local v70 = v48:FindFirstChild("Group"):Clone()
		v70.Text = v64.label
		v50 = v57 + 1
		v70.LayoutOrder = v50
		v70.Visible = true
		v70:SetAttribute("Group", v64.id)
		v70.Parent = v47
		v57 = v50
		for _, v71 in ipairs(v65) do
			local v72 = p_u_46.kinds[v71]
			local v73 = v48:FindFirstChild("KindRow"):Clone()
			local v74 = v73:FindFirstChild("Top")
			local v75 = v74:FindFirstChild("Name")
			local v76 = v74:FindFirstChild("Points")
			local v77 = v74:FindFirstChild("Code")
			local v78 = v73:FindFirstChild("Meaning")
			local v79 = table.find(v72.tapes, "note") ~= nil
			v75.Text = v72.label
			v76.Text = v79 and "no points" or (not v72.weight and "" or ("+%g"):format(v72.weight))
			v77.Text = v71
			v78.Text = v72.meaning
			local v80 = v74:FindFirstChild("Tapes")
			for v81, v82 in ipairs(v_u_1.tapesOf(p_u_46, v71, false)) do
				v_u_1.tape(v49, v82, v80, v81)
			end
			local v83 = v73:FindFirstChild("Partners")
			if #v72.partners > 0 then
				v83.Text = "Second sign: " .. table.concat(v72.partners, ", ")
				v83.Visible = true
			end
			v50 = v57 + 1
			v73.LayoutOrder = v50
			v73.Visible = true
			v73:SetAttribute("Group", v64.id)
			v73:SetAttribute("Find", string.lower(v72.label .. " " .. v71 .. " " .. v72.meaning))
			v73.Parent = v47
			v57 = v50
		end
	end
	v47.CanvasPosition = Vector2.zero
end
local function v_u_97(p85, p86) -- name: filter
	local v87 = p85:FindFirstChild("Legend"):FindFirstChild("Card"):FindFirstChild("Body")
	local v88 = string.lower((string.gsub(p86, "^%s+", "")))
	local v89 = {}
	for _, v90 in ipairs(v87:GetChildren()) do
		local v91 = v90:GetAttribute("Find")
		if not v90:IsA("GuiObject") or type(v91) ~= "string" then
			continue
		end
		local v92 = v88 == "" and true or string.find(v91, v88, 1, true) ~= nil
		v90.Visible = v92
		local v93 = v90:GetAttribute("Group")
		if not v92 or type(v93) ~= "string" then
			continue
		end
		v89[v93] = true
	end
	for _, v94 in ipairs(v87:GetChildren()) do
		if not v94:IsA("GuiObject") then
			continue
		end
		if v94:GetAttribute("Fixed") == true then
			v94.Visible = v88 == ""
		else
			if v94:GetAttribute("Find") ~= nil then
				continue
			end
			local v95 = v94:GetAttribute("Group")
			local v96
			if type(v95) == "string" then
				v96 = v89[v95] == true
			else
				v96 = false
			end
			v94.Visible = v96
		end
	end
	v87.CanvasPosition = Vector2.zero
end
function v_u_1.close() -- name: close
	-- upvalues: (copy) v_u_8
	for _, v98 in ipairs(v_u_8.conns) do
		v98:Disconnect()
	end
	table.clear(v_u_8.conns)
	local v99 = v_u_8.kit
	if v99 then
		v99 = v99:FindFirstChild("Legend")
	end
	if v99 and v99:IsA("GuiObject") then
		v99.Visible = false
	end
end
function v_u_1.open(p_u_100, p101) -- name: open
	-- upvalues: (copy) v_u_8, (copy) v_u_84, (copy) v_u_97, (copy) v_u_1
	local v102 = p_u_100:FindFirstChild("Legend")
	if v102 and v102:IsA("Frame") then
		for _, v103 in ipairs(v_u_8.conns) do
			v103:Disconnect()
		end
		table.clear(v_u_8.conns)
		if v_u_8.built ~= p101 or v_u_8.kit ~= p_u_100 then
			v_u_84(p_u_100, p101)
			v_u_8.built = p101
			v_u_8.kit = p_u_100
		end
		local v104 = v102:FindFirstChild("Card"):FindFirstChild("Header")
		local v_u_105 = v104:FindFirstChild("Search")
		v_u_105.Text = ""
		v_u_97(p_u_100, "")
		local v106 = v_u_8.conns
		local v107 = v104:FindFirstChild("Close").Activated
		local v108 = v_u_1.close
		table.insert(v106, v107:Connect(v108))
		local v109 = v_u_8.conns
		local v110 = v102:FindFirstChild("Shade").Activated
		local v111 = v_u_1.close
		table.insert(v109, v110:Connect(v111))
		local v112 = v_u_8.conns
		local v113 = v_u_105:GetPropertyChangedSignal("Text")
		local function v114()
			-- upvalues: (ref) v_u_97, (copy) p_u_100, (copy) v_u_105
			v_u_97(p_u_100, v_u_105.Text)
		end
		table.insert(v112, v113:Connect(v114))
		local v115 = v_u_8.conns
		local v116 = p_u_100.Destroying
		local v117 = v_u_1.close
		table.insert(v115, v116:Connect(v117))
		v102.Visible = true
	end
end
function v_u_1.isOpen() -- name: isOpen
	-- upvalues: (copy) v_u_8
	local v118 = v_u_8.kit
	if v118 then
		v118 = v118:FindFirstChild("Legend")
	end
	local v119 = v118 ~= nil and v118:IsA("GuiObject")
	if v119 then
		v119 = v118.Visible
	end
	return v119
end
local function v_u_135(p120, p121, p122, p123) -- name: setMeter
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_5, (copy) v_u_4
	local v124 = p120:FindFirstChild("Value")
	local v125 = p120:FindFirstChild("Name")
	if p122 then
		p123 = p123 .. " held"
	end
	v125.Text = p123
	local v126 = p120:FindFirstChild("Track"):FindFirstChild("Fill")
	local v127 = p121.max
	local v128 = math.max(v127, 1)
	local v129 = p121.pts / v128
	local v130 = math.clamp(v129, 0, 1)
	local v131 = p121.pts + 0.5
	local v132 = math.floor(v131)
	local v133 = p121.max + 0.5
	v124.Text = ("%d/%d"):format(v132, (math.floor(v133)))
	v126.Size = UDim2.fromScale(v130, 1)
	local v134
	if p122 then
		v134 = v_u_7
	elseif v130 >= 1 then
		v134 = v_u_6
	elseif v130 >= 0.6 then
		v134 = v_u_5
	else
		v134 = v_u_4
	end
	v126.BackgroundColor3 = v134
end
function v_u_1.meters(p136, p137, p138) -- name: meters
	-- upvalues: (copy) v_u_135, (copy) v_u_1
	local v139 = p136:FindFirstChild("Grid")
	v_u_135(v139:FindFirstChild("Kick"), p137.kick, false, "Auto-kick")
	v_u_135(v139:FindFirstChild("Strict"), p137.strict, false, "Strict kick")
	v_u_135(v139:FindFirstChild("Ban"), p137.ban, p137.banBlocked == true, "Ban")
	v_u_135(v139:FindFirstChild("Sure"), p137.sure, false, "Sure signs")
	local v140 = p136:FindFirstChild("Waiting")
	local v141 = {}
	for _, v142 in ipairs(p137.waiting) do
		local v143 = v_u_1.label
		table.insert(v141, v143(p138, v142))
	end
	v140.Visible = #v141 > 0
	v140.Text = #v141 <= 0 and "" or "Waiting for a second sign, not counted yet: " .. table.concat(v141, ", ")
end
return v_u_1
