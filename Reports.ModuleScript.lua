--!native
-- Path: Reports.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

return function(p1)
	local v_u_2 = p1.player
	local v3 = p1.FustShared
	local v_u_4 = p1.RVH
	local v_u_5 = p1.SB
	local v_u_6 = p1.C
	local v_u_7 = p1.K
	local v_u_8 = p1.escape
	local v_u_9 = p1.formatSpan
	local v_u_10 = p1.serverNow
	local v_u_11 = p1.trim
	local v_u_12 = p1.S
	local v_u_13 = p1.U
	local v_u_14 = p1.Net
	local v_u_15 = p1.Toast
	local v_u_16 = p1.Spec
	local v_u_17 = p1.CF345
	local v_u_18 = p1.P71
	local v19 = p1.Pages
	local v_u_20 = p1.Admin
	local v_u_21 = p1.can
	local v_u_22 = p1.Join68
	local v_u_23 = p1.CP351
	local v_u_24 = p1.PP
	local v_u_25 = p1.GP
	local v_u_26 = {
		["rows"] = nil,
		["selected"] = nil,
		["data"] = nil,
		["loading"] = false,
		["again"] = false,
		["filter"] = "open",
		["open"] = 0,
		["rep"] = nil,
		["repErr"] = nil,
		["repLoading"] = false,
		["who"] = nil,
		["whoData"] = nil,
		["rows"] = {}
	}
	v19.reports = v_u_26
	v_u_26.ui = require((v3:WaitForChild("AdminUI"):WaitForChild("ReportsPage")))
	v_u_26.REASON = {
		["cheating"] = "Cheating / Exploiting",
		["aimbot"] = "Aimbot / ESP",
		["movement"] = "Fly / Speed / Noclip",
		["chat"] = "Abusive chat",
		["teaming"] = "Teaming / griefing",
		["other"] = "Other",
		["bug"] = "Bug report",
		["clan"] = "Clan impersonation / abuse"
	}
	v_u_26.BUG_COLOR = Color3.fromHex("8E6CD9")
	v_u_26.STATUS = {
		["open"] = { "OPEN", "amber" },
		["reviewing"] = { "REVIEWING", "hover" },
		["closed"] = { "CLOSED", "raised" }
	}
	function v_u_26.build(p27) -- name: build
		-- upvalues: (copy) v_u_26
		v_u_26.pageFrame = p27
		task.spawn(v_u_26.mount)
	end
	function v_u_26.mount() -- name: mount
		-- upvalues: (copy) v_u_26, (copy) v_u_25, (copy) v_u_14, (copy) v_u_4
		if not v_u_26.mounting and v_u_26.pageFrame then
			v_u_26.mounting = true
			local v28 = v_u_25.kit(true)
			if v28 and (not v_u_26.page or (not v_u_26.page.alive() or v_u_26.pageKit ~= v28)) then
				if v_u_26.page then
					v_u_26.page.destroy()
				end
				v_u_26.pageKit = v28
				local v36 = {
					["select"] = function(p29) -- name: select
						-- upvalues: (ref) v_u_26
						v_u_26.select(p29)
					end,
					["filter"] = function(p30) -- name: filter
						-- upvalues: (ref) v_u_26
						if v_u_26.filter == "repeat" ~= (p30 == "repeat") then
							v_u_26.selected = nil
						end
						v_u_26.filter = p30
						v_u_26.who = nil
						v_u_26.whoData = nil
						if p30 == "repeat" then
							task.spawn(v_u_26.loadRepeat)
						end
						v_u_26.renderList()
						v_u_26.renderDetail()
					end,
					["closeAll"] = function() -- name: closeAll
						-- upvalues: (ref) v_u_14, (ref) v_u_26
						task.spawn(function()
							-- upvalues: (ref) v_u_14, (ref) v_u_26
							if v_u_14.act("report_close_all", {}) then
								v_u_26.load()
							end
						end)
					end,
					["action"] = function(p31, p32) -- name: action
						-- upvalues: (ref) v_u_26
						task.spawn(v_u_26.action, p31, p32)
					end,
					["copy"] = function() -- name: copy
						-- upvalues: (ref) v_u_26
						v_u_26.copy()
					end,
					["watch"] = function() -- name: watch
						-- upvalues: (ref) v_u_26, (ref) v_u_4
						local v33 = v_u_26.entry(v_u_26.selected)
						if v33 then
							local v34 = v33.replay
							if type(v34) == "string" then
								v33 = v33.replay
							else
								local v35 = v33.case
								if type(v35) == "string" then
									v33 = v33.case
								else
									v33 = nil
								end
							end
						end
						if v33 then
							task.spawn(v_u_4.open, v33)
						end
					end
				}
				v_u_26.page = v_u_26.ui.mount(v28, v_u_26.pageFrame, v36)
			end
			v_u_26.mounting = false
			if v_u_26.page and v_u_26.page.alive() then
				v_u_26.render()
			end
		end
	end
	function v_u_26.copy() -- name: copy
		-- upvalues: (copy) v_u_26, (copy) v_u_23
		local v37 = v_u_26.entry(v_u_26.selected)
		if v37 then
			local v38 = v37.target
			local v39 = type(v38) == "table" and (v37.target or {}) or {}
			local v40 = v37.reporter
			local v41 = type(v40) == "table" and (v37.reporter or {}) or {}
			local v_u_42 = {}
			local function v55(p43, p44) -- name: add
				-- upvalues: (copy) v_u_42
				if p44.name ~= nil or p44.id ~= nil then
					local v45 = p44.name or "?"
					local v46 = tostring(v45)
					local v47 = p44.id or "?"
					local v48 = tostring(v47)
					local v49 = v_u_42
					local v50 = { p43 .. " name", v46 }
					table.insert(v49, v50)
					local v51 = v_u_42
					local v52 = { p43 .. " ID", v48 }
					table.insert(v51, v52)
					local v53 = v_u_42
					local v54 = { p43, ("%s (%s)"):format(v46, v48) }
					table.insert(v53, v54)
				end
			end
			v55("Reported", v39)
			v55("Reporter", v41)
			if #v_u_42 > 0 then
				v_u_23.open("COPY \194\183 REPORT", v_u_42)
			end
		end
	end
	function v_u_26.action(p56, p57) -- name: action
		-- upvalues: (copy) v_u_26, (copy) v_u_14, (copy) v_u_11, (copy) v_u_16, (copy) v_u_22, (copy) v_u_18, (copy) v_u_21
		local v58 = v_u_26.entry(v_u_26.selected)
		if v58 then
			local v59 = v58.target
			local v60 = type(v59) == "table" and (v58.target or {}) or {}
			if v58.group then
				if p56 == "close" then
					local v61 = v60.id
					if type(v61) == "number" then
						v_u_26.showFor(v60.id)
						return
					end
				end
				if p56 == "claim" or p56 == "close" then
					return
				end
			end
			if p56 == "claim" then
				if v_u_14.act("report_claim", {
					["id"] = v58.id
				}, "Claimed") then
					v_u_26.load()
					return
				end
			elseif p56 == "close" then
				if v58.status == "closed" then
					if v_u_14.act("report_reopen", {
						["id"] = v58.id
					}, "Reopened") then
						v_u_26.load()
						return
					end
				elseif v_u_14.act("report_close", {
					["id"] = v58.id,
					["note"] = v_u_11(p57)
				}, "Closed") then
					if v_u_26.page then
						v_u_26.page.clearNote()
					end
					v_u_26.load()
					return
				end
			elseif p56 == "spectate" then
				local v62 = v60.id
				if type(v62) == "number" then
					v_u_16.toggle(v60.id)
					v_u_26.renderDetail()
					return
				end
			elseif p56 == "goto" then
				local v63 = v58.server
				local v64 = type(v63) == "table" and (v58.server or {}) or {}
				if v58.here ~= true and v_u_22.other(v64) then
					v_u_22.sentAt = os.clock()
					v_u_14.act("staff_travel", {
						["serverId"] = v64.id
					}, "Joining")
					return
				end
				local v65 = v60.id
				if type(v65) == "number" then
					v_u_14.act("goto", {
						["userId"] = v60.id
					}, "Teleported")
					return
				end
			else
				if p56 == "kick" then
					v_u_26.jump("kick", v58)
					return
				end
				if p56 == "ban" then
					if v_u_18.can("ban") then
						v_u_26.jump(v58.here and "ban" or "bans", v58)
						return
					end
					if v_u_21("ban_request") then
						v_u_26.jump("reqban", v58)
					end
				end
			end
		end
	end
	function v_u_26.group(p66) -- name: group
		-- upvalues: (copy) v_u_26
		local v67 = v_u_26.rep
		if type(v67) == "table" then
			local v68 = v67.players
			if type(v68) == "table" then
				for _, v69 in ipairs(v67.players) do
					if type(v69) ~= "table" then
						continue
					end
					local v70 = v69.id
					if "p:" .. tostring(v70) ~= p66 then
						continue
					end
					return v69
				end
				return nil
			end
		end
		return nil
	end
	function v_u_26.reasonsText(p71, p72) -- name: reasonsText
		-- upvalues: (copy) v_u_26
		local v73 = pairs
		local v74 = p71.reasons
		local v75 = {}
		for v76, v77 in v73(type(v74) == "table" and (p71.reasons or {}) or {}) do
			local v78 = {
				["label"] = v_u_26.REASON[v76] or tostring(v76),
				["n"] = tonumber(v77) or 0
			}
			table.insert(v75, v78)
		end
		table.sort(v75, function(p79, p80)
			return p79.n > p80.n
		end)
		local v81 = {}
		for v82, v83 in ipairs(v75) do
			if p72 and v82 > 2 then
				break
			end
			local v84 = v83.label
			local v85 = v83.n
			table.insert(v81, ("%s \195\151%d"):format(v84, v85))
		end
		return table.concat(v81, " \194\183 ")
	end
	function v_u_26.byText(p86) -- name: byText
		local v87 = p86.reporters
		local v88 = tonumber(v87) or 0
		return ("by %d player%s"):format(v88, v88 == 1 and "" or "s")
	end
	function v_u_26.groupEntry(p89) -- name: groupEntry
		-- upvalues: (copy) v_u_26
		local v90 = v_u_26.group(p89)
		if not v90 then
			return nil
		end
		local v91 = pairs
		local v92 = v90.reasons
		local v93 = 0
		local v94 = nil
		for v95, v96 in v91(type(v92) == "table" and (v90.reasons or {}) or {}) do
			if v93 >= (tonumber(v96) or 0) then
				continue
			end
			v93 = tonumber(v96) or 0
			v94 = v95
		end
		local v97 = {
			["id"] = nil,
			["group"] = true,
			["target"] = nil,
			["reason"] = nil,
			["reasonText"] = nil,
			["here"] = nil,
			["server"] = nil,
			["replay"] = nil,
			["status"] = nil,
			["id"] = p89,
			["target"] = {
				["id"] = v90.id,
				["name"] = v90.name
			},
			["reason"] = v94
		}
		local v98 = v90.n
		v97.reasonText = ("Reported %d times: %s"):format(tonumber(v98) or 0, v_u_26.reasonsText(v90, true))
		v97.here = v90.here
		v97.server = v90.server
		v97.replay = v90.replay
		local v99 = v90.open
		local v100 = tonumber(v99) or 0
		local v101 = v90.reviewing
		v97.status = v100 + (tonumber(v101) or 0) > 0 and "open" or "closed"
		return v97
	end
	function v_u_26.showFor(p102) -- name: showFor
		-- upvalues: (copy) v_u_26
		v_u_26.filter = "all"
		v_u_26.who = p102
		v_u_26.whoData = nil
		v_u_26.selected = nil
		v_u_26.renderList()
		v_u_26.renderDetail()
		task.spawn(v_u_26.loadWho)
	end
	function v_u_26.loadWho() -- name: loadWho
		-- upvalues: (copy) v_u_26, (copy) v_u_14
		local v103 = v_u_26.who
		if type(v103) == "number" then
			local v104, v105 = v_u_14.call("report_list", {
				["userId"] = v103
			})
			if v_u_26.who == v103 then
				local v106 = v_u_26
				local v107
				if v104 and type(v105) == "table" then
					local v108 = v105.reports
					v107 = type(v108) ~= "table" and {} or v105.reports
				else
					v107 = {}
				end
				v106.whoData = v107
				v_u_26.render()
			end
		else
			return
		end
	end
	function v_u_26.loadRepeat() -- name: loadRepeat
		-- upvalues: (copy) v_u_26, (copy) v_u_14
		if not v_u_26.repLoading then
			v_u_26.repLoading = true
			local v109, v110 = v_u_14.call("report_repeat")
			v_u_26.repLoading = false
			if v109 and type(v110) == "table" then
				v_u_26.rep = v110
				v_u_26.repErr = nil
			else
				v_u_26.repErr = (type(v110) ~= "string" or v110 == "") and "Couldn\'t load the most reported players" or v110
			end
			if v_u_26.filter == "repeat" then
				v_u_26.render()
			end
		end
	end
	function v_u_26.renderRepeat(p111) -- name: renderRepeat
		-- upvalues: (copy) v_u_26, (copy) v_u_10, (copy) v_u_25, (copy) v_u_8, (copy) v_u_9
		local v112 = v_u_26.rep
		local v113
		if type(v112) == "table" then
			local v114 = v112.players
			v113 = type(v114) ~= "table" and {} or v112.players
		else
			v113 = {}
		end
		local v115, v116, v117, v118, v119, v120, v121, v122, v123, v124, v125, v126, v127, v128, v129, v130, v131, v132, v133, v134, v135, v136, v137
		if type(v112) == "table" then
			local v138 = v112.now
			if type(v138) == "number" then
				v115 = v112.now
				v116 = {}
				for v143, v144 in ipairs(v113) do
					if type(v144) ~= "table" then
						continue
					end
					v117 = v144.id
					if type(v117) ~= "number" then
						continue
					end
					v118 = v144.id
					v119 = "p:" .. tostring(v118)
					v120 = v144.open
					v121 = tonumber(v120) or 0
					v122 = v144.reviewing
					v123 = v121 + (tonumber(v122) or 0)
					v124 = {
						["id"] = nil,
						["name"] = nil,
						["state"] = nil,
						["stateTone"] = nil,
						["bug"] = false,
						["sub"] = nil,
						["selected"] = nil,
						["id"] = v119
					}
					v125 = v144.name or v144.id
					v124.name = tostring(v125)
					v126 = v144.n
					v124.state = ("%d REPORTS"):format(tonumber(v126) or 0)
					v124.stateTone = v123 > 0 and "amber" or "raised"
					v127 = v_u_26.byText(v144)
					v128 = v_u_25.hx("amber", v_u_8(v_u_26.reasonsText(v144, true)))
					v129 = v_u_9
					v130 = v144.last
					v131 = v115 - (tonumber(v130) or v115)
					v124.sub = ("%s \194\183 %s \194\183 last %s ago"):format(v127, v128, v129((math.max(0, v131))))
					v124.selected = v_u_26.selected == v119
					table.insert(v116, v124)
				end
				v132 = p111.renderList
				v133 = {
					["rows"] = nil,
					["empty"] = nil,
					["status"] = nil,
					["filter"] = nil,
					["closeAll"] = false,
					["rows"] = v116,
					["empty"] = v112 == nil and (v_u_26.repErr or "Loading") or "Nobody has been reported more than once"
				}
				v134 = v_u_26.repErr
				if not v134 then
					if v112 == nil then
						v134 = "Loading"
					else
						v135 = v112.total
						if (tonumber(v135) or 0) > #v116 then
							v136 = #v116
							v137 = v112.total
							v134 = ("Top %d of %d reported more than once"):format(v136, tonumber(v137) or 0)
						else
							v134 = ("%d reported more than once"):format(#v116)
						end
					end
				end
				v133.status = v134
				v133.filter = v_u_26.filter
				v132(v133)
			else
				v115 = v_u_10()
				v116 = {}
				for v143, v144 in ipairs(v113) do
					if type(v144) ~= "table" then
						continue
					end
					v117 = v144.id
					if type(v117) ~= "number" then
						continue
					end
					v118 = v144.id
					v119 = "p:" .. tostring(v118)
					v120 = v144.open
					v121 = tonumber(v120) or 0
					v122 = v144.reviewing
					v123 = v121 + (tonumber(v122) or 0)
					v124 = {
						["id"] = nil,
						["name"] = nil,
						["state"] = nil,
						["stateTone"] = nil,
						["bug"] = false,
						["sub"] = nil,
						["selected"] = nil,
						["id"] = v119
					}
					v125 = v144.name or v144.id
					v124.name = tostring(v125)
					v126 = v144.n
					v124.state = ("%d REPORTS"):format(tonumber(v126) or 0)
					v124.stateTone = v123 > 0 and "amber" or "raised"
					v127 = v_u_26.byText(v144)
					v128 = v_u_25.hx("amber", v_u_8(v_u_26.reasonsText(v144, true)))
					v129 = v_u_9
					v130 = v144.last
					v131 = v115 - (tonumber(v130) or v115)
					v124.sub = ("%s \194\183 %s \194\183 last %s ago"):format(v127, v128, v129((math.max(0, v131))))
					v124.selected = v_u_26.selected == v119
					table.insert(v116, v124)
				end
				v132 = p111.renderList
				v133 = {
					["rows"] = nil,
					["empty"] = nil,
					["status"] = nil,
					["filter"] = nil,
					["closeAll"] = false,
					["rows"] = v116,
					["empty"] = v112 == nil and (v_u_26.repErr or "Loading") or "Nobody has been reported more than once"
				}
				v134 = v_u_26.repErr
				if not v134 then
					if v112 == nil then
						v134 = "Loading"
					else
						v135 = v112.total
						if (tonumber(v135) or 0) > #v116 then
							v136 = #v116
							v137 = v112.total
							v134 = ("Top %d of %d reported more than once"):format(v136, tonumber(v137) or 0)
						else
							v134 = ("%d reported more than once"):format(#v116)
						end
					end
				end
				v133.status = v134
				v133.filter = v_u_26.filter
				v132(v133)
			end
		else
			v115 = v_u_10()
			v116 = {}
			for v143, v144 in ipairs(v113) do
				if type(v144) ~= "table" then
					continue
				end
				v117 = v144.id
				if type(v117) ~= "number" then
					continue
				end
				v118 = v144.id
				v119 = "p:" .. tostring(v118)
				v120 = v144.open
				v121 = tonumber(v120) or 0
				v122 = v144.reviewing
				v123 = v121 + (tonumber(v122) or 0)
				v124 = {
					["id"] = nil,
					["name"] = nil,
					["state"] = nil,
					["stateTone"] = nil,
					["bug"] = false,
					["sub"] = nil,
					["selected"] = nil,
					["id"] = v119
				}
				v125 = v144.name or v144.id
				v124.name = tostring(v125)
				v126 = v144.n
				v124.state = ("%d REPORTS"):format(tonumber(v126) or 0)
				v124.stateTone = v123 > 0 and "amber" or "raised"
				v127 = v_u_26.byText(v144)
				v128 = v_u_25.hx("amber", v_u_8(v_u_26.reasonsText(v144, true)))
				v129 = v_u_9
				v130 = v144.last
				v131 = v115 - (tonumber(v130) or v115)
				v124.sub = ("%s \194\183 %s \194\183 last %s ago"):format(v127, v128, v129((math.max(0, v131))))
				v124.selected = v_u_26.selected == v119
				table.insert(v116, v124)
			end
			v132 = p111.renderList
			v133 = {
				["rows"] = nil,
				["empty"] = nil,
				["status"] = nil,
				["filter"] = nil,
				["closeAll"] = false,
				["rows"] = v116,
				["empty"] = v112 == nil and (v_u_26.repErr or "Loading") or "Nobody has been reported more than once"
			}
			v134 = v_u_26.repErr
			if not v134 then
				if v112 == nil then
					v134 = "Loading"
				else
					v135 = v112.total
					if (tonumber(v135) or 0) > #v116 then
						v136 = #v116
						v137 = v112.total
						v134 = ("Top %d of %d reported more than once"):format(v136, tonumber(v137) or 0)
					else
						v134 = ("%d reported more than once"):format(#v116)
					end
				end
			end
			v133.status = v134
			v133.filter = v_u_26.filter
			v132(v133)
			return
		end
	end
	function v_u_26.renderGroup(p145, p146) -- name: renderGroup
		-- upvalues: (copy) v_u_26, (copy) v_u_10, (copy) v_u_2, (copy) v_u_16, (copy) v_u_22, (copy) v_u_18, (copy) v_u_21, (copy) v_u_25, (copy) v_u_8, (copy) v_u_9
		local v147 = v_u_26.group(p146.id)
		local v148 = v_u_26.rep
		local v149
		if type(v148) == "table" then
			local v150 = v148.now
			if type(v150) == "number" then
				v149 = v148.now
			else
				v149 = v_u_10()
			end
		else
			v149 = v_u_10()
		end
		local v151 = p146.target.id
		local v152 = v147.server
		local v153 = type(v152) == "table" and (v147.server or {}) or {}
		local v154
		if v147.here == true then
			v154 = v151 ~= v_u_2.UserId
		else
			v154 = false
		end
		local v155
		if v_u_16.target == nil then
			v155 = false
		else
			v155 = v_u_16.target.UserId == v151
		end
		local v156
		if v147.here == true then
			v156 = false
		else
			v156 = v_u_22.other(v153)
		end
		local v157 = string.gsub
		local v158 = v153.name or ""
		local v159 = v157(tostring(v158), "^Fust Survival%s*", "")
		local v160 = v_u_18.can("ban")
		local v161 = v_u_21("ban_request")
		local v162 = v_u_18.on()
		local v163 = v147.n
		local v164 = tonumber(v163) or 0
		local v165 = v147.open
		local v166 = tonumber(v165) or 0
		local v167 = v147.reviewing
		local v168 = v166 + (tonumber(v167) or 0)
		local v169 = v147.reports
		local v170 = type(v169) ~= "table" and {} or v147.reports
		local v171 = {}
		local v172 = v_u_25.hx("dim", "Reasons")
		local v173 = v_u_8
		local v174 = v_u_26.reasonsText
		table.insert(v171, ("%s  %s"):format(v172, v173(v174(v147, false))))
		local v175 = v_u_25.hx("dim", "First report")
		local v176 = v_u_9
		local v177 = v147.first
		local v178 = v149 - (tonumber(v177) or v149)
		local v179 = math.max(0, v178)
		table.insert(v171, ("%s  %s ago"):format(v175, v176(v179)))
		table.insert(v171, "")
		for _, v180 in ipairs(v170) do
			if type(v180) ~= "table" then
				continue
			end
			local v181 = v_u_26.STATUS[v180.status] or v_u_26.STATUS.open
			local v182 = v180.at
			local v183
			if type(v182) == "number" then
				local v184 = v_u_9
				local v185 = v149 - v180.at
				v183 = v184((math.max(0, v185))) .. " ago"
			else
				v183 = ""
			end
			local v186 = "%s  %s \194\183 by %s \194\183 %s"
			local v187 = v_u_25.hx(v180.status == "closed" and "dim" or "amber", v181[1])
			local v188 = v_u_8
			local v189 = v_u_26.REASON[v180.reason]
			if not v189 then
				local v190 = v180.reason
				v189 = tostring(v190)
			end
			local v191 = v188(v189)
			local v192 = v_u_8
			local v193 = v180.by or "?"
			local v194 = v192((tostring(v193)))
			table.insert(v171, v186:format(v187, v191, v194, v183))
			local v195 = {}
			local v196 = v180.sv
			if type(v196) == "string" then
				local v197 = v_u_8
				local v198 = string.gsub(v180.sv, "^Fust Survival%s*", "")
				table.insert(v195, v197(v198))
			end
			if v180.kill then
				table.insert(v195, "they killed the reporter")
			end
			if #v195 > 0 then
				local v199 = "      " .. v_u_25.hx("dim", table.concat(v195, " \194\183 "))
				table.insert(v171, v199)
			end
			local v200 = v180.text
			if type(v200) ~= "string" or v180.text == "" then
				continue
			end
			local v201 = "      " .. v_u_25.hx("text", "\"" .. v_u_8(v180.text) .. "\"")
			table.insert(v171, v201)
		end
		if #v170 < v164 then
			local v202 = v_u_25.hx
			local v203 = #v170
			table.insert(v171, v202("dim", ("Showing the newest %d of %d"):format(v203, v164)))
		end
		local v204
		if v147.here then
			v204 = v_u_25.hx("good", "on this server")
		else
			v204 = "last reported on " .. v_u_8(v153.name or (v153.id or "another server"))
		end
		local v205 = p145.renderDetail
		local v206 = {
			["name"] = nil,
			["state"] = nil,
			["stateTone"] = nil,
			["sub"] = nil,
			["evidence"] = nil,
			["watch"] = nil,
			["note"] = false,
			["actions"] = nil
		}
		local v207 = v147.name or v151
		v206.name = tostring(v207)
		v206.state = ("%d REPORTS"):format(v164)
		v206.stateTone = v168 > 0 and "amber" or "raised"
		local v208 = v_u_26.byText(v147)
		local v209 = v_u_9
		local v210 = v147.last
		local v211 = v149 - (tonumber(v210) or v149)
		v206.sub = ("%s \194\183 %d still open \194\183 last %s ago \194\183 %s"):format(v208, v168, v209((math.max(0, v211))), v204)
		v206.evidence = table.concat(v171, "\n")
		local v212 = {
			["text"] = "Watch newest replay",
			["visible"] = nil,
			["on"] = nil
		}
		local v213 = v147.replay
		v212.visible = type(v213) == "string"
		v212.on = not v162
		v206.watch = v212
		local v214 = {
			["claim"] = {
				["text"] = "Claim",
				["visible"] = false,
				["on"] = false
			},
			["close"] = {
				["text"] = "See reports",
				["visible"] = true,
				["on"] = true
			}
		}
		local v215 = {
			["text"] = v155 and "Stop" or "Spectate",
			["visible"] = v_u_21("spectate")
		}
		if v154 or v155 then
			v155 = not v162
		end
		v215.on = v155
		v214.spectate = v215
		local v216 = {
			["text"] = v156 and "Join" or "Go to",
			["visible"] = v_u_21("goto") or v156
		}
		local v217
		if v154 or v156 then
			v217 = not v162
		else
			v217 = v156
		end
		v216.on = v217
		local v218
		if v156 then
			v218 = v159 == "" and "Join server?" or ("Join %s?"):format(v159)
		else
			v218 = nil
		end
		v216.confirm = v218
		v214.goto = v216
		local v219 = {
			["text"] = "Kick",
			["visible"] = nil,
			["on"] = nil,
			["visible"] = v_u_21("kick")
		}
		local v220
		if v154 then
			v220 = not v162
		else
			v220 = v154
		end
		v219.on = v220
		v214.kick = v219
		v214.ban = {
			["text"] = v160 and "Ban" or "Ask ban",
			["visible"] = v160 or v161,
			["on"] = v160 or v154
		}
		v206.actions = v214
		v205(v206)
	end
	function v_u_26.entry(p221) -- name: entry
		-- upvalues: (copy) v_u_26
		if type(p221) == "string" and string.sub(p221, 1, 2) == "p:" then
			return v_u_26.groupEntry(p221)
		end
		if type(p221) ~= "string" then
			return nil
		end
		local v222 = {}
		local v223 = v_u_26.whoData
		if type(v223) == "table" then
			local v224 = v_u_26.whoData
			table.insert(v222, v224)
		end
		local v225 = v_u_26.data
		if type(v225) == "table" then
			local v226 = v225.reports
			if type(v226) == "table" then
				local v227 = v225.reports
				table.insert(v222, v227)
			end
		end
		for _, v228 in ipairs(v222) do
			for _, v229 in ipairs(v228) do
				if type(v229) ~= "table" or v229.id ~= p221 then
					continue
				end
				return v229
			end
		end
		return nil
	end
	function v_u_26.jump(p230, p231) -- name: jump
		-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_26, (copy) v_u_20, (copy) v_u_24, (copy) v_u_7
		if (p230 == "ban" or (p230 == "bans" or p230 == "reqban")) and v_u_5.banFrom(p231) then
			return
		elseif p230 == "ban" or (p230 == "reqban" or p230 == "bans") then
			v_u_15.push("The ban sheet isn\'t ready yet, try again in a moment", "bad")
			return
		else
			local v232 = p231.reasonText
			local v233
			if type(v232) == "string" then
				v233 = p231.reasonText
			else
				local v234 = "Report: "
				local v235 = v_u_26.REASON[p231.reason]
				if not v235 then
					local v236 = p231.reason
					v235 = tostring(v236)
				end
				v233 = v234 .. v235
			end
			local v237 = p231.target
			local v238 = type(v237) == "table" and (p231.target or {}) or {}
			v_u_20.selectTab("players")
			v_u_20.loadState()
			v_u_24.select(v238.id)
			if v_u_24.selected == v238.id then
				local v239 = v_u_24.openForm
				local v240 = v_u_7.REASON_MAX
				v239(p230, (string.sub(v233, 1, v240)))
			else
				v_u_15.push((v238.name or "That player") .. " isn\'t on this server any more", "bad")
			end
		end
	end
	v_u_25.jump = v_u_26.jump
	function v_u_26.setOpen(p241) -- name: setOpen
		-- upvalues: (copy) v_u_26, (copy) v_u_13, (copy) v_u_6
		if type(p241) == "number" then
			v_u_26.open = p241
			local v242 = v_u_13.tabButtons
			if v242 then
				v242 = v_u_13.tabButtons.reports
			end
			if v242 then
				v242.badge.Text = p241 <= 0 and "" or tostring(p241)
				v242.badge.TextColor3 = v_u_6.amber
			end
		end
	end
	function v_u_26.renderList() -- name: renderList
		-- upvalues: (copy) v_u_26, (copy) v_u_10, (copy) v_u_9, (copy) v_u_25, (copy) v_u_8, (copy) v_u_21
		local v243 = v_u_26.page
		if not (v243 and v243.alive()) then
			if v_u_26.pageFrame and not v_u_26.mounting then
				task.spawn(v_u_26.mount)
			end
			return
		end
		if v_u_26.filter == "repeat" then
			v_u_26.renderRepeat(v243)
			return
		end
		local v244 = v_u_26.data
		local v245
		if v_u_26.who == nil then
			if type(v244) == "table" then
				local v246 = v244.reports
				v245 = type(v246) ~= "table" and {} or v244.reports
			else
				v245 = {}
			end
		else
			v245 = v_u_26.whoData or {}
		end
		local v247, v248, v249, v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260, v261, v262, v263, v264, v265, v266, v267, v268, v269, v270, v271, v272, v273, v274, v275, v276, v277, v278
		if type(v244) == "table" then
			local v279 = v244.now
			if type(v279) == "number" then
				v247 = v244.now
				v248 = {}
				v249 = 0
				v250 = nil
				for v284, v285 in ipairs(v245) do
					if type(v285) ~= "table" then
						continue
					end
					v251 = v285.id
					if type(v251) ~= "string" then
						continue
					end
					if v285.status == "reviewing" then
						v249 = v249 + 1
					end
					v252 = v285.target
					v253 = type(v252) == "table" and (v285.target or {}) or {}
					if v_u_26.who ~= nil and v253.id == v_u_26.who then
						v254 = v253.name
						if type(v254) == "string" then
							v250 = v253.name
						end
					end
					if v_u_26.filter ~= "all" and v285.status == "closed" or v_u_26.who ~= nil and v253.id ~= v_u_26.who then
						continue
					end
					v255 = v285.reporter
					v256 = type(v255) == "table" and (v285.reporter or {}) or {}
					v257 = v_u_26.STATUS[v285.status] or v_u_26.STATUS.open
					v258 = v285.at
					if type(v258) == "number" then
						v259 = v_u_9
						v260 = v247 - v285.at
						v261 = v259((math.max(0, v260))) .. " ago"
					else
						v261 = ""
					end
					v262 = {
						["id"] = v285.id
					}
					v263 = v253.name or "?"
					v262.name = tostring(v263)
					v262.state = v257[1]
					v262.stateTone = v257[2]
					v262.bug = v285.reason == "bug"
					v264 = "%s \194\183 by %s \194\183 %s"
					v265 = v_u_25.hx
					v266 = "amber"
					v267 = v_u_8
					v268 = v_u_26.REASON[v285.reason]
					if not v268 then
						v269 = v285.reason
						v268 = tostring(v269)
					end
					v262.sub = v264:format(v265(v266, v267(v268)), v_u_8(v256.name or "?"), v261)
					v262.selected = v_u_26.selected == v285.id
					table.insert(v248, v262)
				end
				if type(v244) ~= "table" then
					v270 = v_u_26.open
					if v_u_26.who == nil then
						v271 = nil
					elseif v_u_26.whoData == nil then
						v271 = "Loading their reports"
					else
						v272 = "%d reports about %s"
						v273 = #v248
						if not v250 then
							v274 = v_u_26.who
							v250 = tostring(v274)
						end
						v271 = v272:format(v273, v250)
					end
					v275 = v243.renderList
					v276 = {
						["rows"] = v248
					}
					if v_u_26.who == nil then
						if v244 == nil then
							v277 = v_u_26.loadErr or "Loading"
						else
							v277 = v_u_26.filter == "all" and "No reports yet" or "No open reports"
						end
					else
						v277 = v_u_26.whoData == nil and "Loading" or "No reports about them are kept"
					end
					v276.empty = v277
					v276.status = v271 or (v_u_26.loadErr or ("%d open \194\183 %d being reviewed \194\183 newest first"):format(v270, v249))
					v276.filter = v_u_26.who ~= nil and "who" or v_u_26.filter
					v278 = v_u_21("flags_clear_all")
					if v278 then
						v278 = v270 + v249 > 0
					end
					v276.closeAll = v278
					v275(v276)
					if v244 ~= nil then
						v_u_26.setOpen(v270)
					end
					return
				end
			else
				v247 = v_u_10()
				v248 = {}
				v249 = 0
				v250 = nil
				for v284, v285 in ipairs(v245) do
					if type(v285) ~= "table" then
						continue
					end
					v251 = v285.id
					if type(v251) ~= "string" then
						continue
					end
					if v285.status == "reviewing" then
						v249 = v249 + 1
					end
					v252 = v285.target
					v253 = type(v252) == "table" and (v285.target or {}) or {}
					if v_u_26.who ~= nil and v253.id == v_u_26.who then
						v254 = v253.name
						if type(v254) == "string" then
							v250 = v253.name
						end
					end
					if v_u_26.filter ~= "all" and v285.status == "closed" or v_u_26.who ~= nil and v253.id ~= v_u_26.who then
						continue
					end
					v255 = v285.reporter
					v256 = type(v255) == "table" and (v285.reporter or {}) or {}
					v257 = v_u_26.STATUS[v285.status] or v_u_26.STATUS.open
					v258 = v285.at
					if type(v258) == "number" then
						v259 = v_u_9
						v260 = v247 - v285.at
						v261 = v259((math.max(0, v260))) .. " ago"
					else
						v261 = ""
					end
					v262 = {
						["id"] = v285.id
					}
					v263 = v253.name or "?"
					v262.name = tostring(v263)
					v262.state = v257[1]
					v262.stateTone = v257[2]
					v262.bug = v285.reason == "bug"
					v264 = "%s \194\183 by %s \194\183 %s"
					v265 = v_u_25.hx
					v266 = "amber"
					v267 = v_u_8
					v268 = v_u_26.REASON[v285.reason]
					if not v268 then
						v269 = v285.reason
						v268 = tostring(v269)
					end
					v262.sub = v264:format(v265(v266, v267(v268)), v_u_8(v256.name or "?"), v261)
					v262.selected = v_u_26.selected == v285.id
					table.insert(v248, v262)
				end
				if type(v244) ~= "table" then
					v270 = v_u_26.open
					if v_u_26.who == nil then
						v271 = nil
					elseif v_u_26.whoData == nil then
						v271 = "Loading their reports"
					else
						v272 = "%d reports about %s"
						v273 = #v248
						if not v250 then
							v274 = v_u_26.who
							v250 = tostring(v274)
						end
						v271 = v272:format(v273, v250)
					end
					v275 = v243.renderList
					v276 = {
						["rows"] = v248
					}
					if v_u_26.who == nil then
						if v244 == nil then
							v277 = v_u_26.loadErr or "Loading"
						else
							v277 = v_u_26.filter == "all" and "No reports yet" or "No open reports"
						end
					else
						v277 = v_u_26.whoData == nil and "Loading" or "No reports about them are kept"
					end
					v276.empty = v277
					v276.status = v271 or (v_u_26.loadErr or ("%d open \194\183 %d being reviewed \194\183 newest first"):format(v270, v249))
					v276.filter = v_u_26.who ~= nil and "who" or v_u_26.filter
					v278 = v_u_21("flags_clear_all")
					if v278 then
						v278 = v270 + v249 > 0
					end
					v276.closeAll = v278
					v275(v276)
					if v244 ~= nil then
						v_u_26.setOpen(v270)
					end
					return
				end
			end
		else
			v247 = v_u_10()
			v248 = {}
			v249 = 0
			v250 = nil
			for v284, v285 in ipairs(v245) do
				if type(v285) ~= "table" then
					continue
				end
				v251 = v285.id
				if type(v251) ~= "string" then
					continue
				end
				if v285.status == "reviewing" then
					v249 = v249 + 1
				end
				v252 = v285.target
				v253 = type(v252) == "table" and (v285.target or {}) or {}
				if v_u_26.who ~= nil and v253.id == v_u_26.who then
					v254 = v253.name
					if type(v254) == "string" then
						v250 = v253.name
					end
				end
				if v_u_26.filter ~= "all" and v285.status == "closed" or v_u_26.who ~= nil and v253.id ~= v_u_26.who then
					continue
				end
				v255 = v285.reporter
				v256 = type(v255) == "table" and (v285.reporter or {}) or {}
				v257 = v_u_26.STATUS[v285.status] or v_u_26.STATUS.open
				v258 = v285.at
				if type(v258) == "number" then
					v259 = v_u_9
					v260 = v247 - v285.at
					v261 = v259((math.max(0, v260))) .. " ago"
				else
					v261 = ""
				end
				v262 = {
					["id"] = v285.id
				}
				v263 = v253.name or "?"
				v262.name = tostring(v263)
				v262.state = v257[1]
				v262.stateTone = v257[2]
				v262.bug = v285.reason == "bug"
				v264 = "%s \194\183 by %s \194\183 %s"
				v265 = v_u_25.hx
				v266 = "amber"
				v267 = v_u_8
				v268 = v_u_26.REASON[v285.reason]
				if not v268 then
					v269 = v285.reason
					v268 = tostring(v269)
				end
				v262.sub = v264:format(v265(v266, v267(v268)), v_u_8(v256.name or "?"), v261)
				v262.selected = v_u_26.selected == v285.id
				table.insert(v248, v262)
			end
			if type(v244) ~= "table" then
				v270 = v_u_26.open
				if v_u_26.who == nil then
					v271 = nil
				elseif v_u_26.whoData == nil then
					v271 = "Loading their reports"
				else
					v272 = "%d reports about %s"
					v273 = #v248
					if not v250 then
						v274 = v_u_26.who
						v250 = tostring(v274)
					end
					v271 = v272:format(v273, v250)
				end
				v275 = v243.renderList
				v276 = {
					["rows"] = v248
				}
				if v_u_26.who == nil then
					if v244 == nil then
						v277 = v_u_26.loadErr or "Loading"
					else
						v277 = v_u_26.filter == "all" and "No reports yet" or "No open reports"
					end
				else
					v277 = v_u_26.whoData == nil and "Loading" or "No reports about them are kept"
				end
				v276.empty = v277
				v276.status = v271 or (v_u_26.loadErr or ("%d open \194\183 %d being reviewed \194\183 newest first"):format(v270, v249))
				v276.filter = v_u_26.who ~= nil and "who" or v_u_26.filter
				v278 = v_u_21("flags_clear_all")
				if v278 then
					v278 = v270 + v249 > 0
				end
				v276.closeAll = v278
				v275(v276)
				if v244 ~= nil then
					v_u_26.setOpen(v270)
				end
				return
			end
		end
		local v286 = v244.open
		if type(v286) == "number" then
			v270 = v244.open
			if v_u_26.who == nil then
				v271 = nil
			elseif v_u_26.whoData == nil then
				v271 = "Loading their reports"
			else
				v272 = "%d reports about %s"
				v273 = #v248
				if not v250 then
					v274 = v_u_26.who
					v250 = tostring(v274)
				end
				v271 = v272:format(v273, v250)
			end
			v275 = v243.renderList
			v276 = {
				["rows"] = v248
			}
			if v_u_26.who == nil then
				if v244 == nil then
					v277 = v_u_26.loadErr or "Loading"
				else
					v277 = v_u_26.filter == "all" and "No reports yet" or "No open reports"
				end
			else
				v277 = v_u_26.whoData == nil and "Loading" or "No reports about them are kept"
			end
			v276.empty = v277
			v276.status = v271 or (v_u_26.loadErr or ("%d open \194\183 %d being reviewed \194\183 newest first"):format(v270, v249))
			v276.filter = v_u_26.who ~= nil and "who" or v_u_26.filter
			v278 = v_u_21("flags_clear_all")
			if v278 then
				v278 = v270 + v249 > 0
			end
			v276.closeAll = v278
			v275(v276)
			if v244 ~= nil then
				v_u_26.setOpen(v270)
			end
		else
			v270 = v_u_26.open
			if v_u_26.who == nil then
				v271 = nil
			elseif v_u_26.whoData == nil then
				v271 = "Loading their reports"
			else
				v272 = "%d reports about %s"
				v273 = #v248
				if not v250 then
					v274 = v_u_26.who
					v250 = tostring(v274)
				end
				v271 = v272:format(v273, v250)
			end
			v275 = v243.renderList
			v276 = {
				["rows"] = v248
			}
			if v_u_26.who == nil then
				if v244 == nil then
					v277 = v_u_26.loadErr or "Loading"
				else
					v277 = v_u_26.filter == "all" and "No reports yet" or "No open reports"
				end
			else
				v277 = v_u_26.whoData == nil and "Loading" or "No reports about them are kept"
			end
			v276.empty = v277
			v276.status = v271 or (v_u_26.loadErr or ("%d open \194\183 %d being reviewed \194\183 newest first"):format(v270, v249))
			v276.filter = v_u_26.who ~= nil and "who" or v_u_26.filter
			v278 = v_u_21("flags_clear_all")
			if v278 then
				v278 = v270 + v249 > 0
			end
			v276.closeAll = v278
			v275(v276)
			if v244 ~= nil then
				v_u_26.setOpen(v270)
			end
		end
	end
	function v_u_26.select(p287) -- name: select
		-- upvalues: (copy) v_u_26, (copy) v_u_5
		local v288 = v_u_26.entry(p287)
		if v288 then
			local v289 = v288.target
			if type(v289) == "table" then
				v_u_5.pick(v288.target.id, "reports", v288.target.name)
			end
		end
		v_u_26.selected = p287
		if v_u_26.page then
			v_u_26.page.clearNote()
		end
		v_u_26.renderList()
		v_u_26.renderDetail()
	end
	function v_u_26.evidence(p290) -- name: evidence
		-- upvalues: (copy) v_u_25, (copy) v_u_8, (copy) v_u_9, (copy) v_u_17
		local v291 = {}
		local v292 = p290.text
		if type(v292) == "string" and p290.text ~= "" then
			local v293 = v_u_25.hx
			local v294 = "\"" .. v_u_8(p290.text) .. "\""
			table.insert(v291, v293("text", v294))
		else
			local v295 = v_u_25.hx
			table.insert(v291, v295("dim", "No details written"))
		end
		if p290.reason == "bug" then
			local v296 = p290.tod
			if type(v296) == "number" then
				local v297 = p290.tod * 60 + 0.5
				local v298 = math.floor(v297)
				local v299 = ("%02d:%02d in game"):format(v298 // 60 % 24, v298 % 60)
				local v300 = v_u_25.hx("dim", "Time of day")
				table.insert(v291, ("%s  %s"):format(v300, v299))
			end
			local v301 = p290.server
			local v302 = type(v301) == "table" and (p290.server or {}) or {}
			local v303 = v_u_8
			local v304 = v302.name or (v302.id or "?")
			local v305 = v303((tostring(v304)))
			local v306 = v302.job
			local v307 = v305 .. (type(v306) ~= "string" and "" or " \194\183 job " .. v_u_8(v302.job))
			local v308 = v_u_25.hx("dim", "Server")
			table.insert(v291, ("%s  %s"):format(v308, v307))
			local v309 = p290.chat
			if type(v309) == "table" and #p290.chat > 0 then
				local v310 = v_u_25.hx("dim", "Last chat")
				table.insert(v291, ("%s  %s"):format(v310, ""))
				for _, v311 in ipairs(p290.chat) do
					local v312 = "   " .. v_u_8((tostring(v311)))
					table.insert(v291, v312)
				end
			end
		end
		local v313 = p290.kill
		if type(v313) == "table" then
			local v314 = p290.kill
			local v315 = {}
			local v316 = v314.weapon
			if type(v316) == "string" and v314.weapon ~= "" then
				local v317 = v_u_8
				local v318 = v314.weapon
				table.insert(v315, v317(v318))
			end
			local v319 = v314.dist
			if type(v319) == "number" then
				local v320 = v314.dist .. " m"
				table.insert(v315, v320)
			end
			if v314.head then
				local v321 = v_u_25.hx
				table.insert(v315, v321("badText", "headshot"))
			end
			local v322 = v314.ago
			if type(v322) == "number" then
				local v323 = v_u_9(v314.ago) .. " before the report"
				table.insert(v315, v323)
			end
			local v324 = #v315 <= 0 and "yes" or table.concat(v315, " \194\183 ")
			local v325 = v_u_25.hx("dim", "Killed the reporter")
			table.insert(v291, ("%s  %s"):format(v325, v324))
		elseif p290.ctx == "player" and p290.reason ~= "bug" then
			local v326 = v_u_25.hx("dim", "Context")
			table.insert(v291, ("%s  %s"):format(v326, "reported from the player list or chat"))
		end
		local v327 = p290.case
		if type(v327) == "string" then
			local v328 = v_u_8(v_u_17.caseText(p290))
			local v329 = v_u_25.hx("dim", "Team case")
			table.insert(v291, ("%s  %s"):format(v329, v328))
		end
		local v330 = p290.replay
		if type(v330) == "string" then
			local v331 = p290.replaySt
			local v332 = type(v331) ~= "string" and "" or p290.replaySt
			local v333 = string.match(v332, "^%a+:(.+)$")
			local v334 = string.match(v332, "^(%a+)") or ""
			local v335 = v334 == "saved" and "saved" or ((v334 == "saving" or v334 == "queued") and "saving" or (v334 ~= "skipped" and v334 ~= "failed" and "made on another server" or "not saved: " .. tostring(v333 or "unknown reason")))
			local v336 = v_u_8(p290.replay .. " \194\183 " .. v335)
			local v337 = v_u_25.hx("dim", "Replay")
			table.insert(v291, ("%s  %s"):format(v337, v336))
		end
		local v338 = p290.clan
		if type(v338) == "table" then
			local v339 = p290.clan
			local v340 = v_u_8
			local v341 = v339.name or "?"
			local v342 = v340((tostring(v341)))
			local v343 = v339.tag
			local v344 = v342 .. (type(v343) ~= "string" and "" or " [" .. v_u_8(v339.tag) .. "]") .. (not v339.official and "" or " \194\183 " .. v_u_25.hx("text", "official clan"))
			local v345 = v_u_25.hx("dim", "Clan")
			table.insert(v291, ("%s  %s"):format(v345, v344))
			local v346 = v_u_8
			local v347 = v339.label or (v339.kind or "?")
			local v348 = v346((tostring(v347)))
			local v349 = v_u_8
			local v350 = string.lower
			local v351 = v339.role or "member"
			local v352 = v348 .. " \194\183 sent by a clan " .. v349(v350((tostring(v351))))
			local v353 = v_u_25.hx("dim", "Case")
			table.insert(v291, ("%s  %s"):format(v353, v352))
			local v354 = v339.banned and "this clan has blacklisted them" or "not blacklisted"
			local v355 = v_u_25.hx("dim", "Clan blacklist")
			table.insert(v291, ("%s  %s"):format(v355, v354))
			local v356 = v_u_25.hx
			table.insert(v291, v356("dim", "The clan blacklist is the clan\'s own decision. Any game punishment is yours to decide."))
		end
		local v357 = p290.ac
		if type(v357) == "table" then
			local v358 = p290.ac
			local v359 = v358.score
			local v360 = tonumber(v359) or 0
			local v361
			if v358.high then
				v361 = v_u_25.hx("badText", tostring(v360) .. ", high")
			else
				v361 = tostring(v360)
			end
			local v362 = v358.kinds
			local v365 = v361 .. ((type(v362) ~= "string" or v358.kinds == "") and "" or " \194\183 " .. v_u_8((string.gsub(v358.kinds, "([%a_]+) (%d+)", function(p363, p364)
				-- upvalues: (ref) v_u_25
				return v_u_25.label(p363) .. " \195\151" .. p364
			end))))
			local v366 = v_u_25.hx("dim", "Anti-cheat")
			table.insert(v291, ("%s  %s"):format(v366, v365))
			local v367 = v358.flags
			if type(v367) == "table" then
				for _, v368 in ipairs(v358.flags) do
					if type(v368) ~= "table" then
						continue
					end
					local v369 = v_u_8
					local v370 = v_u_25.label
					local v371 = v368.k or "?"
					local v372 = v369(v370((tostring(v371))))
					local v373 = v_u_8
					local v374 = v368.d or ""
					local v375 = v373((tostring(v374)))
					local v376 = v368.ago
					local v377 = type(v376) ~= "number" and "" or " " .. v_u_25.hx("dim", "(" .. v_u_9(v368.ago) .. " before)")
					table.insert(v291, ("   %s %s%s"):format(v372, v375, v377))
				end
			end
		end
		local v378 = p290.kd
		if type(v378) == "table" then
			local v379 = p290.kd.k
			local v380 = tonumber(v379) or 0
			local v381 = p290.kd.d
			local v382 = ("%d / %d this session"):format(v380, tonumber(v381) or 0)
			local v383 = v_u_25.hx("dim", "Kills and deaths here")
			table.insert(v291, ("%s  %s"):format(v383, v382))
		end
		local v384 = p290.age
		if type(v384) == "number" then
			local v385 = ("%d days old"):format(p290.age)
			local v386 = v_u_25.hx("dim", "Account")
			table.insert(v291, ("%s  %s"):format(v386, v385))
		end
		local v387 = p290.tpos
		local v388
		if type(v387) == "table" then
			local v389 = v387[1]
			if type(v389) == "number" then
				local v390 = v387[1]
				local v391 = v387[2]
				local v392 = tonumber(v391) or 0
				local v393 = v387[3]
				v388 = ("%d, %d, %d"):format(v390, v392, tonumber(v393) or 0)
			else
				v388 = nil
			end
		else
			v388 = nil
		end
		local v394 = p290.rpos
		local v395
		if type(v394) == "table" then
			local v396 = v394[1]
			if type(v396) == "number" then
				local v397 = v394[1]
				local v398 = v394[2]
				local v399 = tonumber(v398) or 0
				local v400 = v394[3]
				v395 = ("%d, %d, %d"):format(v397, v399, tonumber(v400) or 0)
			else
				v395 = nil
			end
		else
			v395 = nil
		end
		if v388 or v395 then
			local v401 = (not v388 and "" or "reported " .. v388) .. (v388 and v395 and " \194\183 " or "") .. (not v395 and "" or "reporter " .. v395)
			local v402 = v_u_25.hx("dim", "Positions")
			table.insert(v291, ("%s  %s"):format(v402, v401))
		end
		if p290.status == "reviewing" and p290.claimedByName then
			local v403 = "by " .. v_u_8(p290.claimedByName)
			local v404 = v_u_25.hx("dim", "Claimed")
			table.insert(v291, ("%s  %s"):format(v404, v403))
		elseif p290.status == "closed" then
			local v405 = v_u_8(p290.closedByName or "?")
			local v406 = p290.note
			local v407 = "by " .. v405 .. ((type(v406) ~= "string" or p290.note == "") and "" or ": " .. v_u_8(p290.note))
			local v408 = v_u_25.hx("dim", "Closed")
			table.insert(v291, ("%s  %s"):format(v408, v407))
		end
		if p290.stub then
			local v409 = v_u_25.hx
			table.insert(v291, v409("dim", "The evidence is still coming from the other server. It shows up in a few seconds."))
		end
		return table.concat(v291, "\n")
	end
	function v_u_26.renderDetail() -- name: renderDetail
		-- upvalues: (copy) v_u_26, (copy) v_u_10, (copy) v_u_2, (copy) v_u_16, (copy) v_u_22, (copy) v_u_18, (copy) v_u_21, (copy) v_u_9, (copy) v_u_25, (copy) v_u_8
		local v410 = v_u_26.page
		if not (v410 and v410.alive()) then
			return
		end
		local v411 = v_u_26.entry(v_u_26.selected)
		if v411 and v411.group then
			v_u_26.renderGroup(v410, v411)
			return
		end
		if not v411 then
			local v412 = v_u_26.filter == "repeat" and "Pick a player on the left" or "Pick a report on the left"
			if v_u_26.selected and v_u_26.data then
				v_u_26.selected = nil
				v412 = "That report is gone"
			end
			v410.renderDetail({
				["none"] = nil,
				["name"] = "",
				["state"] = "",
				["stateTone"] = "raised",
				["sub"] = "",
				["evidence"] = "",
				["watch"] = nil,
				["note"] = false,
				["actions"] = nil,
				["none"] = v412,
				["watch"] = {
					["text"] = "",
					["on"] = false,
					["visible"] = false
				},
				["actions"] = {}
			})
			return
		end
		local v413 = v_u_26.data
		local v414
		if type(v413) == "table" then
			local v415 = v413.now
			if type(v415) == "number" then
				v414 = v413.now
			else
				v414 = v_u_10()
			end
		else
			v414 = v_u_10()
		end
		local v416 = v411.target
		local v417 = type(v416) == "table" and (v411.target or {}) or {}
		local v418 = v411.reporter
		local v419 = type(v418) == "table" and (v411.reporter or {}) or {}
		local v420 = v_u_26.STATUS[v411.status] or v_u_26.STATUS.open
		local v421 = v411.server
		local v422 = type(v421) == "table" and (v411.server or {}) or {}
		local v423 = v411.status == "closed"
		local v424
		if v411.status == "reviewing" then
			v424 = v411.claimedBy == v_u_2.UserId
		else
			v424 = false
		end
		local v425
		if v411.here == true then
			v425 = v417.id ~= v_u_2.UserId
		else
			v425 = false
		end
		local v426
		if v_u_16.target == nil then
			v426 = false
		else
			v426 = v_u_16.target.UserId == v417.id
		end
		local v427
		if v411.here == true then
			v427 = false
		else
			v427 = v_u_22.other(v422)
		end
		local v428 = string.gsub
		local v429 = v422.name or ""
		local v430 = v428(tostring(v429), "^Fust Survival%s*", "")
		local v431 = v411.reason == "bug"
		local v432 = v_u_18.can("ban")
		local v433 = v_u_21("ban_request")
		local v434 = v_u_18.on()
		local v435 = v411.replaySt
		local v436 = type(v435) ~= "string" and "" or v411.replaySt
		local v437 = v411.replay
		local v438
		if type(v437) == "string" then
			v438 = (v436 == "" or string.sub(v436, 1, 5) == "saved") and true or string.sub(v436, 1, 6) == "queued"
		else
			v438 = false
		end
		local v439 = v411.at
		local v440
		if type(v439) == "number" then
			local v441 = v_u_9
			local v442 = v414 - v411.at
			v440 = v441((math.max(0, v442))) .. " ago"
		else
			v440 = ""
		end
		local v443
		if v411.here then
			v443 = v_u_25.hx("good", "on this server")
		else
			v443 = v_u_8(v422.name or (v422.id or "another server"))
		end
		local v444 = v410.renderDetail
		local v445 = {}
		local v446 = v417.name or "?"
		v445.name = (v431 and "Bug: " or "") .. tostring(v446)
		v445.state = v420[1]
		v445.stateTone = v420[2]
		local v447 = "%s \194\183 %s \194\183 by %s \194\183 %s"
		local v448 = v_u_25.hx
		local v449 = "amber"
		local v450 = v_u_8
		local v451 = v_u_26.REASON[v411.reason]
		if not v451 then
			local v452 = v411.reason
			v451 = tostring(v452)
		end
		v445.sub = v447:format(v448(v449, v450(v451)), v440, v_u_8(v419.name or "?"), v443)
		v445.evidence = v_u_26.evidence(v411)
		local v453 = {
			["text"] = v438 and "Watch replay" or "Watch old case"
		}
		if not v438 then
			local v454 = v411.case
			v438 = type(v454) == "string"
		end
		v453.visible = v438
		v453.on = not v434
		v445.watch = v453
		v445.note = not v423
		local v455 = {}
		local v456 = {
			["text"] = nil,
			["visible"] = true,
			["on"] = nil,
			["text"] = v424 and "Yours" or "Claim"
		}
		local v457 = not v423
		if v457 then
			v457 = not v424
		end
		v456.on = v457
		v455.claim = v456
		v455.close = {
			["text"] = nil,
			["visible"] = true,
			["on"] = true,
			["text"] = v423 and "Reopen" or "Close"
		}
		local v458 = {
			["text"] = v426 and "Stop" or "Spectate",
			["visible"] = v_u_21("spectate")
		}
		if v425 or v426 then
			v426 = not v434
		end
		v458.on = v426
		v455.spectate = v458
		local v459 = {
			["text"] = v427 and "Join" or "Go to",
			["visible"] = v_u_21("goto") or v427
		}
		local v460
		if v425 or v427 then
			v460 = not v434
		else
			v460 = v427
		end
		v459.on = v460
		local v461
		if v427 then
			v461 = v430 == "" and "Join server?" or ("Join %s?"):format(v430)
		else
			v461 = nil
		end
		v459.confirm = v461
		v455.goto = v459
		local v462 = {
			["text"] = "Kick",
			["visible"] = nil,
			["on"] = nil
		}
		local v463 = v_u_21("kick")
		if v463 then
			v463 = not v431
		end
		v462.visible = v463
		local v464
		if v425 then
			v464 = not v434
		else
			v464 = v425
		end
		v462.on = v464
		v455.kick = v462
		local v465 = {
			["text"] = v432 and "Ban" or "Ask ban"
		}
		if v432 or v433 then
			v433 = not v431
		end
		v465.visible = v433
		v465.on = v432 or v425
		v455.ban = v465
		v445.actions = v455
		v444(v445)
	end
	function v_u_26.render() -- name: render
		-- upvalues: (copy) v_u_26
		v_u_26.renderList()
		v_u_26.renderDetail()
	end
	function v_u_26.load() -- name: load
		-- upvalues: (copy) v_u_26, (copy) v_u_14, (copy) v_u_5, (copy) v_u_12
		if v_u_26.loading then
			v_u_26.again = true
		else
			v_u_26.loading = true
			while true do
				v_u_26.again = false
			local v466, v467 = v_u_14.call("report_list")
			if v466 and type(v467) == "table" then
				v_u_26.data = v467
				v_u_26.loadErr = nil
				v_u_26.render()
				if v_u_26.filter == "repeat" then
					task.spawn(v_u_26.loadRepeat)
				elseif v_u_26.who ~= nil then
					task.spawn(v_u_26.loadWho)
				end
				v_u_5.applyReport()
				if v_u_12.tab == "reports" then
					v_u_5.apply("reports")
				end
			elseif not v466 then
				v_u_26.loadErr = type(v467) ~= "string" and "Couldn\'t load the reports" or v467
				v_u_26.renderList()
			end
				if not (v_u_26.again and v_u_12.open) then
					break
				end
			end
			v_u_26.loading = false
		end
	end
	function v_u_26.count() -- name: count
		-- upvalues: (copy) v_u_14, (copy) v_u_26
		local v468, v469 = v_u_14.call("report_count")
		if v468 and type(v469) == "table" then
			v_u_26.setOpen(v469.open)
		end
	end
	function v_u_17.caseText(p470) -- name: caseText
		local v471 = p470.cs
		local v472 = type(v471) == "table" and p470.cs or nil
		if not v472 then
			return "saved, use Watch old case above"
		end
		local v473 = v472.r
		local v474 = tonumber(v473) or 0
		local v475 = v472.tm
		local v476 = tonumber(v475) or 0
		local v477 = v472.m
		local v478 = tonumber(v477) or 0
		local v479 = v474 == 1 and "" or "s"
		local v480 = v476 == 1 and "" or "s"
		local v481 = v472.tr
		return ("reported by %d player%s from %d team%s \194\183 team of %d%s \194\183 reports alone never punish"):format(v474, v479, v476, v480, v478, (tonumber(v481) or 0) <= 0 and "" or (" \194\183 %d players recorded"):format(v472.tr))
	end
	p1.RP = v_u_26
end
