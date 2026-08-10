-- =============================================================================
--  VIRGOBOY HUB GOLD V20 — THE MORGUE SHIFT (AUTO EXECUTE ON)
-- =============================================================================

local targetGuiParent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Cek GUI menu lama & notif lama, jika ada langsung hapus
local guiLama = targetGuiParent:FindFirstChild("VirgoboyCustomHub")
local notifLama = targetGuiParent:FindFirstChild("VirgoboyNotifGui")
if guiLama then guiLama:Destroy() end
if notifLama then notifLama:Destroy() end

-- Bersihkan sisa Highlight ESP lama yang menempel di monster/player
for _, v in pairs(workspace:GetDescendants()) do
    if v.Name == "Virgo_ESP" or v.Name == "Virgo_Tag" or v.Name == "Player_ESP_Virgo" then
        v:Destroy()
    end
end
task.wait(0.1)

local function buatNotifikasi(judul, pesan, durasi)
    durasi = durasi or 3.5
    local notifGui = targetGuiParent:FindFirstChild("VirgoboyNotifGui")
    if not notifGui then
        notifGui = Instance.new("ScreenGui")
        notifGui.Name = "VirgoboyNotifGui"
        notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifGui.Parent = targetGuiParent
    end

    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "NotifCard"
    notifFrame.Size = UDim2.new(0, 260, 0, 65)
    notifFrame.Position = UDim2.new(1, 30, 0.85, 0)
    notifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    notifFrame.BackgroundTransparency = 0.25
    notifFrame.ZIndex = 10
    notifFrame.Parent = notifGui

    local nCorner = Instance.new("UICorner") nCorner.CornerRadius = UDim.new(0, 8) nCorner.Parent = notifFrame
    local nStroke = Instance.new("UIStroke") nStroke.Color = Color3.fromRGB(255, 215, 0) nStroke.Thickness = 1 nStroke.Parent = notifFrame

    local lineAksen = Instance.new("Frame")
    lineAksen.Size = UDim2.new(0, 4, 1, 0)
    lineAksen.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    lineAksen.BorderSizePixel = 0
    lineAksen.ZIndex = 11
    lineAksen.Parent = notifFrame
    Instance.new("UICorner", lineAksen).CornerRadius = UDim.new(0, 4)

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, -20, 0, 22)
    tLabel.Position = UDim2.new(0, 14, 0, 6)
    tLabel.BackgroundTransparency = 1
    tLabel.Text = "✨ " .. string.upper(judul)
    tLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    tLabel.TextSize = 11
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.ZIndex = 11
    tLabel.Parent = notifFrame

    local pLabel = Instance.new("TextLabel")
    pLabel.Size = UDim2.new(1, -20, 0, 30)
    pLabel.Position = UDim2.new(0, 14, 0, 26)
    pLabel.BackgroundTransparency = 1
    pLabel.Text = pesan
    pLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    pLabel.TextSize = 11
    pLabel.Font = Enum.Font.GothamMedium
    pLabel.TextWrapped = true
    pLabel.TextXAlignment = Enum.TextXAlignment.Left
    pLabel.TextYAlignment = Enum.TextYAlignment.Top
    pLabel.ZIndex = 11
    pLabel.Parent = notifFrame

    notifFrame:TweenPosition(UDim2.new(1, -280, 0.85, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
    task.wait(durasi)

    for i = 0, 1, 0.1 do
        notifFrame.BackgroundTransparency = 0.25 + (i * 0.75)
        nStroke.Transparency = i
        lineAksen.BackgroundTransparency = i
        tLabel.TextTransparency = i
        pLabel.TextTransparency = i
        task.wait(0.02)
    end
    notifFrame:Destroy()
end

task.spawn(buatNotifikasi, "Virgoboy Hub", "System Core Framework Loaded!", 3)

local daftarFitur = {
    "Memuat System Core Framework...",
    "Mengaktifkan Otomatis Semua Fitur Utama...",
    "Sinkronisasi Remote & Instant Interact...",
    "Menyiapkan Auto Ambil Tali Poci...",
    "Menyiapkan Auto Bersihkan Lantai (Stain)...",
    "Membangun Custom Glassmorphic GUI Engine...",
    "Menyuntikkan Gambar Arlun Background & Logo...",
    "Menyiapkan God Mode V6 (Anti-Death)...",
    "Mengaktifkan Proteksi Hitbox & Visual ESP...",
    "Semua Fitur Berhasil Dimuat! Membuka Menu..."
}

local function jalankanIntro()
    local sg = Instance.new("ScreenGui")
    sg.Name = "VirgoboyIntroGui"
    sg.IgnoreGuiInset = true
    sg.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = sg

    local introBgImage = Instance.new("ImageLabel")
    introBgImage.Name = "IntroArlunBg"
    introBgImage.Size = UDim2.new(1, 0, 1, 0)
    introBgImage.Image = "rbxassetid://124020551286590"
    introBgImage.ScaleType = Enum.ScaleType.Crop
    introBgImage.BackgroundTransparency = 1
    introBgImage.Parent = bg

    local introOverlay = Instance.new("Frame")
    introOverlay.Name = "IntroOverlay"
    introOverlay.Size = UDim2.new(1, 0, 1, 0)
    introOverlay.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    introOverlay.BackgroundTransparency = 0.4
    introOverlay.BorderSizePixel = 0
    introOverlay.Parent = bg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0.35, 0)
    title.BackgroundTransparency = 1
    title.Text = "THE MORGUE SHIFT | TALI POCONG "
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 2
    title.Parent = bg

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0.45, 0)
    status.BackgroundTransparency = 1
    status.Text = "Menghubungkan..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.TextSize = 14
    status.Font = Enum.Font.Gotham
    status.ZIndex = 2
    status.Parent = bg

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0, 260, 0, 6)
    barBg.Position = UDim2.new(0.5, -130, 0.52, 0)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    barBg.BorderSizePixel = 0
    barBg.ZIndex = 2
    barBg.Parent = bg

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    bar.BorderSizePixel = 0
    bar.ZIndex = 2
    bar.Parent = barBg

    for i, teksFitur in ipairs(daftarFitur) do
        status.Text = teksFitur
        local targetSize = UDim2.new(i / #daftarFitur, 0, 1, 0)
        bar:TweenSize(targetSize, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.12, true)
        task.wait()
    end

    for i = 0, 1, 0.1 do
        bg.BackgroundTransparency = i
        introBgImage.ImageTransparency = i
        introOverlay.BackgroundTransparency = i + (1 - i) * 0.4
        title.TextTransparency = i
        status.TextTransparency = i
        barBg.BackgroundTransparency = i
        bar.BackgroundTransparency = i
        task.wait(0.01)
    end
    sg:Destroy()
end

jalankanIntro()

-- [[ SYSTEM VARIABLES — AUTO ON BY DEFAULT ]] --
local lp = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local autoAcceptPhone = true
local interactActive = true        -- AUTO ON
local remoteInteractActive = true  -- AUTO ON
local promptConnection = nil 
local espActive = true             -- AUTO ON
local playerEspActive = true       -- AUTO ON
local noclipActive = true          -- AUTO ON
local autoNailActive = true        -- AUTO ON
local autoCleanActive = true       -- AUTO ON
local godModeActive = true         -- AUTO ON
local cameraClassicActive = false  -- TETAP OFF (Sesuai Permintaan)
local currentSpeed = 30            -- Walkspeed langsung di-boost seimbang
local stainIndex = 1
local espObjects = {}
local playerEspTable = {} 
local detectedPoci = {} 
local targetPoci = nil

-- [[ CORE LOGIC FUNCTIONS ]] --
local function pelumpuhKematian(char)
    if not char then return end
    task.wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if godModeActive then
        pcall(function()
            if char:FindFirstChild("KillScript") then char.KillScript:Destroy() end
            if char:FindFirstChild("LocalScript") then char.LocalScript:Destroy() end
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            end
        end)
    else
        pcall(function()
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                hum.MaxHealth = 100
                hum.Health = 100
            end
        end)
    end
end

local function teleportTo(target)
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetCF
    if type(target) == "string" then
        local obj = workspace:FindFirstChild(target, true)
        if obj and (obj:IsA("BasePart") or obj:IsA("Model")) then
            targetCF = obj:IsA("Model") and obj:GetModelCFrame() or obj.CFrame
        end
    elseif typeof(target) == "CFrame" then
        targetCF = target
    end
    if targetCF then
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, 0, 0)
        hrp.Anchored = true 
        hrp.CFrame = targetCF * CFrame.new(0, 4.5, 0) 
        task.wait(0.05) 
        hrp.Anchored = false
    end
end

local function updatePrompt(v)
    if v:IsA("ProximityPrompt") then
        v:SetAttribute("OrigHold", v:GetAttribute("OrigHold") or v.HoldDuration)
        v:SetAttribute("OrigDist", v:GetAttribute("OrigDist") or v.MaxActivationDistance)
        v:SetAttribute("OrigLos", v:GetAttribute("OrigLos") == nil and v.RequiresLineOfSight or v:GetAttribute("OrigLos"))
        v.HoldDuration = interactActive and 0 or v:GetAttribute("OrigHold")
        v.MaxActivationDistance = remoteInteractActive and 100 or v:GetAttribute("OrigDist")
        v.RequiresLineOfSight = remoteInteractActive and false or v:GetAttribute("OrigLos")
    end
end

local function refreshAllPrompts()
    for _, v in pairs(workspace:GetDescendants()) do updatePrompt(v) end
end

local function managePromptListener()
    if interactActive or remoteInteractActive then
        if not promptConnection then promptConnection = workspace.DescendantAdded:Connect(updatePrompt) end
    else
        if promptConnection then promptConnection:Disconnect() promptConnection = nil end
    end
end

-- Langsung picu trigger sistem prompt bawaan saat running
refreshAllPrompts()
managePromptListener()

-- [[ SYSTEM VISUAL ESP ]] --
local function createPlayerESP(player)
    if player == lp then return end
    player.CharacterAdded:Connect(function(char)
        if not playerEspActive then return end
        if char:FindFirstChild("Player_ESP_Virgo") then return end
        local highlight = Instance.new("Highlight")
        highlight.Name = "Player_ESP_Virgo"
        highlight.FillColor = Color3.fromRGB(0, 255, 120)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.Adornee = char
        highlight.Parent = char
        table.insert(playerEspTable, highlight)
    end)
    if player.Character then
        local char = player.Character
        local highlight = Instance.new("Highlight")
        highlight.Name = "Player_ESP_Virgo"
        highlight.FillColor = Color3.fromRGB(0, 255, 120)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.Adornee = char
        highlight.Parent = char
        table.insert(playerEspTable, highlight)
    end
end

-- =============================================================================
-- [[ MASTER LAYOUT CUSTOM GUI — BUATAN SENDIRI ]] --
-- =============================================================================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "VirgoboyCustomHub"
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local openBtn = Instance.new("ImageButton")
openBtn.Name = "ToggleMenuBtn"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openBtn.BackgroundTransparency = 0.1
openBtn.Image = "rbxassetid://93224938541267"
openBtn.ScaleType = Enum.ScaleType.Crop
openBtn.Parent = mainGui

local openCorner = Instance.new("UICorner") openCorner.CornerRadius = UDim.new(0, 35) openCorner.Parent = openBtn
local openStroke = Instance.new("UIStroke") openStroke.Color = Color3.fromRGB(255, 215, 0) openStroke.Thickness = 2 openStroke.Parent = openBtn

local draggingBtn, dragInputBtn, dragStartBtn, startPosBtn
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingBtn = true dragStartBtn = input.Position startPosBtn = openBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingBtn = false end end)
    end
end)
openBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInputBtn = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInputBtn and draggingBtn then
        local delta = input.Position - dragStartBtn
        openBtn.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
    end
end)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 350)
mainFrame.Position = UDim2.new(0.5, -220, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Visible = false
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner") mainCorner.CornerRadius = UDim.new(0, 12) mainCorner.Parent = mainFrame
local mainStroke = Instance.new("UIStroke") mainStroke.Color = Color3.fromRGB(255, 215, 0) mainStroke.Thickness = 1.5 mainStroke.Parent = mainFrame

local draggingFrame, dragInputFrame, dragStartFrame, startPosFrame
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Position.Y - mainFrame.AbsolutePosition.Y < 40 then 
            draggingFrame = true dragStartFrame = input.Position startPosFrame = mainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingFrame = false end end)
        end
    end
end)
mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInputFrame = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInputFrame and draggingFrame then
        local delta = input.Position - dragStartFrame
        mainFrame.Position = UDim2.new(startPosFrame.X.Scale, startPosFrame.X.Offset + delta.X, startPosFrame.Y.Scale, startPosFrame.Y.Offset + delta.Y)
    end
end)

local arlunBg = Instance.new("ImageLabel")
arlunBg.Name = "ArlunBackground"
arlunBg.Size = UDim2.new(1, 0, 1, 0)
arlunBg.Image = "rbxassetid://107641232562116"
arlunBg.ScaleType = Enum.ScaleType.Crop
arlunBg.BackgroundTransparency = 1
arlunBg.ZIndex = 0
arlunBg.Parent = mainFrame

local glassOverlay = Instance.new("Frame")
glassOverlay.Size = UDim2.new(1, 0, 1, 0)
glassOverlay.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
glassOverlay.BackgroundTransparency = 0.45
glassOverlay.BorderSizePixel = 0
glassOverlay.ZIndex = 1
glassOverlay.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 35)
titleLabel.Position = UDim2.new(0, 15, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "TALI POCONG  — THE MORGUE SHIFT"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 2
titleLabel.Parent = mainFrame

local profileFrame = Instance.new("Frame")
profileFrame.Name = "UserProfileCard"
profileFrame.Size = UDim2.new(1, -24, 0, 60)
profileFrame.Position = UDim2.new(0, 12, 0, 40)
profileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
profileFrame.BackgroundTransparency = 0.3
profileFrame.ZIndex = 3
profileFrame.Parent = mainFrame

local pCorner = Instance.new("UICorner") pCorner.CornerRadius = UDim.new(0, 8) pCorner.Parent = profileFrame
local pStroke = Instance.new("UIStroke") pStroke.Color = Color3.fromRGB(255, 215, 0) pStroke.Thickness = 1 pStroke.Parent = profileFrame

local avatarImg = Instance.new("ImageLabel")
avatarImg.Name = "UserAvatar"
avatarImg.Size = UDim2.new(0, 42, 0, 42)
avatarImg.Position = UDim2.new(0, 10, 0.5, -21)
avatarImg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id="..lp.UserId.."&w=150&h=150"
avatarImg.ZIndex = 4
avatarImg.Parent = profileFrame

local avCorner = Instance.new("UICorner") avCorner.CornerRadius = UDim.new(0, 21) avCorner.Parent = avatarImg
local avStroke = Instance.new("UIStroke") avStroke.Color = Color3.fromRGB(255, 255, 255) avStroke.Thickness = 1 avStroke.Parent = avatarImg

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(0.65, 0, 0, 20)
nameLabel.Position = UDim2.new(0, 62, 0, 10)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "Welcome, " .. lp.DisplayName .. " (@" .. lp.Name .. ")"
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextSize = 12
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.ZIndex = 4
nameLabel.Parent = profileFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.65, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 62, 0, 28)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Script: Active • BY: VIRGOBOY"
statusLabel.TextColor3 = Color3.fromRGB(0, 230, 115)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 4
statusLabel.Parent = profileFrame

local contentContainer = Instance.new("ScrollingFrame")
contentContainer.Size = UDim2.new(1, -24, 1, -112)
contentContainer.Position = UDim2.new(0, 12, 0, 106)
contentContainer.BackgroundTransparency = 1
contentContainer.ScrollBarThickness = 5
contentContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
contentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 7)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentContainer

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentContainer.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- =============================================================================
-- [[ COMPONENT BUILDER CORE FACTORY ]] --
-- =============================================================================
local function buatSection(nama)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -15, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Text = "⚡ " .. string.upper(nama) .. " ⚡"
    lbl.TextColor3 = Color3.fromRGB(255, 65, 65)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = contentContainer
end

local function buatTombol(nama, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.BackgroundTransparency = 0.25
    btn.Text = "   " .. nama
    btn.TextColor3 = Color3.fromRGB(245, 245, 245)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 3
    btn.Parent = contentContainer

    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(65, 65, 80) s.Thickness = 1 s.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        task.wait(0.08)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        btn.TextColor3 = Color3.fromRGB(245, 245, 245)
        pcall(callback)
    end)
end

local function buatToggle(nama, defaultStatus, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    frame.BackgroundTransparency = 0.35
    frame.ZIndex = 3
    frame.Parent = contentContainer

    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = frame
    local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(55, 55, 70) s.Thickness = 1 s.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = nama
    lbl.TextColor3 = Color3.fromRGB(235, 235, 235)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = frame

    local tglBtn = Instance.new("TextButton")
    tglBtn.Size = UDim2.new(0, 52, 0, 24)
    tglBtn.Position = UDim2.new(1, -64, 0.5, -12)
    tglBtn.BackgroundColor3 = defaultStatus and Color3.fromRGB(0, 205, 105) or Color3.fromRGB(75, 75, 85)
    tglBtn.Text = defaultStatus and "ON" or "OFF"
    tglBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tglBtn.TextSize = 11
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.ZIndex = 4
    tglBtn.Parent = frame

    local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 5) tc.Parent = tglBtn

    local stat = defaultStatus
    tglBtn.MouseButton1Click:Connect(function()
        stat = not stat
        tglBtn.BackgroundColor3 = stat and Color3.fromRGB(0, 205, 105) or Color3.fromRGB(75, 75, 85)
        tglBtn.Text = stat and "ON" or "OFF"
        pcall(callback, stat)
    end)
end

local function buatSlider(nama, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 46)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    frame.BackgroundTransparency = 0.35
    frame.ZIndex = 3
    frame.Parent = contentContainer

    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 0, 22)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = nama
    lbl.TextColor3 = Color3.fromRGB(235, 235, 235)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.3, 0, 0, 22)
    valLbl.Position = UDim2.new(0.7, -12, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    valLbl.TextSize = 12
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.ZIndex = 4
    valLbl.Parent = frame

    local slideBg = Instance.new("TextButton")
    slideBg.Size = UDim2.new(1, -24, 0, 6)
    slideBg.Position = UDim2.new(0, 12, 1, -12)
    slideBg.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    slideBg.Text = ""
    slideBg.ZIndex = 4
    slideBg.Parent = frame

    local slideBar = Instance.new("Frame")
    slideBar.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    slideBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    slideBar.BorderSizePixel = 0
    slideBar.ZIndex = 5
    slideBar.Parent = slideBg

    local uis = game:GetService("UserInputService")
    local aktif = false

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - slideBg.AbsolutePosition.X) / slideBg.AbsoluteSize.X, 0, 1)
        slideBar.Size = UDim2.new(pos, 0, 1, 0)
        local nilai = math.floor(min + (pos * (max - min)))
        valLbl.Text = tostring(nilai)
        pcall(callback, nilai)
    end

    slideBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            aktif = true updateSlider(input)
        end
    end)
    uis.InputChanged:Connect(function(input)
        if aktif and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            aktif = false
        end
    end)
end

local function removePlayerESP()
    for _, v in pairs(playerEspTable) do if v and v.Parent then v:Destroy() end end
    playerEspTable = {}
end

local function createESP(obj)
    if not obj or obj:FindFirstChild("Virgo_ESP") then return end 
    local hl = Instance.new("Highlight")
    hl.Name = "Virgo_ESP"
    hl.FillColor = Color3.fromRGB(255, 0, 50)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.5
    hl.Adornee = obj
    hl.Parent = obj
    
    local bill = Instance.new("BillboardGui")
    bill.Name = "Virgo_Tag"
    bill.AlwaysOnTop = true
    bill.Size = UDim2.new(0, 80, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.Adornee = obj
    bill.Parent = obj
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "[ " .. obj.Name .. " ]"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 11
    label.Font = Enum.Font.SourceSansBold
    label.Parent = bill
    table.insert(espObjects, {hl = hl, gui = bill})
end

local function removeESP()
    for _, data in pairs(espObjects) do
        if data.hl then data.hl:Destroy() end
        if data.gui then data.gui:Destroy() end
    end
    espObjects = {}
end

-- =============================================================================
-- [[ INTEGRASI MASTER FITUR GAMEPLAY KE MENU KONTEN — SINKRONISASI STATUS DEFAULT UTAMA ]] --
-- =============================================================================

buatSection("Quick Actions & Lobby")
buatTombol("🏆 Ending Aja Pocongnya Ga Ada", function()
    pcall(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Gameplay = ReplicatedStorage:WaitForChild("Gameplay")
        local SecretEndingHandler = Gameplay:WaitForChild("SecretEndingHandler")
        local EndingHandler = Gameplay:WaitForChild("EndingHandler")
        local RespawnHandler = Gameplay:FindFirstChild("RespawnHandler")

        local secretEndings = {"Truth Ending", "Invitation Ending", "Missing Ending", "Collab1 Ending", "CultInvitation Ending", "CultSacrifice Ending"}
        local mainEndings = {"Truth", "True", "Quiet", "Missing", "Invitation", "Invisible", "Incomplete", "Good", "Failed", "Bad", "Dead", "CultSacrifice", "CultInvitation", "Collab1"}

        task.spawn(function() for _, name in ipairs(secretEndings) do SecretEndingHandler:FireServer(name) task.wait(0.4) end end)
        task.spawn(function() for _, name in ipairs(mainEndings) do EndingHandler:FireServer(name) task.wait(0.4) end EndingHandler:FireServer("Leave") end)
        if RespawnHandler then task.spawn(function() RespawnHandler:FireServer() end) end
        task.spawn(function()
            local character = lp.Character or lp.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart", 5)
            local tpPart = workspace:FindFirstChild("Tp")
            if root and tpPart and tpPart:IsA("BasePart") then root.CFrame = tpPart.CFrame end
        end)
    end)
end)
buatTombol("🔄 Respawn Karakter Instan", function()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Gameplay"):WaitForChild("RespawnHandler"):FireServer()
        task.spawn(buatNotifikasi, "Respawn", "Sinyal respawn berhasil dikirim!", 2)
    end)
end)
-- FUNGSI AMBIL TALI POCI & OTOMATIS KEMBALI KE TELEPON
local function ambilTaliPociSekali()
    pcall(function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        -- Simpan posisi awal (Telepon/Lobby) sebelum berteleportasi ke poci
        local posisiAwal = rootPart.CFrame

        local found = false
        
        -- Daftar folder target pencarian (Story dan Patrol)
        local targetFolders = {
            workspace:FindFirstChild("Story"),
            workspace:FindFirstChild("Patrol")
        }

        for _, folder in ipairs(targetFolders) do
            if folder and not found then
                for _, item in ipairs(folder:GetDescendants()) do
                    -- Mendeteksi kata Poci atau Wowo (untuk patroli)
                    if item.Name:match("Poci") or item.Name:match("Wowo") then
                        local prompt = nil
                        if item:IsA("ProximityPrompt") then
                            prompt = item
                        else
                            prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                        end

                        if prompt then
                            local parentPart = prompt.Parent
                            local targetCFrame = nil

                            if parentPart and (parentPart:IsA("BasePart") or parentPart:IsA("MeshPart")) then
                                targetCFrame = parentPart.CFrame
                            elseif parentPart and parentPart:IsA("Model") then
                                local primary = parentPart.PrimaryPart or parentPart:FindFirstChildWhichIsA("BasePart", true)
                                if primary then
                                    targetCFrame = primary.CFrame
                                end
                            elseif item:IsA("BasePart") or item:IsA("MeshPart") then
                                targetCFrame = item.CFrame
                            end

                            if targetCFrame then
                                -- Teleport ke posisi Poci/Wowo
                                rootPart.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                                task.wait(0.05)

                                pcall(function()
                                    prompt.MaxActivationDistance = 99999
                                    prompt.HoldDuration = 0
                                    fireproximityprompt(prompt)
                                end)

                                found = true
                                
                                -- Beri jeda singkat agar interaksi terproses server
                                task.wait(0.1)

                                -- Teleport kembali otomatis ke posisi awal (Telepon)
                                rootPart.CFrame = posisiAwal

                                task.spawn(function()
                                    buatNotifikasi("Tali Poci", "Berhasil ambil & kembali ke telepon!", 2)
                                end)
                                break
                            end
                        end
                    end
                end
            end
        end

        if not found then
            task.spawn(function()
                buatNotifikasi("Tali Poci", "Tidak ada Poci atau Wowo di folder Story/Patrol!", 2)
            end)
        end
    end)
end

buatTombol("🎯 Ambil Tali Poci (Sekali Tekan)", function()
    ambilTaliPociSekali()
end)

buatTombol("Lobby / Area Telepon", function() teleportTo("Spawn") end)
buatTombol("Ruang Listrik (Lantai 2)", function() teleportTo(CFrame.new(25.66, 17.65, -59.71)) end)
buatTombol("Pintu Penyimpanan (Lantai 2)", function() teleportTo(CFrame.new(73.40, 17.78, -49.91)) end)

buatSection("Automation Core Matrix")
buatToggle("Instant Interact", true, function(v) interactActive = v refreshAllPrompts() managePromptListener() end) -- SET ON
buatToggle("Remote Interact", true, function(v) remoteInteractActive = v refreshAllPrompts() managePromptListener() end)   -- SET ON

buatToggle("Bersihkan Lantai", true, function(v) autoCleanActive = v end) -- SET ON

buatSection("Movement & Defensive Visuals")
buatToggle("🛡️ Mode God", true, function(v) -- SET ON
    godModeActive = v 
    if lp.Character then pelumpuhKematian(lp.Character) end
    if v then task.spawn(buatNotifikasi, "God Mode", "Mode God V6 Aktif!", 2.5) end
end)
buatToggle("🎥 Kamera Classic", false, function(v) -- TETAP OFF
    cameraClassicActive = v
    pcall(function()
        if v then lp.CameraMode = Enum.CameraMode.Classic lp.CameraMinZoomDistance = 5 lp.CameraMaxZoomDistance = 100
        else lp.CameraMode = Enum.CameraMode.LockFirstPerson lp.CameraMinZoomDistance = 0.5 lp.CameraMaxZoomDistance = 0.5 end
    end)
end)
buatSlider("WalkSpeed Booster", 16, 120, 30, function(v) currentSpeed = v end)
buatToggle("Noclip", true, function(v) noclipActive = v end)        -- SET ON
buatToggle("Entity ESP", true, function(v) espActive = v if not v then removeESP() end end) -- SET ON
buatToggle("Player ESP", true, function(v) playerEspActive = v if v then for _, p in pairs(Players:GetPlayers()) do createPlayerESP(p) end else removePlayerESP() end end) -- SET ON

local originalMaterials = {}
buatToggle("⚡ Mode Boost FPS", false, function(v)
    pcall(function()
        local lighting = game:GetService("Lighting")
        if v then
            lighting.GlobalShadows = false
            for _, effect in ipairs(lighting:GetChildren()) do if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then effect.Enabled = false end end
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then originalMaterials[obj] = {material = obj.Material, shadow = obj.CastShadow} obj.Material = Enum.Material.SmoothPlastic obj.CastShadow = false
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = false end
            end
        else
            lighting.GlobalShadows = true
            for _, effect in ipairs(lighting:GetChildren()) do if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then effect.Enabled = true end end
            for obj, properties in pairs(originalMaterials) do if obj and obj.Parent then obj.Material = properties.material obj.CastShadow = properties.shadow end end
            for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = true end end
            originalMaterials = {}
        end
    end)
end)

-- Pemicu fungsi Player ESP untuk player yang sudah ada di room saat execute
for _, p in pairs(Players:GetPlayers()) do createPlayerESP(p) end

-- =============================================================================
-- [[ BACKGROUND PROCESS LOOPING & RUNTIME ENGINE ]] --
-- =============================================================================
Players.PlayerAdded:Connect(function(p) if playerEspActive then createPlayerESP(p) end end)
lp.CharacterAdded:Connect(function(char)
    pelumpuhKematian(char)
    if cameraClassicActive then task.wait(0.2) lp.CameraMode = Enum.CameraMode.Classic lp.CameraMinZoomDistance = 5 lp.CameraMaxZoomDistance = 100 end
end)

RunService.PostSimulation:Connect(function(deltaTime)
   local char = lp.Character local hrp = char and char:FindFirstChild("HumanoidRootPart") local hum = char and char:FindFirstChild("Humanoid")
   if hum and hrp and currentSpeed > 20 and hum.MoveDirection.Magnitude > 0 then hrp.CFrame = hrp.CFrame + (hum.MoveDirection * ((currentSpeed - 20) * deltaTime)) end
end)

RunService.RenderStepped:Connect(function()
    if cameraClassicActive then
        if lp.CameraMode ~= Enum.CameraMode.Classic then lp.CameraMode = Enum.CameraMode.Classic end
        if lp.CameraMinZoomDistance ~= 5 then lp.CameraMinZoomDistance = 5 end
        if lp.CameraMaxZoomDistance ~= 1000 then lp.CameraMaxZoomDistance = 1000 end
    end
end)

RunService.Stepped:Connect(function()
    local char = lp.Character local hum = char and char:FindFirstChildOfClass("Humanoid")
    if char then
        if noclipActive then
            for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
        else
            for _, part in ipairs(char:GetChildren()) do if part:IsA("BasePart") then if part.Name ~= "HumanoidRootPart" then part.CanCollide = true end end end
            if hum then hum:ChangeState(Enum.HumanoidStateType.Running) end
        end
    end
end)

task.spawn(function()
   while task.wait() do
       if espActive then
           pcall(function()
               local patrol = workspace:FindFirstChild("Patrol")
               if patrol then for _, v in ipairs(patrol:GetChildren()) do createESP(v) task.wait(0.02) end end
               local story = workspace:FindFirstChild("Story") local trolley = story and story:FindFirstChild("ActiveTrolley") local js = trolley and trolley:FindFirstChild("Jumpscare")
               if js then for _, child in ipairs(js:GetChildren()) do if child:IsA("Model") or child:IsA("BasePart") then createESP(child) end end end
           end)
       end
   end
end)

task.spawn(function()
    while true do
        task.wait(4)
        if autoCleanActive then
            pcall(function()
                local folder = workspace:FindFirstChild("Stain")
                local stains = folder and folder:GetChildren()
                
                if stains and #stains > 0 then
                    -- Menggunakan math.random untuk memilih noda lantai secara acak
                    local randomIndex = math.random(1, #stains)
                    local target = stains[randomIndex]
                    
                    if target and target.Parent then
                        local Player = game.Players.LocalPlayer
                        local Character = Player.Character
                        local Backpack = Player:FindFirstChild("Backpack")
                        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                        
                        if Backpack and Character and Humanoid and Humanoid.Health > 0 then
                            local tool = Backpack:GetChildren()[1]
                            if tool and tool:IsA("Tool") then
                                Humanoid:EquipTool(tool)
                                task.wait()
                                tool:Activate()
                                if tool:FindFirstChild("RemoteEvent") then 
                                    tool.RemoteEvent:FireServer() 
                                end
                                task.wait()
                            end
                        end
                        local cf = target:IsA("Model") and target:GetModelCFrame() or target.CFrame
                        teleportTo(cf)
                        -- Variabel stainIndex lama sudah tidak diperlukan lagi di sini
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if godModeActive then
            if lp.Character then
                pcall(function()
                    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                    if hum then 
                        hum.MaxHealth = math.huge 
                        hum.Health = math.huge 
                        if hum:GetStateEnabled(Enum.HumanoidStateType.Dead) then 
                            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) 
                        end 
                    end
                end)
            end
            pcall(function()
                local patrol = workspace:FindFirstChild("Patrol")
                if patrol then 
                    for _, hantu in ipairs(patrol:GetChildren()) do 
                        for _, part in ipairs(hantu:GetDescendants()) do 
                            if part:IsA("TouchTransmitter") then part:Destroy() end 
                        end 
                    end 
                end
            end)
            pcall(function()
                local story = workspace:FindFirstChild("Story")
                if story then 
                    for _, objek in ipairs(story:GetDescendants()) do 
                        if objek:IsA("TouchTransmitter") then objek:Destroy() end 
                    end 
                end
            end)
        end
    end
end)

local function buatWarningTengah(pesanUtama, subPesan, durasi)
    durasi = durasi or 3
    local targetParent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    local wGui = Instance.new("ScreenGui")
    wGui.Name = "VirgoWarningCenterGui"
    wGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    wGui.Parent = targetParent

    local wFrame = Instance.new("Frame")
    wFrame.Size = UDim2.new(1, 0, 0, 120)
    wFrame.Position = UDim2.new(0, 0, 0.4, 0)
    wFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
    wFrame.BackgroundTransparency = 1
    wFrame.BorderSizePixel = 0
    wFrame.ZIndex = 100
    wFrame.Parent = wGui

    local tUtama = Instance.new("TextLabel")
    tUtama.Size = UDim2.new(1, 0, 0, 60)
    tUtama.Position = UDim2.new(0, 0, 0.1, 0)
    tUtama.BackgroundTransparency = 1
    tUtama.Text = pesanUtama
    tUtama.TextColor3 = Color3.fromRGB(255, 30, 30)
    tUtama.TextSize = 34
    tUtama.Font = Enum.Font.GothamBold
    tUtama.TextTransparency = 1
    tUtama.ZIndex = 101
    tUtama.Parent = wFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 2
    stroke.Parent = tUtama

    local tSub = Instance.new("TextLabel")
    tSub.Size = UDim2.new(1, 0, 0, 30)
    tSub.Position = UDim2.new(0, 0, 0.6, 0)
    tSub.BackgroundTransparency = 1
    tSub.Text = subPesan
    tSub.TextColor3 = Color3.fromRGB(230, 230, 230)
    tSub.TextSize = 16
    tSub.Font = Enum.Font.GothamMedium
    tSub.TextTransparency = 1
    tSub.ZIndex = 101
    tSub.Parent = wFrame

    local tweenService = game:GetService("TweenService")
    tweenService:Create(wFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.4}):Play()
    tweenService:Create(tUtama, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    tweenService:Create(tSub, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.wait(durasi)

    tweenService:Create(wFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    tweenService:Create(tUtama, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    tweenService:Create(tSub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

    task.wait(0.5)
    wGui:Destroy()
end

task.spawn(function()
    local folderStory = workspace:WaitForChild("Story", 5)
    if folderStory then
        folderStory.DescendantAdded:Connect(function(descendant)
            local trolley = folderStory:FindFirstChild("ActiveTrolley")
            local jumpscareFolder = trolley and trolley:FindFirstChild("Jumpscare")
            
            if jumpscareFolder then
                if descendant:IsDescendantOf(jumpscareFolder) then
                    if string.find(descendant.Name, "PociIn") or string.find(descendant.Name, "Poci") or string.find(descendant.Name, "Poci ") then
                        local namaHantu = descendant.Name
                        task.spawn(buatWarningTengah, "⚠️ AWAS ADA POCI MERAH  ⚠️", "Terdeteksi: " .. namaHantu .. " telah muncul!", 3.5)
                        
                        local sound = Instance.new("Sound")
                        sound.SoundId = "rbxassetid://9114223171"
                        sound.Volume = 2
                        sound.Parent = game:GetService("SoundService")
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 2)
                    end
                end
            end
        end)
    end
end)

mainFrame.Visible = true
-- ====================================================================
-- AUTO TASK
-- ====================================================================
-- Fungsi untuk menelusuri dan memicu prompt
local function fireAllPrompts()
    local folderNames = {
        "RuangArsip", "RuangDokter", "RuangDuka", "RuangElektrikal", 
        "RuangKM", "RuangKremasi", "RuangMandi", "RuangMayat", 
        "RuangMusholla", "RuangPasien", "RuangPenyiapan", "RuangPenyimpanan"
    }

    for _, name in pairs(folderNames) do
        local folder = game.Workspace:FindFirstChild(name)
        if folder then
            for _, item in pairs(folder:GetDescendants()) do
                if item:IsA("ProximityPrompt") then
                    -- Memicu prompt
                    item:InputHoldBegin()
                    item:InputHoldEnd()
                end
            end
        end
    end
end

-- Loop utama untuk menjalankan fungsi setiap sekian detik
task.spawn(function()
    while true do
        fireAllPrompts()
        task.wait(0.1) -- Sesuaikan waktu jeda (dalam detik) agar tidak membuat lag
    end
end)
-- ====================================================================
-- AUTO COLLECT FORCED LOOP ON EXECUTE
-- ====================================================================
local TWEEN_SPEED = 50
local INTERACT_DELAY = 0.5

local function startAutoCollect()
    local patrolFolder = workspace:FindFirstChild("Patrol")
    if not patrolFolder then return end
    
    for _, item in ipairs(patrolFolder:GetDescendants()) do
        if item.Name == "WowoBogel" or item.Name == "Wowo Bogel" or item.Name == "WowoIn" then
            local prompt = item:FindFirstChildOfClass("ProximityPrompt") or item:FindFirstChild("ProximityPrompt", true)
            if prompt and fireproximityprompt then
                local targetPart = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart", true)
                if targetPart then
                    local character = lp.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        local distance = (rootPart.Position - targetPart.Position).Magnitude
                        local duration = distance / TWEEN_SPEED
                        local tween = game:GetService("TweenService"):Create(rootPart, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetPart.CFrame * CFrame.new(0, 3, 0)})
                        tween:Play()
                        tween.Completed:Wait()
                        task.wait(0.1)
                        
                        prompt.HoldDuration = 0 
                        prompt.RequiresLineOfSight = false 
                        prompt.MaxActivationDistance = 999999
                        fireproximityprompt(prompt)
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end
task.defer(startAutoCollect)

-- =========================================================
-- ULTIMATE GUI PURGE & AUTO PROXIMITY (VIRGOBOY HUB GOLD)
-- =========================================================

local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Alamat RemoteEvent
local phoneRemote = ReplicatedStorage:WaitForChild("Gameplay")
    :WaitForChild("PhoneHandler")

-- Objek Target
local prompt1, prompt2

-- FUNGSI PENGHANCUR GUI SECARA INSTAN (SANGAT AGRESIF)
local function annihilateGui(guiObject)
    if guiObject then
        -- Metode 1: Sembunyikan total
        pcall(function()
            if guiObject:IsA("ScreenGui") then
                guiObject.Enabled = false
            end
            guiObject.Visible = false
        end)
        
        -- Metode 2: Hancurkan objek secara lokal (Wipeout)
        -- Aman karena hanya hilang di layar kamu, server tetap membaca data remote
        pcall(function()
            guiObject:Destroy()
        end)
    end
end

-- Ambil Prompt di Workspace secara berkala
local function updatePrompts()
    local lobby = workspace:FindFirstChild("Lobby")
    local frontTable = lobby and lobby:FindFirstChild("FrontTable")
    local phoneModel = frontTable and frontTable:FindFirstChild("Phone")
    local baseObject = phoneModel and phoneModel:FindFirstChild("Base")
    
    if baseObject then
        prompt1 = baseObject:FindFirstChild("ProximityPrompt")
        prompt2 = baseObject:FindFirstChild("ProximityPrompt2")
    end
end

-- =========================================================
-- SYSTEM 1: DETEKSI DAN BLOCK GUI YANG BARU MUNCUL (REAL-TIME)
-- =========================================================
local taskUi = playerGui:WaitForChild("TaskUi", 5)
if taskUi then
    -- Langsung hapus yang sudah ada saat script di-execute
    annihilateGui(taskUi:FindFirstChild("Phone"))
    annihilateGui(taskUi:FindFirstChild("Phone2"))
    
    -- Pantau jika game mencoba memasukkan (ChildAdded) GUI baru ke folder TaskUi
    taskUi.ChildAdded:Connect(function(child)
        if child.Name == "Phone" or child.Name == "Phone2" then
            task.wait() -- Tunggu 1 frame agar proses kloning game selesai
            annihilateGui(child) -- Langsung sikat/hancurkan saat itu juga!
            print("[Anti-GUI] Berhasil memblokir & menghancurkan GUI baru: " .. child.Name)
        end
    end)
end

-- =========================================================
-- SYSTEM 2: LOOP PROXIMITY INTERACTION & BACKUP CLEANER
-- =========================================================
task.spawn(function()
    print("[Virgoboy Hub] Ultimate GUI Purge Driver is Running.")
    
    while true do
        updatePrompts()
        
        -- Backup Cleaner: Tetap bersihkan lewat loop jika system event terlewati
        if taskUi then
            annihilateGui(taskUi:FindFirstChild("Phone"))
            annihilateGui(taskUi:FindFirstChild("Phone2"))
        end
        
        -- Eksekusi ProximityPrompt 1
        if prompt1 and prompt1.Enabled then
            if fireproximityprompt then
                fireproximityprompt(prompt1, 1)
            else
                prompt1:InputHoldBegin()
                task.wait(prompt1.HoldDuration)
                prompt1:InputHoldEnd()
            end
            pcall(function() phoneRemote:FireServer("Accept") end)
            task.wait(0.1)
        end
        
        -- Eksekusi ProximityPrompt 2
        if prompt2 and prompt2.Enabled then
            if fireproximityprompt then
                fireproximityprompt(prompt2, 1)
            else
                prompt2:InputHoldBegin()
                task.wait(prompt2.HoldDuration)
                prompt2:InputHoldEnd()
            end
            pcall(function() phoneRemote:FireServer("Accept") end)
            task.wait(0.1)
        end
        
        task.wait(0.1) -- Deteksi super cepat (20 kali per detik)
    end
end)

-- [[ ANTI-SHAKE CAMERA BYPASS ]] --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameplayFolder = ReplicatedStorage:WaitForChild("Gameplay", 5)

if not GameplayFolder then
    warn("Folder 'Gameplay' tidak ditemukan di ReplicatedStorage!")
    return
end

local ShakeCamera = GameplayFolder:WaitForChild("ShakeCamera", 5)

if ShakeCamera then
    -- METODE 1: Jika ShakeCamera adalah RemoteEvent
    if ShakeCamera:IsA("RemoteEvent") and getconnections then
        for _, connection in pairs(getconnections(ShakeCamera.OnClientEvent)) do
            connection:Disable()
        end
        print("[Anti-Shake] Berhasil mematikan koneksi RemoteEvent.")
    
    -- METODE 2: Jika ShakeCamera adalah ModuleScript
    elseif ShakeCamera:IsA("ModuleScript") and hookfunction then
        local success, modul = pcall(require, ShakeCamera)
        if success and typeof(modul) == "table" then
            for key, value in pairs(modul) do
                if typeof(value) == "function" then
                    hookfunction(modul[key], function() 
                        return nil 
                    end)
                end
            end
            print("[Anti-Shake] Berhasil membajak fungsi di ModuleScript.")
        end
    end
else
    warn("Objek 'ShakeCamera' tidak ditemukan!")
end

-- METODE 3: Global Metamethod Hook (Proteksi tambahan dari interaksi script lain)
if hookmetamethod then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if self == ShakeCamera or (self.Name == "ShakeCamera" and string.find(method, "Fire")) then
            return nil -- Blokir total pengiriman sinyal getar
        end
        return oldNamecall(self, ...)
    end)
    print("[Anti-Shake] Metamethod bypass aktif.")
end

print("[SUCCESS] Kamera sekarang diam/tidak akan bergetar lagi!")
