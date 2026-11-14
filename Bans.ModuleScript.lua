--!native
-- Path: Bans.ModuleScript.lua
-- Status: 100% Deobfuscated & Cleaned Authentic Source

return function(p1)
	local v_u_2 = p1.playerGui
	local v3 = p1.FustShared
	local v_u_4 = p1.Sheets
	local v_u_5 = p1.RVH
	local v_u_6 = p1.SB
	local v_u_7 = p1.C
	local v_u_8 = p1.K
	local v_u_9 = p1.escape
	local v_u_10 = p1.formatSpan
	local v_u_11 = p1.formatDate
	local v_u_12 = p1.serverNow
	local v_u_13 = p1.trim
	local v_u_14 = p1.S
	local v_u_15 = p1.U
	local v_u_16 = p1.Net
	local v_u_17 = p1.Toast
	local v18 = p1.Pages
	local v_u_19 = p1.Admin
	local v_u_20 = p1.L237
	local v_u_21 = p1.can
	local v_u_22 = p1.stateRow
	local v_u_23 = p1.PP
	local v_u_24 = {
		["view"] = "bans",
		["status"] = "active",
		["q"] = "",
		["rows"] = nil,
		["reqs"] = nil,
		["pending"] = 0,
		["info"] = nil,
		["loading"] = false,
		["again"] = false,
		["rows"] = {},
		["reqs"] = {},
		["info"] = {}
	}
	v18.bans = v_u_24
	v_u_24.ui = require((v3:WaitForChild("AdminUI"):WaitForChild("BansPage")))
	v_u_24.TONE_HEX = {
		["amber"] = "D9A441",
		["text"] = "ECE6DA",
		["muted"] = "A3A79F",
		["good"] = "6FA35A",
		["badText"] = "E0745A"
	}
	v_u_24.STATE = {
		["perm"] = { "PERM", "bad" },
		["timed"] = { "TIMED", "amber" },
		["expired"] = { "ENDED", "hover" },
		["lifted"] = { "LIFTED", "hover" },
		["pending"] = { "WAITING", "amber" },
		["approved"] = { "BANNED", "bad" },
		["denied"] = { "DENIED", "hover" }
	}
	v_u_24.KIND = {
		["staff"] = "Staff ban",
		["auto"] = "Automatic ban by the anti-cheat",
		["wave"] = "Ban wave"
	}
	v_u_24.EMPTY = {
		["active"] = "Nobody is banned right now",
		["perm"] = "No permanent bans",
		["timed"] = "No timed bans running",
		["ended"] = "No bans ended in the last 60 days",
		["all"] = "The ban list is empty"
	}
	function v_u_24.hx(p25, p26) -- name: hx
		-- upvalues: (copy) v_u_24
		return ("<font color=\"#%s\">%s</font>"):format(v_u_24.TONE_HEX[p25] or v_u_24.TONE_HEX.muted, p26)
	end
	function v_u_24.build(p27) -- name: build
		-- upvalues: (copy) v_u_24
		v_u_24.pageFrame = p27
		task.spawn(v_u_24.mount)
	end
	function v_u_24.mount() -- name: mount
		-- upvalues: (copy) v_u_24, (copy) v_u_2, (copy) v_u_21, (copy) v_u_13, (copy) v_u_5, (copy) v_u_14
		if not v_u_24.mounting and v_u_24.pageFrame then
			v_u_24.mounting = true
			local v28 = v_u_2:WaitForChild("FustAdminKit", 30)
			if not (v28 and v28:IsA("ScreenGui")) then
				v28 = nil
			end
			if v28 and (not v_u_24.page or (not v_u_24.page.alive() or v_u_24.pageKit ~= v28)) then
				if v_u_24.page then
					v_u_24.page.destroy()
				end
				v_u_24.pageKit = v28
				v_u_24.page = v_u_24.ui.mount(v28, v_u_24.pageFrame, {
					["view"] = function(p29) -- name: view
						-- upvalues: (ref) v_u_21, (ref) v_u_24
						local v30 = p29 == "requests" and v_u_21("ban") and "requests" or "bans"
						if v30 ~= v_u_24.view then
							v_u_24.view = v30
							v_u_24.selected = nil
							v_u_24.render()
							if v30 == "requests" then
								task.spawn(v_u_24.loadRequests)
							end
						end
					end,
					["filter"] = function(p31) -- name: filter
						-- upvalues: (ref) v_u_24
						if v_u_24.status ~= p31 then
							v_u_24.status = p31
							v_u_24.selected = nil
							task.spawn(v_u_24.load)
						end
					end,
					["search"] = function(p32) -- name: search
						-- upvalues: (ref) v_u_13, (ref) v_u_24
						local v33 = v_u_13(p32)
						if v33 ~= v_u_24.q then
							v_u_24.q = v33
							task.spawn(v_u_24.load)
						end
					end,
					["find"] = function(p34) -- name: find
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.find, p34)
					end,
					["more"] = function() -- name: more
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.more)
					end,
					["select"] = function(p35) -- name: select
						-- upvalues: (ref) v_u_24
						v_u_24.select(p35)
					end,
					["action"] = function(p36) -- name: action
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.action, p36)
					end,
					["copy"] = function() -- name: copy
						-- upvalues: (ref) v_u_24
						v_u_24.copy()
					end,
					["watch"] = function() -- name: watch
						-- upvalues: (ref) v_u_24, (ref) v_u_5
						local v37 = v_u_24.info[v_u_24.selected]
						if type(v37) == "table" then
							local v38 = v37.replay
							if type(v38) == "string" then
								task.spawn(v_u_5.open, v37.replay)
							end
						end
					end,
					["undo"] = v_u_14.role == "owner" and function()
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.undo)
					end or nil,
					["mass"] = function() -- name: mass
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.massOpen)
					end
				})
			end
			v_u_24.mounting = false
			if v_u_24.page and v_u_24.page.alive() then
				v_u_24.page.setSearch(v_u_24.q)
				v_u_24.render()
			end
		end
	end
	v_u_24.UNDO_CHOICES = {
		{
			["id"] = "1",
			["label"] = "1 HOUR",
			["hours"] = 1
		},
		{
			["id"] = "6",
			["label"] = "6 HOURS",
			["hours"] = 6
		},
		{
			["id"] = "24",
			["label"] = "1 DAY",
			["hours"] = 24
		},
		{
			["id"] = "72",
			["label"] = "3 DAYS",
			["hours"] = 72
		},
		{
			["id"] = "168",
			["label"] = "7 DAYS",
			["hours"] = 168
		},
		{
			["id"] = "dev",
			["label"] = "DEVICES",
			["hours"] = 0
		}
	}
	function v_u_24.undo() -- name: undo
		-- upvalues: (copy) v_u_24, (copy) v_u_4, (copy) v_u_16, (copy) v_u_17, (copy) v_u_10
		local v_u_39 = v_u_24.pageKit
		if v_u_39 then
			v_u_4.ban(v_u_39, {
				["title"] = "Undo anti-cheat bans",
				["sub"] = "Lifts automatic anti-cheat bans from the time you pick (staff bans stay)",
				["choices"] = nil,
				["pick"] = "24",
				["reason"] = "False bans",
				["chips"] = nil,
				["tapes"] = nil,
				["nextText"] = "Show how many",
				["onNext"] = nil,
				["choices"] = v_u_24.UNDO_CHOICES,
				["chips"] = {},
				["tapes"] = {
					["length"] = "HOW FAR BACK",
					["reason"] = "NOTE FOR THE STAFF LOG",
					["proof"] = false,
					["reasonWarn"] = "Write a short note for the staff log first."
				},
				["onNext"] = function(p40, p41) -- name: onNext
					-- upvalues: (ref) v_u_24, (copy) v_u_39, (ref) v_u_16, (ref) v_u_17, (ref) v_u_10, (ref) v_u_4
					if p40 == 0 then
						v_u_24.unblock(v_u_39, p41)
						return
					else
						local v42, v43 = v_u_16.call("ac_undo", {
							["hours"] = p40
						})
						if v42 and type(v43) == "table" then
							local v44 = v43.bans
							local v45 = tonumber(v44) or 0
							local v46 = v43.queued
							local v47 = tonumber(v46) or 0
							if v45 + v47 == 0 then
								v_u_17.push("No anti-cheat bans in that time", "warn")
							else
								local v48 = "the last " .. v_u_10(p40 * 3600)
								v_u_4.ban(v_u_39, {
									["title"] = nil,
									["sub"] = nil,
									["choices"] = nil,
									["pick"] = "go",
									["reason"] = nil,
									["chips"] = nil,
									["tapes"] = nil,
									["nextText"] = "Lift them",
									["onNext"] = nil,
									["title"] = ("Lift %d anti-cheat ban%s?"):format(v45, v45 == 1 and "" or "s"),
									["sub"] = ("From %s, plus %d still queued - they can join again right away"):format(v48, v47),
									["choices"] = {
										{
											["id"] = "go",
											["label"] = "YES, LIFT THEM",
											["hours"] = p40
										}
									},
									["reason"] = p41,
									["chips"] = {},
									["tapes"] = {
										["length"] = "CONFIRM",
										["reason"] = "NOTE FOR THE STAFF LOG",
										["proof"] = false,
										["reasonWarn"] = "Write a short note for the staff log first."
									},
									["onNext"] = function(p49) -- name: onNext
										-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_24
										local v50, v51 = v_u_16.call("ac_undo", {
											["hours"] = nil,
											["go"] = true,
											["hours"] = p49
										})
										v_u_17.push(type(v51) ~= "string" and (v50 and "Done" or "Couldn\'t undo the bans") or v51, v50 and "good" or "bad")
										task.delay(6, function()
											-- upvalues: (ref) v_u_24
											task.spawn(v_u_24.load)
										end)
									end
								})
							end
						else
							v_u_17.push(type(v43) ~= "string" and "Couldn\'t check the bans" or v43, "bad")
							return
						end
					end
				end
			})
		end
	end
	function v_u_24.unblock(p52, p53) -- name: unblock
		-- upvalues: (copy) v_u_16, (copy) v_u_17, (copy) v_u_4
		local v54, v55 = v_u_16.call("ban_unblock", {})
		if v54 and type(v55) == "table" then
			local v56 = v55.bans
			local v57 = tonumber(v56) or 0
			local v58 = v55.all622 == true
			local v59 = v55.progress
			local v60
			if type(v59) == "table" then
				v60 = v55.progress
			else
				v60 = nil
			end
			local v61 = v55.listProgress
			local v62
			if type(v61) == "table" then
				v62 = v55.listProgress
			else
				v62 = nil
			end
			local v63 = v55.free630
			local v64
			if type(v63) == "table" then
				v64 = v55.free630
			else
				v64 = nil
			end
			if v64 and v64.finished == nil then
				local v65 = v_u_17.push
				local v66 = v64.lifted
				local v67 = tonumber(v66) or 0
				local v68 = v64.done
				local v69 = tonumber(v68) or 0
				local v70 = v64.parts
				v65(("Unbanning device-banned players automatically: %d lifted so far, %d of %d parts done - nothing to press"):format(v67, v69, tonumber(v70) or 10), "good")
				return
			else
				if v64 then
					local v71 = v_u_17.push
					local v72 = v64.lifted
					v71(("Automatic device unban finished: %d anti-cheat bans lifted"):format(tonumber(v72) or 0), "good")
				end
				if v60 and v60.running or v62 and v62.running then
					if v62 and v62.running then
						local v73 = v_u_17.push
						local v74 = "Freeing devices (ban list): %d%% - %d of %d done, %d freed, %d failed (updated %ds ago)%s"
						local v75 = v62.pct
						local v76 = tonumber(v75) or 0
						local v77 = v62.pos
						local v78 = tonumber(v77) or 0
						local v79 = v62.total
						local v80 = tonumber(v79) or 0
						local v81 = v62.done
						local v82 = tonumber(v81) or 0
						local v83 = v62.failed
						local v84 = tonumber(v83) or 0
						local v85 = v62.ago
						local v86 = tonumber(v85) or 0
						local v87 = v62.lastErr
						local v88
						if type(v87) == "string" then
							local v89 = v62.lastErr
							v88 = " - last error: " .. string.sub(v89, 1, 80)
						else
							v88 = ""
						end
						v73(v74:format(v76, v78, v80, v82, v84, v86, v88), "good")
					end
					if v60 and v60.running then
						local v90 = v_u_17.push
						local v91 = "Freeing devices (all saved bans): about %d%% through - %d freed, %d failed (updated %ds ago)%s"
						local v92 = v60.pct
						local v93 = tonumber(v92) or 0
						local v94 = v60.done
						local v95 = tonumber(v94) or 0
						local v96 = v60.failed
						local v97 = tonumber(v96) or 0
						local v98 = v60.ago
						local v99 = tonumber(v98) or 0
						local v100 = v60.lastErr
						local v101
						if type(v100) == "string" then
							local v102 = v60.lastErr
							v101 = " - last error: " .. string.sub(v102, 1, 80)
						else
							v101 = ""
						end
						v90(v91:format(v93, v95, v97, v99, v101), "good")
					end
					if v62 and v62.running then
						return
					end
				end
				local v103
				if v60 and v60.running then
					local v104 = v60.pct
					v103 = (" ALL SAVED is still running (about %d%%) - LIST can run alongside it."):format(tonumber(v104) or 0)
				elseif v60 and v60.stopped then
					local v105 = v60.pct
					local v106 = tonumber(v105) or 0
					local v107 = v60.done
					v103 = (" Last ALL SAVED pass stopped at about %d%% (%d freed) - ALL SAVED carries on from there."):format(v106, tonumber(v107) or 0)
				elseif v60 and v60.finished then
					local v108 = v60.done
					v103 = (" Last ALL SAVED pass finished: %d freed."):format(tonumber(v108) or 0)
				else
					v103 = ""
				end
				if v57 == 0 and not v58 then
					v_u_17.push("No bans are blocking devices", "warn")
				else
					v_u_4.ban(p52, {
						["title"] = "Free devices on banned players?",
						["sub"] = nil,
						["choices"] = nil,
						["pick"] = nil,
						["reason"] = nil,
						["chips"] = nil,
						["tapes"] = nil,
						["nextText"] = "Free devices",
						["onNext"] = nil,
						["sub"] = ("Players STAY banned - only the block on their device and alts goes (Roblox takes a few minutes). LIST = the %d bans in the list (~30 min). ALL SAVED = every ban ever saved (a few thousand - an hour or more; it carries on after a restart). Permanent staff bans keep it."):format(v57) .. v103,
						["choices"] = {
							{
								["id"] = "go",
								["label"] = "LIST",
								["hours"] = 0
							},
							{
								["id"] = "all",
								["label"] = "ALL SAVED",
								["hours"] = 1
							}
						},
						["pick"] = v58 and "all" or "go",
						["reason"] = p53,
						["chips"] = {},
						["tapes"] = {
							["length"] = "WHICH BANS",
							["reason"] = "NOTE FOR THE STAFF LOG",
							["proof"] = false,
							["reasonWarn"] = "Write a short note for the staff log first."
						},
						["onNext"] = function(p109) -- name: onNext
							-- upvalues: (ref) v_u_16, (ref) v_u_17
							local v110, v111 = v_u_16.call("ban_unblock", {
								["go"] = true,
								["all"] = p109 == 1
							})
							v_u_17.push(type(v111) ~= "string" and (v110 and "Started" or "Couldn\'t start") or v111, v110 and "good" or "bad")
						end
					})
				end
			end
		else
			v_u_17.push(type(v55) ~= "string" and "Couldn\'t check the bans" or v55, "bad")
			return
		end
	end
	v_u_24.massUi = require((v3:WaitForChild("AdminUI"):WaitForChild("MassUnban")))
	v_u_24.MASS_WHEN = {
		["1"] = 1,
		["6"] = 6,
		["24"] = 24,
		["72"] = 72
	}
	v_u_24.MASS_WAIT = 0.45
	v_u_24.MASS_ARM = 4
	v_u_24.MASS_POLL_BUSY = 1.5
	v_u_24.MASS_POLL_IDLE = 8
	v_u_24.MASS_STEP = 0.5
	v_u_24.MASS_OPTS = {
		{
			["key"] = "roblox",
			["text"] = "Lift the Roblox ban too"
		},
		{
			["key"] = "strikes",
			["text"] = "Clear their anti-cheat strikes"
		},
		{
			["key"] = "flagged",
			["text"] = "Keep anyone with other cheat flags (teleport, fling, tampering, forged hits, baits)"
		}
	}
	function v_u_24.massNum(p112) -- name: massNum
		-- upvalues: (copy) v_u_13
		local v113 = v_u_13
		local v114 = tonumber(v113(p112))
		if v114 and (v114 == v114 and v114 >= 0) then
			return v114
		else
			return nil
		end
	end
	function v_u_24.massFilters(p115) -- name: massFilters
		local v116 = {}
		for v117, v118 in p115.reasons do
			if not v118 then
				continue
			end
			table.insert(v116, v117)
		end
		local v119 = {
			["kinds"] = p115.kinds,
			["reasons"] = v116,
			["words"] = p115.words,
			["player"] = p115.player,
			["by"] = p115.by,
			["fromHours"] = p115.from,
			["toHours"] = p115.to,
			["length"] = p115.length
		}
		local v120
		if p115.length == "timed" then
			v120 = p115.minH
		else
			v120 = nil
		end
		v119.minHours = v120
		local v121
		if p115.length == "timed" then
			v121 = p115.maxH
		else
			v121 = nil
		end
		v119.maxHours = v121
		return v119
	end
	function v_u_24.massExpect(p122) -- name: massExpect
		local v123 = p122.res
		if not v123 then
			return 0, 0
		end
		local v124 = p122.skip
		local v125 = 0
		for _, v126 in v123.rows do
			if not v124[v126.id] then
				continue
			end
			v125 = v125 + 1
		end
		local v127 = v123.total
		return (tonumber(v127) or 0) - v125, v125
	end
	function v_u_24.massBusy(p128) -- name: massBusy
		local v129
		if p128 == nil then
			v129 = false
		else
			v129 = (p128.state == "running" or p128.state == "undoing") and true or p128.state == "stopping"
		end
		return v129
	end
	function v_u_24.massQuery() -- name: massQuery
		-- upvalues: (copy) v_u_24, (copy) v_u_16
		local v_u_130 = v_u_24.MU
		if v_u_130 then
			v_u_130.seq = v_u_130.seq + 1
			local v_u_131 = v_u_130.seq
			task.delay(v_u_24.MASS_WAIT, function()
				-- upvalues: (ref) v_u_24, (copy) v_u_130, (copy) v_u_131, (ref) v_u_16
				if v_u_24.MU == v_u_130 and (v_u_130.seq == v_u_131 and v_u_130.sheet.alive()) then
					local v132, v133 = v_u_16.call("ban_mass_find", {
						["filters"] = v_u_24.massFilters(v_u_130)
					})
					if v_u_24.MU == v_u_130 and v_u_130.seq == v_u_131 then
						if v132 and type(v133) == "table" then
							v_u_130.res = v133
							v_u_130.job = v133.job
							if v_u_130.status ~= "" and v_u_130.tone == "bad" then
								v_u_130.status = ""
							end
						else
							v_u_130.status = type(v133) ~= "string" and "Couldn\'t check the bans" or v133
							v_u_130.tone = "bad"
						end
						v_u_24.massRender()
					end
				else
					return
				end
			end)
		end
	end
	function v_u_24.massPoll() -- name: massPoll
		-- upvalues: (copy) v_u_24, (copy) v_u_14, (copy) v_u_16
		local v134 = v_u_24.MU
		while v134 and (v_u_24.MU == v134 and v134.sheet.alive()) do
			local v135 = 0
			task.wait(v_u_24.MASS_STEP)
			v135 = v135 + v_u_24.MASS_STEP
			if v_u_24.MU == v134 then
				local v136
				if v_u_24.massBusy(v134.job) then
					v136 = v_u_24.MASS_POLL_BUSY
				else
					v136 = v_u_24.MASS_POLL_IDLE
				end
				if v136 > v135 then
					continue
				end
			end
			if v_u_24.MU ~= v134 or not v134.sheet.alive() then
				return
			end
			if v_u_14.focused == false then
				break
			end
			local v137, v138 = v_u_16.call("ban_mass_status", {})
			if not v137 or (type(v138) ~= "table" or v_u_24.MU ~= v134) then
				break
			end
			local v139 = v_u_24.massBusy(v134.job)
			v134.job = v138.job
			v_u_24.massRender()
			if not v139 or v_u_24.massBusy(v134.job) then
				break
			end
			v134.status = ""
			v_u_24.massRender()
			v_u_24.massQuery()
			task.spawn(v_u_24.load)
		end
	end
	function v_u_24.massArmed(p140) -- name: massArmed
		-- upvalues: (copy) v_u_24
		local v141
		if p140 == nil then
			v141 = false
		else
			v141 = os.clock() - p140 < v_u_24.MASS_ARM
		end
		return v141
	end
	function v_u_24.massRearm(p_u_142) -- name: massRearm
		-- upvalues: (copy) v_u_24
		local v_u_143 = p_u_142.status
		task.delay(v_u_24.MASS_ARM + 0.05, function()
			-- upvalues: (ref) v_u_24, (copy) p_u_142, (copy) v_u_143
			if v_u_24.MU == p_u_142 then
				if p_u_142.status == v_u_143 and not (v_u_24.massArmed(p_u_142.armedAt) or v_u_24.massArmed(p_u_142.actArmedAt)) then
					p_u_142.status = ""
				end
				v_u_24.massRender()
			end
		end)
	end
	function v_u_24.massShort(p144) -- name: massShort
		return string.gsub(p144, "^Anti%-cheat: ", "")
	end
	function v_u_24.massLength(p145, p146) -- name: massLength
		if p145 == -1 then
			return "permanent"
		else
			local v147 = p145 - p146
			local v148 = math.max(0, v147) / 3600
			if v148 >= 48 then
				local v149 = v148 / 24 + 0.5
				return ("%d days"):format((math.floor(v149)))
			else
				local v150 = v148 + 0.5
				return ("%d h"):format((math.floor(v150)))
			end
		end
	end
	function v_u_24.massJob(p151) -- name: massJob
		-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_24
		local v152 = p151.job
		if not v152 then
			return {
				["visible"] = false,
				["text"] = "",
				["act"] = nil,
				["actOn"] = false,
				["armed"] = false
			}
		end
		local v153 = v152.now
		local v154 = tonumber(v153) or v_u_12()
		local v155 = v_u_10
		local v156 = v152.at
		local v157 = v155(v154 - (tonumber(v156) or v154))
		local v158 = v152.dry == true and " (Studio dry run)" or ""
		if v152.state == "running" then
			local v159 = {
				["visible"] = true,
				["text"] = nil,
				["act"] = "Stop",
				["actOn"] = true,
				["armed"] = false
			}
			local v160 = v152.done
			local v161 = tonumber(v160) or 0
			local v162 = v152.total
			local v163 = tonumber(v162) or 0
			local v164 = v152.kept
			local v165 = tonumber(v164) or 0
			local v166 = v152.gone
			local v167 = tonumber(v166) or 0
			local v168 = v152.failed
			v159.text = ("Unbanning%s: %d of %d done, %d kept, %d already gone, %d failed"):format(v158, v161, v163, v165, v167, tonumber(v168) or 0)
			return v159
		end
		if v152.state == "stopping" then
			local v169 = {
				["visible"] = true,
				["text"] = nil,
				["act"] = nil,
				["actOn"] = false,
				["armed"] = false
			}
			local v170 = v152.done
			local v171 = tonumber(v170) or 0
			local v172 = v152.total
			v169.text = ("Stopping at %d of %d..."):format(v171, tonumber(v172) or 0)
			return v169
		end
		if v152.state == "undoing" then
			local v173 = {
				["visible"] = true,
				["text"] = nil,
				["act"] = nil,
				["actOn"] = false,
				["armed"] = false
			}
			local v174 = v152.lifted
			v173.text = ("Banning %d players again%s..."):format(tonumber(v174) or 0, v158)
			return v173
		end
		if v152.state == "undone" then
			local v175 = {
				["visible"] = true,
				["text"] = nil,
				["act"] = nil,
				["actOn"] = false,
				["armed"] = false
			}
			local v176 = v152.by
			local v177 = tostring(v176)
			local v178 = v152.undoneBy or "?"
			local v179 = tostring(v178)
			local v180 = v152.rebanned
			v175.text = ("%s\'s run (%s ago) was put back by %s: %d banned again%s"):format(v177, v157, v179, tonumber(v180) or 0, v158)
			return v175
		end
		local v181 = v152.kept
		local v182
		if (tonumber(v181) or 0) > 0 then
			local v183 = v152.kept
			v182 = (", %d kept for other flags"):format(tonumber(v183) or 0)
		else
			v182 = ""
		end
		local v184
		if v152.state == "stopped" then
			local v185 = v152.done
			local v186 = tonumber(v185) or 0
			local v187 = v152.total
			v184 = (", stopped at %d of %d"):format(v186, tonumber(v187) or 0)
		else
			v184 = ""
		end
		local v188 = v_u_24.massArmed(p151.actArmedAt)
		local v189 = v152.undoable == true
		local v190 = {
			["visible"] = true,
			["text"] = nil,
			["act"] = nil,
			["actOn"] = nil,
			["armed"] = nil
		}
		local v191 = v152.by
		local v192 = tostring(v191)
		local v193 = v152.lifted
		v190.text = ("Last run by %s, %s ago: %d unbanned%s%s%s"):format(v192, v157, tonumber(v193) or 0, v182, v184, v158)
		v190.act = v189 and (v188 and "Press again" or "Ban them again") or nil
		v190.actOn = v189
		v190.armed = v188 and v189
		return v190
	end
	function v_u_24.massRender() -- name: massRender
		-- upvalues: (copy) v_u_24, (copy) v_u_10, (copy) v_u_12, (copy) v_u_11
		local v194 = v_u_24.MU
		if v194 and v194.sheet.alive() then
			local v195 = v194.res
			local v196 = {}
			local v197 = {}
			if v195 then
				for _, v198 in v195.reasons do
					v197[v198.text] = true
					local v199 = {
						["key"] = v198.text
					}
					local v200 = v_u_24.massShort(v198.text)
					local v201 = v198.n
					v199.text = ("%s  %d"):format(v200, tonumber(v201) or 0)
					v199.on = v194.reasons[v198.text] == true
					table.insert(v196, v199)
				end
			end
			for v202, v203 in v194.reasons do
				if not v203 or v197[v202] then
					continue
				end
				local v204 = {
					["key"] = nil,
					["text"] = nil,
					["on"] = true,
					["key"] = v202,
					["text"] = v_u_24.massShort(v202) .. "  0"
				}
				table.insert(v196, v204)
			end
			local v205 = {}
			if v195 then
				for _, v206 in v195.rows do
					local v207 = {}
					local v208 = v206.id
					v207.key = "u:" .. tostring(v208)
					local v209 = v206.name
					v207.name = tostring(v209)
					local v210 = v_u_24.massShort
					local v211 = v206.reason
					local v212 = v210((tostring(v211)))
					local v213 = v_u_24.massLength(v206.untilTime, v206.at)
					local v214 = v_u_10
					local v215 = v195.now
					local v216 = tonumber(v215) or v_u_12()
					local v217 = v206.at
					v207.sub = ("%s, %s, %s ago"):format(v212, v213, v214(v216 - (tonumber(v217) or 0)))
					v207.out = v194.skip[v206.id] == true
					table.insert(v205, v207)
				end
			end
			local v218, v219 = v_u_24.massExpect(v194)
			local v220
			if v195 then
				local v221 = v195.total
				v220 = tonumber(v221) or 0
			else
				v220 = 0
			end
			local v222
			if v195 then
				local v223 = v195.max
				v222 = tonumber(v223) or 500
			else
				v222 = 500
			end
			local v224 = v_u_24.massBusy(v194.job)
			local v225 = v_u_24.massArmed(v194.armedAt)
			local v226 = {}
			for _, v227 in v_u_24.MASS_OPTS do
				local v228 = {
					["key"] = v227.key,
					["text"] = v227.text,
					["on"] = v194.opts[v227.key] == true
				}
				table.insert(v226, v228)
			end
			local v229 = "Lifts a group of bans in one go."
			if v195 and v195.oldest then
				local v230 = v195.listed
				v229 = v229 .. (" Looks at the %d bans in the ban list, back to %s."):format(tonumber(v230) or 0, v_u_11(v195.oldest))
			end
			local v231
			if v195 then
				if v224 then
					v231 = "A run is going"
				elseif v218 <= 0 then
					v231 = "Nothing to unban"
				elseif v222 < v218 then
					v231 = ("Too many, %d at most"):format(v222)
				elseif v225 then
					v231 = ("Press again to unban %d"):format(v218)
				else
					v231 = ("Unban %d player%s"):format(v218, v218 == 1 and "" or "s")
				end
			else
				v231 = "Checking..."
			end
			local v232 = v194.sheet.render
			local v233 = {
				["sub"] = v229,
				["kinds"] = v194.kinds,
				["reasons"] = v196,
				["when"] = v194.when,
				["length"] = v194.length,
				["opts"] = v226,
				["count"] = not v195 and "Checking..." or ("%d ban%s match"):format(v220, v220 == 1 and "" or "s"),
				["countSub"] = not v195 and "" or ("%d left out, %d to unban%s"):format(v219, math.max(0, v218), #v205 >= v220 and "" or (", showing the newest %d"):format(#v205)),
				["rows"] = v205,
				["empty"] = v195 and "No bans match" or "Loading",
				["status"] = v194.status,
				["statusTone"] = v194.tone
			}
			local v234 = {
				["text"] = v231
			}
			local v235 = v195 ~= nil and not v224
			if v235 then
				if v218 > 0 then
					v235 = v218 <= v222
				else
					v235 = false
				end
			end
			v234.on = v235
			if v225 then
				v225 = not v224
			end
			v234.armed = v225
			v233.run = v234
			v233.job = v_u_24.massJob(v194)
			v232(v233)
		end
	end
	function v_u_24.massRun() -- name: massRun
		-- upvalues: (copy) v_u_24, (copy) v_u_13, (copy) v_u_16
		local v236 = v_u_24.MU
		if v236 and (v236.res and not v_u_24.massBusy(v236.job)) then
			local v237 = v_u_24.massExpect(v236)
			local v238 = v236.res.max
			local v239 = tonumber(v238) or 500
			if v237 <= 0 or v239 < v237 then
				return
			else
				v236.note = v_u_13(v236.sheet.text("Note"))
				if #v236.note < 3 then
					v236.status = "Write a short note for the staff log first"
					v236.tone = "amber"
					v236.armedAt = nil
					v_u_24.massRender()
					return
				elseif v_u_24.massArmed(v236.armedAt) then
					v236.armedAt = nil
					local v240 = {}
					for v241, v242 in v236.skip do
						if not v242 then
							continue
						end
						table.insert(v240, v241)
					end
					local v243, v244 = v_u_16.call("ban_mass_run", {
						["filters"] = v_u_24.massFilters(v236),
						["skip"] = v240,
						["expect"] = v237,
						["note"] = v236.note,
						["roblox"] = v236.opts.roblox == true,
						["strikes"] = v236.opts.strikes == true,
						["keepFlagged"] = v236.opts.flagged == true
					})
					v236.status = type(v244) ~= "string" and (v243 and "Started" or "Couldn\'t start") or v244
					v236.tone = v243 and "good" or "bad"
					if v243 then
						local v245, v246 = v_u_16.call("ban_mass_status", {})
						if v245 and type(v246) == "table" then
							v236.job = v246.job
						end
					else
						v_u_24.massQuery()
					end
					v_u_24.massRender()
				else
					v236.armedAt = os.clock()
					v236.status = ("They can join again right away. Press again to unban %d."):format(v237)
					v236.tone = "amber"
					v_u_24.massRender()
					v_u_24.massRearm(v236)
				end
			end
		else
			return
		end
	end
	function v_u_24.massAct() -- name: massAct
		-- upvalues: (copy) v_u_24, (copy) v_u_16
		local v247 = v_u_24.MU
		local v248
		if v247 then
			v248 = v247.job
		else
			v248 = v247
		end
		if v247 and v248 then
			if v248.state == "running" then
				local v249, v250 = v_u_16.call("ban_mass_stop", {})
				v247.status = type(v250) ~= "string" and "Couldn\'t stop it" or v250
				v247.tone = v249 and "amber" or "bad"
				v_u_24.massRender()
				return
			elseif v248.undoable == true then
				if v_u_24.massArmed(v247.actArmedAt) then
					v247.actArmedAt = nil
					local v251, v252 = v_u_16.call("ban_mass_undo", {
						["id"] = v248.id
					})
					v247.status = type(v252) ~= "string" and (v251 and "Started" or "Couldn\'t start") or v252
					v247.tone = v251 and "good" or "bad"
					local v253, v254 = v_u_16.call("ban_mass_status", {})
					if v253 and type(v254) == "table" then
						v247.job = v254.job
					end
					v_u_24.massRender()
				else
					v247.actArmedAt = os.clock()
					local v255 = v248.lifted
					v247.status = ("This bans the %d players from that run again. Press again to do it."):format(tonumber(v255) or 0)
					v247.tone = "amber"
					v_u_24.massRender()
					v_u_24.massRearm(v247)
				end
			else
				return
			end
		else
			return
		end
	end
	function v_u_24.massClose() -- name: massClose
		-- upvalues: (copy) v_u_24
		local v256 = v_u_24.MU
		v_u_24.MU = nil
		if v256 then
			v256.sheet.close()
		end
	end
	function v_u_24.massOpen() -- name: massOpen
		-- upvalues: (copy) v_u_24, (copy) v_u_21, (copy) v_u_13, (copy) v_u_17
		local v257 = v_u_24.pageKit
		if v257 and v_u_21("unban_mass") then
			if v_u_24.MU and v_u_24.MU.sheet.alive() then
				return
			else
				local v_u_258 = {
					["kinds"] = nil,
					["reasons"] = nil,
					["words"] = "",
					["when"] = "24",
					["from"] = 0,
					["to"] = 24,
					["length"] = "any",
					["minH"] = nil,
					["maxH"] = nil,
					["player"] = "",
					["by"] = "",
					["opts"] = nil,
					["skip"] = nil,
					["note"] = "",
					["res"] = nil,
					["job"] = nil,
					["seq"] = 0,
					["status"] = "",
					["tone"] = "muted",
					["armedAt"] = nil,
					["actArmedAt"] = nil,
					["sheet"] = nil,
					["kinds"] = {
						["auto"] = true
					},
					["reasons"] = {},
					["opts"] = {
						["roblox"] = true,
						["strikes"] = true,
						["flagged"] = false
					},
					["skip"] = {}
				}
				local v292 = v_u_24.massUi.mount(v257, {
					["kind"] = function(p259) -- name: kind
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						local v260 = not v_u_258.kinds[p259]
						if not v260 then
							local v261 = 0
							for _, v262 in v_u_258.kinds do
								if not v262 then
									continue
								end
								v261 = v261 + 1
							end
							if v261 <= 1 then
								local v263 = v_u_258
								v_u_258.status = "Keep at least one kind of ban"
								v263.tone = "amber"
								v_u_24.massRender()
								return
							end
						end
						v_u_258.kinds[p259] = v260 and true or nil
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["reason"] = function(p264) -- name: reason
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						v_u_258.reasons[p264] = not v_u_258.reasons[p264] and true or nil
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["words"] = function(p265) -- name: words
						-- upvalues: (copy) v_u_258, (ref) v_u_13, (ref) v_u_24
						v_u_258.words = v_u_13(p265)
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["when"] = function(p266) -- name: when
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						v_u_258.when = p266
						local v267 = v_u_24.MASS_WHEN[p266]
						v_u_258.from = v267 and 0 or nil
						v_u_258.to = v267
						v_u_258.sheet.setText("From", v267 and "0" or "")
						v_u_258.sheet.setText("To", not v267 and "" or tostring(v267))
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["range"] = function(p268, p269) -- name: range
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						local v270 = v_u_258
						local v271 = v_u_258
						local v272 = v_u_24.massNum(p268)
						local v273 = v_u_24.massNum(p269)
						v270.from = v272
						v271.to = v273
						v_u_258.when = v_u_258.from == nil and v_u_258.to == nil and "any" or "custom"
						for v274, v275 in v_u_24.MASS_WHEN do
							if v_u_258.from ~= nil and v_u_258.from ~= 0 or v_u_258.to ~= v275 then
								continue
							end
							v_u_258.when = v274
						end
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["length"] = function(p276) -- name: length
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						v_u_258.length = p276
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["lengthRange"] = function(p277, p278) -- name: lengthRange
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						local v279 = v_u_258
						local v280 = v_u_258
						local v281 = v_u_24.massNum(p277)
						local v282 = v_u_24.massNum(p278)
						v279.minH = v281
						v280.maxH = v282
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["player"] = function(p283) -- name: player
						-- upvalues: (copy) v_u_258, (ref) v_u_13, (ref) v_u_24
						v_u_258.player = v_u_13(p283)
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["by"] = function(p284) -- name: by
						-- upvalues: (copy) v_u_258, (ref) v_u_13, (ref) v_u_24
						v_u_258.by = v_u_13(p284)
						v_u_258.armedAt = nil
						v_u_24.massRender()
						v_u_24.massQuery()
					end,
					["opt"] = function(p285) -- name: opt
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						v_u_258.opts[p285] = not v_u_258.opts[p285]
						v_u_24.massRender()
					end,
					["row"] = function(p286) -- name: row
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						local v287 = string.match
						local v288 = tonumber(v287(p286, "^u:(%-?%d+)$"))
						if v288 then
							v_u_258.skip[v288] = not v_u_258.skip[v288] and true or nil
							v_u_258.armedAt = nil
							v_u_24.massRender()
						end
					end,
					["bulk"] = function(p289) -- name: bulk
						-- upvalues: (copy) v_u_258, (ref) v_u_24
						if p289 then
							v_u_258.skip = {}
						elseif v_u_258.res then
							for _, v290 in v_u_258.res.rows do
								v_u_258.skip[v290.id] = true
							end
						end
						v_u_258.armedAt = nil
						v_u_24.massRender()
					end,
					["note"] = function(p291) -- name: note
						-- upvalues: (copy) v_u_258, (ref) v_u_13, (ref) v_u_24
						v_u_258.note = v_u_13(p291)
						if v_u_258.tone == "amber" and #v_u_258.note >= 3 then
							v_u_258.status = ""
						end
						v_u_24.massRender()
					end,
					["run"] = function() -- name: run
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.massRun)
					end,
					["act"] = function() -- name: act
						-- upvalues: (ref) v_u_24
						task.spawn(v_u_24.massAct)
					end,
					["close"] = v_u_24.massClose
				})
				if v292 then
					v_u_258.sheet = v292
					v_u_24.MU = v_u_258
					v292.setText("From", "0")
					v292.setText("To", "24")
					v_u_24.massRender()
					v_u_24.massQuery()
					task.spawn(v_u_24.massPoll)
				else
					v_u_17.push("The mass unban screen is missing from the kit", "bad")
				end
			end
		else
			return
		end
	end
	function v_u_24.ban(p293) -- name: ban
		-- upvalues: (copy) v_u_24
		local v294
		if type(p293) == "string" then
			local v295 = string.match
			v294 = tonumber(v295(p293, "^b:(%-?%d+)$"))
		else
			v294 = nil
		end
		if not v294 then
			return nil
		end
		for _, v296 in ipairs(v_u_24.rows) do
			if type(v296) ~= "table" or v296.id ~= v294 then
				continue
			end
			return v296
		end
		return nil
	end
	function v_u_24.request(p297) -- name: request
		-- upvalues: (copy) v_u_24
		local v298
		if type(p297) == "string" then
			v298 = string.match(p297, "^r:(.+)$")
		else
			v298 = nil
		end
		if not v298 then
			return nil
		end
		for _, v299 in ipairs(v_u_24.reqs) do
			if type(v299) ~= "table" or v299.id ~= v298 then
				continue
			end
			return v299
		end
		return nil
	end
	function v_u_24.lengthLabel(p300) -- name: lengthLabel
		-- upvalues: (copy) v_u_8
		if type(p300) ~= "number" or p300 <= 0 then
			return "PERM"
		end
		for _, v301 in ipairs(v_u_8.BAN_CHOICES) do
			if v301.hours ~= p300 then
				continue
			end
			return v301.label
		end
		local v302 = p300 * 10 + 0.5
		return ("%g H"):format(math.floor(v302) / 10)
	end
	function v_u_24.setPending(p303) -- name: setPending
		-- upvalues: (copy) v_u_24, (copy) v_u_15, (copy) v_u_7
		v_u_24.pending = p303
		local v304 = v_u_15.tabButtons
		if v304 then
			v304 = v_u_15.tabButtons.bans
		end
		if v304 then
			v304.badge.Text = p303 <= 0 and "" or tostring(p303)
			v304.badge.TextColor3 = v_u_7.amber
		end
		if v_u_24.page and v_u_24.page.alive() then
			v_u_24.renderList()
		end
	end
	function v_u_24.load() -- name: load
		-- upvalues: (copy) v_u_24, (copy) v_u_16
		if v_u_24.loading then
			v_u_24.again = true
		else
			v_u_24.loading = true
			task.spawn(v_u_24.loadRequests)
			while true do
				v_u_24.again = false
			local v305, v306 = v_u_16.call("bans", {
				["q"] = v_u_24.q,
				["status"] = v_u_24.status
			})
			if v305 and type(v306) == "table" then
				v_u_24.data = v306
				local v307 = v_u_24
				local v308 = v306.rows
				v307.rows = type(v308) ~= "table" and {} or v306.rows
				local v309 = v_u_24
				local v310 = v306.next
				local v311
				if type(v310) == "number" then
					v311 = v306.next
				else
					v311 = nil
				end
				v309.next = v311
				v_u_24.loadErr = nil
			else
				v_u_24.loadErr = type(v306) ~= "string" and "Couldn\'t load the ban list" or v306
			end
				if not v_u_24.again then
					break
				end
			end
			v_u_24.loading = false
			v_u_24.render()
		end
	end
	function v_u_24.more() -- name: more
		-- upvalues: (copy) v_u_24, (copy) v_u_16, (copy) v_u_17
		if not v_u_24.loading and v_u_24.next then
			v_u_24.loading = true
			local v312, v313 = v_u_16.call("bans", {
				["q"] = v_u_24.q,
				["status"] = v_u_24.status,
				["cursor"] = v_u_24.next
			})
			v_u_24.loading = false
			if v312 and type(v313) == "table" then
				local v314 = v313.rows
				if type(v314) == "table" then
					for _, v315 in ipairs(v313.rows) do
						local v316 = v_u_24.rows
						table.insert(v316, v315)
					end
					local v317 = v_u_24
					local v318 = v313.next
					local v319
					if type(v318) == "number" then
						v319 = v313.next
					else
						v319 = nil
					end
					v317.next = v319
					v_u_24.render()
					return
				end
			end
			v_u_17.push(type(v313) ~= "string" and "Couldn\'t load more bans" or v313, "bad")
		end
	end
	function v_u_24.loadRequests() -- name: loadRequests
		-- upvalues: (copy) v_u_24, (copy) v_u_16
		if not v_u_24.reqLoading then
			v_u_24.reqLoading = true
			local v320, v321 = v_u_16.call("ban_requests")
			v_u_24.reqLoading = false
			if v320 and type(v321) == "table" then
				v_u_24.reqs = v321
				v_u_24.reqErr = nil
			else
				v_u_24.reqErr = type(v321) ~= "string" and "Couldn\'t load the requests" or v321
			end
			local v322 = 0
			for _, v323 in ipairs(v_u_24.reqs) do
				if type(v323) ~= "table" or v323.status ~= "pending" then
					continue
				end
				v322 = v322 + 1
			end
			v_u_24.setPending(v322)
			v_u_24.render()
		end
	end
	function v_u_24.leftText(p324, p325) -- name: leftText
		-- upvalues: (copy) v_u_10
		local v326 = p324.untilTime
		if type(v326) == "number" and v326 >= 0 then
			if v326 <= p325 then
				return "ended " .. v_u_10(p325 - v326) .. " ago"
			else
				return v_u_10(v326 - p325) .. " left"
			end
		else
			return "permanent"
		end
	end
	function v_u_24.tapeFor(p327, p328) -- name: tapeFor
		-- upvalues: (copy) v_u_24, (copy) v_u_10
		local v329 = v_u_24.STATE[p327.state] or v_u_24.STATE.expired
		return p327.state == "timed" and { string.upper(v_u_10(p327.untilTime - p328)) .. " LEFT", v329[2] } or v329
	end
	function v_u_24.robloxTape(p330) -- name: robloxTape
		if p330.state == "perm" or p330.state == "timed" then
			if p330.rb == "on" then
				return p330.alts and "ROBLOX + ALTS" or "ROBLOX", "good"
			elseif p330.rb == "studio" then
				return "STUDIO TEST", "muted"
			elseif p330.rb == "failed" then
				return "ROBLOX FAILED", "badText"
			else
				local v331 = p330.id
				if type(v331) == "number" and p330.id < 1 then
					return "TEST PLAYER", "muted"
				else
					return "GAME ONLY", "hover"
				end
			end
		else
			return nil, "hover"
		end
	end
	function v_u_24.renderList() -- name: renderList
		-- upvalues: (copy) v_u_24, (copy) v_u_12, (copy) v_u_10, (copy) v_u_9, (copy) v_u_21
		local v332 = v_u_24.page
		if not (v332 and v332.alive()) then
			if v_u_24.pageFrame and not v_u_24.mounting then
				task.spawn(v_u_24.mount)
			end
			return
		end
		local v333 = v_u_24.data
		local v334, v335, v336, v337, v338, v339, v340, v341, v342, v343, v344, v345, v346, v347, v348, v349, v350, v351, v352, v353, v354, v355, v356, v357, v358, v359, v360, v361, v362, v363, v364, v365, v366, v367, v368, v369
		if type(v333) == "table" then
			local v370 = v333.now
			if type(v370) == "number" then
				v334 = v333.now
				v335 = {}
				if v_u_24.view == "requests" then
					for v379, v380 in ipairs(v_u_24.reqs) do
						if type(v380) ~= "table" then
							continue
						end
						v336 = v380.id
						if type(v336) ~= "string" then
							continue
						end
						v337 = v_u_24.STATE[v380.status] or v_u_24.STATE.pending
						v338 = v380.at
						if type(v338) == "number" then
							v339 = v_u_10
							v340 = v334 - v380.at
							v341 = v339((math.max(0, v340))) .. " ago"
						else
							v341 = ""
						end
						v342 = {
							["key"] = "r:" .. v380.id
						}
						v343 = v380.targetName or "?"
						v342.name = tostring(v343)
						v342.state = v337[1]
						v342.stateTone = v337[2]
						v342.sub = ("%s \194\183 asked by %s \194\183 %s"):format(v_u_24.hx("amber", v_u_24.lengthLabel(v380.hours)), v_u_9(v380.byName or "?"), v341)
						v342.selected = v_u_24.selected == "r:" .. v380.id
						table.insert(v335, v342)
					end
					v344 = v_u_24.reqErr or ("%d waiting \194\183 newest first"):format(v_u_24.pending)
					v345 = v_u_24.reqErr or "No ban requests in the last 7 days"
					v346 = v332.renderList
					v347 = {
						["view"] = v_u_24.view,
						["rows"] = v335,
						["empty"] = v345,
						["status"] = v344,
						["filter"] = v_u_24.status
					}
					if v_u_24.view == "bans" then
						v348 = v_u_24.next ~= nil
					else
						v348 = false
					end
					v347.more = v348
					v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
					v347.mass = v_u_21("unban_mass")
					v346(v347)
				else
					for v381, v382 in ipairs(v_u_24.rows) do
						if type(v382) ~= "table" then
							continue
						end
						v349 = v382.id
						if type(v349) ~= "number" then
							continue
						end
						v350 = v_u_24.tapeFor(v382, v334)
						if v382.state == "lifted" then
							v351 = "lifted by " .. v_u_9(v382.liftedBy or "?")
						else
							v351 = "by " .. v_u_9(v382.by or "?")
						end
						v352 = {}
						v353 = v382.id
						v352.key = "b:" .. tostring(v353)
						v354 = v382.name or v382.id
						v352.name = tostring(v354)
						v352.state = v350[1]
						v352.stateTone = v350[2]
						v355 = v_u_24.hx("text", v_u_9(v382.reason == "" and "no reason" or v382.reason))
						v356 = v_u_10
						v357 = v382.at
						v358 = v334 - (tonumber(v357) or v334)
						v352.sub = ("%s \194\183 %s \194\183 %s"):format(v355, v351, v356((math.max(0, v358))) .. " ago")
						v359 = v_u_24.selected
						v360 = v382.id
						v352.selected = v359 == "b:" .. tostring(v360)
						table.insert(v335, v352)
					end
					if type(v333) == "table" then
						v361 = v333.counts
						v362 = type(v361) ~= "table" and {} or v333.counts
					else
						v362 = {}
					end
					if type(v333) == "table" then
						v363 = v333.total
						if type(v363) == "number" then
							v364 = v333.total
							v365 = v362.waiting
							v366 = tonumber(v365) or 0
							if v_u_24.loadErr then
								v344 = v_u_24.loadErr
							elseif v333 == nil then
								v344 = "Loading"
							else
								v367 = v362.active
								v368 = tonumber(v367) or 0
								v369 = v362.perm
								v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
								if v_u_24.q ~= "" or v_u_24.status ~= "active" then
									v344 = ("%d found \194\183 "):format(v364) .. v344
								end
								if v366 > 0 then
									v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
								end
							end
							if v_u_24.loadErr then
								v345 = v_u_24.loadErr
							elseif v333 == nil then
								v345 = "Loading"
							elseif v_u_24.q == "" then
								v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
							else
								v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
							end
						else
							v364 = #v335
							v365 = v362.waiting
							v366 = tonumber(v365) or 0
							if v_u_24.loadErr then
								v344 = v_u_24.loadErr
							elseif v333 == nil then
								v344 = "Loading"
							else
								v367 = v362.active
								v368 = tonumber(v367) or 0
								v369 = v362.perm
								v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
								if v_u_24.q ~= "" or v_u_24.status ~= "active" then
									v344 = ("%d found \194\183 "):format(v364) .. v344
								end
								if v366 > 0 then
									v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
								end
							end
							if v_u_24.loadErr then
								v345 = v_u_24.loadErr
							elseif v333 == nil then
								v345 = "Loading"
							elseif v_u_24.q == "" then
								v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
							else
								v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
							end
						end
					else
						v364 = #v335
						v365 = v362.waiting
						v366 = tonumber(v365) or 0
						if v_u_24.loadErr then
							v344 = v_u_24.loadErr
						elseif v333 == nil then
							v344 = "Loading"
						else
							v367 = v362.active
							v368 = tonumber(v367) or 0
							v369 = v362.perm
							v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
							if v_u_24.q ~= "" or v_u_24.status ~= "active" then
								v344 = ("%d found \194\183 "):format(v364) .. v344
							end
							if v366 > 0 then
								v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
							end
						end
						if v_u_24.loadErr then
							v345 = v_u_24.loadErr
						elseif v333 == nil then
							v345 = "Loading"
						elseif v_u_24.q == "" then
							v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
						else
							v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
						end
					end
					v346 = v332.renderList
					v347 = {
						["view"] = v_u_24.view,
						["rows"] = v335,
						["empty"] = v345,
						["status"] = v344,
						["filter"] = v_u_24.status
					}
					if v_u_24.view == "bans" then
						v348 = v_u_24.next ~= nil
					else
						v348 = false
					end
					v347.more = v348
					v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
					v347.mass = v_u_21("unban_mass")
					v346(v347)
				end
			else
				v334 = v_u_12()
				v335 = {}
				if v_u_24.view == "requests" then
					for v379, v380 in ipairs(v_u_24.reqs) do
						if type(v380) ~= "table" then
							continue
						end
						v336 = v380.id
						if type(v336) ~= "string" then
							continue
						end
						v337 = v_u_24.STATE[v380.status] or v_u_24.STATE.pending
						v338 = v380.at
						if type(v338) == "number" then
							v339 = v_u_10
							v340 = v334 - v380.at
							v341 = v339((math.max(0, v340))) .. " ago"
						else
							v341 = ""
						end
						v342 = {
							["key"] = "r:" .. v380.id
						}
						v343 = v380.targetName or "?"
						v342.name = tostring(v343)
						v342.state = v337[1]
						v342.stateTone = v337[2]
						v342.sub = ("%s \194\183 asked by %s \194\183 %s"):format(v_u_24.hx("amber", v_u_24.lengthLabel(v380.hours)), v_u_9(v380.byName or "?"), v341)
						v342.selected = v_u_24.selected == "r:" .. v380.id
						table.insert(v335, v342)
					end
					v344 = v_u_24.reqErr or ("%d waiting \194\183 newest first"):format(v_u_24.pending)
					v345 = v_u_24.reqErr or "No ban requests in the last 7 days"
					v346 = v332.renderList
					v347 = {
						["view"] = v_u_24.view,
						["rows"] = v335,
						["empty"] = v345,
						["status"] = v344,
						["filter"] = v_u_24.status
					}
					if v_u_24.view == "bans" then
						v348 = v_u_24.next ~= nil
					else
						v348 = false
					end
					v347.more = v348
					v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
					v347.mass = v_u_21("unban_mass")
					v346(v347)
				else
					for v381, v382 in ipairs(v_u_24.rows) do
						if type(v382) ~= "table" then
							continue
						end
						v349 = v382.id
						if type(v349) ~= "number" then
							continue
						end
						v350 = v_u_24.tapeFor(v382, v334)
						if v382.state == "lifted" then
							v351 = "lifted by " .. v_u_9(v382.liftedBy or "?")
						else
							v351 = "by " .. v_u_9(v382.by or "?")
						end
						v352 = {}
						v353 = v382.id
						v352.key = "b:" .. tostring(v353)
						v354 = v382.name or v382.id
						v352.name = tostring(v354)
						v352.state = v350[1]
						v352.stateTone = v350[2]
						v355 = v_u_24.hx("text", v_u_9(v382.reason == "" and "no reason" or v382.reason))
						v356 = v_u_10
						v357 = v382.at
						v358 = v334 - (tonumber(v357) or v334)
						v352.sub = ("%s \194\183 %s \194\183 %s"):format(v355, v351, v356((math.max(0, v358))) .. " ago")
						v359 = v_u_24.selected
						v360 = v382.id
						v352.selected = v359 == "b:" .. tostring(v360)
						table.insert(v335, v352)
					end
					if type(v333) == "table" then
						v361 = v333.counts
						v362 = type(v361) ~= "table" and {} or v333.counts
					else
						v362 = {}
					end
					if type(v333) == "table" then
						v363 = v333.total
						if type(v363) == "number" then
							v364 = v333.total
							v365 = v362.waiting
							v366 = tonumber(v365) or 0
							if v_u_24.loadErr then
								v344 = v_u_24.loadErr
							elseif v333 == nil then
								v344 = "Loading"
							else
								v367 = v362.active
								v368 = tonumber(v367) or 0
								v369 = v362.perm
								v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
								if v_u_24.q ~= "" or v_u_24.status ~= "active" then
									v344 = ("%d found \194\183 "):format(v364) .. v344
								end
								if v366 > 0 then
									v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
								end
							end
							if v_u_24.loadErr then
								v345 = v_u_24.loadErr
							elseif v333 == nil then
								v345 = "Loading"
							elseif v_u_24.q == "" then
								v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
							else
								v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
							end
						else
							v364 = #v335
							v365 = v362.waiting
							v366 = tonumber(v365) or 0
							if v_u_24.loadErr then
								v344 = v_u_24.loadErr
							elseif v333 == nil then
								v344 = "Loading"
							else
								v367 = v362.active
								v368 = tonumber(v367) or 0
								v369 = v362.perm
								v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
								if v_u_24.q ~= "" or v_u_24.status ~= "active" then
									v344 = ("%d found \194\183 "):format(v364) .. v344
								end
								if v366 > 0 then
									v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
								end
							end
							if v_u_24.loadErr then
								v345 = v_u_24.loadErr
							elseif v333 == nil then
								v345 = "Loading"
							elseif v_u_24.q == "" then
								v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
							else
								v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
							end
						end
					else
						v364 = #v335
						v365 = v362.waiting
						v366 = tonumber(v365) or 0
						if v_u_24.loadErr then
							v344 = v_u_24.loadErr
						elseif v333 == nil then
							v344 = "Loading"
						else
							v367 = v362.active
							v368 = tonumber(v367) or 0
							v369 = v362.perm
							v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
							if v_u_24.q ~= "" or v_u_24.status ~= "active" then
								v344 = ("%d found \194\183 "):format(v364) .. v344
							end
							if v366 > 0 then
								v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
							end
						end
						if v_u_24.loadErr then
							v345 = v_u_24.loadErr
						elseif v333 == nil then
							v345 = "Loading"
						elseif v_u_24.q == "" then
							v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
						else
							v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
						end
					end
					v346 = v332.renderList
					v347 = {
						["view"] = v_u_24.view,
						["rows"] = v335,
						["empty"] = v345,
						["status"] = v344,
						["filter"] = v_u_24.status
					}
					if v_u_24.view == "bans" then
						v348 = v_u_24.next ~= nil
					else
						v348 = false
					end
					v347.more = v348
					v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
					v347.mass = v_u_21("unban_mass")
					v346(v347)
				end
			end
		else
			v334 = v_u_12()
			v335 = {}
			if v_u_24.view == "requests" then
				for v379, v380 in ipairs(v_u_24.reqs) do
					if type(v380) ~= "table" then
						continue
					end
					v336 = v380.id
					if type(v336) ~= "string" then
						continue
					end
					v337 = v_u_24.STATE[v380.status] or v_u_24.STATE.pending
					v338 = v380.at
					if type(v338) == "number" then
						v339 = v_u_10
						v340 = v334 - v380.at
						v341 = v339((math.max(0, v340))) .. " ago"
					else
						v341 = ""
					end
					v342 = {
						["key"] = "r:" .. v380.id
					}
					v343 = v380.targetName or "?"
					v342.name = tostring(v343)
					v342.state = v337[1]
					v342.stateTone = v337[2]
					v342.sub = ("%s \194\183 asked by %s \194\183 %s"):format(v_u_24.hx("amber", v_u_24.lengthLabel(v380.hours)), v_u_9(v380.byName or "?"), v341)
					v342.selected = v_u_24.selected == "r:" .. v380.id
					table.insert(v335, v342)
				end
				v344 = v_u_24.reqErr or ("%d waiting \194\183 newest first"):format(v_u_24.pending)
				v345 = v_u_24.reqErr or "No ban requests in the last 7 days"
				v346 = v332.renderList
				v347 = {
					["view"] = v_u_24.view,
					["rows"] = v335,
					["empty"] = v345,
					["status"] = v344,
					["filter"] = v_u_24.status
				}
				if v_u_24.view == "bans" then
					v348 = v_u_24.next ~= nil
				else
					v348 = false
				end
				v347.more = v348
				v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
				v347.mass = v_u_21("unban_mass")
				v346(v347)
			else
				for v381, v382 in ipairs(v_u_24.rows) do
					if type(v382) ~= "table" then
						continue
					end
					v349 = v382.id
					if type(v349) ~= "number" then
						continue
					end
					v350 = v_u_24.tapeFor(v382, v334)
					if v382.state == "lifted" then
						v351 = "lifted by " .. v_u_9(v382.liftedBy or "?")
					else
						v351 = "by " .. v_u_9(v382.by or "?")
					end
					v352 = {}
					v353 = v382.id
					v352.key = "b:" .. tostring(v353)
					v354 = v382.name or v382.id
					v352.name = tostring(v354)
					v352.state = v350[1]
					v352.stateTone = v350[2]
					v355 = v_u_24.hx("text", v_u_9(v382.reason == "" and "no reason" or v382.reason))
					v356 = v_u_10
					v357 = v382.at
					v358 = v334 - (tonumber(v357) or v334)
					v352.sub = ("%s \194\183 %s \194\183 %s"):format(v355, v351, v356((math.max(0, v358))) .. " ago")
					v359 = v_u_24.selected
					v360 = v382.id
					v352.selected = v359 == "b:" .. tostring(v360)
					table.insert(v335, v352)
				end
				if type(v333) == "table" then
					v361 = v333.counts
					v362 = type(v361) ~= "table" and {} or v333.counts
				else
					v362 = {}
				end
				if type(v333) == "table" then
					v363 = v333.total
					if type(v363) == "number" then
						v364 = v333.total
						v365 = v362.waiting
						v366 = tonumber(v365) or 0
						if v_u_24.loadErr then
							v344 = v_u_24.loadErr
						elseif v333 == nil then
							v344 = "Loading"
						else
							v367 = v362.active
							v368 = tonumber(v367) or 0
							v369 = v362.perm
							v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
							if v_u_24.q ~= "" or v_u_24.status ~= "active" then
								v344 = ("%d found \194\183 "):format(v364) .. v344
							end
							if v366 > 0 then
								v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
							end
						end
						if v_u_24.loadErr then
							v345 = v_u_24.loadErr
						elseif v333 == nil then
							v345 = "Loading"
						elseif v_u_24.q == "" then
							v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
						else
							v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
						end
					else
						v364 = #v335
						v365 = v362.waiting
						v366 = tonumber(v365) or 0
						if v_u_24.loadErr then
							v344 = v_u_24.loadErr
						elseif v333 == nil then
							v344 = "Loading"
						else
							v367 = v362.active
							v368 = tonumber(v367) or 0
							v369 = v362.perm
							v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
							if v_u_24.q ~= "" or v_u_24.status ~= "active" then
								v344 = ("%d found \194\183 "):format(v364) .. v344
							end
							if v366 > 0 then
								v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
							end
						end
						if v_u_24.loadErr then
							v345 = v_u_24.loadErr
						elseif v333 == nil then
							v345 = "Loading"
						elseif v_u_24.q == "" then
							v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
						else
							v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
						end
					end
				else
					v364 = #v335
					v365 = v362.waiting
					v366 = tonumber(v365) or 0
					if v_u_24.loadErr then
						v344 = v_u_24.loadErr
					elseif v333 == nil then
						v344 = "Loading"
					else
						v367 = v362.active
						v368 = tonumber(v367) or 0
						v369 = v362.perm
						v344 = ("%d active \194\183 %d permanent"):format(v368, tonumber(v369) or 0)
						if v_u_24.q ~= "" or v_u_24.status ~= "active" then
							v344 = ("%d found \194\183 "):format(v364) .. v344
						end
						if v366 > 0 then
							v344 = v344 .. " \194\183 " .. v_u_24.hx("amber", ("%d not on Roblox yet"):format(v366))
						end
					end
					if v_u_24.loadErr then
						v345 = v_u_24.loadErr
					elseif v333 == nil then
						v345 = "Loading"
					elseif v_u_24.q == "" then
						v345 = v_u_24.EMPTY[v_u_24.status] or "No bans"
					else
						v345 = ("Nothing matches \"%s\". Try the Ended or All filter, or Look up for older bans"):format(v_u_24.q)
					end
				end
				v346 = v332.renderList
				v347 = {
					["view"] = v_u_24.view,
					["rows"] = v335,
					["empty"] = v345,
					["status"] = v344,
					["filter"] = v_u_24.status
				}
				if v_u_24.view == "bans" then
					v348 = v_u_24.next ~= nil
				else
					v348 = false
				end
				v347.more = v348
				v347.requests = not v_u_21("ban") and "" or (v_u_24.pending <= 0 and "Requests" or ("Requests (%d)"):format(v_u_24.pending))
				v347.mass = v_u_21("unban_mass")
				v346(v347)
			end
		end
	end
	function v_u_24.banBody(p383, p384, p385) -- name: banBody
		-- upvalues: (copy) v_u_24, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11
		local v386 = {}
		local v387 = v_u_24.hx("amber", "Reason")
		table.insert(v386, v387)
		local v388 = v_u_9(p383.reason == "" and "No reason given" or p383.reason)
		table.insert(v386, v388)
		local v389 = p383.pub
		if type(v389) == "string" and (p383.pub ~= "" and p383.pub ~= p383.reason) then
			table.insert(v386, "")
			local v390 = v_u_24.hx("amber", "Shown to them")
			table.insert(v386, v390)
			local v391 = v_u_9(p383.pub)
			table.insert(v386, v391)
		end
		table.insert(v386, "")
		local v392 = p383.untilTime
		if type(v392) == "number" and p383.untilTime > 0 then
			local v393 = v_u_10
			local v394 = p383.untilTime
			local v395 = p383.at
			local v396 = ("Length: %s, until %s (%s)"):format(v393(v394 - (tonumber(v395) or p385)), v_u_11(p383.untilTime), p383.state == "lifted" and "lifted early" or v_u_24.leftText(p383, p385))
			table.insert(v386, v396)
		else
			table.insert(v386, "Length: permanent")
		end
		local v397 = v_u_9(p383.by or "?")
		local v398 = v_u_11(p383.at)
		local v399 = v_u_10
		local v400 = p383.at
		local v401 = p385 - (tonumber(v400) or p385)
		local v402 = ("Banned by %s, %s (%s ago)"):format(v397, v398, v399((math.max(0, v401))))
		table.insert(v386, v402)
		local v403 = "Kind: " .. (v_u_24.KIND[p383.kind] or "Staff ban")
		table.insert(v386, v403)
		if p383.state == "lifted" then
			local v404 = ("Lifted by %s, %s"):format(v_u_9(p383.liftedBy or "?"), v_u_11(p383.liftedAt))
			table.insert(v386, v404)
		end
		if p383.state == "perm" or p383.state == "timed" then
			local v405
			if p383.rb == "on" then
				v405 = p383.alts and "on, their alt accounts are banned too" or "on, alt accounts not included"
				if p383.device then
					v405 = v405 .. ". Their device is blocked for the first 24 hours"
				end
			elseif p383.rb == "studio" then
				v405 = "tested in Studio only, live servers will place it when they next see this ban"
			elseif p383.rb == "failed" then
				v405 = "failed, the server keeps trying"
			else
				local v406 = p383.id
				v405 = type(v406) == "number" and p383.id < 1 and "not used for Studio test players" or "not placed yet, the servers move it over in the background"
			end
			local v407 = "Roblox ban: " .. v405
			table.insert(v386, v407)
		end
		if type(p384) == "table" then
			local v408 = {}
			local v409 = p384.replay
			if type(v409) == "string" then
				local v410 = "Replay " .. v_u_9(p384.replay)
				table.insert(v408, v410)
			end
			local v411 = p384.clip
			if type(v411) == "string" then
				local v412 = "Clip " .. v_u_9(p384.clip)
				table.insert(v408, v412)
			end
			local v413 = p384.reports
			if type(v413) == "table" and #p384.reports > 0 then
				local v414 = "Reports " .. v_u_9(table.concat(p384.reports, ", "))
				table.insert(v408, v414)
			end
			if #v408 > 0 then
				table.insert(v386, "")
				local v415 = v_u_24.hx("amber", "Proof")
				table.insert(v386, v415)
				for _, v416 in ipairs(v408) do
					table.insert(v386, v416)
				end
			end
			local v417 = p384.lines
			if type(v417) == "table" and #p384.lines > 0 then
				table.insert(v386, "")
				local v418 = v_u_24.hx("amber", "Evidence at the time")
				table.insert(v386, v418)
				for _, v419 in ipairs(p384.lines) do
					local v420 = v_u_9(v419)
					table.insert(v386, v420)
				end
			end
		elseif p384 == false then
			table.insert(v386, "")
			local v421 = v_u_24.hx("muted", "Loading the proof")
			table.insert(v386, v421)
		end
		return table.concat(v386, "\n")
	end
	function v_u_24.renderDetail() -- name: renderDetail
		-- upvalues: (copy) v_u_24, (copy) v_u_12, (copy) v_u_23, (copy) v_u_21, (copy) v_u_9, (copy) v_u_11
		local v422 = v_u_24.page
		if not (v422 and v422.alive()) then
			return
		end
		local v423 = v_u_24.data
		local v424, v425, v426, v427, v428, v429, v430, v431, v432, v433, v434, v435, v436, v437, v438, v439, v440, v441, v442, v443, v444, v445, v446, v447, v448, v449, v450, v451, v452, v453, v454, v455, v456, v457, v458, v459, v460, v461, v462, v463, v464, v465
		if type(v423) == "table" then
			local v466 = v423.now
			if type(v466) == "number" then
				v424 = v423.now
				v425 = {
					["text"] = "",
					["on"] = false,
					["visible"] = false
				}
				v426 = v_u_24.request(v_u_24.selected)
				if v_u_24.view == "requests" and v426 then
					v427 = v_u_24.STATE[v426.status] or v_u_24.STATE.pending
					v428 = v426.status == "pending"
					v429 = v_u_23.banCap()
					if v429 == nil then
						v430 = false
					else
						v431 = v426.hours
						v430 = type(v431) ~= "number" and true or (v426.hours <= 0 and not v_u_21("ban_perm") or v429 < v426.hours)
					end
					v432 = {
						v_u_24.hx("amber", "Reason"),
						v_u_9(v426.reason == "" and "No reason given" or v426.reason),
						"",
						"Length asked for: " .. string.lower(v_u_24.lengthLabel(v426.hours)),
						("Asked by %s, %s"):format(v_u_9(v426.byName or "?"), v_u_11(v426.at))
					}
					if v428 then
						if v430 then
							table.insert(v432, "")
							v433 = v_u_24.hx
							table.insert(v432, v433("amber", "That ban is longer than you can give. An admin has to decide it."))
						end
					else
						v434 = v426.status == "approved" and "Approved" or "Denied"
						v435 = v_u_9(v426.decidedByName or "?")
						v436 = v_u_11
						v437 = v426.decidedAt
						table.insert(v432, ("%s by %s, %s"):format(v434, v435, v436(v437)))
					end
					v438 = v422.renderDetail
					v439 = {
						["name"] = nil,
						["sub"] = nil,
						["state"] = nil,
						["stateTone"] = nil,
						["roblox"] = nil,
						["robloxTone"] = "hover",
						["body"] = nil,
						["watch"] = nil,
						["actions"] = nil
					}
					v440 = v426.targetName or "?"
					v439.name = tostring(v440)
					v441 = v426.target
					v439.sub = ("id %s"):format((tostring(v441)))
					v439.state = v427[1]
					v439.stateTone = v427[2]
					v439.body = table.concat(v432, "\n")
					v439.watch = v425
					v442 = {}
					v443 = {
						["text"] = "Approve ban",
						["on"] = nil,
						["visible"] = nil
					}
					if v428 then
						v444 = not v430
					else
						v444 = v428
					end
					v443.on = v444
					v443.visible = v428
					v442.approve = v443
					v445 = {
						["text"] = "Deny",
						["on"] = nil,
						["visible"] = nil,
						["confirm"] = "Deny it?"
					}
					if v428 then
						v446 = not v430
					else
						v446 = v428
					end
					v445.on = v446
					v445.visible = v428
					v442.deny = v445
					v442.lookup = {
						["text"] = "Look up",
						["on"] = true,
						["visible"] = v_u_21("flags")
					}
					v439.actions = v442
					v438(v439)
					return
				else
					v447 = v_u_24.ban(v_u_24.selected)
					if v_u_24.view == "bans" and v447 then
						v448 = v_u_24.info[v_u_24.selected]
						v449 = v_u_24.tapeFor(v447, v424)
						v450, v451 = v_u_24.robloxTape(v447)
						v452 = v447.state == "perm" and true or v447.state == "timed"
						v453 = v422.renderDetail
						v454 = {}
						v455 = v447.name or v447.id
						v454.name = tostring(v455)
						v456 = v_u_9(v447.name or "?")
						v457 = v447.id
						v454.sub = ("@%s \194\183 id %s"):format(v456, (tostring(v457)))
						v454.state = v449[1]
						v454.stateTone = v449[2]
						v454.roblox = v450
						v454.robloxTone = v451
						v458 = v_u_24.banBody
						if v448 == nil then
							v459 = false
						else
							v459 = v448
						end
						v454.body = v458(v447, v459, v424)
						v460 = {
							["text"] = "Watch replay",
							["on"] = true,
							["visible"] = nil
						}
						if type(v448) == "table" then
							v461 = v448.replay
							v462 = type(v461) == "string"
						else
							v462 = false
						end
						v460.visible = v462
						v454.watch = v460
						v463 = {}
						v464 = {
							["text"] = nil,
							["on"] = nil,
							["visible"] = nil,
							["confirm"] = "Unban them?",
							["text"] = v447.liftable and "Unban" or "Admin only"
						}
						if v452 then
							v465 = v447.liftable == true
						else
							v465 = v452
						end
						v464.on = v465
						v464.visible = v452
						v463.unban = v464
						v463.lookup = {
							["text"] = "Look up",
							["on"] = true,
							["visible"] = v_u_21("flags")
						}
						v463.again = {
							["text"] = "Ban again",
							["on"] = true,
							["visible"] = not v452
						}
						v454.actions = v463
						v453(v454)
					else
						v422.renderDetail({
							["none"] = nil,
							["name"] = "",
							["sub"] = "",
							["state"] = "",
							["stateTone"] = "hover",
							["robloxTone"] = "hover",
							["body"] = "",
							["watch"] = nil,
							["actions"] = nil,
							["none"] = v_u_24.view == "requests" and "Pick a request on the left" or "Pick a ban on the left",
							["watch"] = v425,
							["actions"] = {}
						})
					end
				end
			else
				v424 = v_u_12()
				v425 = {
					["text"] = "",
					["on"] = false,
					["visible"] = false
				}
				v426 = v_u_24.request(v_u_24.selected)
				if v_u_24.view == "requests" and v426 then
					v427 = v_u_24.STATE[v426.status] or v_u_24.STATE.pending
					v428 = v426.status == "pending"
					v429 = v_u_23.banCap()
					if v429 == nil then
						v430 = false
					else
						v431 = v426.hours
						v430 = type(v431) ~= "number" and true or (v426.hours <= 0 and not v_u_21("ban_perm") or v429 < v426.hours)
					end
					v432 = {
						v_u_24.hx("amber", "Reason"),
						v_u_9(v426.reason == "" and "No reason given" or v426.reason),
						"",
						"Length asked for: " .. string.lower(v_u_24.lengthLabel(v426.hours)),
						("Asked by %s, %s"):format(v_u_9(v426.byName or "?"), v_u_11(v426.at))
					}
					if v428 then
						if v430 then
							table.insert(v432, "")
							v433 = v_u_24.hx
							table.insert(v432, v433("amber", "That ban is longer than you can give. An admin has to decide it."))
						end
					else
						v434 = v426.status == "approved" and "Approved" or "Denied"
						v435 = v_u_9(v426.decidedByName or "?")
						v436 = v_u_11
						v437 = v426.decidedAt
						table.insert(v432, ("%s by %s, %s"):format(v434, v435, v436(v437)))
					end
					v438 = v422.renderDetail
					v439 = {
						["name"] = nil,
						["sub"] = nil,
						["state"] = nil,
						["stateTone"] = nil,
						["roblox"] = nil,
						["robloxTone"] = "hover",
						["body"] = nil,
						["watch"] = nil,
						["actions"] = nil
					}
					v440 = v426.targetName or "?"
					v439.name = tostring(v440)
					v441 = v426.target
					v439.sub = ("id %s"):format((tostring(v441)))
					v439.state = v427[1]
					v439.stateTone = v427[2]
					v439.body = table.concat(v432, "\n")
					v439.watch = v425
					v442 = {}
					v443 = {
						["text"] = "Approve ban",
						["on"] = nil,
						["visible"] = nil
					}
					if v428 then
						v444 = not v430
					else
						v444 = v428
					end
					v443.on = v444
					v443.visible = v428
					v442.approve = v443
					v445 = {
						["text"] = "Deny",
						["on"] = nil,
						["visible"] = nil,
						["confirm"] = "Deny it?"
					}
					if v428 then
						v446 = not v430
					else
						v446 = v428
					end
					v445.on = v446
					v445.visible = v428
					v442.deny = v445
					v442.lookup = {
						["text"] = "Look up",
						["on"] = true,
						["visible"] = v_u_21("flags")
					}
					v439.actions = v442
					v438(v439)
					return
				else
					v447 = v_u_24.ban(v_u_24.selected)
					if v_u_24.view == "bans" and v447 then
						v448 = v_u_24.info[v_u_24.selected]
						v449 = v_u_24.tapeFor(v447, v424)
						v450, v451 = v_u_24.robloxTape(v447)
						v452 = v447.state == "perm" and true or v447.state == "timed"
						v453 = v422.renderDetail
						v454 = {}
						v455 = v447.name or v447.id
						v454.name = tostring(v455)
						v456 = v_u_9(v447.name or "?")
						v457 = v447.id
						v454.sub = ("@%s \194\183 id %s"):format(v456, (tostring(v457)))
						v454.state = v449[1]
						v454.stateTone = v449[2]
						v454.roblox = v450
						v454.robloxTone = v451
						v458 = v_u_24.banBody
						if v448 == nil then
							v459 = false
						else
							v459 = v448
						end
						v454.body = v458(v447, v459, v424)
						v460 = {
							["text"] = "Watch replay",
							["on"] = true,
							["visible"] = nil
						}
						if type(v448) == "table" then
							v461 = v448.replay
							v462 = type(v461) == "string"
						else
							v462 = false
						end
						v460.visible = v462
						v454.watch = v460
						v463 = {}
						v464 = {
							["text"] = nil,
							["on"] = nil,
							["visible"] = nil,
							["confirm"] = "Unban them?",
							["text"] = v447.liftable and "Unban" or "Admin only"
						}
						if v452 then
							v465 = v447.liftable == true
						else
							v465 = v452
						end
						v464.on = v465
						v464.visible = v452
						v463.unban = v464
						v463.lookup = {
							["text"] = "Look up",
							["on"] = true,
							["visible"] = v_u_21("flags")
						}
						v463.again = {
							["text"] = "Ban again",
							["on"] = true,
							["visible"] = not v452
						}
						v454.actions = v463
						v453(v454)
					else
						v422.renderDetail({
							["none"] = nil,
							["name"] = "",
							["sub"] = "",
							["state"] = "",
							["stateTone"] = "hover",
							["robloxTone"] = "hover",
							["body"] = "",
							["watch"] = nil,
							["actions"] = nil,
							["none"] = v_u_24.view == "requests" and "Pick a request on the left" or "Pick a ban on the left",
							["watch"] = v425,
							["actions"] = {}
						})
					end
				end
			end
		else
			v424 = v_u_12()
			v425 = {
				["text"] = "",
				["on"] = false,
				["visible"] = false
			}
			v426 = v_u_24.request(v_u_24.selected)
			if v_u_24.view == "requests" and v426 then
				v427 = v_u_24.STATE[v426.status] or v_u_24.STATE.pending
				v428 = v426.status == "pending"
				v429 = v_u_23.banCap()
				if v429 == nil then
					v430 = false
				else
					v431 = v426.hours
					v430 = type(v431) ~= "number" and true or (v426.hours <= 0 and not v_u_21("ban_perm") or v429 < v426.hours)
				end
				v432 = {
					v_u_24.hx("amber", "Reason"),
					v_u_9(v426.reason == "" and "No reason given" or v426.reason),
					"",
					"Length asked for: " .. string.lower(v_u_24.lengthLabel(v426.hours)),
					("Asked by %s, %s"):format(v_u_9(v426.byName or "?"), v_u_11(v426.at))
				}
				if v428 then
					if v430 then
						table.insert(v432, "")
						v433 = v_u_24.hx
						table.insert(v432, v433("amber", "That ban is longer than you can give. An admin has to decide it."))
					end
				else
					v434 = v426.status == "approved" and "Approved" or "Denied"
					v435 = v_u_9(v426.decidedByName or "?")
					v436 = v_u_11
					v437 = v426.decidedAt
					table.insert(v432, ("%s by %s, %s"):format(v434, v435, v436(v437)))
				end
				v438 = v422.renderDetail
				v439 = {
					["name"] = nil,
					["sub"] = nil,
					["state"] = nil,
					["stateTone"] = nil,
					["roblox"] = nil,
					["robloxTone"] = "hover",
					["body"] = nil,
					["watch"] = nil,
					["actions"] = nil
				}
				v440 = v426.targetName or "?"
				v439.name = tostring(v440)
				v441 = v426.target
				v439.sub = ("id %s"):format((tostring(v441)))
				v439.state = v427[1]
				v439.stateTone = v427[2]
				v439.body = table.concat(v432, "\n")
				v439.watch = v425
				v442 = {}
				v443 = {
					["text"] = "Approve ban",
					["on"] = nil,
					["visible"] = nil
				}
				if v428 then
					v444 = not v430
				else
					v444 = v428
				end
				v443.on = v444
				v443.visible = v428
				v442.approve = v443
				v445 = {
					["text"] = "Deny",
					["on"] = nil,
					["visible"] = nil,
					["confirm"] = "Deny it?"
				}
				if v428 then
					v446 = not v430
				else
					v446 = v428
				end
				v445.on = v446
				v445.visible = v428
				v442.deny = v445
				v442.lookup = {
					["text"] = "Look up",
					["on"] = true,
					["visible"] = v_u_21("flags")
				}
				v439.actions = v442
				v438(v439)
				return
			else
				v447 = v_u_24.ban(v_u_24.selected)
				if v_u_24.view == "bans" and v447 then
					v448 = v_u_24.info[v_u_24.selected]
					v449 = v_u_24.tapeFor(v447, v424)
					v450, v451 = v_u_24.robloxTape(v447)
					v452 = v447.state == "perm" and true or v447.state == "timed"
					v453 = v422.renderDetail
					v454 = {}
					v455 = v447.name or v447.id
					v454.name = tostring(v455)
					v456 = v_u_9(v447.name or "?")
					v457 = v447.id
					v454.sub = ("@%s \194\183 id %s"):format(v456, (tostring(v457)))
					v454.state = v449[1]
					v454.stateTone = v449[2]
					v454.roblox = v450
					v454.robloxTone = v451
					v458 = v_u_24.banBody
					if v448 == nil then
						v459 = false
					else
						v459 = v448
					end
					v454.body = v458(v447, v459, v424)
					v460 = {
						["text"] = "Watch replay",
						["on"] = true,
						["visible"] = nil
					}
					if type(v448) == "table" then
						v461 = v448.replay
						v462 = type(v461) == "string"
					else
						v462 = false
					end
					v460.visible = v462
					v454.watch = v460
					v463 = {}
					v464 = {
						["text"] = nil,
						["on"] = nil,
						["visible"] = nil,
						["confirm"] = "Unban them?",
						["text"] = v447.liftable and "Unban" or "Admin only"
					}
					if v452 then
						v465 = v447.liftable == true
					else
						v465 = v452
					end
					v464.on = v465
					v464.visible = v452
					v463.unban = v464
					v463.lookup = {
						["text"] = "Look up",
						["on"] = true,
						["visible"] = v_u_21("flags")
					}
					v463.again = {
						["text"] = "Ban again",
						["on"] = true,
						["visible"] = not v452
					}
					v454.actions = v463
					v453(v454)
				else
					v422.renderDetail({
						["none"] = nil,
						["name"] = "",
						["sub"] = "",
						["state"] = "",
						["stateTone"] = "hover",
						["robloxTone"] = "hover",
						["body"] = "",
						["watch"] = nil,
						["actions"] = nil,
						["none"] = v_u_24.view == "requests" and "Pick a request on the left" or "Pick a ban on the left",
						["watch"] = v425,
						["actions"] = {}
					})
				end
			end
		end
	end
	function v_u_24.render() -- name: render
		-- upvalues: (copy) v_u_24
		v_u_24.renderList()
		v_u_24.renderDetail()
	end
	function v_u_24.select(p467) -- name: select
		-- upvalues: (copy) v_u_24, (copy) v_u_6
		v_u_24.selected = p467
		local v468 = v_u_24.ban(p467)
		local v469 = v_u_24.request(p467)
		if v468 then
			v_u_6.pick(v468.id, "bans", v468.name)
			if v_u_24.info[p467] == nil then
				task.spawn(v_u_24.fetchInfo, p467, v468.id)
			end
		elseif v469 then
			v_u_6.pick(v469.target, "bans", v469.targetName)
		end
		v_u_24.render()
	end
	function v_u_24.fetchInfo(p470, p471) -- name: fetchInfo
		-- upvalues: (copy) v_u_16, (copy) v_u_24
		local v472, v473 = v_u_16.call("ban_get", {
			["userId"] = p471
		})
		local v474 = v_u_24.info
		if not v472 or type(v473) ~= "table" then
			v473 = {
				["lines"] = {}
			}
		end
		v474[p470] = v473
		if v_u_24.selected == p470 then
			v_u_24.renderDetail()
		end
	end
	function v_u_24.find(p475) -- name: find
		-- upvalues: (copy) v_u_16, (copy) v_u_17, (copy) v_u_24, (copy) v_u_6
		local v476, v477 = v_u_16.call("ban_find", {
			["name"] = p475
		})
		if v476 and type(v477) == "table" then
			local v478 = v477.userId
			if type(v478) == "number" then
				if v477.owner then
					v_u_17.push("Owners can\'t be banned", "bad")
					return
				elseif v477.banned then
					local v479 = v_u_17.push
					local v480 = v477.name
					v479(tostring(v480) .. " is already banned", "warn")
					local v481 = v_u_24
					local v482 = v_u_24
					local v483 = v_u_24
					local v484 = v477.userId
					local v485 = tostring(v484)
					v481.view = "bans"
					v482.status = "all"
					v483.q = v485
					if v_u_24.page then
						v_u_24.page.setSearch(v_u_24.q)
					end
					task.spawn(v_u_24.load)
				else
					local v486 = v_u_6.openBan
					local v487 = v477.userId
					local v488 = v477.name
					if v486(v487, tostring(v488), nil, v477.here == true) then
						if v_u_24.page then
							v_u_24.page.clearFind()
							return
						end
					else
						v_u_17.push("The ban sheet isn\'t ready yet, try again in a moment", "bad")
					end
				end
			end
		end
		v_u_17.push(type(v477) ~= "string" and "Couldn\'t find that player" or v477, "bad")
	end
	function v_u_24.lookup(p489, p490) -- name: lookup
		-- upvalues: (copy) v_u_19, (copy) v_u_20
		v_u_19.selectTab("lookup")
		v_u_20.setQuery(p490)
		task.spawn(v_u_20.search, tostring(p489), true)
	end
	function v_u_24.action(p491) -- name: action
		-- upvalues: (copy) v_u_24, (copy) v_u_20, (copy) v_u_16, (copy) v_u_6, (copy) v_u_22, (copy) v_u_17
		local v492 = v_u_24.request(v_u_24.selected)
		if v_u_24.view == "requests" and v492 then
			if p491 == "approve" then
				local v493 = v_u_20.confirmBan
				local v494 = {
					["op"] = "ban_request_decide",
					["args"] = nil,
					["userId"] = nil,
					["name"] = nil,
					["hours"] = nil,
					["reason"] = nil,
					["okText"] = nil,
					["onDone"] = nil,
					["onFail"] = nil,
					["args"] = {
						["id"] = nil,
						["approve"] = true,
						["id"] = v492.id
					}
				}
				local v495 = v492.target
				local v496
				if type(v495) == "number" then
					v496 = v492.target
				else
					v496 = nil
				end
				v494.userId = v496
				local v497 = v492.targetName or "?"
				v494.name = tostring(v497)
				v494.hours = v492.hours
				local v498 = v492.reason
				v494.reason = type(v498) ~= "string" and "" or v492.reason
				local v499 = v492.targetName
				v494.okText = "Banned " .. tostring(v499)
				v494.onDone = v_u_24.load
				v494.onFail = v_u_24.loadRequests
				v493(v494)
			elseif p491 == "deny" then
				if v_u_16.act("ban_request_decide", {
					["id"] = nil,
					["approve"] = false,
					["id"] = v492.id
				}, "Request denied") then
					v_u_24.loadRequests()
					return
				end
			elseif p491 == "lookup" then
				local v500 = v492.target
				if type(v500) == "number" then
					local v501 = v_u_24.lookup
					local v502 = v492.target
					local v503 = v492.targetName or v492.target
					v501(v502, (tostring(v503)))
				end
			end
		else
			local v504 = v_u_24.ban(v_u_24.selected)
			if v504 then
				if p491 == "unban" then
					local v505 = v_u_16.act
					local v506 = {
						["userId"] = v504.id
					}
					local v507 = v504.name or v504.id
					if v505("unban", v506, "Unbanned " .. tostring(v507)) then
						v_u_24.info[v_u_24.selected] = nil
						task.spawn(v_u_6.refresh)
						v_u_24.load()
						return
					end
				else
					if p491 == "lookup" then
						local v508 = v_u_24.lookup
						local v509 = v504.id
						local v510 = v504.name or v504.id
						v508(v509, (tostring(v510)))
						return
					end
					if p491 == "again" then
						local v511 = v_u_6.openBan
						local v512 = v504.id
						local v513 = v504.name or ""
						local v514 = tostring(v513)
						local v515 = v504.reason
						local v516
						if type(v515) == "string" then
							v516 = v504.reason
						else
							v516 = nil
						end
						if not v511(v512, v514, v516, v_u_22(v504.id) ~= nil) then
							v_u_17.push("The ban sheet isn\'t ready yet, try again in a moment", "bad")
						end
					end
				end
			end
		end
	end
	function v_u_24.copy() -- name: copy
		-- upvalues: (copy) v_u_24, (copy) v_u_6
		local v517 = v_u_24.ban(v_u_24.selected)
		local v518 = v_u_24.request(v_u_24.selected)
		local v519
		if v517 then
			local v520 = v517.name or ""
			v519 = tostring(v520)
		elseif v518 then
			local v521 = v518.targetName or ""
			v519 = tostring(v521)
		else
			v519 = nil
		end
		local v522
		if v517 then
			local v523 = v517.id
			v522 = tostring(v523)
		elseif v518 then
			local v524 = v518.target
			v522 = tostring(v524)
		else
			v522 = nil
		end
		if v519 and v522 then
			local v525 = {
				{ "Username", v519 },
				{ "User ID", v522 },
				{ "Both", ("%s (%s)"):format(v519, v522) }
			}
			local v526
			if v517 then
				v526 = v517.reason
			elseif v518 then
				v526 = v518.reason
			else
				v526 = nil
			end
			if type(v526) == "string" and v526 ~= "" then
				table.insert(v525, { "Reason", v526 })
			end
			local v527 = v_u_24.info[v_u_24.selected]
			if type(v527) == "table" then
				local v528 = v527.replay
				if type(v528) == "string" then
					local v529 = { "Replay", v527.replay }
					table.insert(v525, v529)
				end
			end
			v_u_6.copy("Copy " .. v519, v525)
		end
	end
	p1.BP = v_u_24
end
