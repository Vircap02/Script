--[[
    ╔══════════════════════════════════════════════╗
    ║              VIRGOBOY HUB  v2.0              ║
    ║     Hacker Live Animated Edition • PC/Mobile ║
    ║              Owner: Virgoboy                 ║
    ╚══════════════════════════════════════════════╝
]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end

--// SERVICES
local Players = game:GetService("Players")
while not Players.LocalPlayer do
	task.wait()
end
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

local IS_TOUCH = UIS.TouchEnabled
local IS_MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled

--// BERSIHKAN INSTANCE LAMA
if type(_G.VirgoboyHubCleanup) == "function" then
	pcall(_G.VirgoboyHubCleanup)
end
do
	local places = {}
	if gethui then
		pcall(function()
			table.insert(places, gethui())
		end)
	end
	table.insert(places, LP:FindFirstChildOfClass("PlayerGui"))
	pcall(function()
		table.insert(places, game:GetService("CoreGui"))
	end)
	for _, p in ipairs(places) do
		pcall(function()
			local o = p:FindFirstChild("VirgoboyHub")
			if o then
				o:Destroy()
			end
		end)
	end
end

--// CONFIG
local CFG = {
	Name = "Virgoboy Hub",
	Owner = "Virgoboy",
	Version = "2.0.0",
	ToggleKey = Enum.KeyCode.RightShift,
	ThemeName = "Hacker",
	Accent = Color3.fromRGB(0, 255, 65),
	SaveFile = "VirgoboyHub_Scripts.json",
	SettingsFile = "VirgoboyHub_Settings.json",
}

local THEMES = {
	{ "Hacker", Color3.fromRGB(0, 255, 65) },
	{ "Cyber", Color3.fromRGB(0, 229, 255) },
	{ "Ungu", Color3.fromRGB(139, 92, 246) },
	{ "Merah", Color3.fromRGB(239, 68, 68) },
	{ "Emas", Color3.fromRGB(245, 180, 40) },
	{ "Pink", Color3.fromRGB(236, 72, 153) },
}

local C = {
	BG = Color3.fromRGB(10, 15, 10),
	Side = Color3.fromRGB(12, 22, 12),
	Card = Color3.fromRGB(15, 30, 15),
	Card2 = Color3.fromRGB(20, 42, 20),
	Text = Color3.fromRGB(200, 255, 200),
	Sub = Color3.fromRGB(100, 180, 100),
	Good = Color3.fromRGB(0, 255, 65),
	Bad = Color3.fromRGB(255, 50, 50),
}

local hasFS = (writefile and readfile and isfile) and true or false

local function loadSettings()
	if not hasFS then return end
	local okExists, exists = pcall(isfile, CFG.SettingsFile)
	if not (okExists and exists) then return end
	local ok, d = pcall(function()
		return HttpService:JSONDecode(readfile(CFG.SettingsFile))
	end)
	if ok and type(d) == "table" then
		for _, t in ipairs(THEMES) do
			if t[1] == d.Theme then
				CFG.ThemeName = t[1]
				CFG.Accent = t[2]
			end
		end
		if type(d.Key) == "string" then
			local ok2, k = pcall(function() return Enum.KeyCode[d.Key] end)
			if ok2 and k then CFG.ToggleKey = k end
		end
	end
end

local function saveSettings()
	if not hasFS then return end
	pcall(function()
		writefile(CFG.SettingsFile, HttpService:JSONEncode({ Theme = CFG.ThemeName, Key = CFG.ToggleKey.Name }))
	end)
end

loadSettings()

--// SCREEN GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "VirgoboyHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999

do
	local ok = false
	if gethui then ok = pcall(function() Gui.Parent = gethui() end) end
	if not ok or not Gui.Parent then Gui.Parent = LP:WaitForChild("PlayerGui") end
end

local connections = {}
local function connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(connections, c)
	return c
end

local themeFns = {}
local function onTheme(fn)
	table.insert(themeFns, fn)
	pcall(fn)
end
local function trackAccent(obj, prop)
	onTheme(function() obj[prop] = CFG.Accent end)
end

local function make(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do inst[k] = v end
	for _, ch in ipairs(children or {}) do ch.Parent = inst end
	return inst
end

local function corner(r)
	return make("UICorner", { CornerRadius = UDim.new(0, r or 8) })
end

local function stroke(color, thick, trans)
	return make("UIStroke", {
		Color = color or Color3.fromRGB(0, 255, 65),
		Thickness = thick or 1,
		Transparency = trans or 0.4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local function pad(l, t, r, b)
	return make("UIPadding", {
		PaddingLeft = UDim.new(0, l or 0),
		PaddingTop = UDim.new(0, t or 0),
		PaddingRight = UDim.new(0, r or 0),
		PaddingBottom = UDim.new(0, b or 0),
	})
end

local function tween(obj, t, props)
	local tw = TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Back, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function smoothTween(obj, t, props)
	local tw = TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function isBlank(s)
	return s == nil or s:match("^%s*$") ~= nil
end

local function trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function getVP()
	local a = Gui.AbsoluteSize
	if a.X < 100 or a.Y < 100 then
		local cam = workspace.CurrentCamera
		if cam then return cam.ViewportSize end
	end
	return a
end

local function clampPos(pos, mx, my)
	local vp = getVP()
	local cx = vp.X * pos.X.Scale + pos.X.Offset
	local cy = vp.Y * pos.Y.Scale + pos.Y.Offset
	cx = math.clamp(cx, mx, math.max(mx, vp.X - mx))
	cy = math.clamp(cy, my, math.max(my, vp.Y - my))
	return UDim2.new(pos.X.Scale, cx - vp.X * pos.X.Scale, pos.Y.Scale, cy - vp.Y * pos.Y.Scale)
end

local function isPointer(i)
	return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch
end

local function makeDraggable(handle, target, mx, my, onTap, onDropped)
	local dragging, dragInput, startPt, startPos, moved = false, nil, nil, nil, false
	connect(handle.InputBegan, function(i)
		if isPointer(i) then dragging = true; moved = false; startPt = i.Position; startPos = target.Position end
	end)
	connect(handle.InputChanged, function(i)
		if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dragInput = i end
	end)
	connect(UIS.InputChanged, function(i)
		if dragging and i == dragInput then
			local d = i.Position - startPt
			if d.Magnitude > 6 then moved = true end
			if moved then
				target.Position = clampPos(UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y), mx, my)
			end
		end
	end)
	connect(UIS.InputEnded, function(i)
		if dragging and isPointer(i) then
			dragging = false
			if not moved and onTap then onTap() elseif moved and onDropped then onDropped() end
		end
	end)
end

--// NOTIFIKASI
local NotifLayout = make("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
local NotifHolder = make("Frame", {
	Name = "Notifs",
	BackgroundTransparency = 1,
	Size = UDim2.new(0, 290, 0, 320),
	ZIndex = 50,
	Parent = Gui,
}, { NotifLayout })

if IS_MOBILE then
	NotifHolder.AnchorPoint = Vector2.new(0.5, 0)
	NotifHolder.Position = UDim2.new(0.5, 0, 0, 56)
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
else
	NotifHolder.AnchorPoint = Vector2.new(1, 1)
	NotifHolder.Position = UDim2.new(1, -16, 1, -16)
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
end

local function notify(title, text, color)
	color = color or CFG.Accent
	local f = make("CanvasGroup", {
		BackgroundColor3 = C.Card,
		BackgroundTransparency = 0.2,
		Size = UDim2.new(1, 0, 0, 62),
		GroupTransparency = 1,
		Parent = NotifHolder,
	}, {
		corner(10),
		stroke(color, 1.5, 0.2),
		make("Frame", {
			Size = UDim2.new(0, 4, 1, -16),
			Position = UDim2.new(0, 8, 0, 8),
			BackgroundColor3 = color,
			BorderSizePixel = 0,
		}, { corner(2) }),
		make("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 22, 0, 7),
			Size = UDim2.new(1, -30, 0, 18),
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = C.Text,
			Text = tostring(title),
		}),
		make("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 22, 0, 26),
			Size = UDim2.new(1, -30, 0, 30),
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextWrapped = true,
			TextColor3 = C.Sub,
			Text = tostring(text),
		}),
	})
	smoothTween(f, 0.3, { GroupTransparency = 0 })
	task.delay(3.5, function()
		if f and f.Parent then
			smoothTween(f, 0.3, { GroupTransparency = 1 })
			task.wait(0.35)
			if f and f.Parent then f:Destroy() end
		end
	end)
end

--// WINDOW UTAMA (MAIN GUI)
local FULL_W, FULL_H = 640, 420
local curSize = UDim2.fromOffset(FULL_W, FULL_H)
local lastMainPos = UDim2.new(0.5, 0, 0.5, 0)

local Main = make("ImageLabel", {
	Name = "Main",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = lastMainPos,
	Size = curSize,
	BackgroundTransparency = 1,
	Image = "rbxassetid://113929380862927",
	ScaleType = Enum.ScaleType.Stretch,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Visible = false,
	ZIndex = 1,
	Parent = Gui,
}, {
	corner(14),
	stroke(CFG.Accent, 1.5, 0.3),
})
trackAccent(Main:FindFirstChildOfClass("UIStroke"), "Color")

make("Frame", {
	Name = "Overlay",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.fromRGB(5, 20, 5),
	BackgroundTransparency = 0.55,
	BorderSizePixel = 0,
	ZIndex = 0,
	Parent = Main,
})

--// ANIMASI BERGERAK: HACKER SCANNER LINE
local ScannerLine = make("Frame", {
	Name = "ScannerLine",
	Size = UDim2.new(1, 0, 0, 2),
	BackgroundColor3 = CFG.Accent,
	BackgroundTransparency = 0.3,
	BorderSizePixel = 0,
	ZIndex = 5,
	Parent = Main,
}, {
	make("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
})
trackAccent(ScannerLine, "BackgroundColor3")

task.spawn(function()
	while true do
		if Main.Visible then
			TweenService:Create(ScannerLine, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(0, 0, 1, -2)
			}):Play()
			task.wait(2)
			TweenService:Create(ScannerLine, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(0, 0, 0, 44)
			}):Play()
			task.wait(2)
		else
			task.wait(0.5)
		end
	end
end)

--// TOP BAR
local Top = make("Frame", {
	Name = "Top",
	Size = UDim2.new(1, 0, 0, 44),
	BackgroundColor3 = C.Side,
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
	ZIndex = 2,
	Parent = Main,
})

local accentLine = make("Frame", {
	Size = UDim2.new(1, 0, 0, 2),
	Position = UDim2.new(0, 0, 1, -2),
	BorderSizePixel = 0,
	Parent = Top,
})
trackAccent(accentLine, "BackgroundColor3")

task.spawn(function()
	while true do
		TweenService:Create(accentLine, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			BackgroundTransparency = 0.8
		}):Play()
		task.wait(1)
		TweenService:Create(accentLine, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			BackgroundTransparency = 0.1
		}):Play()
		task.wait(1)
	end
end)

local badge = make("TextLabel", {
	Position = UDim2.new(0, 12, 0.5, -13),
	Size = UDim2.fromOffset(26, 26),
	Font = Enum.Font.GothamBlack,
	TextSize = 16,
	TextColor3 = Color3.new(1, 1, 1),
	Text = ">_",
	Parent = Top,
}, { corner(8) })
trackAccent(badge, "BackgroundColor3")

make("TextLabel", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 46, 0, 0),
	Size = UDim2.new(0, 150, 1, 0),
	Font = Enum.Font.GothamBlack,
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.Text,
	Text = "VIRGOBOY HUB",
	Parent = Top,
})

local versionLbl = make("TextLabel", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 195, 0, 0),
	Size = UDim2.new(0, 120, 1, 0),
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextColor3 = C.Sub,
	Text = "SECURE  v" .. CFG.Version,
	Parent = Top,
})

local function topButton(text, xOffset, hoverColor)
	local b = make("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, xOffset, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		BackgroundColor3 = C.Card2,
		BackgroundTransparency = 0.3,
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = C.Text,
		Text = text,
		AutoButtonColor = false,
		Parent = Top,
	}, { corner(8), stroke(CFG.Accent, 1, 0.5) })
	trackAccent(b:FindFirstChildOfClass("UIStroke"), "Color")
	
	connect(b.MouseEnter, function()
		smoothTween(b, 0.2, { BackgroundColor3 = hoverColor or CFG.Accent, Size = UDim2.fromOffset(34, 34) })
	end)
	connect(b.MouseLeave, function()
		smoothTween(b, 0.2, { BackgroundColor3 = C.Card2, Size = UDim2.fromOffset(30, 30) })
	end)
	return b
end

local CloseBtn = topButton("×", -10, C.Bad)
local MinBtn = topButton("–", -48, nil)

--// SIDEBAR
local SidePad = pad(10, 12, 10, 10)
local Side = make("Frame", {
	Name = "Side",
	Position = UDim2.new(0, 0, 0, 44),
	Size = UDim2.new(0, 150, 1, -44),
	BackgroundColor3 = C.Side,
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
	ZIndex = 2,
	Parent = Main,
}, {
	SidePad,
	make("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }),
})

local ownerTag = make("TextLabel", {
	AnchorPoint = Vector2.new(0, 1),
	Position = UDim2.new(0, 10, 1, -10),
	Size = UDim2.fromOffset(130, 30),
	BackgroundColor3 = C.Card,
	BackgroundTransparency = 0.3,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	TextColor3 = C.Text,
	Text = "🛡️ OWNER: " .. string.upper(CFG.Owner),
	TextTruncate = Enum.TextTruncate.AtEnd,
	ZIndex = 3,
	Parent = Main,
}, { corner(8), stroke(CFG.Accent, 1, 0.6) })
trackAccent(ownerTag:FindFirstChildOfClass("UIStroke"), "Color")

--// CONTENT
local Content = make("Frame", {
	Name = "Content",
	Position = UDim2.new(0, 150, 0, 44),
	Size = UDim2.new(1, -150, 1, -44),
	BackgroundTransparency = 1,
	ZIndex = 2,
	Parent = Main,
})

local pages, tabMeta = {}, {}
local currentTab = "Home"

local function newPage(name)
	local p = make("ScrollingFrame", {
		Name = name,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Visible = false,
		Parent = Content,
	}, {
		pad(12, 12, 12, 12),
		make("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	trackAccent(p, "ScrollBarImageColor3")
	pages[name] = p
	return p
end

local function selectTab(name)
	currentTab = name
	for n, p in pairs(pages) do p.Visible = (n == name) end
	for n, m in pairs(tabMeta) do
		local active = (n == name)
		m.btn.BackgroundColor3 = CFG.Accent
		smoothTween(m.btn, 0.25, { 
			BackgroundTransparency = active and 0.15 or 1,
			Size = active and UDim2.new(1, 4, 0, 36) or UDim2.new(1, 0, 0, 36)
		})
		m.btn.TextColor3 = active and Color3.new(1, 1, 1) or C.Sub
	end
end
onTheme(function() selectTab(currentTab) end)

local function newTab(name, icon, order)
	local padObj = pad(14, 0, 0, 0)
	local b = make("TextButton", {
		Name = name,
		Size = UDim2.new(1, 0, 0, 36),
		BackgroundColor3 = CFG.Accent,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.Sub,
		Text = icon .. "  " .. name,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		LayoutOrder = order,
		Parent = Side,
	}, { corner(8), padObj })
	
	connect(b.MouseEnter, function()
		if currentTab ~= name then
			smoothTween(b, 0.2, { BackgroundTransparency = 0.8, TextColor3 = C.Text })
		end
	end)
	connect(b.MouseLeave, function()
		if currentTab ~= name then
			smoothTween(b, 0.2, { BackgroundTransparency = 1, TextColor3 = C.Sub })
		end
	end)
	
	tabMeta[name] = { btn = b, icon = icon, pad = padObj }
	connect(b.MouseButton1Click, function() selectTab(name) end)
	return newPage(name)
end

--// KOMPONEN UI
local function section(page, text)
	return make("TextLabel", {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CFG.Accent,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = string.upper(text),
		Parent = page,
	})
end

local function card(page, height)
	local f = make("Frame", {
		Size = UDim2.new(1, 0, 0, height or 40),
		BackgroundColor3 = C.Card,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Parent = page,
	}, { corner(10), stroke(CFG.Accent, 1, 0.6) })
	trackAccent(f:FindFirstChildOfClass("UIStroke"), "Color")
	return f
end

local function button(page, text, callback)
	local b = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = C.Card2,
		BackgroundTransparency = 0.3,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.Text,
		Text = text,
		TextTruncate = Enum.TextTruncate.AtEnd,
		AutoButtonColor = false,
		Parent = page,
	}, { corner(10), stroke(CFG.Accent, 1, 0.5), pad(8, 0, 8, 0) })
	trackAccent(b:FindFirstChildOfClass("UIStroke"), "Color")
	
	connect(b.MouseEnter, function()
		smoothTween(b, 0.2, { BackgroundColor3 = CFG.Accent, BackgroundTransparency = 0.2, Size = UDim2.new(1, 4, 0, 40) })
	end)
	connect(b.MouseLeave, function()
		smoothTween(b, 0.2, { BackgroundColor3 = C.Card2, BackgroundTransparency = 0.3, Size = UDim2.new(1, 0, 0, 40) })
	end)
	connect(b.MouseButton1Click, function()
		task.spawn(function()
			smoothTween(b, 0.08, { Size = UDim2.new(1, -6, 0, 36) })
			task.wait(0.08)
			smoothTween(b, 0.12, { Size = UDim2.new(1, 0, 0, 40) })
		end)
		local ok, err = pcall(callback)
		if not ok then notify("Error", tostring(err), C.Bad) end
	end)
	return b
end

local function toggle(page, text, default, callback)
	local c = card(page, 42)
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 14, 0, 0),
		Size = UDim2.new(1, -80, 1, 0),
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Text = text,
		Parent = c,
	})
	local track = make("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(44, 24),
		BackgroundColor3 = C.Card2,
		BackgroundTransparency = 0.2,
		Parent = c,
	}, { corner(12), stroke(CFG.Accent, 1, 0.4) })
	trackAccent(track:FindFirstChildOfClass("UIStroke"), "Color")
	
	local knob = make("Frame", {
		Position = UDim2.new(0, 3, 0.5, -9),
		Size = UDim2.fromOffset(18, 18),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Parent = track,
	}, { corner(9) })
	local hit = make("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 3,
		Parent = c,
	})

	local state = default
	local function render()
		smoothTween(track, 0.25, { BackgroundColor3 = state and CFG.Accent or C.Card2 })
		smoothTween(knob, 0.25, { Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9) })
	end
	onTheme(render)

	local function apply(v)
		state = v
		render()
		local ok, err = pcall(callback, state)
		if not ok then notify("Error", tostring(err), C.Bad) end
	end
	connect(hit.MouseButton1Click, function() apply(not state) end)
	return { Set = apply, Get = function() return state end }
end

local function slider(page, text, min, max, default, callback)
	default = math.clamp(default, min, max)
	local c = card(page, 58)
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 14, 0, 6),
		Size = UDim2.new(1, -28, 0, 20),
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
		Parent = c,
	})
	local val = make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 14, 0, 6),
		Size = UDim2.new(1, -28, 0, 20),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = C.Sub,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = tostring(default),
		Parent = c,
	})
	local hit = make("Frame", {
		Position = UDim2.new(0, 14, 0, 28),
		Size = UDim2.new(1, -28, 0, 24),
		BackgroundTransparency = 1,
		Parent = c,
	})
	local bar = make("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundColor3 = C.Card2,
		BackgroundTransparency = 0.2,
		Parent = hit,
	}, { corner(4) })
	local rel0 = (default - min) / (max - min)
	local fill = make("Frame", {
		Size = UDim2.new(rel0, 0, 1, 0),
		BorderSizePixel = 0,
		Parent = bar,
	}, { corner(4) })
	trackAccent(fill, "BackgroundColor3")
	local knob = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(rel0, 0, 0.5, 0),
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.new(1, 1, 1),
		ZIndex = 2,
		Parent = bar,
	}, { corner(8) })

	local dragging = false
	local function update(x)
		local w = math.max(bar.AbsoluteSize.X, 1)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / w, 0, 1)
		local v = math.floor(min + (max - min) * rel + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		knob.Position = UDim2.new(rel, 0, 0.5, 0)
		val.Text = tostring(v)
		pcall(callback, v)
	end
	connect(hit.InputBegan, function(i)
		if isPointer(i) then dragging = true; page.ScrollingEnabled = false; update(i.Position.X) end
	end)
	connect(UIS.InputChanged, function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			update(i.Position.X)
		end
	end)
	connect(UIS.InputEnded, function(i)
		if dragging and isPointer(i) then dragging = false; page.ScrollingEnabled = true end
	end)
end

local function textbox(page, placeholder, height, multiline)
	return make("TextBox", {
		Size = UDim2.new(1, 0, 0, height or 38),
		BackgroundColor3 = C.Card,
		BackgroundTransparency = 0.3,
		Font = multiline and Enum.Font.Code or Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = C.Text,
		PlaceholderText = placeholder,
		PlaceholderColor3 = C.Sub,
		Text = "",
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		MultiLine = multiline or false,
		TextWrapped = multiline or false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = multiline and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
		Parent = page,
	}, { corner(10), stroke(CFG.Accent, 1, 0.4), pad(10, 8, 10, 8) })
end

local function buttonRow(page, defs)
	local row = make("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		Parent = page,
	}, {
		make("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	local n = #defs
	for idx, d in ipairs(defs) do
		local b = make("TextButton", {
			Size = UDim2.new(1 / n, -8 * (n - 1) / n, 1, 0),
			BackgroundColor3 = d.color,
			BackgroundTransparency = 0.15,
			Font = Enum.Font.GothamBold,
			TextColor3 = Color3.new(1, 1, 1),
			Text = d.text,
			TextScaled = true,
			LayoutOrder = idx,
			Parent = row,
		}, { corner(10), pad(6, 8, 6, 8), make("UITextSizeConstraint", { MaxTextSize = 13, MinTextSize = 8 }) })
		connect(b.MouseButton1Click, function()
			local ok, err = pcall(d.callback)
			if not ok then notify("Error", tostring(err), C.Bad) end
		end)
	end
	return row
end

--// BUAT HALAMAN
local Home = newTab("Home", "🏠", 1)
local PlayerPg = newTab("Player", "🏃", 2)
local ScriptsPg = newTab("Scripts", "📜", 3)
local SettingsPg = newTab("Settings", "⚙️", 4)
local CreditsPg = newTab("Credits", "👑", 5)

local cleanup

--// ========== HOME ==========
do
	local hero = card(Home, 96)
	local avatar = make("ImageLabel", {
		Position = UDim2.new(0, 14, 0, 14),
		Size = UDim2.fromOffset(68, 68),
		BackgroundColor3 = C.Card2,
		BackgroundTransparency = 0.3,
		Image = "rbxthumb://type=AvatarHeadShot&id=" .. LP.UserId .. "&w=150&h=150",
		Parent = hero,
	}, { corner(34) })
	local ring = stroke(CFG.Accent, 2, 0)
	ring.Parent = avatar
	trackAccent(ring, "Color")

	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 96, 0, 18),
		Size = UDim2.new(1, -106, 0, 22),
		Font = Enum.Font.GothamBlack,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = C.Text,
		Text = "Halo, " .. LP.DisplayName,
		Parent = hero,
	})
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 96, 0, 44),
		Size = UDim2.new(1, -106, 0, 18),
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = C.Sub,
		Text = "@" .. LP.Name .. "  •  ID " .. LP.UserId,
		Parent = hero,
	})
	local powered = make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 96, 0, 64),
		Size = UDim2.new(1, -106, 0, 18),
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = CFG.Accent,
		Text = "System Mode: Hacker Live Active",
		Parent = hero,
	})
	trackAccent(powered, "TextColor3")

	section(Home, "Statistik Live")
	local stat = card(Home, 74)
	local function statLabel(x, txt)
		return make("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(x, 8, 0, 10),
			Size = UDim2.new(0.33, -8, 0, 54),
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = C.Text,
			Text = txt,
			Parent = stat,
		})
	end
	local fpsL = statLabel(0, "FPS\n0")
	local pingL = statLabel(0.335, "PING\n0 ms")
	local plrL = statLabel(0.67, "PEMAIN\n" .. #Players:GetPlayers())

	local frames, last = 0, os.clock()
	connect(RunService.RenderStepped, function()
		frames = frames + 1
		if os.clock() - last >= 1 then
			fpsL.Text = "FPS\n" .. frames
			frames, last = 0, os.clock()
			local ok, ping = pcall(function() return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
			pingL.Text = "PING\n" .. (ok and ping or 0) .. " ms"
			plrL.Text = "PEMAIN\n" .. #Players:GetPlayers()
		end
	end)

	section(Home, "Info System")
	local gi = card(Home, 56)
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 14, 0, 0),
		Size = UDim2.new(1, -28, 1, 0),
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = C.Sub,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "PlaceId: " .. game.PlaceId .. "\nJobId: " .. (game.JobId ~= "" and string.sub(game.JobId, 1, 24) or "Studio"),
		Parent = gi,
	})
end

--// ========== PLAYER ==========
local flying, noclip, infJump, esp, antiAfk = false, false, false, false, true
local customSpeed, customJump = nil, nil
local flySpeed = 60
local flyUp, flyDown = false, false
local bv, bg
local stopFly
local flyToggle

local function getHum()
	local ch = LP.Character
	return ch and ch:FindFirstChildOfClass("Humanoid")
end
local function getOWNER()
	local ch = LP.Character
	return ch and ch:FindFirstChild("HumanoidOWNERPart")
end

local FlyPad = make("Frame", {
	Name = "FlyPad",
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -14, 0.5, -40),
	Size = UDim2.fromOffset(64, 140),
	BackgroundTransparency = 1,
	Visible = false,
	ZIndex = 40,
	Parent = Gui,
}, {
	make("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }),
})
do
	local function padBtn(text, order, setter)
		local b = make("TextButton", {
			Size = UDim2.fromOffset(64, 64),
			BackgroundColor3 = C.Card,
			BackgroundTransparency = 0.2,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = C.Text,
			Text = text,
			AutoButtonColor = false,
			LayoutOrder = order,
			Parent = FlyPad,
		}, { corner(32), stroke(CFG.Accent, 2, 0.1) })
		connect(b.InputBegan, function(i)
			if isPointer(i) then setter(true); smoothTween(b, 0.1, { BackgroundColor3 = CFG.Accent }) end
		end)
		connect(UIS.InputEnded, function(i)
			if isPointer(i) then setter(false); smoothTween(b, 0.1, { BackgroundColor3 = C.Card }) end
		end)
	end
	padBtn("UP", 1, function(v) flyUp = v end)
	padBtn("DOWN", 2, function(v) flyDown = v end)
end

stopFly = function()
	flying = false
	flyUp, flyDown = false, false
	if bv then bv:Destroy() bv = nil end
	if bg then bg:Destroy() bg = nil end
	local h = getHum()
	if h then h.PlatformStand = false end
	FlyPad.Visible = false
end

local function startFly()
	local OWNER, hum = getOWNER(), getHum()
	if not OWNER or not hum then notify("Fly", "Karakter belum siap.", C.Bad) return false end
	stopFly()
	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.Velocity = Vector3.zero
	bv.Parent = OWNER
	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
	bg.P = 9e4
	bg.CFrame = OWNER.CFrame
	bg.Parent = OWNER
	hum.PlatformStand = true
	flying = true
	FlyPad.Visible = IS_TOUCH
	return true
end

do
	section(PlayerPg, "Movement")
	local h0 = getHum()
	local ws0 = h0 and math.floor(h0.WalkSpeed + 0.5) or 16
	local jp0 = h0 and math.floor(h0.JumpPower + 0.5) or 50

	slider(PlayerPg, "WalkSpeed", 16, 250, ws0, function(v)
		customSpeed = v
		local h = getHum()
		if h then h.WalkSpeed = v end
	end)
	slider(PlayerPg, "JumpPower", 50, 300, jp0, function(v)
		customJump = v
		local h = getHum()
		if h then h.UseJumpPower = true; h.JumpPower = v end
	end)

	connect(RunService.Heartbeat, function()
		local h = getHum()
		if h then
			if customSpeed and h.WalkSpeed ~= customSpeed then h.WalkSpeed = customSpeed end
			if customJump and h.JumpPower ~= customJump then h.UseJumpPower = true; h.JumpPower = customJump end
		end
	end)

	section(PlayerPg, "Abilities")

	flyToggle = toggle(PlayerPg, IS_TOUCH and "Fly  (joystick + tombol UP/DOWN)" or "Fly  (WASD + Space / Shift)", false, function(s)
		if s then
			if not startFly() then flyToggle.Set(false) end
		else
			stopFly()
		end
	end)
	slider(PlayerPg, "Fly Speed", 20, 300, 60, function(v) flySpeed = v end)

	connect(RunService.RenderStepped, function()
		if not (flying and bv and bg) then return end
		local OWNER = getOWNER()
		if not OWNER or not bv.Parent then return end
		local cam = workspace.CurrentCamera
		local hum = getHum()
		local dir = Vector3.zero
		local move = hum and hum.MoveDirection or Vector3.zero
		if move.Magnitude > 0.05 then
			local rel = cam.CFrame:VectorToObjectSpace(move)
			dir = cam.CFrame.LookVector * (-rel.Z) + cam.CFrame.RightVector * rel.X
		else
			if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
		end
		if flyUp or UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
		if flyDown or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
		if dir.Magnitude > 0.01 then
			bv.Velocity = dir.Unit * flySpeed
		else
			bv.Velocity = Vector3.zero
		end
		bg.CFrame = CFrame.new(OWNER.Position, OWNER.Position + cam.CFrame.LookVector)
	end)

	toggle(PlayerPg, "Noclip", false, function(s) noclip = s end)
	connect(RunService.Stepped, function()
		if noclip and LP.Character then
			for _, p in ipairs(LP.Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
		end
	end)

	toggle(PlayerPg, "Infinite Jump", false, function(s) infJump = s end)
	connect(UIS.JumpRequest, function()
		if infJump then
			local h = getHum()
			if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
		end
	end)

	local espFolder = make("Folder", { Name = "VirgoESP", Parent = Gui })
	local espObjs = {}
	local function removeEsp(plr)
		local h = espObjs[plr]
		if h then h:Destroy() espObjs[plr] = nil end
	end
	local function updateEsp(plr)
		removeEsp(plr)
		if not esp or plr == LP then return end
		local ch = plr.Character
		if not ch then return end
		local h = Instance.new("Highlight")
		h.FillColor = CFG.Accent
		h.FillTransparency = 0.6
		h.OutlineColor = Color3.new(1, 1, 1)
		h.Adornee = ch
		h.Parent = espFolder
		espObjs[plr] = h
	end
	local function hookPlayer(plr)
		if plr == LP then return end
		connect(plr.CharacterAdded, function() task.wait(0.15); updateEsp(plr) end)
	end
	for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
	connect(Players.PlayerAdded, hookPlayer)
	connect(Players.PlayerRemoving, removeEsp)
	onTheme(function() for _, h in pairs(espObjs) do h.FillColor = CFG.Accent end end)
	toggle(PlayerPg, "ESP Pemain (Highlight)", false, function(s)
		esp = s
		for _, p in ipairs(Players:GetPlayers()) do updateEsp(p) end
	end)

	toggle(PlayerPg, "Anti-AFK", true, function(s) antiAfk = s end)
	connect(LP.Idled, function()
		if antiAfk then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
	end)

	section(PlayerPg, "Utility")
	button(PlayerPg, "Reset Karakter", function()
		local h = getHum()
		if h then h.Health = 0 end
	end)
	button(PlayerPg, "Rejoin Server", function()
		local TS = game:GetService("TeleportService")
		if game.JobId ~= "" then TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) else TS:Teleport(game.PlaceId, LP) end
	end)

	connect(LP.CharacterAdded, function(char)
		flyToggle.Set(false)
		local hum = char:WaitForChild("Humanoid", 10)
		if hum then
			if customSpeed then hum.WalkSpeed = customSpeed end
			if customJump then hum.UseJumpPower = true; hum.JumpPower = customJump end
		end
	end)
end

--// ========== SCRIPTS ==========
local library = {}
local libList
local Editor

local function saveLibrary()
	if not hasFS then return end
	pcall(function() writefile(CFG.SaveFile, HttpService:JSONEncode(library)) end)
end

local function loadLibrary()
	if hasFS then
		local okE, exists = pcall(isfile, CFG.SaveFile)
		if okE and exists then
			local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CFG.SaveFile)) end)
			if ok and type(data) == "table" then library = data end
		end
	end
	if #library == 0 then
		library = { { name = "Contoh: Hello", code = 'print("Halo dari Virgoboy Hub!")' } }
	end
end

local function runCode(code)
	if isBlank(code) then notify("Scripts", "Editor kosong.", C.Bad) return end
	local ls = loadstring
	if not ls then notify("Scripts", "loadstring tidak tersedia.", C.Bad) return end
	local fn, err = ls(code)
	if not fn then notify("Syntax Error", tostring(err), C.Bad) return end
	notify("Execute", "Script dijalankan.", C.Good)
	task.spawn(function()
		local ok, e = pcall(fn)
		if not ok then notify("Runtime Error", tostring(e), C.Bad) end
	end)
end

local function httpGet(url)
	if not url:match("^https?://") then return nil, "URL harus diawali http:// atau https://" end
	local ok, res = pcall(function() return game:HttpGet(url) end)
	if ok and type(res) == "string" then return res end
	local req = (syn and syn.request) or http_request or request
	if req then
		local ok2, r = pcall(req, { Url = url, Method = "GET" })
		if ok2 and type(r) == "table" and type(r.Body) == "string" then return r.Body end
	end
	local ok3, res3 = pcall(function() return HttpService:GetAsync(url) end)
	if ok3 and type(res3) == "string" then return res3 end
	return nil, tostring(res)
end

local function renderLibrary()
	for _, ch in ipairs(libList:GetChildren()) do if ch:IsA("Frame") then ch:Destroy() end end
	for i, item in ipairs(library) do
		local row = make("Frame", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = C.Card,
			BackgroundTransparency = 0.3,
			LayoutOrder = i,
			Parent = libList,
		}, { corner(10), stroke(CFG.Accent, 1, 0.5) })
		trackAccent(row:FindFirstChildOfClass("UIStroke"), "Color")
		
		make("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 12, 0, 0),
			Size = UDim2.new(1, -176, 1, 0),
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			TextColor3 = C.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Text = item.name,
			Parent = row,
		})
		local function mini(text, x, color, cb)
			local b = make("TextButton", {
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, x, 0.5, 0),
				Size = UDim2.fromOffset(48, 28),
				BackgroundColor3 = color,
				BackgroundTransparency = 0.15,
				Font = Enum.Font.GothamBold,
				TextSize = 11,
				TextColor3 = Color3.new(1, 1, 1),
				Text = text,
				Parent = row,
			}, { corner(7) })
			connect(b.MouseButton1Click, cb)
		end
		mini("RUN", -108, C.Good, function() runCode(item.code) end)
		mini("LOAD", -58, CFG.Accent, function() Editor.Text = item.code; notify("Library", "Dimuat ke editor: " .. item.name) end)
		mini("DEL", -8, C.Bad, function() table.remove(library, i); saveLibrary(); renderLibrary() end)
	end
end

do
	loadLibrary()
	section(ScriptsPg, "Editor Script Lua")
	Editor = textbox(ScriptsPg, "-- Tempel script Lua kamu di sini...", 150, true)

	buttonRow(ScriptsPg, {
		{ text = "EXECUTE", color = C.Good, callback = function() runCode(Editor.Text) end },
		{ text = "CLEAR", color = C.Bad, callback = function() Editor.Text = "" end },
		{ text = "COPY", color = C.Card2, callback = function()
			if setclipboard then setclipboard(Editor.Text); notify("Clipboard", "Script disalin.")
			else notify("Clipboard", "Tidak didukung executor.", C.Bad) end
		end },
	})

	section(ScriptsPg, "Simpan ke Library")
	local nameBox = textbox(ScriptsPg, "Nama script...", 38, false)
	button(ScriptsPg, "💾  Simpan Script ke Library", function()
		local nm = trim(nameBox.Text)
		if nm == "" or isBlank(Editor.Text) then notify("Library", "Isi nama dan script dulu.", C.Bad) return end
		local replaced = false
		for _, item in ipairs(library) do
			if item.name == nm then item.code = Editor.Text; replaced = true end
		end
		if not replaced then table.insert(library, { name = nm, code = Editor.Text }) end
		saveLibrary(); renderLibrary(); nameBox.Text = ""
		notify("Library", (replaced and "Diperbarui: " or "Tersimpan: ") .. nm, C.Good)
	end)

	section(ScriptsPg, "Load dari URL")
	local urlBox = textbox(ScriptsPg, "https://raw.githubusercontent.com/.../script.lua", 38, false)
	buttonRow(ScriptsPg, {
		{ text = "AMBIL KE EDITOR", color = CFG.Accent, callback = function()
			local r, err = httpGet(trim(urlBox.Text))
			if r then Editor.Text = r; notify("URL", "Script dimuat ke editor.", C.Good)
			else notify("HttpGet Gagal", tostring(err), C.Bad) end
		end },
		{ text = "AMBIL & JALANKAN", color = C.Good, callback = function()
			local r, err = httpGet(trim(urlBox.Text))
			if r then runCode(r) else notify("HttpGet Gagal", tostring(err), C.Bad) end
		end },
	})

	section(ScriptsPg, "Library Script Tersimpan")
	libList = make("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = ScriptsPg,
	}, { make("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }) })
	renderLibrary()
end

--// ========== SETTINGS ==========
local function setTheme(name, col)
	CFG.ThemeName = name; CFG.Accent = col
	for _, f in ipairs(themeFns) do pcall(f) end
	saveSettings()
	notify("Tema", "Tema diganti ke " .. name, col)
end

do
	section(SettingsPg, "Pilih Tema Warna")
	local grid = make("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = SettingsPg,
	}, { make("UIGridLayout", { CellSize = UDim2.fromOffset(88, 38), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder }) })
	for idx, t in ipairs(THEMES) do
		local b = make("TextButton", {
			BackgroundColor3 = t[2],
			BackgroundTransparency = 0.15,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Color3.new(1, 1, 1),
			Text = t[1],
			LayoutOrder = idx,
			Parent = grid,
		}, { corner(10) })
		connect(b.MouseButton1Click, function() setTheme(t[1], t[2]) end)
	end

	if not IS_MOBILE then
		section(SettingsPg, "Tombol Toggle Hub")
		local keyBtn
		keyBtn = button(SettingsPg, "Toggle Key: " .. CFG.ToggleKey.Name .. "  (klik untuk ganti)", function()
			keyBtn.Text = "Tekan tombol baru...  (Esc = batal)"
			local c
			c = connect(UIS.InputBegan, function(i)
				if i.UserInputType == Enum.UserInputType.Keyboard then
					c:Disconnect()
					if i.KeyCode ~= Enum.KeyCode.Escape and i.KeyCode ~= Enum.KeyCode.Unknown then
						CFG.ToggleKey = i.KeyCode; saveSettings()
						notify("Settings", "Toggle key: " .. i.KeyCode.Name)
					end
					keyBtn.Text = "Toggle Key: " .. CFG.ToggleKey.Name .. "  (klik untuk ganti)"
				end
			end)
		end)
	end

	section(SettingsPg, "Zona Bahaya")
	button(SettingsPg, "Destroy Virgoboy Hub", function() cleanup() end)
end

--// ========== CREDITS ==========
do
	local c = card(CreditsPg, 160)
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 14),
		Size = UDim2.new(1, -32, 0, 28),
		Font = Enum.Font.GothamBlack,
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = C.Text,
		Text = "VIRGOBOY HUB",
		Parent = c,
	})
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 46),
		Size = UDim2.new(1, -32, 0, 100),
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = C.Sub,
		Text = "Owner & Developer : " .. CFG.Owner .. "\nVersi : " .. CFG.Version
			.. "\nStatus : Hacker Live Animation Edition\n\nTerima kasih sudah memakai sistem kami!",
		Parent = c,
	})
end

--// ========== BUBBLE (MINIMIZE LOGO) ==========
local Bubble = make("ImageButton", {
	Name = "Bubble",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0, 44, 0.4, 0),
	Size = UDim2.fromOffset(58, 58),
	BackgroundTransparency = 1,
	Image = "rbxassetid://128092559044681",
	ScaleType = Enum.ScaleType.Fit,
	AutoButtonColor = false,
	Visible = false,
	ZIndex = 30,
	Parent = Gui,
}, { corner(29) })

local bubbleStroke = stroke(CFG.Accent, 3, 0.05)
bubbleStroke.Parent = Bubble
trackAccent(bubbleStroke, "Color")
TweenService:Create(
	bubbleStroke,
	TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	{ Transparency = 0.7 }
):Play()

--// BUKA / TUTUP WINDOW
local token = 0

local function showMain()
	token = token + 1
	Bubble.Visible = false
	Main.Visible = true
	Main.Size = UDim2.fromOffset(0, 0)
	Main.Position = Bubble.Position
	tween(Main, 0.35, { Size = curSize, Position = lastMainPos })
end

local function hideMain()
	token = token + 1
	local my = token
	if Main.AbsoluteSize.X >= curSize.X.Offset - 6 then lastMainPos = Main.Position end
	smoothTween(Main, 0.25, { Size = UDim2.fromOffset(0, 0), Position = Bubble.Position })
	task.delay(0.28, function()
		if my == token then Main.Visible = false; Bubble.Visible = true end
	end)
end

local function toggleMain()
	if Main.Visible then hideMain() else showMain() end
end

makeDraggable(Top, Main, 80, 30, nil, function() lastMainPos = Main.Position end)
makeDraggable(Bubble, Bubble, 32, 32, function() showMain() end, nil)
connect(MinBtn.MouseButton1Click, hideMain)

--// KONFIRMASI TUTUP
local Confirm = make("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.4,
	Visible = false,
	Active = true,
	ZIndex = 20,
	Parent = Main,
})
do
	local box = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(250, 120),
		BackgroundColor3 = C.Card,
		BackgroundTransparency = 0.1,
		ZIndex = 21,
		Parent = Confirm,
	}, { corner(12), stroke(CFG.Accent, 1.5, 0.2) })
	trackAccent(box:FindFirstChildOfClass("UIStroke"), "Color")
	
	make("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 12),
		Size = UDim2.new(1, -24, 0, 40),
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextWrapped = true,
		TextColor3 = C.Text,
		Text = "Tutup Virgoboy Hub sepenuhnya?",
		ZIndex = 22,
		Parent = box,
	})
	local function cbtn(text, x, color, cb)
		local b = make("TextButton", {
			Position = UDim2.new(x, x == 0 and 12 or 4, 0, 68),
			Size = UDim2.new(0.5, -16, 0, 36),
			BackgroundColor3 = color,
			BackgroundTransparency = 0.1,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = Color3.new(1, 1, 1),
			Text = text,
			ZIndex = 22,
			Parent = box,
		}, { corner(8) })
		connect(b.MouseButton1Click, cb)
	end
	cbtn("Tutup", 0, C.Bad, function() cleanup() end)
	cbtn("Batal", 0.5, C.Card2, function() Confirm.Visible = false end)
end
connect(CloseBtn.MouseButton1Click, function() Confirm.Visible = true end)

--// LAYOUT RESPONSIF
local function applyLayout()
	local vp = getVP()
	local w = math.clamp(vp.X * 0.9, 300, FULL_W)
	local h = math.clamp(vp.Y * 0.88, 260, FULL_H)
	local compact = w < 520
	curSize = UDim2.fromOffset(w, h)

	local sideW = compact and 56 or 150
	local sp = compact and 8 or 10
	SidePad.PaddingLeft = UDim.new(0, sp)
	SidePad.PaddingRight = UDim.new(0, sp)
	Side.Size = UDim2.new(0, sideW, 1, -44)
	Content.Position = UDim2.new(0, sideW, 0, 44)
	Content.Size = UDim2.new(1, -sideW, 1, -44)

	ownerTag.Position = UDim2.new(0, sp, 1, -10)
	ownerTag.Size = UDim2.fromOffset(sideW - sp * 2, 30)
	ownerTag.Text = compact and "🛡️" or ("🛡️ OWNER: " .. string.upper(CFG.Owner))
	ownerTag.Visible = (h - 44) >= 290
	versionLbl.Visible = not compact

	for name, m in pairs(tabMeta) do
		if compact then
			m.btn.Text = m.icon; m.btn.TextSize = 18; m.btn.TextXAlignment = Enum.TextXAlignment.Center; m.pad.PaddingLeft = UDim.new(0, 0)
		else
			m.btn.Text = m.icon .. "  " .. name; m.btn.TextSize = 13; m.btn.TextXAlignment = Enum.TextXAlignment.Left; m.pad.PaddingLeft = UDim.new(0, 14)
		end
	end

	if Main.Visible and Main.AbsoluteSize.X > 40 then Main.Size = curSize end
	lastMainPos = clampPos(lastMainPos, 80, 30)
	if Main.Visible then Main.Position = clampPos(Main.Position, 80, 30) end
	Bubble.Position = clampPos(Bubble.Position, 32, 32)
end

connect(Gui:GetPropertyChangedSignal("AbsoluteSize"), applyLayout)

--// TOGGLE KEY
connect(UIS.InputBegan, function(i, gp)
	if gp then return end
	if i.KeyCode == CFG.ToggleKey then toggleMain() end
end)

--// CLEANUP
cleanup = function()
	for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
	table.clear(connections)
	pcall(stopFly)
	flying, noclip, infJump, esp = false, false, false, false
	pcall(function() Gui:Destroy() end)
	_G.VirgoboyHubCleanup = nil
end
_G.VirgoboyHubCleanup = cleanup

--// START
applyLayout()
selectTab("Home")
Main.Visible = true
Main.Position = lastMainPos
Main.Size = UDim2.fromOffset(0, 0)
tween(Main, 0.45, { Size = curSize })
task.delay(0.5, function()
	local hint = IS_MOBILE and "Tekan – untuk jadi bubble." or ("Tekan " .. CFG.ToggleKey.Name .. " untuk buka/tutup.")
	notify("Virgoboy.sys", "Akses diberikan, " .. LP.DisplayName .. "! " .. hint, CFG.Accent)
end)

print("[Virgoboy Hub] v" .. CFG.Version .. " [Hacker Live Animated] loaded - Owner: " .. CFG.Owner)
