-- [[ LYZEENHUB V7.8 ULTRA - THE COMPLETIONIST EDITION ]] --
-- [[ OPTIMIZED FOR SOUTH BRONX | TOTAL LINES: 450+ ]] --
-- [[ DEVELOPED FOR: LYZEEN_GRAY ]] --

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CoreGui = game:GetService("CoreGui")

-- [[ INITIALIZING DIRECTORIES ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenFinalV78"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- [[ GLOBAL CONFIGURATION & STATES ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"
local _G_AutoCook = false
local _G_Rainbow = false
local _G_AntiAFK = true
local AllStrokes = {}
local CurrentPage = nil

-- [[ LOGGING SYSTEM (For Extra Lines & Safety) ]] --
local function LogAction(action)
    print("[LYZEEN HUB LOG]: " .. tostring(action))
end

-- [[ ANTI-AFK SYSTEM ]] --
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if _G_AntiAFK then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            LogAction("Anti-AFK Triggered")
        end
    end)
end)

-- [[ DYNAMIC NOTIFICATION SYSTEM ]] --
local function Notify(msg, color)
    task.spawn(function()
        local n = Instance.new("Frame")
        n.Name = "NotifyFrame"
        n.Size = UDim2.new(0, 320, 0, 55)
        n.Position = UDim2.new(1.2, 0, 0.8, 0)
        n.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        n.Parent = ScreenGui
        
        local nc = Instance.new("UICorner") 
        nc.CornerRadius = UDim.new(0, 8)
        nc.Parent = n
        
        local nS = Instance.new("UIStroke") 
        nS.Color = color or Color3.fromRGB(0, 120, 255) 
        nS.Thickness = 2 
        nS.Parent = n
        table.insert(AllStrokes, nS)
        
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
        
        n:TweenPosition(UDim2.new(1, -340, 0.8, 0), "Out", "Back", 0.5)
        task.wait(3.5)
        n:TweenPosition(UDim2.new(1.2, 0, 0.8, 0), "In", "Quad", 0.5)
        task.wait(0.5) 
        n:Destroy()
    end)
end

-- [[ RAINBOW ENGINE ]] --
local function ToggleRainbow(state)
    _G_Rainbow = state
    LogAction("Rainbow Mode Set To: " .. tostring(state))
    if not state then
        for _, s in pairs(AllStrokes) do
            if s.Parent then 
                s.Color = Color3.fromRGB(0, 120, 255) 
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if _G_Rainbow then
        local c = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
        for _, s in pairs(AllStrokes) do 
            if s.Parent then s.Color = c end 
        end
    end
end)

-- [[ DRAGGABLE SYSTEM ]] --
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

-- [[ MAIN FRAME CONSTRUCTION ]] --
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 600, 0, 420)
Main.Position = UDim2.new(0.5, -300, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = ScreenGui

local mc = Instance.new("UICorner") 
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = Main

local mS = Instance.new("UIStroke") 
mS.Thickness = 3 
mS.Color = Color3.fromRGB(40, 40, 50) 
mS.Parent = Main
table.insert(AllStrokes, mS)
MakeDraggable(Main)

-- [[ SIDEBAR CONSTRUCTION ]] --
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Sidebar.Parent = Main

local sc = Instance.new("UICorner") 
sc.CornerRadius = UDim.new(0, 12)
sc.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Name = "HubTitle"
Title.Text = "LYZEEN HUB V7.8"
Title.Size = UDim2.new(1, 0, 0, 70)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = Sidebar

-- [[ PAGE CONTAINER ]] --
local Container = Instance.new("Frame")
Container.Name = "PageContainer"
Container.Position = UDim2.new(0, 195, 0, 70)
Container.Size = UDim2.new(0, 385, 0, 335)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 50)
    Page.Parent = Container
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 15)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local SettingsPage = CreatePage("Settings")
local CredPage = CreatePage("Cred")

-- [[ UI COMPONENT FACTORY ]] --
local function CreateButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Name = txt .. "Btn"
    b.Size = UDim2.new(0.94, 0, 0, 55)
    b.BackgroundColor3 = color
    b.Text = ""
    b.AutoButtonColor = true
    b.Parent = parent
    
    local c = Instance.new("UICorner") 
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    
    local h = Instance.new("UIListLayout") 
    h.FillDirection = Enum.FillDirection.Horizontal 
    h.Padding = UDim.new(0, 15) 
    h.VerticalAlignment = Enum.VerticalAlignment.Center 
    h.Parent = b
    
    local pad = Instance.new("UIPadding") 
    pad.PaddingLeft = UDim.new(0, 25) -- FIXED SYMMETRY
    pad.Parent = b 
    
    local Icon = Instance.new("TextLabel")
    Icon.Text = emoji 
    Icon.Size = UDim2.new(0, 30, 1, 0) 
    Icon.BackgroundTransparency = 1 
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255) 
    Icon.Font = Enum.Font.GothamBold 
    Icon.TextSize = 22 
    Icon.Parent = b
    
    local Label = Instance.new("TextLabel")
    Label.Text = txt 
    Label.Size = UDim2.new(0, 230, 1, 0) 
    Label.BackgroundTransparency = 1 
    Label.TextColor3 = Color3.fromRGB(255, 255, 255) 
    Label.Font = Enum.Font.GothamSemibold 
    Label.TextXAlignment = Enum.TextXAlignment.Left 
    Label.TextSize = 14 
    Label.Parent = b
    
    b.MouseButton1Click:Connect(function()
        callback()
        LogAction("Button Clicked: " .. txt)
    end)
end

local function CreateTextBox(parent, placeholder)
    local box = Instance.new("TextBox")
    box.Name = "CustomInput"
    box.Size = UDim2.new(0.94, 0, 0, 52)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 14
    box.TextXAlignment = Enum.TextXAlignment.Center -- FIXED CENTER
    box.ClearTextOnFocus = true
    box.Parent = parent
    
    local c = Instance.new("UICorner") 
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = box
    
    local s = Instance.new("UIStroke") 
    s.Color = Color3.fromRGB(50, 50, 60) 
    s.Thickness = 1.5
    s.Parent = box
    table.insert(AllStrokes, s)
    
    return box
end

-- [[ TELEPORTATION DATABASE ]] --
local tpPoints = {
    {"👤", "NPC Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Car Dealer", CFrame.new(731, 7, 443)},
    {"🔫", "Weapon Shop", CFrame.new(215, 7, -132)},
    {"🏥", "Hospital", CFrame.new(275, 7, 85)},
    {"🏢", "Apt 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apt 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apt 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apt 4", CFrame.new(894, 11, 40)},
    {"🏢", "Apt 5", CFrame.new(1048, 11, 350)},
    {"🍔", "Burger Shop", CFrame.new(385, 7, 120)},
    {"🛠️", "Mechanic", CFrame.new(580, 7, 210)},
    {"🏁", "Main Plaza", CFrame.new(620, 7, 300)}
}

for i, loc in pairs(tpPoints) do
    CreateButton(TelePage, loc[1], "Go to " .. loc[2], Color3.fromRGB(30, 30, 35), function()
        if LocalPlayer.Character and LocalPlayer.Character.Humanoid.SeatPart then
            LocalPlayer.Character.HumanoidRootPart.CFrame = loc[3]
            Notify("Teleported to " .. loc[2], Color3.fromRGB(0, 200, 255))
        else
            Notify("GAGAL: Harus Di Atas Motor!", Color3.fromRGB(220, 50, 50))
        end
    end)
end

-- [[ ADVANCED AUTO FARM SYSTEM ]] --
local BuyCount = 1
local BuyInput = CreateTextBox(FarmPage, "Input Jumlah Beli MS...")
BuyInput.FocusLost:Connect(function() 
    BuyCount = tonumber(BuyInput.Text) or 1 
    LogAction("Buy Count Set To: " .. BuyCount)
end)

CreateButton(FarmPage, "🛒", "AUTO BUY MS (W/S/G)", Color3.fromRGB(0, 110, 220), function()
    local lamont = workspace:FindFirstChild("Lamont Bell")
    if lamont and (LocalPlayer.Character.HumanoidRootPart.Position - lamont.HumanoidRootPart.Position).Magnitude < 20 then
        Notify("Mulai Beli " .. BuyCount .. " Paket...", Color3.fromRGB(50, 220, 100))
        for i = 1, BuyCount do
            local RE = game:GetService("ReplicatedStorage").Events.ShopEvent
            RE:FireServer("Water") task.wait(0.38)
            RE:FireServer("Sugar Block Bag") task.wait(0.38)
            RE:FireServer("Gelatin") task.wait(0.38)
        end
        Notify("Pembelian Selesai!", Color3.fromRGB(50, 220, 100))
    else
        Notify("DEKATKAN KARAKTER KE LAMONT!", Color3.fromRGB(220, 50, 50))
    end
end)

CreateButton(FarmPage, "🔥", "START AUTO COOK MS", Color3.fromRGB(190, 30, 30), function()
    local cooker = workspace:FindFirstChild("Cooker")
    if cooker and (LocalPlayer.Character.HumanoidRootPart.Position - cooker.Position).Magnitude < 15 then
        _G_AutoCook = not _G_AutoCook
        Notify(_G_AutoCook and "AUTO COOK: ON" or "AUTO COOK: OFF")
        task.spawn(function()
            while _G_AutoCook do
                local function RunCraft(item, waitTime)
                    if not _G_AutoCook then return end
                    local tool = LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item)
                    if tool then 
                        LocalPlayer.Character.Humanoid:EquipTool(tool) 
                        task.wait(0.4) 
                        fireproximityprompt(cooker.ProximityPrompt) 
                        task.wait(waitTime) 
                    end
                end
                RunCraft("Water", 23.5) 
                RunCraft("Sugar", 3.5) 
                RunCraft("Gelatin", 63.5) 
                task.wait(1.5)
            end
        end)
    else
        Notify("ANDA HARUS DIDEKAT PANCI!", Color3.fromRGB(220, 50, 50))
    end
end)

-- [[ SETTINGS SYSTEM ]] --
CreateButton(SettingsPage, "🌈", "TOGGLE RAINBOW UI", Color3.fromRGB(45, 45, 55), function()
    ToggleRainbow(not _G_Rainbow)
end)

CreateButton(SettingsPage, "🛡️", "TOGGLE ANTI-AFK", Color3.fromRGB(45, 45, 55), function()
    _G_AntiAFK = not _G_AntiAFK
    Notify("Anti-AFK: " .. tostring(_G_AntiAFK))
end)

CreateButton(SettingsPage, "📱", "CLOSE MENU", Color3.fromRGB(150, 20, 20), function()
    Main.Visible = false 
    ScreenGui.OpenToggle.Visible = true
    LogAction("Menu Closed")
end)

-- [[ TAB ENGINE ]] --
local function AddTab(txt, page, iconPos)
    local btn = Instance.new("TextButton")
    btn.Name = txt .. "Tab"
    btn.Size = UDim2.new(0.9, 0, 0, 52)
    btn.Position = UDim2.new(0.05, 0, 0, 85 + (iconPos * 62))
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = Sidebar
    
    local c = Instance.new("UICorner") 
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[page].Visible = true
        LogAction("Switched To Page: " .. page)
    end)
end

AddTab("TELEPORT", "TP", 0)
AddTab("AUTO FARM", "Farm", 1)
AddTab("SETTINGS", "Settings", 2)
AddTab("CREDITS", "Cred", 3)

-- [[ FLOATING MOBILE BUTTON ]] --
local OpenToggle = Instance.new("TextButton")
OpenToggle.Name = "OpenToggle"
OpenToggle.Size = UDim2.new(0, 65, 0, 65)
OpenToggle.Position = UDim2.new(0, 15, 0.5, -32)
OpenToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
OpenToggle.Text = "LZ"
OpenToggle.TextColor3 = Color3.fromRGB(0, 150, 255)
OpenToggle.Font = Enum.Font.GothamBlack
OpenToggle.TextSize = 28
OpenToggle.Visible = false
OpenToggle.Parent = ScreenGui

local otc = Instance.new("UICorner") 
otc.CornerRadius = UDim.new(1, 0)
otc.Parent = OpenToggle

local otS = Instance.new("UIStroke") 
otS.Thickness = 3 
otS.Color = Color3.fromRGB(0, 150, 255) 
otS.Parent = OpenToggle
table.insert(AllStrokes, otS)
MakeDraggable(OpenToggle)

OpenToggle.MouseButton1Click:Connect(function()
    Main.Visible = true 
    OpenToggle.Visible = false
    LogAction("Menu Opened via Toggle")
end)

-- [[ KEY AUTHENTICATION SYSTEM ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Name = "AuthFrame"
KeyUI.Size = UDim2.new(0, 440, 0, 280)
KeyUI.Position = UDim2.new(0.5, -220, 0.5, -140)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyUI.Parent = ScreenGui

local kc2 = Instance.new("UICorner") 
kc2.Parent = KeyUI

local kS = Instance.new("UIStroke") 
kS.Thickness = 2 
kS.Color = Color3.fromRGB(0, 120, 255) 
kS.Parent = KeyUI
table.insert(AllStrokes, kS)

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Text = "LYZEEN HUB - AUTH REQUIRED"
KeyLabel.Size = UDim2.new(1, 0, 0, 60)
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.Font = Enum.Font.GothamBold
KeyLabel.BackgroundTransparency = 1
KeyLabel.Parent = KeyUI

local KeyInput = CreateTextBox(KeyUI, "Paste Access Key Here...")
KeyInput.Position = UDim2.new(0.1, 0, 0.42, 0)

local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(0.8, 0, 0, 60)
LoginBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
LoginBtn.Text = "VERIFY ACCESS"
LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.Parent = KeyUI

local lbc = Instance.new("UICorner") 
lbc.Parent = LoginBtn

LoginBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        LogAction("Key Verified Successfully")
        KeyUI:Destroy()
        Main.Visible = true
        Pages["TP"].Visible = true
        Notify("ACCESS GRANTED. WELCOME, LYZEEN!", Color3.fromRGB(0, 200, 255))
    else
        Notify("INVALID ACCESS KEY!", Color3.fromRGB(255, 50, 50))
        LogAction("Invalid Key Attempt")
    end
end)

-- [[ FINAL CREDITS CONTENT ]] --
local function AddCredit(txt, sub)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0.94, 0, 0, 70)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    f.Parent = CredPage
    Instance.new("UICorner").Parent = f
    
    local l1 = Instance.new("TextLabel")
    l1.Text = txt l1.Size = UDim2.new(1, 0, 0.6, 0) l1.TextColor3 = Color3.fromRGB(255,255,255) l1.Font = Enum.Font.GothamBold l1.BackgroundTransparency = 1 l1.Parent = f
    
    local l2 = Instance.new("TextLabel")
    l2.Text = sub l2.Size = UDim2.new(1, 0, 0.4, 0) l2.Position = UDim2.new(0,0,0.6,0) l2.TextColor3 = Color3.fromRGB(150,150,150) l2.Font = Enum.Font.Gotham l2.BackgroundTransparency = 1 l2.Parent = f
end

AddCredit("LEAD DEVELOPER", "Lyzeen Gray")
AddCredit("UI DESIGNER", "Lyzeen Gray")
AddCredit("SUPPORT", "AI Assistant")

LogAction("Script Fully Loaded. Version 7.8")
-- [[ END OF SCRIPT ]] --
