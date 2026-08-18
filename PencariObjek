-- [[ VIRGOBOY HUB: SMART EXPLORER V2 - FULL EDITION ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- Pembersihan GUI Lama
if lp.PlayerGui:FindFirstChild("VirgoboyFullExplorer") then 
    lp.PlayerGui.VirgoboyFullExplorer:Destroy() 
end

-- [[ 1. UI CONSTRUCTION ]]
local sg = Instance.new("ScreenGui", lp.PlayerGui)
sg.Name = "VirgoboyFullExplorer"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true

-- Tombol Toggle Utama (Tetap di layar)
local mainToggle = Instance.new("TextButton", sg)
mainToggle.Size = UDim2.new(0, 120, 0, 35)
mainToggle.Position = UDim2.new(0.5, -60, 0, 40)
mainToggle.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainToggle.Text = "EXPLORER: OFF"
mainToggle.TextColor3 = Color3.fromRGB(255, 0, 0)
mainToggle.Font = Enum.Font.GothamBold
mainToggle.TextSize = 12
mainToggle.ZIndex = 100

local tCorner = Instance.new("UICorner", mainToggle)
local tStroke = Instance.new("UIStroke", mainToggle)
tStroke.Color = Color3.fromRGB(255, 0, 0)
tStroke.Thickness = 2

-- Main Info Panel
local infoFrame = Instance.new("Frame", sg)
infoFrame.Size = UDim2.new(0, 300, 0, 190)
infoFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
infoFrame.BackgroundTransparency = 0.1
infoFrame.BorderSizePixel = 0
infoFrame.Visible = false

local iCorner = Instance.new("UICorner", infoFrame)
local iStroke = Instance.new("UIStroke", infoFrame)
iStroke.Color = Color3.fromRGB(255, 215, 0) -- Luxury Gold
iStroke.Thickness = 2.5

-- UI Shadow/Glow (Neon Effect)
local shadow = Instance.new("ImageLabel", infoFrame)
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014264792"
shadow.ImageColor3 = Color3.fromRGB(255, 215, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = -1

-- Labels Container
local content = Instance.new("Frame", infoFrame)
content.Size = UDim2.new(1, -20, 1, -80)
content.Position = UDim2.new(0, 10, 0, 10)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 8)

local function createLabel(title, color)
    local lbl = Instance.new("TextLabel", content)
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.RichText = true
    
    local s = Instance.new("UIStroke", lbl)
    s.Thickness = 1.5
    s.Color = Color3.new(0, 0, 0)
    
    return lbl
end

local nameLabel = createLabel("<b>OBJ:</b> ...", Color3.new(1, 1, 1))
local classLabel = createLabel("<b>CLASS:</b> ...", Color3.fromRGB(0, 255, 255))
local pathLabel = createLabel("<b>PATH:</b> ...", Color3.fromRGB(255, 215, 0))
pathLabel.TextWrapped = true

-- Buttons Container
local btnGrid = Instance.new("Frame", infoFrame)
btnGrid.Size = UDim2.new(1, -20, 0, 70)
btnGrid.Position = UDim2.new(0, 10, 1, -75)
btnGrid.BackgroundTransparency = 1

local function createBtn(text, pos, color)
    local b = Instance.new("TextButton", btnGrid)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Position = pos
    b.BackgroundColor3 = color
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = (color == Color3.new(1,1,1) and Color3.new(0,0,0) or Color3.new(1,1,1))
    Instance.new("UICorner", b)
    return b
end

local copyBtn = createBtn("COPY PATH (C)", UDim2.new(0, 0, 0, 0), Color3.fromRGB(255, 215, 0))
local lockBtn = createBtn("LOCK POSITION (L)", UDim2.new(0, 0, 0, 35), Color3.fromRGB(40, 40, 40))

-- Selection Highlight
local highlight = Instance.new("Highlight", sg)
highlight.FillColor = Color3.fromRGB(255, 215, 0)
highlight.OutlineColor = Color3.new(1, 1, 1)

-- [[ 2. CORE LOGIC ]]
local active = false
local locked = false
local currentPath = ""

local function getPath(obj)
    local p = obj.Name
    local cur = obj.Parent
    while cur and cur ~= game do
        p = cur.Name .. "." .. p
        cur = cur.Parent
    end
    return "game." .. p
end

-- Toggle On/Off
mainToggle.MouseButton1Click:Connect(function()
    active = not active
    if active then
        mainToggle.Text = "EXPLORER: ON"
        mainToggle.TextColor3 = Color3.fromRGB(0, 255, 100)
        tStroke.Color = Color3.fromRGB(0, 255, 100)
    else
        mainToggle.Text = "EXPLORER: OFF"
        mainToggle.TextColor3 = Color3.fromRGB(255, 0, 0)
        tStroke.Color = Color3.fromRGB(255, 0, 0)
        infoFrame.Visible = false
        highlight.Adornee = nil
        locked = false
    end
end)

-- Lock Function
local function toggleLock()
    if not active then return end
    locked = not locked
    lockBtn.Text = locked and "POSITION LOCKED" or "LOCK POSITION (L)"
    lockBtn.BackgroundColor3 = locked and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end

-- Copy Function
local function copyPath()
    if currentPath ~= "" then
        setclipboard(currentPath)
        local old = copyBtn.Text
        copyBtn.Text = "COPIED TO CLIPBOARD!"
        task.wait(0.8)
        copyBtn.Text = old
    end
end

-- Render Loop
RunService.RenderStepped:Connect(function()
    if not active then return end
    
    if not locked then
        local target = mouse.Target
        if target then
            infoFrame.Visible = true
            infoFrame.Position = UDim2.new(0, mouse.X + 25, 0, mouse.Y + 25)
            
            currentPath = getPath(target)
            nameLabel.Text = "<b>OBJ:</b> " .. target.Name:upper()
            classLabel.Text = "<b>CLASS:</b> " .. target.ClassName
            pathLabel.Text = "<b>PATH:</b> " .. currentPath
            highlight.Adornee = target
        else
            infoFrame.Visible = false
            highlight.Adornee = nil
        end
    end
end)

-- Input Bindings
copyBtn.MouseButton1Click:Connect(copyPath)
lockBtn.MouseButton1Click:Connect(toggleLock)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.L then
        toggleLock()
    elseif input.KeyCode == Enum.KeyCode.C then
        copyPath()
    end
end)
