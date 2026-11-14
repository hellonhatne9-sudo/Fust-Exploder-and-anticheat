--!native
-- Path: LiveBait.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local function __set_list(target, start, items)
	for i, v in ipairs(items) do
		target[start + i - 1] = v
	end
	return target
end

return function(p1)
	local v_u_2 = p1.SB
	local v_u_3 = p1.C
	local v_u_4 = p1.make
	local v_u_5 = p1.U
	local v_u_6 = p1.Net
	local v_u_7 = p1.L240
	local v_u_8 = p1.GP
	v_u_7.STALE = 2
	v_u_7.FAR = 30
	v_u_7.MAX_LINES = 6
	v_u_7.GREEN = { 0.4235294117647059, 0.7607843137254902, 0.2901960784313726 }
	v_u_7.RED = { 0.9215686274509803, 0.3764705882352941, 0.3137254901960784 }
	function v_u_7.fmtLeft(p9) -- name: fmtLeft
		local v10 = tonumber(p9) or 0
		local v11 = math.floor(v10)
		local v12 = math.max(0, v11)
		return ("%d:%02d"):format(v12 // 60, v12 % 60)
	end
	function v_u_7.n(p13, p14) -- name: n
		local v15 = tonumber(p13)
		if not v15 or v15 ~= v15 then
			return "-"
		end
		if p14 == 1 then
			return ("%.1f"):format(v15)
		end
		local v16 = v15 + 0.5
		local v17 = math.floor(v16)
		return tostring(v17)
	end
	function v_u_7.meterLines(p18) -- name: meterLines
		-- upvalues: (copy) v_u_7
		local v19 = {}
		local v20 = p18.name or "?"
		local v21 = tostring(v20)
		local v22 = p18.aim
		local v23
		if type(v22) == "table" then
			v23 = p18.aim
		else
			v23 = nil
		end
		local v24 = p18.baits
		local v25 = type(v24) ~= "table" and {} or p18.baits
		local v26 = 0
		for _, v27 in ipairs(v25) do
			if type(v27) ~= "table" or v27.k ~= "aim" and (v27.k ~= "auto" and v27.k ~= "esp") then
				continue
			end
			v26 = v26 + 1
		end
		local v28 = p18.trial
		local v29
		if type(v28) == "table" then
			local v30 = p18.trial.line
			if type(v30) == "string" then
				v29 = p18.trial.line
			else
				v29 = nil
			end
		else
			v29 = nil
		end
		if v29 then
			local v31 = v29 .. " \194\183 " .. v21
			table.insert(v19, v31)
		end
		if v23 and (v23.staff or v26 > 0) then
			local v32 = { (v23.staff and "AIM BAIT on " or "LIVE on ") .. v21 }
			if v23.err == nil then
				local v33 = p18.alive == false and "not alive" or "no aim data"
				table.insert(v32, v33)
			else
				local v34 = v_u_7.n
				local v35 = v23.err
				table.insert(v32, ("aim %s\194\176 off nearest bait"):format(v34(v35)))
			end
			local v36 = v_u_7.n(v23.track, 1)
			local v37 = v_u_7.n
			local v38 = v23.trackNeed
			table.insert(v32, ("tracking %s / %s s"):format(v36, v37(v38, 1)))
			local v39 = v_u_7.n(v23.inc)
			local v40 = v_u_7.n
			local v41 = v23.incNeed
			table.insert(v32, ("incidents %s / %s"):format(v39, v40(v41)))
			local v42 = v_u_7.n(v23.shots)
			local v43 = v_u_7.n
			local v44 = v23.shotsNeed
			table.insert(v32, ("shots at bait %s / %s"):format(v42, v43(v44)))
			if v23.left ~= nil then
				local v45 = v_u_7.fmtLeft(v23.left) .. " left"
				table.insert(v32, v45)
			end
			local v46 = table.concat
			table.insert(v19, v46(v32, " \194\183 "))
		else
			local v47 = p18.esp
			if type(v47) ~= "table" and not v29 then
				table.insert(v19, ("LIVE on %s \194\183 no bait near them"):format(v21))
			end
		end
		local v48 = p18.esp
		local v49
		if type(v48) == "table" then
			v49 = p18.esp
		else
			v49 = nil
		end
		if v49 then
			local v50 = v49.heading
			local v51 = tonumber(v50)
			local v52 = table.concat
			local v53 = {}
			local v54 = "ESP BAIT on " .. v21
			local v55 = v49.d == nil and "- studs away" or v_u_7.n(v49.d) .. " studs away"
			local v56 = "heading at it %s%%"
			local v57
			if v51 then
				local v58 = v51 * 100 + 0.5
				local v59 = math.floor(v58)
				v57 = tostring(v59)
			else
				v57 = "-"
			end
			__set_list(v53, 1, {v54, v55, v56:format(v57), ("on spot %s / %s s"):format(v_u_7.n(v49.stay, 1), v_u_7.n(v49.stayNeed, 1)), ("looking %s / %s s"):format(v_u_7.n(v49.look, 1), v_u_7.n(v49.lookNeed, 1)), v_u_7.fmtLeft(v49.left) .. " left"})
			table.insert(v19, v52(v53, " \194\183 "))
		end
		return v19
	end
	function v_u_7.color(p60, p61) -- name: color
		-- upvalues: (copy) v_u_7
		local v62 = tonumber(p60)
		local v63 = tonumber(p61) or 3
		local v64 = not v62 and 0 or (v62 <= v63 and 1 or (v_u_7.FAR <= v62 and 0 or 1 - (v62 - v63) / (v_u_7.FAR - v63)))
		local v65 = v_u_7.GREEN
		local v66 = v_u_7.RED
		return Color3.new(v65[1] + (v66[1] - v65[1]) * v64, v65[2] + (v66[2] - v65[2]) * v64, v65[3] + (v66[3] - v65[3]) * v64)
	end
	function v_u_7.build() -- name: build
		-- upvalues: (copy) v_u_7, (copy) v_u_5
		if not v_u_7.panel then
			v_u_7.panel = v_u_5.hud:WaitForChild("BaitLive")
			v_u_7.body = v_u_7.panel:WaitForChild("Body")
			v_u_7.title = v_u_7.body:WaitForChild("Title")
			v_u_7.lineTpl = v_u_7.panel:WaitForChild("Templates"):WaitForChild("Line")
			v_u_7.closeBtn = v_u_7.panel:WaitForChild("Close")
			v_u_7.closeBtn.Activated:Connect(v_u_7.close)
		end
	end
	function v_u_7.world(p67) -- name: world
		-- upvalues: (copy) v_u_2
		local v68 = v_u_2.kit()
		if v68 then
			v68 = v68:FindFirstChild("World")
		end
		if v68 then
			v68 = v68:FindFirstChild(p67)
		end
		if v68 then
			return v68:Clone()
		else
			return nil
		end
	end
	function v_u_7.folder() -- name: folder
		-- upvalues: (copy) v_u_7, (copy) v_u_4
		local v69 = workspace.CurrentCamera
		if not v69 then
			return nil
		end
		local v70 = v_u_7.markFolder
		if not v70 or v70.Parent ~= v69 then
			v70 = v_u_4("Folder", {
				["Name"] = "FustBaitLive",
				["Parent"] = v69
			})
			v_u_7.markFolder = v70
		end
		return v70
	end
	function v_u_7.marker(p71, p72) -- name: marker
		-- upvalues: (copy) v_u_7
		local v73 = v_u_7.markers[p71]
		if v73 then
			return v73
		end
		local v74 = v_u_7.world("BaitMarker")
		if not (v74 and v74:IsA("BasePart")) then
			return nil
		end
		local v75 = v74:WaitForChild("Box")
		local v76 = v74:WaitForChild("Label")
		v75.Adornee = v74
		v76.Adornee = v74
		v76.Enabled = true
		v74.Parent = p72
		local v77 = {
			["part"] = nil,
			["box"] = nil,
			["label"] = nil,
			["hl"] = nil,
			["part"] = v74,
			["box"] = v75,
			["label"] = v76:WaitForChild("Text")
		}
		v_u_7.markers[p71] = v77
		return v77
	end
	function v_u_7.aimLine(p78, p79) -- name: aimLine
		-- upvalues: (copy) v_u_7
		local v80 = v_u_7.aimLines[p78]
		if v80 then
			return v80
		end
		local v81 = v_u_7.world("AimLine")
		if not (v81 and v81:IsA("BasePart")) then
			return nil
		end
		local v82 = v81:WaitForChild("Through")
		v82.Adornee = v81
		v81.Parent = p79
		local v83 = {
			["part"] = v81,
			["box"] = v82
		}
		v_u_7.aimLines[p78] = v83
		return v83
	end
	function v_u_7.clear() -- name: clear
		-- upvalues: (copy) v_u_7
		for _, v_u_84 in pairs(v_u_7.markers) do
			pcall(function()
				-- upvalues: (copy) v_u_84
				v_u_84.part:Destroy()
				if v_u_84.hl then
					v_u_84.hl:Destroy()
				end
			end)
		end
		for _, v_u_85 in pairs(v_u_7.aimLines) do
			pcall(function()
				-- upvalues: (copy) v_u_85
				v_u_85.part:Destroy()
			end)
		end
		local v86 = v_u_7
		v_u_7.markers = {}
		v86.aimLines = {}
		if v_u_7.markFolder then
			v_u_7.markFolder:ClearAllChildren()
		end
		if v_u_7.panel then
			v_u_7.panel.Visible = false
		end
	end
	function v_u_7.close() -- name: close
		-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_8
		v_u_7.subs = {}
		v_u_7.clear()
		v_u_7.lastAt = (-1 / 0)
		task.spawn(v_u_6.call, "bait_live", {
			["all"] = true,
			["on"] = false
		})
		if v_u_8.selected and (v_u_8.entry and (v_u_8.entry(v_u_8.selected) and v_u_8.page)) then
			local v87 = v_u_8.renderDetail
			pcall(v87)
		end
	end
	v_u_7.LABEL = {
		["aim"] = "BAIT",
		["esp"] = "ESP BAIT",
		["auto"] = "AUTO BAIT",
		["crate"] = "ESP CRATE",
		["tbait"] = "TRIAL BAIT",
		["tctrl"] = "CONTROL"
	}
	v_u_7.TRIAL = Color3.fromHex("B36BFF")
	function v_u_7.render(p88) -- name: render
		-- upvalues: (copy) v_u_7, (copy) v_u_3
		v_u_7.build()
		local v89 = v_u_7.folder()
		local v90 = {}
		for _, v91 in ipairs(p88) do
			for _, v92 in ipairs(v_u_7.meterLines(v91)) do
				if #v90 >= v_u_7.MAX_LINES then
					continue
				end
				table.insert(v90, v92)
			end
		end
		local v93 = #v90
		local v94 = #v_u_7.labels
		for v95 = 1, math.max(v93, v94) do
			local v96 = v_u_7.labels[v95]
			if v90[v95] then
				if not v96 then
					v96 = v_u_7.lineTpl:Clone()
					v96.Name = "Line" .. v95
					v96.LayoutOrder = v95
					v96.Parent = v_u_7.body
					v_u_7.labels[v95] = v96
				end
				v96.Text = v90[v95]
				v96.Visible = true
			else
				if not v96 then
					continue
				end
				v96.Visible = false
			end
		end
		v_u_7.panel.Visible = true
		if v89 then
			local v97 = {}
			local v98 = {}
			for _, v99 in ipairs(p88) do
				local v100 = v99.uid
				local v101 = tostring(v100)
				local v102 = v99.aim
				local v103 = type(v102) ~= "table" and {} or v99.aim
				local v104 = ipairs
				local v105 = v99.baits
				for v106, v107 in v104(type(v105) ~= "table" and {} or v99.baits) do
					if type(v107) ~= "table" then
						continue
					end
					local v108 = v107.p
					if typeof(v108) ~= "Vector3" then
						continue
					end
					local v109 = v101 .. ":" .. v106
					v97[v109] = true
					local v110 = v_u_7.marker(v109, v89)
					if not v110 then
						continue
					end
					local v111 = v107.k == "crate" and true or v107.mode == "stash"
					local v112 = v107.mode == "sleeper"
					local v113 = v107.k == "tbait" and true or v107.k == "tctrl"
					v110.part.CFrame = CFrame.new(v107.p)
					v110.box.Size = v111 and Vector3.new(3, 2.4, 3) or (v112 and Vector3.new(3, 2, 5.4) or Vector3.new(2.6, 5.4, 2.6))
					local v114 = v110.box
					local v115
					if v107.k == "tbait" then
						v115 = v_u_7.TRIAL
					elseif v107.k == "tctrl" then
						v115 = v_u_3.ice
					elseif v107.k == "auto" or v111 then
						v115 = v_u_3.amber
					else
						v115 = v_u_3.bad
					end
					v114.Color3 = v115
					v110.box.Transparency = v107.k == "tctrl" and 0.7 or 0.45
					v110.label.BackgroundColor3 = v110.box.Color3
					local v116 = v110.label
					local v117
					if v107.k == "auto" or (v111 or v107.k == "tctrl") then
						v117 = v_u_3.slot
					else
						v117 = v_u_3.text
					end
					v116.TextColor3 = v117
					if v113 then
						local v118 = v110.label
						local v119 = v_u_7.LABEL[v107.k] or "TRIAL"
						local v120
						if v107.k == "tctrl" then
							local v121 = v107.label
							v120 = type(v121) ~= "string" and "" or " " .. v107.label
						else
							v120 = ""
						end
						v118.Text = v119 .. v120 .. (v107.seen and " (SEEN)" or "") .. (v107.left == nil and "" or " " .. v_u_7.fmtLeft(v107.left))
					else
						v110.label.Text = (v_u_7.LABEL[v107.k] or "BAIT") .. ((v107.k == "auto" or v107.left == nil) and "" or " " .. v_u_7.fmtLeft(v107.left))
					end
					local v122 = v107.m
					if typeof(v122) == "Instance" and v122.Parent ~= nil then
						if v110.hl and v110.hl.Adornee == v122 then
							continue
						end
						if v110.hl then
							v110.hl:Destroy()
						end
						local v123 = v_u_7.world("BaitHighlight")
						if not (v123 and v123:IsA("Highlight")) then
							continue
						end
						v123.Adornee = v122
						v123.FillColor = v110.box.Color3
						v123.OutlineColor = v110.box.Color3
						v123.Parent = v89
						v110.hl = v123
					else
						if not v110.hl then
							continue
						end
						v110.hl:Destroy()
						v110.hl = nil
					end
				end
				local v124 = v99.eye
				local v125 = v99.dir
				if typeof(v124) ~= "Vector3" or (typeof(v125) ~= "Vector3" or v125.Magnitude <= 0.5) then
					break
				end
				v98[v101] = true
				local v126 = v_u_7.aimLine(v101, v89)
				if not v126 then
					break
				end
				local v127 = v103.nd
				local v128 = (tonumber(v127) or 120) + 15
				local v129 = math.clamp(v128, 30, 250)
				local v130 = Vector3.new(0.12, 0.12, v129)
				v126.part.Size = v130
				v126.box.Size = v130
				v126.part.CFrame = CFrame.lookAt(v124, v124 + v125) * CFrame.new(0, 0, -v129 / 2)
				local v131 = v_u_7.color(v103.err, v103.tol)
				v126.part.Color = v131
				v126.box.Color3 = v131
			end
			for v132, v_u_133 in pairs(v_u_7.markers) do
				if v97[v132] then
					continue
				end
				pcall(function()
					-- upvalues: (copy) v_u_133
					v_u_133.part:Destroy()
					if v_u_133.hl then
						v_u_133.hl:Destroy()
					end
				end)
				v_u_7.markers[v132] = nil
			end
			for v134, v_u_135 in pairs(v_u_7.aimLines) do
				if v98[v134] then
					continue
				end
				pcall(function()
					-- upvalues: (copy) v_u_135
					v_u_135.part:Destroy()
				end)
				v_u_7.aimLines[v134] = nil
			end
		end
	end
	function v_u_7.onMsg(p136) -- name: onMsg
		-- upvalues: (copy) v_u_7
		local v137 = p136.list
		local v138 = type(v137) ~= "table" and {} or p136.list
		local v139 = {}
		for _, v140 in ipairs(v138) do
			if type(v140) ~= "table" then
				continue
			end
			local v141 = v140.uid
			if type(v141) ~= "number" then
				continue
			end
			v139[v140.uid] = true
		end
		v_u_7.subs = v139
		if p136.stop == true or #v138 == 0 then
			v_u_7.clear()
		else
			v_u_7.lastAt = os.clock()
			v_u_7.render(v138)
			if not v_u_7.watching then
				v_u_7.watching = true
				task.spawn(function()
					-- upvalues: (ref) v_u_7
					while v_u_7.panel and v_u_7.panel.Visible do
						task.wait(0.5)
						if os.clock() - v_u_7.lastAt <= v_u_7.STALE then
							continue
						end
						v_u_7.clear()
					end
					v_u_7.watching = false
				end)
			end
		end
	end
end
