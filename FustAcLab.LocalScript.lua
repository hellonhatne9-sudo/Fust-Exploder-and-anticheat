-- Path: StarterPlayer.StarterPlayerScripts.FustAcLab
-- Status: 100% Complete Original Source

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Fust = ReplicatedStorage:WaitForChild("Fust")

local THEME = {
	panel = Color3.fromHex("151816"),
	card = Color3.fromHex("1C201D"),
	slot = Color3.fromHex("0F1110"),
	button = Color3.fromHex("262A27"),
	rust = Color3.fromHex("C2502A"),
	patina = Color3.fromHex("3F8F84"),
	text = Color3.fromHex("ECE6DA"),
	muted = Color3.fromHex("A3A79F"),
	dim = Color3.fromHex("6E736C"),
	label = Color3.fromHex("8C918A"),
	amber = Color3.fromHex("D9A441"),
	bad = Color3.fromRGB(235, 96, 80),
	danger = Color3.fromHex("9E3527"),
	good = Color3.fromHex("6CC24A"),
	ice = Color3.fromHex("7FB8D9"),
	line = Color3.new(1, 1, 1),
}

local CONFIG = {
	MAX_LINES = 300,
	W = 560,
	H = 600,
	REFRESH = 3,
	CONFIRM = 3,
	TOGGLE_KEY = Enum.KeyCode.F10,
	KIND = {
		flag = { "FLAG", THEME.amber },
		kick = { "KICK", THEME.bad },
		ban = { "BAN", Color3.fromRGB(255, 70, 130) },
		alert = { "STAFF ALERT", THEME.ice },
		discord = { "DISCORD", Color3.fromHex("8A93F0") },
		log = { "LOG", THEME.dim },
		report = { "REPORT", THEME.patina },
		note = { "NOTE", THEME.dim },
	},
	FILTERS = {
		{ id = "all", label = "ALL" },
		{ id = "flag", label = "FLAGS", kinds = { flag = true } },
		{ id = "act", label = "KICK / BAN", kinds = { kick = true, ban = true } },
		{ id = "out", label = "ALERTS", kinds = { alert = true, discord = true, log = true } },
		{ id = "note", label = "NOTES", kinds = { note = true, report = true } },
	},
}

while Fust:GetAttribute("AcLab") ~= true do
	Fust:GetAttributeChangedSignal("AcLab"):Wait()
end

local Remotes = Fust:WaitForChild("Remotes")
local AcLabRemote = Remotes:WaitForChild("AcLab", 60)
local AcLabFeed = Remotes:WaitForChild("AcLabFeed", 60)

if not (AcLabRemote and AcLabFeed) then
	return
end

local function call(action: string, payload: any?)
	local ok, res = pcall(function()
		return AcLabRemote:InvokeServer(action, payload)
	end)
	if not ok or type(res) ~= "table" then
		return { ok = false, err = "No answer from the server" }
	end
	return res
end

local initData = call("get")
if initData.ok ~= true then
	return
end

local function make(className: string, props: { [string]: any }, children: { Instance }?)
	local inst = Instance.new(className)
	for k, v in pairs(props) do
		if k ~= "Parent" then
			inst[k] = v
		end
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	inst.Parent = props.Parent
	return inst
end

local function pad(top: number, right: number, bottom: number, left: number)
	return make("UIPadding", {
		PaddingTop = UDim.new(0, top),
		PaddingRight = UDim.new(0, right),
		PaddingBottom = UDim.new(0, bottom),
		PaddingLeft = UDim.new(0, left),
	})
end

local function label(props: { [string]: any })
	props.BackgroundTransparency = props.BackgroundTransparency or 1
	props.Font = props.Font or Enum.Font.Gotham
	props.TextSize = props.TextSize or 14
	props.TextColor3 = props.TextColor3 or THEME.text
	props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
	return make("TextLabel", props)
end

local function button(props: { [string]: any }, bgColor: Color3?)
	props.BackgroundColor3 = bgColor or THEME.button
	props.AutoButtonColor = true
	props.Font = props.Font or Enum.Font.GothamBold
	props.TextSize = props.TextSize or 13
	props.TextColor3 = props.TextColor3 or THEME.text
	props.BorderSizePixel = 0
	return make("TextButton", props, {
		make("UICorner", { CornerRadius = UDim.new(0, 6) }),
	})
end

local function chip(text: string, bgColor: Color3, parent: Instance, layoutOrder: number?)
	return label({
		Size = UDim2.fromOffset(0, 18),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 0,
		BackgroundColor3 = bgColor,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = THEME.slot,
		TextXAlignment = Enum.TextXAlignment.Center,
		Text = text,
		LayoutOrder = layoutOrder or 0,
		Parent = parent,
	})
end

local gui = make("ScreenGui", {
	Name = "FustAcLab",
	ResetOnSpawn = false,
	DisplayOrder = 60,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = LocalPlayer:WaitForChild("PlayerGui"),
})

local openBtn = button({
	Name = "Open",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -12, 0, 12),
	Size = UDim2.fromOffset(92, 30),
	Font = Enum.Font.Oswald,
	TextSize = 17,
	Text = "AC LAB",
	Parent = gui,
}, THEME.rust)

local panel = make("Frame", {
	Name = "Panel",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -12, 0, 50),
	Size = UDim2.fromOffset(CONFIG.W, CONFIG.H),
	BackgroundColor3 = THEME.panel,
	BorderSizePixel = 0,
	Active = true,
	Parent = gui,
}, {
	make("UICorner", { CornerRadius = UDim.new(0, 10) }),
	make("UIStroke", {
		Color = THEME.line,
		Transparency = 0.9,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}),
})

local uiScale = make("UIScale", { Parent = panel })

local head = make("Frame", {
	Name = "Head",
	Size = UDim2.new(1, 0, 0, 58),
	BackgroundTransparency = 1,
	Parent = panel,
}, { pad(12, 14, 0, 16) })

make("Frame", {
	Position = UDim2.fromOffset(0, 4),
	Size = UDim2.fromOffset(4, 22),
	BackgroundColor3 = THEME.rust,
	BorderSizePixel = 0,
	Parent = head,
})

label({
	Position = UDim2.fromOffset(12, 0),
	Size = UDim2.fromOffset(84, 30),
	Font = Enum.Font.Oswald,
	TextSize = 26,
	Text = "AC LAB",
	Parent = head,
})

chip(" PRACTICE MODE ", THEME.patina, head).Position = UDim2.fromOffset(98, 6)

label({
	Position = UDim2.fromOffset(12, 30),
	Size = UDim2.new(1, -170, 0, 16),
	TextSize = 12,
	TextColor3 = THEME.muted,
	Text = "Nothing here is saved, posted or banned for real.",
	TextTruncate = Enum.TextTruncate.AtEnd,
	Parent = head,
})

local watchBtn = button({
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -42, 0, 2),
	Size = UDim2.fromOffset(112, 30),
	Text = "WATCH: ON",
	Parent = head,
}, THEME.patina)

local closeBtn = button({
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 2),
	Size = UDim2.fromOffset(32, 30),
	TextSize = 16,
	Text = "X",
	Parent = head,
})

local tabsBar = make("Frame", {
	Name = "Tabs",
	Position = UDim2.fromOffset(16, 62),
	Size = UDim2.new(1, -32, 0, 34),
	BackgroundColor3 = THEME.slot,
	BorderSizePixel = 0,
	Parent = panel,
}, {
	make("UICorner", { CornerRadius = UDim.new(0, 8) }),
	pad(3, 3, 3, 3),
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 3),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local body = make("Frame", {
	Name = "Body",
	Position = UDim2.fromOffset(16, 106),
	Size = UDim2.new(1, -32, 1, -150),
	BackgroundTransparency = 1,
	Parent = panel,
})

local statusLabel = label({
	Name = "Status",
	AnchorPoint = Vector2.new(0, 1),
	Position = UDim2.new(0, 16, 1, -10),
	Size = UDim2.new(1, -32, 0, 26),
	TextSize = 12,
	TextColor3 = THEME.muted,
	TextWrapped = true,
	Text = "Press U to use your mouse on the panel (U again to aim). F10 or the AC LAB button hides it.",
	Parent = panel,
})

local pages = {}
local tabButtons = {}
local state = {
	tab = "live",
	filter = "all",
	mine = false,
	watched = initData.watched == true,
	order = 0,
	lastId = 0,
	rows = {},
	armed = {},
	detailOf = nil,
	me = initData.me,
}

local function showTab(tabId: string)
	state.tab = tabId
	for id, frame in pairs(pages) do
		frame.Visible = (id == tabId)
	end
	for id, btn in pairs(tabButtons) do
		btn.BackgroundTransparency = (id == tabId) and 0 or 1
		btn.TextColor3 = (id == tabId) and THEME.text or THEME.muted
	end
end

local function clear(container: Instance)
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("GuiObject") then
			child:Destroy()
		end
	end
end

for idx, tabDef in ipairs({
	{ "live", "LIVE" },
	{ "players", "PLAYERS" },
	{ "reports", "REPORTS" },
}) do
	tabButtons[tabDef[1]] = button({
		Name = "Tab_" .. tabDef[1],
		Size = UDim2.new(1 / 3, -2, 1, 0),
		LayoutOrder = idx,
		Font = Enum.Font.Oswald,
		TextSize = 16,
		Text = tabDef[2],
		Parent = tabsBar,
	}, THEME.button)

	pages[tabDef[1]] = make("Frame", {
		Name = tabDef[1],
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = false,
		Parent = body,
	})
end

-- LIVE TAB
local livePage = pages.live
local filterBar = make("Frame", {
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundTransparency = 1,
	Parent = livePage,
}, {
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local filterBtns = {}
for idx, f in ipairs(CONFIG.FILTERS) do
	local btn = button({
		Size = UDim2.fromOffset(0, 28),
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = idx,
		TextSize = 12,
		Text = f.label,
		Parent = filterBar,
	}, THEME.button)
	pad(0, 10, 0, 10).Parent = btn
	filterBtns[f.id] = btn
end

local actionsBar = make("Frame", {
	Position = UDim2.fromOffset(0, 34),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundTransparency = 1,
	Parent = livePage,
}, {
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local mineBtn = button({
	Size = UDim2.new(0.34, -4, 1, 0),
	LayoutOrder = 1,
	Text = "MINE ONLY: OFF",
	Parent = actionsBar,
})
local resetBtn = button({
	Size = UDim2.new(0.38, -4, 1, 0),
	LayoutOrder = 2,
	Text = "RESET MY ANTI-CHEAT",
	Parent = actionsBar,
})
local clearBtn = button({
	Size = UDim2.new(0.28, 0, 1, 0),
	LayoutOrder = 3,
	Text = "CLEAR",
	Parent = actionsBar,
})

local feedScroll = make("ScrollingFrame", {
	Position = UDim2.fromOffset(0, 70),
	Size = UDim2.new(1, 0, 1, -70),
	BackgroundColor3 = THEME.slot,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = THEME.dim,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	Parent = livePage,
}, {
	make("UICorner", { CornerRadius = UDim.new(0, 8) }),
	pad(6, 8, 6, 6),
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local function rowVisible(row): boolean
	if state.mine and not row.mine then
		return false
	end
	for _, f in ipairs(CONFIG.FILTERS) do
		if f.id == state.filter then
			return f.kinds == nil or f.kinds[row.kind] == true
		end
	end
	return true
end

local function addRow(ev)
	if type(ev) ~= "table" then
		return
	end
	if type(ev.i) == "number" then
		if ev.i <= state.lastId then
			return
		end
		state.lastId = ev.i
	end

	state.order += 1
	local kindKey = tostring(ev.k or "note")
	local kindMeta = CONFIG.KIND[kindKey] or { string.upper(kindKey), THEME.dim }

	local card = make("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = THEME.card,
		BorderSizePixel = 0,
		LayoutOrder = state.order,
		Parent = feedScroll,
	}, {
		make("UICorner", { CornerRadius = UDim.new(0, 6) }),
		pad(6, 8, 6, 8),
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 3),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	local header = make("Frame", {
		Size = UDim2.new(1, 0, 0, 18),
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Parent = card,
	}, {
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	label({
		Size = UDim2.fromOffset(62, 18),
		Font = Enum.Font.RobotoMono,
		TextSize = 12,
		TextColor3 = THEME.dim,
		Text = type(ev.t) == "number" and os.date("%H:%M:%S", ev.t) or "--:--:--",
		LayoutOrder = 1,
		Parent = header,
	})

	chip(" " .. kindMeta[1] .. " ", kindMeta[2], header, 2)

	if type(ev.n) == "string" then
		label({
			Size = UDim2.fromOffset(0, 18),
			AutomaticSize = Enum.AutomaticSize.X,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			Text = ev.n,
			LayoutOrder = 3,
			Parent = header,
		})
	end

	label({
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextWrapped = true,
		TextSize = 13,
		TextColor3 = THEME.muted,
		Text = tostring(ev.x or ""),
		LayoutOrder = 2,
		Parent = card,
	})

	local entry = {
		frame = card,
		kind = kindKey,
		mine = (ev.u == LocalPlayer.UserId),
	}
	card.Visible = rowVisible(entry)
	table.insert(state.rows, entry)

	while #state.rows > CONFIG.MAX_LINES do
		local old = table.remove(state.rows, 1)
		if old then
			old.frame:Destroy()
		end
	end

	task.defer(function()
		local maxScroll = feedScroll.AbsoluteCanvasSize.Y - feedScroll.AbsoluteWindowSize.Y
		feedScroll.CanvasPosition = Vector2.new(0, math.max(0, maxScroll))
	end)
end

local function paintFilters()
	for id, btn in pairs(filterBtns) do
		btn.BackgroundColor3 = (id == state.filter) and THEME.rust or THEME.button
	end
	mineBtn.Text = state.mine and "MINE ONLY: ON" or "MINE ONLY: OFF"
	mineBtn.BackgroundColor3 = state.mine and THEME.rust or THEME.button
	for _, row in ipairs(state.rows) do
		row.frame.Visible = rowVisible(row)
	end
end

for _, ev in ipairs(type(initData.events) == "table" and initData.events or {}) do
	addRow(ev)
end
AcLabFeed.OnClientEvent:Connect(addRow)

for id, btn in pairs(filterBtns) do
	btn.Activated:Connect(function()
		state.filter = id
		paintFilters()
	end)
end

mineBtn.Activated:Connect(function()
	state.mine = not state.mine
	paintFilters()
end)

clearBtn.Activated:Connect(function()
	for _, row in ipairs(state.rows) do
		row.frame:Destroy()
	end
	state.rows = {}
end)

resetBtn.Activated:Connect(function()
	local res = call("reset")
	statusLabel.Text = res.ok and "Your anti-cheat state was reset - start the next test clean"
		or tostring(res.err or "Couldn't reset")
	statusLabel.TextColor3 = res.ok and THEME.muted or THEME.bad
end)

-- PLAYERS TAB
local playersPage = pages.players
label({
	Size = UDim2.new(1, 0, 0, 30),
	TextSize = 12,
	TextColor3 = THEME.muted,
	TextWrapped = true,
	Text = "Live anti-cheat view of everyone here (refreshes every few seconds). TEST BAN shows the real ban screen and keeps them out of the lab for 10 minutes - nothing is saved.",
	Parent = playersPage,
})

local playersScroll = make("ScrollingFrame", {
	Position = UDim2.fromOffset(0, 36),
	Size = UDim2.new(1, 0, 1, -36),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = THEME.dim,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	Parent = playersPage,
}, {
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local ROLE_COLORS = {
	owner = THEME.rust,
	tester = THEME.patina,
	["test account"] = THEME.amber,
}

local refreshPlayers

local function detailBlock(parent: Instance, detail: any)
	local box = make("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = THEME.slot,
		BorderSizePixel = 0,
		LayoutOrder = 9,
		Parent = parent,
	}, {
		make("UICorner", { CornerRadius = UDim.new(0, 6) }),
		pad(6, 8, 6, 8),
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 3),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	local count = 0
	local aimList = (type(detail) == "table" and type(detail.aim) == "table") and detail.aim or {}
	for _, item in ipairs(aimList) do
		count += 1
		label({
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			TextWrapped = true,
			TextSize = 12,
			TextColor3 = THEME.ice,
			Text = tostring(item.line) .. "  -  " .. tostring(item.detail),
			LayoutOrder = count,
			Parent = box,
		})
	end

	local flagList = (type(detail) == "table" and type(detail.flags) == "table") and detail.flags or {}
	for _, fl in ipairs(flagList) do
		count += 1
		local ts = type(fl.t) == "number" and os.date("%H:%M:%S", fl.t) or "--:--:--"
		label({
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			TextWrapped = true,
			Font = Enum.Font.RobotoMono,
			TextSize = 12,
			TextColor3 = THEME.muted,
			Text = ("%s  %s +%s  %s"):format(ts, tostring(fl.kind), tostring(fl.weight or 0), tostring(fl.detail or "")),
			LayoutOrder = count,
			Parent = box,
		})
	end

	if count == 0 then
		label({
			Size = UDim2.new(1, 0, 0, 16),
			TextSize = 12,
			TextColor3 = THEME.dim,
			Text = "No flags yet",
			Parent = box,
		})
	end
end

local function playerCard(plrInfo, order: number)
	local card = make("Frame", {
		Size = UDim2.new(1, -6, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = THEME.card,
		BorderSizePixel = 0,
		LayoutOrder = order,
		Parent = playersScroll,
	}, {
		make("UICorner", { CornerRadius = UDim.new(0, 8) }),
		pad(10, 10, 10, 12),
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	local topRow = make("Frame", {
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Parent = card,
	}, {
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	label({
		Size = UDim2.fromOffset(0, 20),
		AutomaticSize = Enum.AutomaticSize.X,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		Text = tostring(plrInfo.name),
		LayoutOrder = 1,
		Parent = topRow,
	})

	chip(" " .. string.upper(tostring(plrInfo.kind)) .. " ", ROLE_COLORS[plrInfo.kind] or THEME.dim, topRow, 2)

	if plrInfo.watched == false then
		chip(" NOT WATCHED ", THEME.dim, topRow, 3)
	end
	if type(plrInfo.banned) == "number" then
		chip((" TEST BANNED %dm "):format(math.ceil(plrInfo.banned / 60)), Color3.fromRGB(255, 70, 130), topRow, 4)
	end

	local score = tonumber(plrInfo.score) or 0
	local barBg = make("Frame", {
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundColor3 = THEME.slot,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Parent = card,
	}, { make("UICorner", { CornerRadius = UDim.new(0, 4) }) })

	make("Frame", {
		Size = UDim2.fromScale(math.clamp(score / 60, 0, 1), 1),
		BackgroundColor3 = plrInfo.high and THEME.bad or (score >= 20 and THEME.amber or THEME.good),
		BorderSizePixel = 0,
		Parent = barBg,
	}, { make("UICorner", { CornerRadius = UDim.new(0, 4) }) })

	local aimText = type(plrInfo.aim) == "number" and (" · aim vs same device %+.1f sd"):format(plrInfo.aim) or ""
	local kindsText = (type(plrInfo.kinds) == "string" and plrInfo.kinds ~= "") and (" · " .. plrInfo.kinds) or ""

	label({
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextWrapped = true,
		TextSize = 12,
		TextColor3 = THEME.muted,
		LayoutOrder = 3,
		Text = ("Score %s%s · %d flags%s%s"):format(
			tostring(plrInfo.score),
			plrInfo.high and " (HIGH)" or "",
			tonumber(plrInfo.total) or 0,
			aimText,
			kindsText
		),
		Parent = card,
	})

	local btnRow = make("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		LayoutOrder = 4,
		Parent = card,
	}, {
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Wraps = false,
		}),
	})

	button({
		Size = UDim2.new(0.5, -3, 1, 0),
		LayoutOrder = 1,
		Text = (state.detailOf == plrInfo.id) and "HIDE DETAIL" or "DETAIL",
		Parent = btnRow,
	}).Activated:Connect(function()
		state.detailOf = (state.detailOf == plrInfo.id) and nil or plrInfo.id
		task.spawn(refreshPlayers)
	end)

	if plrInfo.kind ~= "owner" then
		local isBanned = type(plrInfo.banned) == "number"
		local banBtn
		banBtn = button({
			Size = UDim2.new(0.5, -3, 1, 0),
			LayoutOrder = 2,
			Text = isBanned and "LIFT TEST BAN" or "TEST BAN",
			Parent = btnRow,
		}, isBanned and THEME.button or THEME.danger)

		banBtn.Activated:Connect(function()
			if isBanned then
				call("unban", plrInfo.id)
				statusLabel.Text = "Test ban lifted - they can rejoin the lab"
				statusLabel.TextColor3 = THEME.muted
				task.spawn(refreshPlayers)
				return
			end

			local now = os.clock()
			if (state.armed[plrInfo.id] or 0) < now then
				state.armed[plrInfo.id] = now + CONFIG.CONFIRM
				banBtn.Text = "SURE? PRESS AGAIN"
				task.delay(CONFIG.CONFIRM, function()
					if banBtn.Parent then
						banBtn.Text = "TEST BAN"
					end
				end)
			else
				state.armed[plrInfo.id] = nil
				local res = call("testban", plrInfo.id)
				statusLabel.Text = res.ok
					and ("%s gets the real ban screen now - see the LIVE tab"):format(tostring(plrInfo.name))
					or tostring(res.err or "Couldn't")
				statusLabel.TextColor3 = res.ok and THEME.muted or THEME.bad
				task.delay(1, refreshPlayers)
			end
		end)
	end

	if state.detailOf == plrInfo.id then
		local res = call("player", plrInfo.id)
		detailBlock(card, res.ok and res.detail or nil)
	end
end

local isRefreshingPlayers = false
refreshPlayers = function()
	if isRefreshingPlayers then
		return
	end
	isRefreshingPlayers = true

	local res = call("players")
	local rows = (res.ok and type(res.view) == "table" and type(res.view.rows) == "table") and res.view.rows or {}

	table.sort(rows, function(a, b)
		return (tonumber(a.score) or 0) > (tonumber(b.score) or 0)
	end)

	clear(playersScroll)
	for idx, r in ipairs(rows) do
		playerCard(r, idx)
	end

	if #rows == 0 then
		label({
			Size = UDim2.new(1, 0, 0, 30),
			TextColor3 = THEME.dim,
			Text = res.ok and "Nobody here yet" or tostring(res.err),
			Parent = playersScroll,
		})
	end

	isRefreshingPlayers = false
end

-- REPORTS TAB
local reportsPage = pages.reports
local reportInput = make("TextBox", {
	Size = UDim2.new(1, 0, 0, 120),
	BackgroundColor3 = THEME.slot,
	BorderSizePixel = 0,
	ClearTextOnFocus = false,
	MultiLine = true,
	TextWrapped = true,
	Font = Enum.Font.Gotham,
	TextSize = 14,
	TextColor3 = THEME.text,
	PlaceholderColor3 = THEME.dim,
	PlaceholderText = "Report a bypass: what you did, what the anti-cheat missed (or flagged wrongly), how to repeat it, and your fix idea...",
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	Text = "",
	Parent = reportsPage,
}, {
	make("UICorner", { CornerRadius = UDim.new(0, 8) }),
	make("UIStroke", {
		Color = THEME.line,
		Transparency = 0.9,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}),
	pad(8, 10, 8, 10),
})

local sendReportBtn = button({
	Position = UDim2.fromOffset(0, 128),
	Size = UDim2.new(1, 0, 0, 34),
	Font = Enum.Font.Oswald,
	TextSize = 17,
	Text = "SEND REPORT",
	Parent = reportsPage,
}, THEME.rust)

label({
	Position = UDim2.fromOffset(0, 170),
	Size = UDim2.new(1, 0, 0, 16),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = THEME.label,
	Text = "SAVED REPORTS",
	Parent = reportsPage,
})

local reportsScroll = make("ScrollingFrame", {
	Position = UDim2.fromOffset(0, 190),
	Size = UDim2.new(1, 0, 1, -190),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = THEME.dim,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	Parent = reportsPage,
}, {
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Wraps = false,
	}),
})

local function loadReports()
	local res = call("reports")
	clear(reportsScroll)
	local count = 0
	local list = (res.ok and type(res.list) == "table") and res.list or {}

	for idx, item in ipairs(list) do
		count += 1
		local card = make("Frame", {
			Size = UDim2.new(1, -6, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = THEME.card,
			BorderSizePixel = 0,
			LayoutOrder = idx,
			Parent = reportsScroll,
		}, {
			make("UICorner", { CornerRadius = UDim.new(0, 6) }),
			pad(6, 8, 6, 8),
			make("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Wraps = false,
			}),
		})

		local dateStr = type(item.t) == "number" and os.date("%Y-%m-%d %H:%M", item.t) or ""
		label({
			Size = UDim2.new(1, 0, 0, 16),
			Font = Enum.Font.RobotoMono,
			TextSize = 11,
			TextColor3 = THEME.dim,
			Text = dateStr .. "  " .. tostring(item.n or ""),
			LayoutOrder = 1,
			Parent = card,
		})

		label({
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			TextWrapped = true,
			TextSize = 13,
			TextColor3 = THEME.muted,
			Text = tostring(item.x or ""),
			LayoutOrder = 2,
			Parent = card,
		})
	end

	if count == 0 then
		label({
			Size = UDim2.new(1, 0, 0, 24),
			TextSize = 12,
			TextColor3 = THEME.dim,
			Text = "No reports yet",
			Parent = reportsScroll,
		})
	end
end

local isSendingReport = false
sendReportBtn.Activated:Connect(function()
	if isSendingReport then
		return
	end
	isSendingReport = true
	statusLabel.Text = "Sending..."
	statusLabel.TextColor3 = THEME.muted

	local res = call("report", reportInput.Text)
	isSendingReport = false

	if res.ok then
		reportInput.Text = ""
		statusLabel.Text = "Report saved - thank you"
		statusLabel.TextColor3 = THEME.muted
		loadReports()
	else
		statusLabel.Text = tostring(res.err or "Couldn't send")
		statusLabel.TextColor3 = THEME.bad
	end
end)

watchBtn.Visible = (state.me ~= "owner")
watchBtn.Activated:Connect(function()
	local res = call("watch", not state.watched)
	if res.ok then
		state.watched = (res.watched == true)
		watchBtn.Text = state.watched and "WATCH: ON" or "WATCH: OFF"
		watchBtn.BackgroundColor3 = state.watched and THEME.patina or THEME.button
		statusLabel.Text = state.watched
			and "The anti-cheat now checks you like any player"
			or "The anti-cheat now treats you as staff (no checks)"
		statusLabel.TextColor3 = THEME.muted
	else
		statusLabel.Text = tostring(res.err or "Couldn't switch")
		statusLabel.TextColor3 = THEME.bad
	end
end)

for tabId, btn in pairs(tabButtons) do
	btn.Activated:Connect(function()
		showTab(tabId)
		if tabId == "players" then
			task.spawn(refreshPlayers)
		elseif tabId == "reports" then
			task.spawn(loadReports)
		end
	end)
end

closeBtn.Activated:Connect(function()
	panel.Visible = false
	openBtn.BackgroundColor3 = THEME.rust
end)

openBtn.Activated:Connect(function()
	local vis = not panel.Visible
	panel.Visible = vis
	openBtn.BackgroundColor3 = vis and THEME.button or THEME.rust
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == CONFIG.TOGGLE_KEY then
		local vis = not panel.Visible
		panel.Visible = vis
		openBtn.BackgroundColor3 = vis and THEME.button or THEME.rust
	end
end)

local function fit()
	local cam = workspace.CurrentCamera
	local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
	local scale = math.min(1, (vp.X - 24) / CONFIG.W, (vp.Y - 70) / CONFIG.H)
	uiScale.Scale = math.max(0.45, scale)
end

fit()
if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
end

task.spawn(function()
	while true do
		repeat
			task.wait(CONFIG.REFRESH)
		until panel.Visible and state.tab == "players" and state.detailOf == nil
		refreshPlayers()
	end
end)

watchBtn.Text = state.watched and "WATCH: ON" or "WATCH: OFF"
watchBtn.BackgroundColor3 = state.watched and THEME.patina or THEME.button
paintFilters()
showTab("live")
panel.Visible = true
openBtn.BackgroundColor3 = THEME.button
