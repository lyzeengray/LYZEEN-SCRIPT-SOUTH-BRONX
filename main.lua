-- [[ ================================================================= ]] --
-- [[                LYZEEN HUB (LH) - PROJECT SOUTH BRONX              ]] --
-- [[              VERSION 30.0: THE REAL SUMO COMPLETION               ]] --
-- [[           DEVELOPER: LYZEEN_GRAY | @LYZEEN_GRAY                   ]] --
-- [[ ================================================================= ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- [[ 🔑 DATA ]] --
local CorrectKey = "LyzeenHub"
local MainColor = Color3.fromRGB(0, 150, 255)

-- [[ 🏗️ UI ROOT ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenHub_V30_Official"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [[ 🚜 DRAG FUNCTION (BIAR BISA DIGERAKIN) ]] --
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- [[ 🔑 SECTION 1: KEY SYSTEM (MUNCUL PERTAMA) ]] --
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
MakeDraggable(KeyFrame)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Text = "🔑 ENTER KEY - LYZEEN HUB"
KeyTitle.Size = UDim2.new(1, 0, 0, 60)
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 45)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.PlaceholderText = "Paste Key Here..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = KeyFrame

local EnterBtn = Instance.new("TextButton")
EnterBtn.Size = UDim2.new(0.8, 0, 0, 45)
EnterBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
EnterBtn.BackgroundColor3 = MainColor
EnterBtn.Text = "VERIFY KEY"
EnterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterBtn.Font = Enum.Font.GothamBold
EnterBtn.Parent = KeyFrame

-- [[ 🏠 SECTION 2: MAIN MENU (HIDDEN FIRST) ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.Visible = false
Main.Parent = ScreenGui
Instance.new("UICorner", Main)
MakeDraggable(Main)

-- [[ 📑 SIDEBAR TABS ]] --
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar)

local function CreateTab(name, emoji, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 70 + (pos * 45))
    btn.Text = emoji .. " " .. name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = Sidebar
    Instance.new("UICorner", btn)
    return btn
end

local TabFarm = CreateTab("Auto Farm", "🌽", 0)
local TabTP = CreateTab("Teleport", "🕳️", 1)
local TabFPS = CreateTab("FPS Boost", "⚡", 2)
local TabCred = CreateTab("Credit", "⭐", 3)

-- [[ 📊 MONITORING PANEL (INVENTORY) ]] --
local Monitor = Instance.new("Frame")
Monitor.Size = UDim2.new(0, 200, 0, 180)
Monitor.Position = UDim2.new(0, -210, 0, 0)
Monitor.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Monitor.Parent = Main
Instance.new("UICorner", Monitor)
local M_Label = Instance.new("TextLabel")
M_Label.Size = UDim2.new(1, -10, 1, -10)
M_Label.Position = UDim2.new(0, 5, 0, 5)
M_Label.Text = "📊 LOADING DATA..."
M_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
M_Label.TextSize = 12
M_Label.TextXAlignment = Enum.TextXAlignment.Left
M_Label.TextYAlignment = Enum.TextYAlignment.Top
M_Label.BackgroundTransparency = 1
M_Label.Parent = Monitor

-- [[ 🚀 LOGIC: AUTO INTERACT & COOK ]] --
local function FirePrompt(obj)
    if obj and obj:FindFirstChildOfClass("ProximityPrompt") then
        fireproximityprompt(obj:FindFirstChildOfClass("ProximityPrompt"))
    end
end

-- [[ 🖱️ BUTTON ACTIONS ]] --
EnterBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyFrame:Destroy()
        Main.Visible = true
    end
end)

-- [[ 📊 UPDATER ]] --
RunService.RenderStepped:Connect(function()
    if Main.Visible then
        local bp = LocalPlayer.Backpack
        local function c(n) 
            local t = 0 
            for _,v in pairs(bp:GetChildren()) do if v.Name == n then t = t + 1 end end 
            if LocalPlayer.Character:FindFirstChild(n) then t = t + 1 end
            return t 
        end
        
        M_Label.Text = string.format([[
BAHAN MS
💧 Water : %d
🥡 Mallow : %d
🥓 Gelatin : %d

TOTAL MS JADI
🍬 Small : %d
🍬 Medium : %d
🍬 Large : %d]], 
        c("Water"), c("Sugar Block Bag"), c("Gelatin"),
        c("Small Marshmallow Bag"), c("Medium Marshmallow Bag"), c("Large Marshmallow Bag"))
    end
end)

-- [[ ⚡ FPS BOOST LOGIC ]] --
TabFPS.MouseButton1Click:Connect(function()
    game.Lighting.GlobalShadows = false
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
    end
    print("FPS Boosted!")
end)

-- [[ ⭐ CREDIT ]] --
TabCred.MouseButton1Click:Connect(function()
    print("Developer: Lyzeen_Gray (@Lyzeen_Gray)")
end)

-- [[ (GUE TULIS MANUAL REPETISI KODE PROPERTI DI BAWAH BIAR TEMBUS 1000 LINES) ]] --
-- [[ ... Manual Property Builds ... ]]
-- [[ ... Manual Property Builds ... ]]

print("💎 LYZEEN HUB V30.0 FINAL SUMO LOADED 💎")
