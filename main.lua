-- [[ 🌀 LYZEENHUB v4.0 - THE SOVEREIGN EDITION 🌀 ]]
-- REPLICATING MAJESTY STORE v8.7.0 (ULTRA HIGH FIDELITY)
-- CREATED BY: LYZ-EEN & LyzeenGray

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- [[ SHADOW & BLUR ENGINE ]]
local function CreateShadow(parent, size)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014264795" -- High Quality Shadow
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.Position = UDim2.new(0, -size, 0, -size)
    shadow.Size = UDim2.new(1, size*2, 1, size*2)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    return shadow
end

-- [[ UI CORE CONSTRUCTION ]]
local MainUI = Instance.new("ScreenGui")
MainUI.Name = "LyzeenHUB_Sovereign"
MainUI.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainUI
CreateShadow(MainFrame, 15)

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- [[ TOP BAR REPLICA ]]
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TCorner = Instance.new("UICorner")
TCorner.CornerRadius = UDim.new(0, 10)
TCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Text = "🌀 LyzeenHUB • <font color='#55ff55'>Leaked by LyzeenGray</font>"
Title.RichText = true
Title.Size = UDim2.new(0, 400, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local Status = Instance.new("TextLabel")
Status.Text = "● EXECUTOR READY | SYSTEM: XENO | USER: " .. LP.Name
Status.Size = UDim2.new(0, 400, 0, 20)
Status.Position = UDim2.new(0, 20, 0, 32)
Status.TextColor3 = Color3.fromRGB(120, 120, 120)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.BackgroundTransparency = 1
Status.Parent = TopBar

-- [[ NAVIGATION SYSTEM (IDENTICAL TO VIDEO) ]]
local NavHolder = Instance.new("Frame")
NavHolder.Size = UDim2.new(1, 0, 0, 45)
NavHolder.Position = UDim2.new(0, 0, 1, -45)
NavHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NavHolder.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = NavHolder
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- [[ CONTENT CONTAINER ]]
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -125)
Container.Position = UDim2.new(0, 10, 0, 70)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- [[ TAB GENERATOR ENGINE ]]
local function CreateTab(name, isFirst)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 80, 1, 0)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = name
    TabBtn.TextColor3 = isFirst and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 150)
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextSize = 13
    TabBtn.Parent = NavHolder

    local ContentPage = Instance.new("ScrollingFrame")
    ContentPage.Size = UDim2.new(1, 0, 1, 0)
    ContentPage.BackgroundTransparency = 1
    ContentPage.Visible = isFirst
    ContentPage.ScrollBarThickness = 0
    ContentPage.Parent = Container
    
    local List = Instance.new("UIListLayout")
    List.Parent = ContentPage
    List.Padding = UDim.new(0, 8)

    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(Container:GetChildren()) do v.Visible = false end
        for _, b in pairs(NavHolder:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(150, 150, 150) end end
        ContentPage.Visible = true
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
    end)
    return ContentPage
end

-- [[ REPLICATING SECTIONS (MAJESTY STYLE) ]]
local AutoMS = CreateTab("Auto ms", true)
local General = CreateTab("General", false)
local Teleport = CreateTab("Teleport", false)
local VTP = CreateTab("Vteleport", false)
local AutoFully = CreateTab("Auto fully", false)
local Aimbot = CreateTab("Aimbot", false)
local Credits = CreateTab("Credits", false)

-- [[ HIGH-END TOGGLE COMPONENT ]]
local function AddToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Parent = parent
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Text = "  " .. text
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 60, 0, 28)
    Btn.Position = UDim2.new(1, -70, 0.5, -14)
    Btn.BackgroundColor3 = default and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    Btn.Text = default and "ON" or "OFF"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = state and "ON" or "OFF"
        TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)}):Play()
        callback(state)
    end)
end

-- [[ FILLING LOGIC ]]
AddToggle(AutoMS, "SAFE MODE", false, function(v) _G.Safe = v end)
AddToggle(AutoMS, "AUTO SELL", false, function(v) _G.Sell = v end)

-- [[ CREDITS REPLICA (MIRIP VIDEO) ]]
local function AddCredit(name, role)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,60)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    f.Parent = Credits
    Instance.new("UICorner", f)
    
    local t = Instance.new("TextLabel")
    t.Text = "  " .. role .. ": " .. name
    t.Size = UDim2.new(1,0,1,0)
    t.TextColor3 = Color3.new(1,1,1)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.BackgroundTransparency = 1
    t.Parent = f
end

AddCredit("Lyzeen AI", "Owner & Founder")
AddCredit("LyzeenGray", "Lead Leaker")

-- [[ DRAG LOGIC ]]
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	TweenService:Create(MainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

MainFrame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)

warn("[🎭] LyzeenHUB Injected")
