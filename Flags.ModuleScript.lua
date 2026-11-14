--!native
-- Path: Flags.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

local function __set_list(target, start, items)
	for i, v in ipairs(items) do
		target[start + i - 1] = v
	end
	return target
end

return function(p1)
	local v_u_2 = p1.playerGui
	local v3 = p1.FustShared
	local v_u_4 = p1.FlagGuide
	local v_u_5 = p1.RVH
	local v_u_6 = p1.C
	local v_u_7 = p1.escape
	local v_u_8 = p1.formatSpan
	local v_u_9 = p1.trim
	local v_u_10 = p1.S
	local v_u_11 = p1.U
	local v_u_12 = p1.Net
	local v_u_13 = p1.Toast
	local v_u_14 = p1.Spec
	local v_u_15 = p1.P71
	local v16 = p1.Pages
	local v_u_17 = p1.Admin
	local v_u_18 = p1.L240
	local v_u_19 = p1.T265
	local v_u_20 = p1.can
	local v_u_21 = p1.Join68
	local v22 = p1.PP
	local v_u_23 = {
		["rows"] = nil,
		["selected"] = nil,
		["data"] = nil,
		["loading"] = false,
		["again"] = false,
		["kind"] = "any",
		["rows"] = {}
	}
	v16.flags = v_u_23
	v_u_23.ui = require((v3:WaitForChild("AdminUI"):WaitForChild("FlagsPage")))
	v_u_23.SHORT_TAPE = {
		["NOTE ONLY"] = "NOTE",
		["REVIEW ONLY"] = "REVIEW",
		["NEEDS 2ND SIGN"] = "2ND SIGN"
	}
	v_u_23.TONE_HEX = {
		["amber"] = "D9A441",
		["rust"] = "C2502A",
		["good"] = "6FA35A",
		["bad"] = "B8452F",
		["badText"] = "E0745A",
		["text"] = "ECE6DA",
		["muted"] = "A3A79F",
		["dim"] = "6E736C"
	}
	local v_u_24 = {
		["wl"] = {},
		["wlRows"] = {}
	}
	v_u_23.sort = "newest"
	v_u_23.filter = "all"
	v_u_23.q = ""
	v_u_23.qGen = 0
	v_u_23.view = "flags"
	v_u_23.extra = nil
	v_u_23.vocab = nil
	v_u_23.vocabBusy = false
	v_u_23.AIM348_SHOW = 2
	v_u_23.AIM348_FLAG = 4
	function v_u_23.kit(p25) -- name: kit
		-- upvalues: (copy) v_u_2
		local v26
		if p25 then
			v26 = v_u_2:WaitForChild("FustAdminKit", 30)
		else
			v26 = v_u_2:FindFirstChild("FustAdminKit")
		end
		if v26 and v26:IsA("ScreenGui") then
			return v26
		else
			return nil
		end
	end
	function v_u_23.label(p27) -- name: label
		-- upvalues: (copy) v_u_4, (copy) v_u_23
		return v_u_4.label(v_u_23.vocab, p27)
	end
	function v_u_23.loadVocab() -- name: loadVocab
		-- upvalues: (copy) v_u_23, (copy) v_u_12
		if not (v_u_23.vocab or v_u_23.vocabBusy) then
			v_u_23.vocabBusy = true
			local v28, v29 = v_u_12.call("flag_vocab", {})
			v_u_23.vocabBusy = false
			if v28 and type(v29) == "table" then
				local v30 = v29.kinds
				if type(v30) == "table" then
					v_u_23.vocab = v29
					v_u_23.render()
				end
			end
		end
	end
	function v_u_23.openGuide() -- name: openGuide
		-- upvalues: (copy) v_u_23, (copy) v_u_13, (copy) v_u_4
		local v31 = v_u_23.kit()
		if not v_u_23.vocab then
			v_u_23.loadVocab()
		end
		if v31 and v_u_23.vocab then
			v_u_4.open(v31, v_u_23.vocab)
		else
			v_u_13.push("The flag guide isn\'t loaded yet, try again in a moment", "bad")
		end
	end
	function v_u_23.build(p32) -- name: build
		-- upvalues: (copy) v_u_23
		v_u_23.pageFrame = p32
		task.spawn(v_u_23.mount)
	end
	function v_u_23.mount() -- name: mount
		-- upvalues: (copy) v_u_23, (copy) v_u_24, (copy) v_u_5, (copy) v_u_12
		if not v_u_23.mounting and v_u_23.pageFrame then
			v_u_23.mounting = true
			local v33 = v_u_23.kit(true)
			if v33 and (not v_u_23.page or (not v_u_23.page.alive() or v_u_23.pageKit ~= v33)) then
				if v_u_23.page then
					v_u_23.page.destroy()
				end
				v_u_23.pageKit = v33
				local v50 = {
					["select"] = function(p34) -- name: select
						-- upvalues: (ref) v_u_23
						v_u_23.select(p34)
					end,
					["search"] = function(p35) -- name: search
						-- upvalues: (ref) v_u_23
						v_u_23.onSearch(p35)
					end,
					["sort"] = function() -- name: sort
						-- upvalues: (ref) v_u_23
						v_u_23.sort = v_u_23.sort == "score" and "newest" or "score"
						v_u_23.renderList()
					end,
					["filter"] = function(p36) -- name: filter
						-- upvalues: (ref) v_u_23, (ref) v_u_24
						v_u_23.filter = p36
						v_u_23.renderList()
						if p36 == "watch" then
							task.spawn(v_u_24.loadWatch, true)
						end
					end,
					["kind"] = function(p37) -- name: kind
						-- upvalues: (ref) v_u_23
						v_u_23.kind = p37
						if not v_u_23.vocab then
							task.spawn(v_u_23.loadVocab)
						end
						v_u_23.render()
					end,
					["view"] = function(p38) -- name: view
						-- upvalues: (ref) v_u_23, (ref) v_u_5
						if p38 == "replays" then
							local v39 = v_u_23.selected
							if v39 then
								v39 = v_u_23.entry(v_u_23.selected)
							end
							local v40 = task.spawn
							local v41 = v_u_5.showList
							local v42 = v_u_23.selected
							local v43
							if v39 then
								v43 = v39.name
							else
								v43 = nil
							end
							v40(v41, v42, v43)
						else
							v_u_23.view = p38
							v_u_23.renderDetail()
						end
					end,
					["action"] = function(p44) -- name: action
						-- upvalues: (ref) v_u_23
						task.spawn(v_u_23.action, p44)
					end,
					["guide"] = function() -- name: guide
						-- upvalues: (ref) v_u_23
						task.spawn(v_u_23.openGuide)
					end,
					["clearAll"] = function() -- name: clearAll
						-- upvalues: (ref) v_u_12, (ref) v_u_23
						task.spawn(function()
							-- upvalues: (ref) v_u_12, (ref) v_u_23
							if v_u_12.act("flags_clear_all", {}) then
								v_u_23.selected = nil
								v_u_23.load()
							end
						end)
					end,
					["watchSave"] = function(p45) -- name: watchSave
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.save, p45)
					end,
					["watchRemove"] = function() -- name: watchRemove
						-- upvalues: (ref) v_u_24, (ref) v_u_23
						task.spawn(v_u_24.remove, v_u_23.selected)
					end,
					["watchJump"] = function(p46) -- name: watchJump
						-- upvalues: (ref) v_u_24
						v_u_24.jump(p46, nil)
					end,
					["watchDrop"] = function(p47) -- name: watchDrop
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.remove, p47)
					end,
					["watchFlag"] = function(p48, p49) -- name: watchFlag
						-- upvalues: (ref) v_u_5
						task.spawn(v_u_5.open, p48, p49)
					end
				}
				v_u_23.page = v_u_23.ui.mount(v33, v_u_23.pageFrame, v50)
				if v_u_23.page then
					v_u_23.page.setSearch(v_u_23.q)
				end
			end
			v_u_23.mounting = false
			if v_u_23.page and v_u_23.page.alive() then
				v_u_23.render()
			end
		end
	end
	function v_u_23.onSearch(p51) -- name: onSearch
		-- upvalues: (copy) v_u_9, (copy) v_u_23, (copy) v_u_10
		local v52 = v_u_9(p51)
		if v52 ~= v_u_23.q then
			v_u_23.q = v52
			v_u_23.renderList()
			local v53 = v_u_23
			v53.qGen = v53.qGen + 1
			local v_u_54 = v_u_23.qGen
			task.delay(0.5, function()
				-- upvalues: (copy) v_u_54, (ref) v_u_23, (ref) v_u_10
				if v_u_54 == v_u_23.qGen and (v_u_10.open and v_u_10.tab == "flags") then
					v_u_23.load()
				end
			end)
		end
	end
	function v_u_23.hx(p55, p56) -- name: hx
		-- upvalues: (copy) v_u_23
		return ("<font color=\"#%s\">%s</font>"):format(v_u_23.TONE_HEX[p55] or v_u_23.TONE_HEX.muted, p56)
	end
	function v_u_23.banFor(p57) -- name: banFor
		-- upvalues: (copy) v_u_23, (copy) v_u_15, (copy) v_u_20
		local v58 = p57.userId
		local v59 = "Anti-cheat"
		for v60 = 3, 1, -1 do
			local v61 = v_u_23.kindSummary(p57.kinds, v60)
			local v62 = "Anti-cheat" .. (v61 == "" and "" or ": " .. v61)
			if #v62 > 120 then
				continue
			end
			v59 = v62
		end
		local v63 = {
			["target"] = {
				["id"] = v58,
				["name"] = p57.name
			}
		}
		local v64
		if p57.online == true then
			v64 = not p57.remote
		else
			v64 = false
		end
		v63.here = v64
		v63.reasonText = v59
		if v_u_15.can("ban") then
			v_u_23.jump(v63.here and "ban" or "bans", v63)
		elseif v_u_20("ban_request") then
			v_u_23.jump("reqban", v63)
		end
	end
	function v_u_23.action(p65) -- name: action
		-- upvalues: (copy) v_u_23, (copy) v_u_21, (copy) v_u_12, (copy) v_u_14, (copy) v_u_5, (copy) v_u_18, (copy) v_u_19, (copy) v_u_13, (copy) v_u_24
		local v66 = v_u_23.selected
		local v67
		if v66 then
			v67 = v_u_23.entry(v66)
		else
			v67 = v66
		end
		if v66 and v67 then
			if p65 == "goto" then
				if v67.remote == true and (v67.online == true and (not v67.history and v_u_21.other(v67.server))) then
					v_u_21.sentAt = os.clock()
					v_u_12.act("staff_travel", {
						["serverId"] = v67.server.id
					}, "Joining")
				else
					v_u_12.act("goto", {
						["userId"] = v66
					}, "Teleported")
				end
			elseif p65 == "spectate" then
				v_u_14.toggle(v66)
				v_u_23.renderDetail()
				return
			elseif p65 == "replay" then
				v_u_5.live(v66)
				return
			elseif p65 == "ban" then
				v_u_23.banFor(v67)
			elseif p65 == "clear" then
				if v_u_12.act("flags_clear", {
					["userId"] = v66
				}, "Cleared") then
					v_u_23.load()
					return
				end
			elseif p65 == "watch" then
				if v_u_12.act("watch", {
					["userId"] = v66,
					["on"] = v67.watched ~= true
				}) then
					v_u_23.load()
					return
				end
			elseif p65 == "aim" or p65 == "esp" then
				if v_u_23.baitTry("bait_" .. p65, v66) then
					v_u_23.load()
					return
				end
			elseif p65 == "freeze" then
				local v68 = v_u_23.extra
				local v69
				if type(v68) == "table" and v68.userId == v66 then
					v69 = v68.frozen == true
				else
					v69 = false
				end
				if v_u_12.act("freeze", {
					["userId"] = v66,
					["on"] = not v69
				}) then
					v_u_23.load()
					return
				end
			elseif p65 == "live" then
				local v70 = v_u_18.subs[v66] ~= true
				if v_u_12.act("bait_live", {
					["userId"] = v66,
					["on"] = v70
				}) then
					v_u_18.subs[v66] = v70 and true or nil
					v_u_23.renderDetail()
					return
				end
			else
				if p65 == "trial" then
					v_u_19.open(v66, v67.name)
					return
				end
				if p65 == "evidence" then
					v_u_12.act("evidence_pack", {
						["userId"] = v66
					}, "Evidence sent to Discord")
					return
				end
				if p65 == "save" then
					local v71, v72 = v_u_12.call("replay_capture", {
						["userId"] = v66
					})
					if v71 and type(v72) == "table" then
						local v73 = v_u_13.push
						local v74 = v72.text or "Clip saved"
						v73(tostring(v74) .. " - it\'s in Replays", "good")
					else
						v_u_13.push((type(v72) ~= "string" or v72 == "") and "Couldn\'t save a clip" or v72, "bad")
					end
				end
				if p65 == "watchlist" then
					v_u_23.view = "intel"
					v_u_23.renderDetail()
					if not v_u_24.wl[v66] and v_u_23.page then
						v_u_23.page.focusNote()
					end
				end
			end
		else
			return
		end
	end
	function v_u_23.entry(p75) -- name: entry
		-- upvalues: (copy) v_u_23
		local v76 = v_u_23.data
		if type(v76) == "table" then
			local v77 = v76.players
			if type(v77) == "table" then
				for _, v78 in ipairs(v76.players) do
					if type(v78) ~= "table" or v78.userId ~= p75 then
						continue
					end
					return v78
				end
				return nil
			end
		end
		return nil
	end
	v_u_23.INFO298 = {
		["alt_hint"] = true,
		["potion"] = true,
		["stat_spike"] = true,
		["aimcohort"] = true
	}
	function v_u_23.isInfo(p79) -- name: isInfo
		-- upvalues: (copy) v_u_23
		local v80 = v_u_23.data
		local v81, v82
		if type(v80) == "table" then
			local v83 = v80.info
			if type(v83) == "table" then
				v81 = v80.info
				if type(p79) == "string" then
					v82 = v81[p79] == true and true or v_u_23.INFO298[p79] == true
				else
					v82 = false
				end
				return v82
			else
				v81 = v_u_23.INFO298
				if type(p79) == "string" then
					v82 = v81[p79] == true and true or v_u_23.INFO298[p79] == true
				else
					v82 = false
				end
				return v82
			end
		else
			v81 = v_u_23.INFO298
			if type(p79) == "string" then
				v82 = v81[p79] == true and true or v_u_23.INFO298[p79] == true
			else
				v82 = false
			end
			return v82
		end
	end
	function v_u_23.kindSummary(p84, p85) -- name: kindSummary
		-- upvalues: (copy) v_u_23
		local v86 = {}
		if type(p84) == "table" then
			for v87, v88 in pairs(p84) do
				if type(v87) ~= "string" or type(v88) ~= "number" then
					continue
				end
				local v89 = {
					["kind"] = v87,
					["n"] = v88,
					["info"] = v_u_23.isInfo(v87)
				}
				table.insert(v86, v89)
			end
		end
		table.sort(v86, function(p90, p91)
			if p90.info == p91.info then
				if p90.n == p91.n then
					return p90.kind < p91.kind
				else
					return p90.n > p91.n
				end
			else
				return not p90.info
			end
		end)
		local v92 = #v86
		local v93 = {}
		for v94 = 1, math.min(v92, p85) do
			local v95 = v_u_23.label(v86[v94].kind)
			local v96 = v86[v94].n
			local v97 = v86[v94].info and " (note)" or ""
			table.insert(v93, ("%s \195\151%d%s"):format(v95, v96, v97))
		end
		return table.concat(v93, " \194\183 ")
	end
	function v_u_23.matches(p98, p99) -- name: matches
		if p99 == "" then
			return true
		end
		if p98.found == true then
			return true
		end
		local v100 = p98.userId
		local v101
		if tostring(v100) == p99 then
			v101 = true
		else
			local v102 = string.find
			local v103 = string.lower
			local v104 = p98.name or ""
			if v102(v103((tostring(v104))), p99, 1, true) == nil then
				local v105 = string.find
				local v106 = string.lower
				local v107 = p98.displayName or ""
				v101 = v105(v106((tostring(v107))), p99, 1, true) ~= nil
			else
				v101 = true
			end
		end
		return v101
	end
	function v_u_23.groupOf(p108) -- name: groupOf
		-- upvalues: (copy) v_u_23
		local v109 = v_u_23.vocab
		if v109 then
			local v110 = v109.kinds
			if type(v110) == "table" then
				v109 = v109.kinds[p108]
			else
				v109 = false
			end
		end
		local v111
		if type(v109) == "table" then
			local v112 = v109.group
			v111 = type(v112) ~= "string" and "other" or v109.group
		else
			v111 = "other"
		end
		return v111 ~= "movement" and (v111 ~= "aim" and (v111 ~= "combat" and v111 ~= "base")) and "other" or v111
	end
	function v_u_23.kindOk(p113) -- name: kindOk
		-- upvalues: (copy) v_u_23
		return v_u_23.kind == "any" and true or v_u_23.groupOf(p113) == v_u_23.kind
	end
	function v_u_23.hasKind(p114) -- name: hasKind
		-- upvalues: (copy) v_u_23
		if v_u_23.kind == "any" then
			return true
		end
		local v115 = p114.kinds
		if type(v115) ~= "table" then
			return false
		end
		for v116 in pairs(p114.kinds) do
			if type(v116) ~= "string" or not v_u_23.kindOk(v116) then
				continue
			end
			return true
		end
		return false
	end
	function v_u_23.visible(p117) -- name: visible
		-- upvalues: (copy) v_u_23
		local v118 = string.lower((string.gsub(v_u_23.q, "^@", "")))
		local v119 = {}
		for _, v120 in ipairs(p117) do
			if type(v120) ~= "table" then
				continue
			end
			local v121 = v120.userId
			if type(v121) ~= "number" or not (v_u_23.matches(v120, v118) and v_u_23.hasKind(v120)) then
				continue
			end
			local v122
			if v120.online == true then
				v122 = not v120.remote
			else
				v122 = false
			end
			if v_u_23.filter ~= "all" and (v_u_23.filter ~= "online" or (v120.online ~= true or v120.history)) and ((v_u_23.filter ~= "here" or not v122) and (v_u_23.filter ~= "canban" or v120.banReady ~= true)) then
				continue
			end
			table.insert(v119, v120)
		end
		table.sort(v119, function(p123, p124)
			-- upvalues: (ref) v_u_23
			if v_u_23.sort == "score" then
				local v125 = p123.score
				local v126 = tonumber(v125) or 0
				local v127 = p123.peak
				local v128 = tonumber(v127) or 0
				local v129 = math.max(v126, v128)
				local v130 = p124.score
				local v131 = tonumber(v130) or 0
				local v132 = p124.peak
				local v133 = tonumber(v132) or 0
				local v134 = math.max(v131, v133)
				if v129 ~= v134 then
					return v134 < v129
				end
			end
			local v135 = p123.ago
			local v136 = tonumber(v135) or (1 / 0)
			local v137 = p124.ago
			local v138 = tonumber(v137) or (1 / 0)
			if v136 ~= v138 then
				return v136 < v138
			end
			local v139 = p123.score
			local v140 = tonumber(v139) or 0
			local v141 = p123.peak
			local v142 = tonumber(v141) or 0
			local v143 = math.max(v140, v142)
			local v144 = p124.score
			local v145 = tonumber(v144) or 0
			local v146 = p124.peak
			local v147 = tonumber(v146) or 0
			return math.max(v145, v147) < v143
		end)
		return v119
	end
	function v_u_23.serverShort(p148) -- name: serverShort
		if p148.online == true and not p148.remote then
			return "HERE"
		end
		local v149 = p148.server
		local v150
		if type(v149) == "table" then
			v150 = p148.server.name or p148.server.id
		else
			v150 = false
		end
		local v151 = string.gsub(tostring(v150 or "?"), "^Fust Survival%s*", "")
		local v152 = string.upper
		if v151 == "" then
			v151 = tostring(v150 or "?")
		end
		return v152(v151)
	end
	function v_u_23.renderList() -- name: renderList
		-- upvalues: (copy) v_u_23, (copy) v_u_7, (copy) v_u_24, (copy) v_u_8, (copy) v_u_20, (copy) v_u_11, (copy) v_u_6
		local v153 = v_u_23.page
		if v153 and v153.alive() then
			local v154 = v_u_23.data
			local v155
			if type(v154) == "table" then
				local v156 = v154.players
				v155 = type(v156) ~= "table" and {} or v154.players
			else
				v155 = {}
			end
			local v157
			if type(v154) == "table" then
				local v158 = v154.high
				v157 = type(v158) ~= "number" and 25 or v154.high
			else
				v157 = 25
			end
			local v159 = 0
			for _, v160 in ipairs(v155) do
				if type(v160) ~= "table" or (v160.high ~= true or (not v160.online or v160.remote)) then
					continue
				end
				v159 = v159 + 1
			end
			local v161 = v_u_23.visible(v155)
			local v162 = {}
			for _, v163 in ipairs(v161) do
				local v164 = v163.displayName or (v163.name or v163.userId)
				local v165 = tostring(v164)
				local v166 = v163.name or ""
				local v167 = tostring(v166)
				local v168 = v163.score
				local v169 = tonumber(v168) or 0
				local v170 = v163.peak
				local v171 = type(v170) ~= "number" and 0 or v163.peak
				local v172 = math.max(v169, v171)
				local v173 = v163.high == true
				local v174 = {}
				local v175
				if v163.online == true then
					v175 = not v163.remote
				else
					v175 = false
				end
				local v176 = v_u_23.hx
				local v177 = v_u_7
				local v178 = string.lower
				local v179 = v_u_23.serverShort
				table.insert(v174, v176(v175 and "good" or "muted", v177(v178(v179(v163)))))
				if v163.watched then
					local v180 = v_u_23.hx
					table.insert(v174, v180("text", "watched"))
				end
				if v_u_24.wl[v163.userId] then
					local v181 = v_u_23.hx
					table.insert(v174, v181("amber", "listed"))
				end
				local v182 = v163.ago
				local v183 = tonumber(v182)
				if v183 then
					local v184 = v163.total
					if (tonumber(v184) or 0) > 0 then
						local v185
						if v183 < 10 then
							v185 = v_u_23.hx("badText", "just now")
						else
							v185 = v_u_23.hx("muted", v_u_7(v_u_8(v183)) .. " ago")
						end
						table.insert(v174, v185)
					end
				end
				if v169 < v171 and not v163.history then
					local v186 = v_u_23.hx
					local v187 = v169 + 0.5
					local v188 = math.floor(v187)
					table.insert(v174, v186("dim", ("now %d"):format(v188)))
				end
				if v163.history then
					local v189 = v_u_23.hx
					table.insert(v174, v189("dim", "saved"))
				elseif not v163.online then
					local v190 = v_u_23.hx
					table.insert(v174, v190("dim", "left"))
				end
				if v163.kicked then
					local v191 = v_u_23.hx
					table.insert(v174, v191("badText", "kicked"))
				end
				if v163.banReady == true then
					local v192 = v_u_23.hx
					table.insert(v174, v192("badText", "can ban"))
				end
				local v193 = v163.aim348
				local v194 = tonumber(v193)
				if v194 and v_u_23.AIM348_SHOW <= v194 then
					local v195 = v_u_23.hx
					local v196 = v_u_23.AIM348_FLAG <= v194 and "bad" or "amber"
					table.insert(v174, v195(v196, ("aim +%.1f sd"):format(v194)))
				end
				if v163.banned then
					local v197 = v_u_23.hx
					table.insert(v174, v197("badText", "banned"))
				elseif v163.alerted and v173 then
					local v198 = v_u_23.hx
					table.insert(v174, v198("badText", "alert sent"))
				end
				local v199 = v_u_23.kindSummary(v163.kinds, 3)
				if v199 ~= "" then
					local v200 = v_u_7
					table.insert(v174, v200(v199))
				end
				local v201 = v_u_23.selected == v163.userId
				local v202 = {
					["uid"] = v163.userId,
					["name"] = v_u_7(v165) .. ((v167 == "" or string.lower(v167) == string.lower(v165)) and "" or " " .. v_u_23.hx("dim", "@" .. v_u_7(v167)))
				}
				local v203 = v172 + 0.5
				local v204 = math.floor(v203)
				v202.score = tostring(v204)
				v202.scoreTone = v173 and "badText" or (v169 >= 1 and "amber" or (v172 >= 1 and "muted" or "dim"))
				v202.sub = table.concat(v174, " \194\183 ")
				local v205 = v157 * 4
				v202.fill = v172 / math.max(v205, 1)
				v202.fillTone = v173 and "bad" or "amber"
				v202.mark = v201 and "rust" or (v163.watched == true and "muted" or nil)
				v202.bg = v201 and "hover" or "raised"
				table.insert(v162, v202)
			end
			local v206 = v_u_23.loadErr
			if not v206 and type(v154) == "table" then
				local v207 = {}
				local v208
				if #v161 < #v155 then
					v208 = ("%d of %d players"):format(#v161, #v155)
				else
					v208 = ("%d %s"):format(#v155, #v155 == 1 and "player" or "players")
				end
				__set_list(v207, 1, {v208})
				local v209 = v154.running == false and "checks off" or "checks on"
				table.insert(v207, v209)
				local v210 = v154.autoKick == true and "auto-kick on" or "auto-kick off"
				table.insert(v207, v210)
				v206 = table.concat(v207, " \194\183 ")
			end
			if v_u_23.filter == "watch" then
				local v211 = v_u_24.wlOrder
				local v212
				if type(v211) == "table" then
					v212 = v_u_24.wlOrder
				else
					v212 = nil
				end
				local v213 = v_u_24.watchVM()
				local v214 = v153.renderList
				local v215 = {
					["rows"] = nil,
					["watch"] = nil,
					["empty"] = nil,
					["status"] = nil,
					["sort"] = nil,
					["filter"] = nil,
					["kind"] = nil,
					["clearAll"] = false,
					["rows"] = {},
					["watch"] = v213
				}
				local v216
				if v_u_24.wlErr then
					v216 = v_u_24.wlErr
				else
					v216 = v212 == nil and "Loading" or (v_u_23.q == "" and "Nobody on the watchlist yet. Add players from their Intel view." or "No watchlisted player matches")
				end
				v215.empty = v216
				local v217
				if v212 then
					v217 = ("%d on the watchlist, every server"):format(#v212)
				else
					v217 = v_u_24.wlErr or "Loading"
				end
				v215.status = v217
				v215.sort = v_u_23.sort
				v215.filter = v_u_23.filter
				v215.kind = v_u_23.kind
				v214(v215)
			else
				local v218 = v153.renderList
				local v219 = {
					["rows"] = nil,
					["watch"] = nil,
					["empty"] = nil,
					["status"] = nil,
					["sort"] = nil,
					["filter"] = nil,
					["kind"] = nil,
					["clearAll"] = nil,
					["rows"] = v162
				}
				local v220
				if v154 == nil then
					v220 = v_u_23.loadErr or "Loading"
				elseif v_u_23.q == "" then
					v220 = #v155 > 0 and "Nobody in this filter" or "No flags this session"
				else
					v220 = ("No flagged player matches \"%s\"%s"):format(v_u_23.q, v_u_23.loading and ", still searching saved history" or "")
				end
				v219.empty = v220
				v219.status = v206 or "Loading"
				v219.sort = v_u_23.sort
				v219.filter = v_u_23.filter
				v219.kind = v_u_23.kind
				local v221 = v_u_20("flags_clear_all")
				if v221 then
					v221 = #v155 > 0
				end
				v219.clearAll = v221
				v218(v219)
				if v_u_11.tabButtons.flags and v154 ~= nil then
					v_u_11.tabButtons.flags.badge.Text = v159 <= 0 and "" or tostring(v159)
					v_u_11.tabButtons.flags.badge.TextColor3 = v_u_6.bad
				end
			end
		else
			if v_u_23.pageFrame and not v_u_23.mounting then
				task.spawn(v_u_23.mount)
			end
			return
		end
	end
	function v_u_23.focus(p222, p223) -- name: focus
		-- upvalues: (copy) v_u_10, (copy) v_u_20, (copy) v_u_9, (copy) v_u_23, (copy) v_u_17
		if not (v_u_10.role and v_u_20("flags")) then
			return false, nil
		end
		local v224 = string.gsub(v_u_9((tostring(p222 or ""))), "^@", "")
		if v224 == "" and type(p223) == "number" then
			v224 = tostring(p223)
		end
		v_u_23.pending230 = {
			["userId"] = p223,
			["q"] = string.lower(v224)
		}
		v_u_23.filter = "all"
		v_u_23.q = v224
		if v_u_23.page then
			v_u_23.page.setSearch(v224)
		end
		if not v_u_10.open then
			v_u_17.setOpen(true)
		end
		v_u_17.selectTab("flags")
		task.spawn(v_u_23.load)
		return true, nil
	end
	function v22.openFlags(p225, p226) -- name: openFlags
		-- upvalues: (copy) v_u_23
		v_u_23.view = "flags"
		v_u_23.focus(p225 or "", p226)
	end
	function v_u_23.applyFocus() -- name: applyFocus
		-- upvalues: (copy) v_u_23
		local v227 = v_u_23.pending230
		local v228 = v_u_23.data
		if v227 and type(v228) == "table" then
			local v229 = v228.players
			if type(v229) == "table" then
				v_u_23.pending230 = nil
				local v230 = 0
				local v231 = nil
				for _, v232 in ipairs(v228.players) do
					if type(v232) ~= "table" then
						continue
					end
					local v233 = v232.userId
					if type(v233) ~= "number" then
						continue
					end
					if v227.userId and v232.userId == v227.userId then
						v231 = v232.userId
						v230 = 1
						break
					end
					if v227.q == "" then
						if not v_u_23.matches(v232, v227.q) then
							continue
						end
						v230 = v230 + 1
						v231 = v231 or v232.userId
					else
						local v234 = string.lower
						local v235 = v232.name or ""
						if v234((tostring(v235))) == v227.q then
							v231 = v232.userId
							v230 = 1
							break
						end
						local v236 = v232.userId
						if tostring(v236) == v227.q then
							v231 = v232.userId
							v230 = 1
							break
						end
						if not v_u_23.matches(v232, v227.q) then
							continue
						end
						v230 = v230 + 1
						v231 = v231 or v232.userId
					end
				end
				if v231 and (v230 == 1 and v_u_23.selected ~= v231) then
					v_u_23.select(v231)
				end
			end
		else
			return
		end
	end
	v_u_23.BAIT_TAG = "[retry] "
	v_u_23.BAIT_TRIES = 4
	v_u_23.BAIT_GAP = 6
	function v_u_23.baitTry(p237, p238) -- name: baitTry
		-- upvalues: (copy) v_u_10, (copy) v_u_23, (copy) v_u_12, (copy) v_u_13
		if v_u_10.busy[p237] then
			return false
		end
		v_u_10.busy[p237] = true
		local v239 = false
		local v240 = nil
		for v241 = 1, v_u_23.BAIT_TRIES do
			v239, v240 = v_u_12.call(p237, {
				["userId"] = p238
			})
			local v242 = not v239
			if v242 then
				if type(v240) == "string" then
					local v243 = #v_u_23.BAIT_TAG
					v242 = string.sub(v240, 1, v243) == v_u_23.BAIT_TAG
				else
					v242 = false
				end
			end
			if v242 then
				local v244 = #v_u_23.BAIT_TAG + 1
				v240 = string.sub(v240, v244)
			end
			if v239 or (not v242 or v241 == v_u_23.BAIT_TRIES) then
				break
			end
			if v241 == 1 then
				v_u_13.push("Trying again for ~20 s: " .. tostring(v240), "warn")
			end
			task.wait(v_u_23.BAIT_GAP)
		end
		v_u_10.busy[p237] = nil
		if v239 then
			v_u_13.push((type(v240) ~= "string" or v240 == "") and "Done" or v240, "good")
			return v239
		else
			v_u_13.push((type(v240) ~= "string" or v240 == "") and "Not allowed" or v240, "bad")
			return v239
		end
	end
	p1.GP = v_u_23
	p1.RJ = v_u_24
end
