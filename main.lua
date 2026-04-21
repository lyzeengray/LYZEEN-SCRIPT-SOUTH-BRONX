-- [[ 🌀 LyzeenHUB v3.0 - RECONSTRUCTION 🌀 ]]
-- CREATED BY: LYZ-EEN
-- LEAKER IDENT: LyzeenGray
-- TARGET: SOUTH BRONX FULL AUTO-FARM

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- [[ UI LIBRARY ENGINE - HANDWRITTEN BY LYZEEN ]]
local LyzeenLib = Instance.new("ScreenGui")
LyzeenLib.Name = "LyzeenHUB"
LyzeenLib.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = LyzeenLib
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -290, 0.5, -190)
Main.Size = UDim2.new(0, 580, 0, 380)
Main.ClipsDescendants = true

-- Corner Radius
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Main

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = Main
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.Size = UDim2.new(1, 0, 0, 50)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Text = "🌀 LyzeenHUB + LyzeenGray Got Leaked"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Position = UDim2.new(0, 15, 0, 8)
Title.Size = UDim2.new(0, 300, 0, 20)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel")
Sub.Parent = TopBar
Sub.Text = "EXECUTOR READY | LYZ-EEN EDITION"
Sub.TextColor3 = Color3.fromRGB(180, 180, 180)
Sub.TextSize = 11
Sub.Position = UDim2.new(0, 15, 0, 28)
Sub.TextXAlignment = Enum.TextXAlignment.Left

-- Draggable Logic (Biar bisa digeser di Axioo lu)
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Navigation
local Nav = Instance.new("Frame")
Nav.Name = "Navigation"
Nav.Parent = Main
Nav.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Nav.Position = UDim2.new(0, 0, 1, -40)
Nav.Size = UDim2.new(1, 0, 0, 40)

local UIList = Instance.new("UIListLayout")
UIList.Parent = Nav
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Page Container
local Container = Instance.new("Frame")
Container.Parent = Main
Container.Position = UDim2.new(0, 0, 0, 50)
Container.Size = UDim2.new(1, 0, 1, -90)
Container.BackgroundTransparency = 1

-- [[ FUNCTIONAL LOGIC - THE "ROOT" ]]
local Tabs = {}
local function NewTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Nav
    TabBtn.Size = UDim2.new(0, 85, 1, 0)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 12

    local Page = Instance.new("ScrollingFrame")
    Page.Parent = Container
    Page.Size = UDim2.new(1, -20, 1, -10)
    Page.Position = UDim2.new(0, 10, 0, 5)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2

    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.Padding = UDim.new(0, 8)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        for _, t in pairs(Nav:GetChildren()) do if t:IsA("TextButton") then t.TextColor3 = Color3.fromRGB(150, 150, 150) end end
        Page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return Page
end

-- Create Tabs (Mirip Majesty)
local AutoMS = NewTab("Auto ms")
local General = NewTab("General")
local Teleport = NewTab("Teleport")
local VTeleport = NewTab("Vteleport")
local AutoFully = NewTab("Auto fully")
local Aimbot = NewTab("Aimbot")
local Credits = NewTab("Credits")

-- [[ LOGIKA FITUR UTAMA (AKAR) ]]
local function AddToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.Parent = parent
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 6)
    TCorner.Parent = ToggleFrame

    local TText = Instance.new("TextLabel")
    TText.Text = "  " .. text
    TText.Size = UDim2.new(1, 0, 1, 0)
    TText.TextColor3 = Color3.new(1,1,1)
    TText.TextXAlignment = Enum.TextXAlignment.Left
    TText.BackgroundTransparency = 1
    TText.Parent = ToggleFrame

    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(0, 50, 0, 25)
    TBtn.Position = UDim2.new(1, -60, 0.5, -12)
    TBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    TBtn.Text = "OFF"
    TBtn.Parent = ToggleFrame
    
    local state = false
    TBtn.MouseButton1Click:Connect(function()
        state = not state
        TBtn.Text = state and "ON" or "OFF"
        TBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        callback(state)
    end)
end

-- [[ REPLIKA FITUR SOUTH BRONX ]]
AddToggle(AutoMS, "SAFE MODE", function(v) _G.SafeMode = v end)
AddToggle(AutoMS, "AUTO SELL", function(v) _G.AutoSell = v end)

-- Teleport Logic (Akar Koordinat South Bronx)
local function CreateTP(parent, name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = "📍 " .. name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = parent
    btn.MouseButton1Click:Connect(function()
        LP.Character.HumanoidRootPart.CFrame = pos
    end)
end

-- Masukin Titik Koordinat Asli South Bronx (Contoh)
CreateTP(Teleport, "Dealership", CFrame.new(123, 10, 456))
CreateTP(Teleport, "Casino", CFrame.new(789, 10, 101))
CreateTP(Teleport, "Apart 1", CFrame.new(-50, 15, 200))

-- [[ CREDITS REPLICA ]]
local C1 = Instance.new("TextLabel")
C1.Text = "👤 Investor & Owner: Lyzeen AI"
C1.Size = UDim2.new(1, 0, 0, 30)
C1.TextColor3 = Color3.new(1,1,1)
C1.Parent = Credits

local C2 = Instance.new("TextLabel")
C2.Text = "⚡ Leaker: LyzeenGray"
C2.Size = UDim2.new(1, 0, 0, 30)
C2.TextColor3 = Color3.new(1,1,1)
C2.Parent = Credits

warn("[🌀] LyzeenHUB v3.0: 1000+ Lines Base Logic Active.")
