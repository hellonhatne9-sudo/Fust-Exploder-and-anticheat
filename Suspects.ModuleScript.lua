--!native
-- Path: Suspects.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

return function(p1)
	local v_u_2 = p1.Players
	local v_u_3 = p1.playerGui
	local v4 = p1.FustShared
	local v_u_5 = p1.SB
	local v_u_6 = p1.C
	local v_u_7 = p1.escape
	local v_u_8 = p1.U
	local v_u_9 = p1.Net
	local v_u_10 = p1.Toast
	local v_u_11 = p1.Spec
	local v12 = p1.Pages
	local v_u_13 = p1.can
	local v_u_14 = p1.BP
	local v_u_15 = {
		["selected"] = nil,
		["waveSel"] = nil,
		["data"] = nil,
		["view"] = "suspects"
	}
	v12.suspects = v_u_15
	v_u_15.ui = require((v4:WaitForChild("AdminUI"):WaitForChild("ReviewPage")))
	local function v_u_20(p16) -- name: xsAgo
		if p16 < 90 then
			return "just now"
		elseif p16 < 5400 then
			local v17 = p16 / 60
			return ("%dm ago"):format((math.floor(v17)))
		elseif p16 < 172800 then
			local v18 = p16 / 3600
			return ("%dh ago"):format((math.floor(v18)))
		else
			local v19 = p16 / 86400
			return ("%dd ago"):format((math.floor(v19)))
		end
	end
	function v_u_15.build(p21) -- name: build
		-- upvalues: (copy) v_u_15
		v_u_15.pageFrame = p21
		task.spawn(v_u_15.mount)
	end
	function v_u_15.mount() -- name: mount
		-- upvalues: (copy) v_u_15, (copy) v_u_3
		if not v_u_15.mounting and v_u_15.pageFrame then
			v_u_15.mounting = true
			local v22 = v_u_3:WaitForChild("FustAdminKit", 30)
			if not (v22 and v22:IsA("ScreenGui")) then
				v22 = nil
			end
			if v22 and (not v_u_15.page or (not v_u_15.page.alive() or v_u_15.pageKit ~= v22)) then
				if v_u_15.page then
					v_u_15.page.destroy()
				end
				v_u_15.pageKit = v22
				local v26 = {
					["view"] = function(p23) -- name: view
						-- upvalues: (ref) v_u_15
						v_u_15.view = p23 == "wave" and "wave" or "suspects"
						v_u_15.render()
					end,
					["select"] = function(p24) -- name: select
						-- upvalues: (ref) v_u_15
						v_u_15.select((tonumber(p24)))
					end,
					["action"] = function(p25) -- name: action
						-- upvalues: (ref) v_u_15
						task.spawn(v_u_15.action, p25)
					end,
					["refresh"] = function() -- name: refresh
						-- upvalues: (ref) v_u_15
						task.spawn(v_u_15.load)
					end
				}
				v_u_15.page = v_u_15.ui.mount(v22, v_u_15.pageFrame, v26)
			end
			v_u_15.mounting = false
			if v_u_15.page and v_u_15.page.alive() then
				v_u_15.render()
			end
		end
	end
	function v_u_15.rows() -- name: rows
		-- upvalues: (copy) v_u_15
		local v27 = v_u_15.data
		if type(v27) == "table" then
			local v28 = v27.rows
			if type(v28) == "table" then
				return v27.rows
			end
		end
		return {}
	end
	function v_u_15.entries() -- name: entries
		-- upvalues: (copy) v_u_15
		local v29 = v_u_15.data
		local v30
		if type(v29) == "table" then
			local v31 = v29.wave
			if type(v31) == "table" then
				v30 = v29.wave
			else
				v30 = nil
			end
		else
			v30 = nil
		end
		if v30 then
			local v32 = v30.entries
			if type(v32) == "table" then
				return v30.entries
			end
		end
		return {}
	end
	function v_u_15.row(p33) -- name: row
		-- upvalues: (copy) v_u_15
		for _, v34 in ipairs(v_u_15.rows()) do
			if type(v34) ~= "table" or v34.userId ~= p33 then
				continue
			end
			return v34
		end
		return nil
	end
	function v_u_15.entry(p35) -- name: entry
		-- upvalues: (copy) v_u_15
		for _, v36 in ipairs(v_u_15.entries()) do
			if type(v36) ~= "table" or v36.id ~= p35 then
				continue
			end
			return v36
		end
		return nil
	end
	function v_u_15.flag(p37) -- name: flag
		-- upvalues: (copy) v_u_15
		local v38 = v_u_15.data
		local v39
		if type(v38) == "table" then
			v39 = v38[p37] == true
		else
			v39 = false
		end
		return v39
	end
	function v_u_15.now() -- name: now
		-- upvalues: (copy) v_u_15
		local v40 = v_u_15.data
		if type(v40) == "table" then
			local v41 = v40.now
			if type(v41) == "number" then
				return v40.now
			end
		end
		return os.time()
	end
	function v_u_15.counts(p42) -- name: counts
		local v43 = p42.kinds
		local v44 = type(v43) ~= "table" and {} or p42.kinds
		local v45 = p42.bait
		local v46 = tonumber(v45) or 0
		local v47 = v44.bait
		local v48 = v46 + (tonumber(v47) or 0)
		local v49 = p42.baitShots
		local v50 = tonumber(v49) or 0
		local v51 = v44.baitshot
		local v52 = v50 + (tonumber(v51) or 0)
		local v53 = p42.esp
		local v54 = tonumber(v53) or 0
		local v55 = v44.esptrack
		local v56 = v54 + (tonumber(v55) or 0)
		local v57 = v44.aimlock
		local v58 = tonumber(v57) or 0
		local v59 = v44.silentaim
		local v60 = v58 + (tonumber(v59) or 0)
		local v61 = v44.aimflick
		return v48, v52, v56, v60 + (tonumber(v61) or 0)
	end
	function v_u_15.reasonFor(p62) -- name: reasonFor
		-- upvalues: (copy) v_u_15
		local v63, v64, v65, v66 = v_u_15.counts(p62)
		local v67 = {}
		if v63 + v65 > 0 then
			table.insert(v67, "ESP")
		end
		local v68, v69, v70, v71
		if v64 + v66 > 0 then
			table.insert(v67, "aimbot")
			v74 = {}
			if v63 > 0 then
				v68 = "bait " .. v63
				table.insert(v74, v68)
			end
			if v64 > 0 then
				v69 = "bait shots " .. v64
				table.insert(v74, v69)
			end
			if v65 > 0 then
				v70 = "wall tracks " .. v65
				table.insert(v74, v70)
			end
			if v66 > 0 then
				v71 = "head lock x" .. v66
				table.insert(v74, v71)
			end
			return ("Cheating: %s (%s)"):format(#v67 <= 0 and "suspicious aim" or table.concat(v67, " + "), #v74 <= 0 and "evidence in Suspects" or table.concat(v74, ", "))
		end
		local v72 = p62.lockN
		if (tonumber(v72) or 0) < 20 then
			v74 = {}
			if v63 > 0 then
				v68 = "bait " .. v63
				table.insert(v74, v68)
			end
			if v64 > 0 then
				v69 = "bait shots " .. v64
				table.insert(v74, v69)
			end
			if v65 > 0 then
				v70 = "wall tracks " .. v65
				table.insert(v74, v70)
			end
			if v66 > 0 then
				v71 = "head lock x" .. v66
				table.insert(v74, v71)
			end
			return ("Cheating: %s (%s)"):format(#v67 <= 0 and "suspicious aim" or table.concat(v67, " + "), #v74 <= 0 and "evidence in Suspects" or table.concat(v74, ", "))
		end
		local v73 = p62.lockPct
		if (tonumber(v73) or 0) < 65 then
			v74 = {}
			if v63 > 0 then
				v68 = "bait " .. v63
				table.insert(v74, v68)
			end
			if v64 > 0 then
				v69 = "bait shots " .. v64
				table.insert(v74, v69)
			end
			if v65 > 0 then
				v70 = "wall tracks " .. v65
				table.insert(v74, v70)
			end
			if v66 > 0 then
				v71 = "head lock x" .. v66
				table.insert(v74, v71)
			end
			return ("Cheating: %s (%s)"):format(#v67 <= 0 and "suspicious aim" or table.concat(v67, " + "), #v74 <= 0 and "evidence in Suspects" or table.concat(v74, ", "))
		end
		table.insert(v67, "aimbot")
		local v74 = {}
		if v63 > 0 then
			v68 = "bait " .. v63
			table.insert(v74, v68)
		end
		if v64 > 0 then
			v69 = "bait shots " .. v64
			table.insert(v74, v69)
		end
		if v65 > 0 then
			v70 = "wall tracks " .. v65
			table.insert(v74, v70)
		end
		if v66 > 0 then
			v71 = "head lock x" .. v66
			table.insert(v74, v71)
		end
		return ("Cheating: %s (%s)"):format(#v67 <= 0 and "suspicious aim" or table.concat(v67, " + "), #v74 <= 0 and "evidence in Suspects" or table.concat(v74, ", "))
	end
	function v_u_15.tone(p75) -- name: tone
		return p75 >= 10 and "bad" or (p75 >= 1 and "amber" or "dim")
	end
	function v_u_15.where(p76) -- name: where
		return p76.online and p76.here and {
			["text"] = "HERE",
			["tone"] = "good"
		} or (p76.online and {
			["text"] = "OTHER SERVER",
			["tone"] = "hover"
		} or {
			["text"] = "OFFLINE",
			["tone"] = "hover"
		})
	end
	function v_u_15.tapes(p77) -- name: tapes
		-- upvalues: (copy) v_u_15
		local v78 = { v_u_15.where(p77) }
		if p77.queued then
			table.insert(v78, 1, {
				["text"] = "QUEUED",
				["tone"] = "bad"
			})
		end
		return v78
	end
	function v_u_15.summary(p79) -- name: summary
		-- upvalues: (copy) v_u_15
		local v80, v81, v82, v83 = v_u_15.counts(p79)
		local v84 = {}
		if v80 > 0 then
			local v85 = "bait " .. v80
			table.insert(v84, v85)
		end
		if v81 > 0 then
			local v86 = "shots " .. v81
			table.insert(v84, v86)
		end
		if v82 > 0 then
			local v87 = "wall " .. v82
			table.insert(v84, v87)
		end
		local v88 = p79.lockN
		if (tonumber(v88) or 0) > 0 then
			local v89 = p79.lockPct
			local v90 = tonumber(v89) or 0
			table.insert(v84, ("lock %d%%"):format(v90))
		elseif v83 > 0 then
			local v91 = "lock x" .. v83
			table.insert(v84, v91)
		end
		return table.concat(v84, ", ")
	end
	function v_u_15.waveText() -- name: waveText
		-- upvalues: (copy) v_u_15
		local v92 = v_u_15.data
		local v93
		if type(v92) == "table" then
			local v94 = v92.wave
			if type(v94) == "table" then
				v93 = v92.wave
			else
				v93 = nil
			end
		else
			v93 = nil
		end
		if not v93 then
			return "No ban wave info yet"
		end
		local v95 = v_u_15.now()
		local v96 = #v_u_15.entries()
		if v96 ~= 0 then
			local v97 = v93.nextAt
			if tonumber(v97) ~= nil then
				local v98 = v93.nextAt
				local v99 = tonumber(v98) - v95
				local v100
				if v99 <= 60 then
					v100 = "any minute now"
				else
					local v101 = v99 / 3600
					local v102 = math.floor(v101)
					local v103 = v99 % 3600 / 60
					v100 = ("in %dh %02dm"):format(v102, (math.floor(v103)))
				end
				return ("%d queued. The next ban lands %s. Each ban lands at its own random time, 6 to 48 hours after it was queued. Every ban also covers their alt accounts."):format(v96, v100)
			end
		end
		return ("%d queued. Each ban lands at its own random time, 6 to 48 hours after it was queued. Every ban also covers their alt accounts."):format(v96)
	end
	function v_u_15.select(p104) -- name: select
		-- upvalues: (copy) v_u_15, (copy) v_u_5
		if type(p104) == "number" then
			if v_u_15.view == "wave" then
				v_u_15.waveSel = p104
			else
				v_u_15.selected = p104
				local v105 = v_u_15.row(p104)
				local v106 = v_u_5.pick
				local v107 = "suspects"
				local v108
				if v105 then
					local v109 = v105.name
					if type(v109) == "string" then
						v108 = v105.name
					else
						v108 = nil
					end
				else
					v108 = nil
				end
				v106(p104, v107, v108)
			end
			v_u_15.render()
		end
	end
	function v_u_15.action(p110) -- name: action
		-- upvalues: (copy) v_u_15, (copy) v_u_9, (copy) v_u_14, (copy) v_u_11
		local v111 = v_u_15.view == "wave"
		if p110 == "go" then
			if v111 then
				if v_u_9.act("wave_run", {}) then
					v_u_15.load()
					return
				end
			elseif v_u_9.act("suspects_clear_all", {}) then
				v_u_15.selected = nil
				v_u_15.load()
			end
			return
		elseif v111 then
			local v112 = v_u_15.entry(v_u_15.waveSel)
			if v112 then
				if p110 == "remove" then
					if v_u_9.act("wave_remove", {
						["userId"] = v112.id
					}) then
						v_u_15.waveSel = nil
						v_u_15.load()
						return
					end
				elseif p110 == "lookup" then
					local v113 = v_u_14.lookup
					local v114 = v112.id
					local v115 = v112.name or v112.id
					v113(v114, (tostring(v115)))
				end
			end
		else
			local v116 = v_u_15.row(v_u_15.selected)
			if v116 then
				local v117 = v116.userId
				if p110 == "spectate" then
					v_u_11.toggle(v117)
					return
				elseif p110 == "goto" then
					v_u_9.act("goto", {
						["userId"] = v117
					}, "Teleported")
				elseif p110 == "clear" then
					if v_u_9.act("suspect_clear", {
						["userId"] = v117
					}) then
						v_u_15.selected = nil
						v_u_15.load()
						return
					end
				elseif p110 == "queue" then
					if v_u_9.act("wave_add", {
						["userId"] = v117,
						["name"] = v116.name,
						["reason"] = v_u_15.reasonFor(v116)
					}) then
						v_u_15.load()
						return
					end
				elseif p110 == "lookup" then
					local v118 = v_u_14.lookup
					local v119 = v116.name or v117
					v118(v117, (tostring(v119)))
				end
			else
				return
			end
		end
	end
	function v_u_15.listVM() -- name: listVM
		-- upvalues: (copy) v_u_15, (copy) v_u_20
		local v120 = v_u_15.rows()
		local v121 = v_u_15.entries()
		local v122 = {
			{
				["id"] = "suspects",
				["label"] = ("Suspects (%d)"):format(#v120)
			},
			{
				["id"] = "wave",
				["label"] = ("Ban wave (%d)"):format(#v121)
			}
		}
		local v123 = {}
		if v_u_15.view ~= "wave" then
			for _, v124 in ipairs(v120) do
				if type(v124) ~= "table" then
					continue
				end
				local v125 = v124.userId
				if type(v125) ~= "number" then
					continue
				end
				local v126 = v124.score
				local v127 = tonumber(v126) or 0
				local v128 = {}
				local v129 = v124.userId
				v128.key = tostring(v129)
				local v130 = v124.name or v124.userId
				v128.name = tostring(v130)
				v128.right = tostring(v127)
				v128.rightTone = v_u_15.tone(v127)
				v128.tapes = v_u_15.tapes(v124)
				v128.sub = v_u_15.summary(v124)
				v128.selected = v_u_15.selected == v124.userId
				table.insert(v123, v128)
			end
			return {
				["views"] = nil,
				["view"] = "suspects",
				["go"] = nil,
				["status"] = "",
				["rows"] = nil,
				["empty"] = nil,
				["views"] = v122,
				["go"] = v_u_15.flag("canClearAll") and #v123 > 0 and {
					["id"] = "go",
					["text"] = "Clear all suspects",
					["on"] = true,
					["visible"] = true,
					["tone"] = "hover",
					["confirm"] = "Clear every one?"
				} or nil,
				["rows"] = v123,
				["empty"] = v_u_15.data == nil and "Loading" or "No ESP or aimbot evidence yet"
			}
		end
		local v131 = v_u_15.now()
		for _, v132 in ipairs(v121) do
			if type(v132) ~= "table" then
				continue
			end
			local v133 = v132.id
			if type(v133) ~= "number" then
				continue
			end
			local v134 = v132.hours
			local v135 = tonumber(v134) or 0
			local v136 = {
				["key"] = nil,
				["name"] = nil,
				["right"] = nil,
				["rightTone"] = "badText",
				["tapes"] = nil,
				["sub"] = nil,
				["selected"] = nil
			}
			local v137 = v132.id
			v136.key = tostring(v137)
			local v138 = v132.name or v132.id
			v136.name = tostring(v138)
			v136.right = v135 <= 0 and "perm" or ("%dh"):format(v135)
			v136.tapes = {}
			local v139 = v132.by or "?"
			local v140 = tostring(v139)
			local v141 = v_u_20
			local v142 = v132.at
			v136.sub = ("by %s, %s"):format(v140, v141(v131 - (tonumber(v142) or v131)))
			v136.selected = v_u_15.waveSel == v132.id
			table.insert(v123, v136)
		end
		return {
			["views"] = nil,
			["view"] = "wave",
			["go"] = nil,
			["status"] = "",
			["rows"] = nil,
			["empty"] = nil,
			["views"] = v122,
			["go"] = v_u_15.flag("canRun") and {
				["id"] = "go",
				["text"] = "Run the wave now",
				["on"] = nil,
				["visible"] = true,
				["tone"] = "bad",
				["confirm"] = "Ban them all now?",
				["on"] = #v121 > 0
			} or nil,
			["rows"] = v123,
			["empty"] = v_u_15.data == nil and "Loading" or "Nobody is queued"
		}
	end
	function v_u_15.detailVM() -- name: detailVM
		-- upvalues: (copy) v_u_15, (copy) v_u_7, (copy) v_u_13, (copy) v_u_2
		local v143 = v_u_15.now()
		if v_u_15.view == "wave" then
			local v144 = v_u_15.entry(v_u_15.waveSel)
			if not v144 then
				return {
					["none"] = v_u_15.waveText(),
					["noneActions"] = {}
				}
			end
			local v145 = v144.hours
			local v146 = tonumber(v145) or 0
			local v147 = {
				["name"] = nil,
				["score"] = "",
				["scoreTone"] = "text",
				["tapes"] = nil,
				["sub"] = nil,
				["body"] = nil,
				["actions"] = nil
			}
			local v148 = v144.name or v144.id
			v147.name = tostring(v148)
			v147.tapes = {
				{
					["text"] = nil,
					["tone"] = "bad",
					["text"] = v146 <= 0 and "PERM BAN" or ("%dH BAN"):format(v146)
				}
			}
			local v149 = "queued by %s, %s, %s"
			local v150 = v144.by or "?"
			local v151 = tostring(v150)
			local v152 = v144.at
			local v153 = v143 - (tonumber(v152) or v143)
			local v154
			if v153 < 90 then
				v154 = "just now"
			elseif v153 < 5400 then
				local v155 = v153 / 60
				v154 = ("%dm ago"):format((math.floor(v155)))
			elseif v153 < 172800 then
				local v156 = v153 / 3600
				v154 = ("%dh ago"):format((math.floor(v156)))
			else
				local v157 = v153 / 86400
				v154 = ("%dd ago"):format((math.floor(v157)))
			end
			local v158 = v144.dueAt
			local v159
			if tonumber(v158) and v143 < v144.dueAt then
				local v160 = (v144.dueAt - v143) / 3600
				local v161 = math.floor(v160)
				local v162 = (v144.dueAt - v143) % 3600 / 60
				v159 = ("lands in %dh %02dm"):format(v161, (math.floor(v162)))
			else
				v159 = "lands any minute"
			end
			v147.sub = v149:format(v151, v154, v159)
			local v163 = v_u_7
			local v164 = v144.reason or "No reason given"
			v147.body = v163((tostring(v164))) .. "\n\n<font color=\"#6E736C\">The ban covers their alt accounts too when it lands. A staff ban before then replaces it.</font>"
			v147.actions = {
				{
					["id"] = "remove",
					["text"] = "Take out of the wave",
					["on"] = true,
					["visible"] = nil,
					["confirm"] = "Sure? Press again",
					["visible"] = v_u_15.flag("canQueue")
				},
				{
					["id"] = "lookup",
					["text"] = "Look up",
					["on"] = true,
					["visible"] = v_u_13("flags")
				}
			}
			return v147
		end
		local v165 = v_u_15.selected
		if v165 then
			v165 = v_u_15.row(v_u_15.selected)
		end
		if not v165 then
			return {
				["none"] = "Pick a suspect on the left. Nothing on this page bans anyone by itself.",
				["noneActions"] = {}
			}
		end
		local v166 = v165.score
		local v167 = tonumber(v166) or 0
		local v168, v169, v170, v171 = v_u_15.counts(v165)
		local v172 = { ("Bait: followed %d, shot at %d"):format(v168, v169), ("Wall tracks: %d"):format(v170) }
		local v173 = v165.lockN
		if (tonumber(v173) or 0) > 0 then
			local v174 = v165.lockPct
			local v175 = tonumber(v174) or 0
			local v176 = v165.lockN
			local v177 = tonumber(v176) or 0
			local v178 = v171 <= 0 and "" or (", flagged %d times"):format(v171)
			table.insert(v172, ("Head lock: %d%% dead on over the last %d shots%s"):format(v175, v177, v178))
		elseif v171 > 0 then
			table.insert(v172, ("Head lock: flagged %d times"):format(v171))
		end
		local v179 = v165.last
		if type(v179) == "string" and v165.last ~= "" then
			table.insert(v172, "")
			local v180 = "<font color=\"#A3A79F\">" .. v_u_7(v165.last) .. "</font>"
			table.insert(v172, v180)
		end
		local v181 = v165.online and (v165.here and "on this server" or "on another server") or "offline"
		local v182 = v165.at
		local v183
		if type(v182) == "number" and v165.at > 0 then
			local v184 = ", last seen "
			local v185 = v143 - v165.at
			local v186
			if v185 < 90 then
				v186 = "just now"
			elseif v185 < 5400 then
				local v187 = v185 / 60
				v186 = ("%dm ago"):format((math.floor(v187)))
			elseif v185 < 172800 then
				local v188 = v185 / 3600
				v186 = ("%dh ago"):format((math.floor(v188)))
			else
				local v189 = v185 / 86400
				v186 = ("%dd ago"):format((math.floor(v189)))
			end
			v183 = v184 .. v186
		else
			v183 = ""
		end
		local v190 = v165.online and v165.here
		if v190 then
			v190 = v_u_2:GetPlayerByUserId(v165.userId) ~= nil
		end
		local v191 = {}
		local v192 = v165.name or v165.userId
		v191.name = tostring(v192)
		v191.score = tostring(v167)
		v191.scoreTone = v_u_15.tone(v167)
		v191.tapes = v_u_15.tapes(v165)
		v191.sub = v181 .. v183
		v191.body = table.concat(v172, "\n")
		v191.actions = {
			{
				["id"] = "spectate",
				["text"] = "Spectate",
				["on"] = nil,
				["visible"] = true,
				["on"] = v190
			},
			{
				["id"] = "goto",
				["text"] = "Go to",
				["on"] = nil,
				["visible"] = true,
				["on"] = v190
			},
			{
				["id"] = "lookup",
				["text"] = "Look up",
				["on"] = true,
				["visible"] = v_u_13("flags")
			},
			{
				["id"] = "clear",
				["text"] = "Clear",
				["on"] = true,
				["visible"] = nil,
				["confirm"] = "Clear them?",
				["visible"] = v_u_15.flag("canClear")
			},
			{
				["id"] = "queue",
				["text"] = nil,
				["on"] = nil,
				["visible"] = nil,
				["tone"] = "bad",
				["confirm"] = "Perm ban in the wave?",
				["text"] = v165.queued and "Queued" or "Queue ban",
				["on"] = not v165.queued,
				["visible"] = v_u_15.flag("canQueue")
			}
		}
		return v191
	end
	function v_u_15.render() -- name: render
		-- upvalues: (copy) v_u_15
		local v193 = v_u_15.page
		if v193 and v193.alive() then
			v193.renderList(v_u_15.listVM())
			v193.renderDetail(v_u_15.detailVM())
		elseif v_u_15.pageFrame and not v_u_15.mounting then
			task.spawn(v_u_15.mount)
		end
	end
	function v_u_15.load() -- name: load
		-- upvalues: (copy) v_u_15, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6, (copy) v_u_10
		if not v_u_15.loading then
			v_u_15.loading = true
			local v194, v195 = v_u_9.call("suspects")
			v_u_15.loading = false
			if v194 and type(v195) == "table" then
				v_u_15.data = v195
				if v_u_8.tabButtons.suspects then
					local v196 = v195.rows
					if type(v196) == "table" then
						local v197 = 0
						for _, v198 in ipairs(v195.rows) do
							if type(v198) ~= "table" then
								continue
							end
							local v199 = v198.score
							if (tonumber(v199) or 0) < 10 or v198.queued then
								continue
							end
							v197 = v197 + 1
						end
						v_u_8.tabButtons.suspects.badge.Text = v197 <= 0 and "" or tostring(v197)
						v_u_8.tabButtons.suspects.badge.TextColor3 = v_u_6.bad
					end
				end
			elseif v_u_15.data == nil then
				v_u_15.data = {
					["rows"] = nil,
					["wave"] = nil,
					["rows"] = {}
				}
				v_u_10.push(type(v195) ~= "string" and "Couldn\'t load the suspects" or v195, "bad")
			end
			v_u_15.render()
		end
	end
	p1.XS = v_u_15
	p1.xsAgo = v_u_20
end
