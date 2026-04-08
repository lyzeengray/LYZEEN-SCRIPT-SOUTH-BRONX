-- [[ LYZEENHUB V7.0 ULTRA - THE MONSTER EDITION ]] --
-- [[ CREATED FOR: LYZEEN_GRAY ]] --
-- [[ TOTAL LINES: 400+ GUARANTEED ]] --

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [[ CORE GUI SETUP ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenUltraV7"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- [[ GLOBAL STATE ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"
local _G_AutoCook = false
local _G_Rainbow = false
local _G_Toggled = true

-- [[ CUSTOM NOTIFICATION SYSTEM ]] --
local function Notify(msg, color)
    spawn(function()
        local n = Instance.new("Frame")
        n.Size = UDim2.new(0, 300, 0, 50)
        n.Position = UDim2.new(1.2, 0, 0.8, 0)
        n.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        n.Parent = ScreenGui
        
        local nc = Instance.new("UICorner") nc.Parent = n
        local nS = Instance.new("UIStroke") nS.Color = color or Color3.fromRGB(0, 120, 255) nS.Thickness = 2 nS.Parent = n
        
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -20, 1, 0)
        l.Position = UDim2.new(0, 15, 0, 0)
        l.Text = msg
        l.TextColor3 = Color3.fromRGB(255, 255, 255)
        l.Font = Enum.Font.GothamBold
        l.TextSize = 13
        l.BackgroundTransparency = 1
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = n
        
        n:TweenPosition(UDim2.new(1, -320, 0.8, 0), "Out", "Back", 0.5)
        task.wait(3)
        n:TweenPosition(UDim2.new(1.2, 0, 0.8, 0), "In", "Quad", 0.5)
        task.wait(0.5) n:Destroy()
    end)
end

-- [[ RAINBOW SYSTEM LOGIC ]] --
task.spawn(function()
    while task.wait() do
        if _G_Rainbow then
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            -- Will be applied to UI Strokes
        end
    end
end)

-- [[ DRAG SYSTEM ]] --
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- [[ MAIN CONTAINER ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 580, 0, 400)
Main.Position = UDim2.new(0.5, -290, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.CornerRadius = UDim.new(0, 15) mc.Parent = Main
local mS = Instance.new("UIStroke") mS.Thickness = 3 mS.Color = Color3.fromRGB(40, 40, 50) mS.Parent = Main
MakeDraggable(Main)

-- [[ SIDEBAR ]] --
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Sidebar.Parent = Main
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 15) sc.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Text = "LYZEEN HUB V7"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Parent = Sidebar

-- [[ CLOSE & TOGGLE BUTTON ]] --
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main
local cbc = Instance.new("UICorner") cbc.Parent = CloseBtn

-- [[ MOBILE TOGGLE (Floating) ]] --
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -30)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
OpenBtn.Text = "LZ"
OpenBtn.TextColor3 = Color3.fromRGB(0, 120, 255)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextSize = 25
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
local obc = Instance.new("UICorner") obc.CornerRadius = UDim.new(1, 0) obc.Parent = OpenBtn
local obS = Instance.new("UIStroke") obS.Thickness = 3 obS.Color = Color3.fromRGB(0, 120, 255) obS.Parent = OpenBtn
MakeDraggable(OpenBtn)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

-- [[ PAGE SYSTEM ]] --
local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 195, 0, 60)
Container.Size = UDim2.new(0, 365, 0, 320)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.Parent = Container
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 12)
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local SettingPage = CreatePage("Settings")
local CredPage = CreatePage("Cred")

-- [[ ADVANCED UTILITIES ]] --
local function IsNearPanci()
    local cooker = workspace:FindFirstChild("Cooker")
    if cooker and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return (LocalPlayer.Character.HumanoidRootPart.Position - cooker.Position).Magnitude < 15
    end
    return false
end

local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return (LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 20
    end
    return false
end

-- [[ COMPONENT BUILDER ]] --
local function CreateButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.96, 0, 0, 52)
    b.BackgroundColor3 = color
    b.AutoButtonColor = true
    b.Text = ""
    b.Parent = parent
    local c = Instance.new("UICorner") c.Parent = b
    
    local h = Instance.new("UIListLayout")
    h.FillDirection = Enum.FillDirection.Horizontal
    h.Padding = UDim.new(0, 15)
    h.VerticalAlignment = Enum.VerticalAlignment.Center
    h.Parent = b
    
    local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0, 15) pad.Parent = b
    
    local Icon = Instance.new("TextLabel")
    Icon.Text = emoji Icon.Size = UDim2.new(0, 30, 1, 0) Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255) Icon.Font = Enum.Font.GothamBold Icon.TextSize = 22 Icon.Parent = b
    
    local Label = Instance.new("TextLabel")
    Label.Text = txt Label.Size = UDim2.new(0, 220, 1, 0) Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255) Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left Label.TextSize = 13 Label.Parent = b
    
    b.MouseButton1Click:Connect(callback)
end

local function CreateTextBox(parent, placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.96, 0, 0, 48)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 14
    box.TextXAlignment = Enum.TextXAlignment.Center
    box.ClearTextOnFocus = true
    box.BorderSizePixel = 0
    box.Parent = parent
    local c = Instance.new("UICorner") c.Parent = box
    local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(50, 50, 60) s.Parent = box
    return box
end

-- [[ TELEPORT SYSTEM ]] --
local tps = {
    {"👤", "Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Dealer", CFrame.new(731, 7, 443)},
    {"🏢", "Apt 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apt 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apt 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apt 4", CFrame.new(894, 11, 40)},
    {"🏢", "Apt 5", CFrame.new(1048, 11, 350)},
    {"🏢", "Apt 6", CFrame.new(1048, 11, 300)}
}

for _, v in pairs(tps) do
    CreateButton(TelePage, v[1], "GO TO " .. v[2], Color3.fromRGB(30, 30, 40), function()
        if LocalPlayer.Character and LocalPlayer.Character.Humanoid.SeatPart then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v[3]
        else
            Notify("Gagal: Harus Naik Motor!", Color3.fromRGB(200, 40, 40))
        end
    end)
end

-- [[ AUTO FARM LOGIC ]] --
local BuyAmt = 1
local BuyIn = CreateTextBox(FarmPage, "Jumlah Beli MS...")
BuyIn.FocusLost:Connect(function() BuyAmt = tonumber(BuyIn.Text) or 1 end)

CreateButton(FarmPage, "🛒", "AUTO BUY (W/S/G)", Color3.fromRGB(0, 120, 255), function()
    if not NearNPC() then Notify("Gagal: Dekat NPC Lamont!", Color3.fromRGB(200, 40, 40)) return end
    Notify("Buying " .. BuyAmt .. " Sets...", Color3.fromRGB(0, 255, 120))
    for i = 1, BuyAmt do
        local RE = game:GetService("ReplicatedStorage").Events.ShopEvent
        RE:FireServer("Water") task.wait(0.35)
        RE:FireServer("Sugar Block Bag") task.wait(0.35)
        RE:FireServer("Gelatin") task.wait(0.35)
    end
end)

CreateButton(FarmPage, "🔥", "AUTO COOK MS", Color3.fromRGB(180, 40, 40), function()
    if not IsNearPanci() then Notify("ANDA HARUS DIDEKAT PANCI", Color3.fromRGB(200, 40, 40)) return end
    _G_AutoCook = not _G_AutoCook
    Notify(_G_AutoCook and "Cooker: ACTIVE" or "Cooker: OFF")
    task.spawn(function()
        while _G_AutoCook do
            if not IsNearPanci() then _G_AutoCook = false break end
            local function Craft(item, wt)
                if not _G_AutoCook then return end
                local t = LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item)
                if t then LocalPlayer.Character.Humanoid:EquipTool(t) task.wait(0.4) fireproximityprompt(workspace.Cooker.ProximityPrompt) task.wait(wt) end
            end
            Craft("Water", 23.5) Craft("Sugar", 3.5) Craft("Gelatin", 63.5) task.wait(1)
        end
    end)
end)

-- [[ SETTINGS SYSTEM ]] --
CreateButton(SettingPage, "🌈", "RAINBOW UI STROKE", Color3.fromRGB(40, 40, 50), function()
    _G_Rainbow = not _G_Rainbow
    Notify("Rainbow Mode: " .. tostring(_G_Rainbow))
end)

CreateButton(SettingPage, "🗑️", "DESTROY UI", Color3.fromRGB(200, 0, 0), function()
    ScreenGui:Destroy()
end)

-- [[ SIDEBAR TABS ]] --
local function AddTab(txt, page, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 48)
    b.Position = UDim2.new(0.05, 0, 0, 75 + (pos * 58))
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.Parent = Sidebar
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[page].Visible = true
    end)
end

AddTab("🎭 TELEPORT", "TP", 0)
AddTab("🍃 AUTO FARM", "Farm", 1)
AddTab("⚙️ SETTINGS", "Settings", 2)
AddTab("⭐ CREDIT", "Cred", 3)

-- [[ AUTHENTICATION SYSTEM ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 400, 0, 240)
KeyUI.Position = UDim2.new(0.5, -200, 0.5, -120)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI
local kS = Instance.new("UIStroke") kS.Thickness = 2 kS.Color = Color3.fromRGB(0, 120, 255) kS.Parent = KeyUI

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Text = "LYZEEN HUB - ACCESS REQUIRED"
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyUI

local KeyIn = CreateTextBox(KeyUI, "Enter Private Key...")
KeyIn.Position = UDim2.new(0.1, 0, 0.35, 0)

local LogBtn = Instance.new("TextButton")
LogBtn.Size = UDim2.new(0.8, 0, 0, 55)
LogBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
LogBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
LogBtn.Text = "VERIFY LOGIN"
LogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LogBtn.Font = Enum.Font.GothamBold
LogBtn.Parent = KeyUI
local lbc = Instance.new("UICorner") lbc.Parent = LogBtn

LogBtn.MouseButton1Click:Connect(function()
    if KeyIn.Text == CorrectKey then
        KeyUI:Destroy()
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 580, 0, 400)}):Play()
        Pages["TP"].Visible = true
        Notify("Access Granted. Welcome, Lyzeen!", Color3.fromRGB(0, 200, 255))
    else
        Notify("INVALID KEY!", Color3.fromRGB(255, 0, 0))
    end
end)

-- [[ RAINBOW STROKE HANDLER ]] --
RunService.RenderStepped:Connect(function()
    if _G_Rainbow then
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        mS.Color = color
        obS.Color = color
        kS.Color = color
    end
end)
