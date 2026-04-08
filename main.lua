-- [[ LYZEENHUB V6.7 PLATINUM - FULL CONSOLIDATED EDITION ]] --
-- [[ DEVELOPED FOR LYZEEN_GRAY | SOUTH BRONX PROJECT ]] --
-- [[ TOTAL LINES: 300+ GUARANTEED ]] --

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenPlatinumFinal"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- [[ CONFIGURATION ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"
local _G_AutoCook = false
local _G_AutoBuy = false

-- [[ NOTIFICATION SYSTEM ]] --
local function Notify(msg, color)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 280, 0, 45)
    n.Position = UDim2.new(0.5, -140, -0.1, 0)
    n.BackgroundColor3 = color or Color3.fromRGB(20, 20, 25)
    n.BorderSizePixel = 0
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.Text = "  " .. msg
    n.Font = Enum.Font.GothamBold
    n.TextSize = 13
    n.Parent = ScreenGui
    
    local nc = Instance.new("UICorner") nc.CornerRadius = UDim.new(0, 10) nc.Parent = n
    
    local nStroke = Instance.new("UIStroke")
    nStroke.Thickness = 2
    nStroke.Color = Color3.fromRGB(45, 45, 55)
    nStroke.Parent = n
    
    n:TweenPosition(UDim2.new(0.5, -140, 0.05, 0), "Out", "Back", 0.5)
    
    task.delay(2.5, function()
        if n then
            n:TweenPosition(UDim2.new(0.5, -140, -0.1, 0), "In", "Quad", 0.5)
            task.wait(0.5) n:Destroy()
        end
    end)
end

-- [[ DRAG SYSTEM LOGIC ]] --
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

-- [[ MAIN FRAME UI ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 560, 0, 390)
Main.Position = UDim2.new(0.5, -280, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.CornerRadius = UDim.new(0, 12) mc.Parent = Main
MakeDraggable(Main)

-- [[ SIDEBAR SYSTEM ]] --
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 170, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 12) sc.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 185, 0, 50)
Container.Size = UDim2.new(0, 360, 0, 320)
Container.BackgroundTransparency = 1
Container.Parent = Main

-- [[ CLOSE BUTTON ]] --
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 55, 55)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main
local cbcr = Instance.new("UICorner") cbcr.CornerRadius = UDim.new(0, 8) cbcr.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- [[ PAGE MANAGER ]] --
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
local CredPage = CreatePage("Cred")

-- [[ GLOBAL UTILITIES ]] --
local function IsOnMotor()
    return (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart ~= nil)
end

local function IsNearPanci()
    local cooker = workspace:FindFirstChild("Cooker")
    if cooker and LocalPlayer.Character then
        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - cooker.Position).Magnitude
        return dist < 15
    end
    return false
end

local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and LocalPlayer.Character then
        return (LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 18
    end
    return false
end

-- [[ COMPONENT BUILDER ]] --
local function AddButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.96, 0, 0, 50)
    b.BackgroundColor3 = color
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
    Label.Text = txt Label.Size = UDim2.new(0, 210, 1, 0) Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255) Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left Label.TextSize = 14 Label.Parent = b
    
    b.MouseButton1Click:Connect(function()
        local t = TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255,255,255)})
        t:Play() t.Completed:Wait()
        TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = color}):Play()
        callback()
    end)
end

-- [[ AUTO FARMING SECTION ]] --
local BuyAmount = 1
local AmountInp = Instance.new("TextBox")
AmountInp.Size = UDim2.new(0.96, 0, 0, 45)
AmountInp.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
AmountInp.PlaceholderText = "Input Jumlah Beli (MS)..."
AmountInp.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountInp.Font = Enum.Font.Gotham
AmountInp.Parent = FarmPage
local ac = Instance.new("UICorner") ac.Parent = AmountInp
AmountInp.FocusLost:Connect(function() BuyAmount = tonumber(AmountInp.Text) or 1 end)

AddButton(FarmPage, "🛒", "AUTO BUY MS INGREDIENTS", Color3.fromRGB(0, 100, 210), function()
    if not NearNPC() then Notify("Gagal: Harus Dekat NPC Lamont!", Color3.fromRGB(200, 50, 50)) return end
    Notify("Membeli " .. BuyAmount .. " Set Bahan...", Color3.fromRGB(50, 200, 50))
    for i = 1, BuyAmount do
        local RE = game:GetService("ReplicatedStorage").Events.ShopEvent
        RE:FireServer("Water") task.wait(0.4)
        RE:FireServer("Sugar Block Bag") task.wait(0.4)
        RE:FireServer("Gelatin") task.wait(0.4)
    end
    Notify("Selesai Belanja MS!", Color3.fromRGB(50, 200, 50))
end)

AddButton(FarmPage, "🔥", "START AUTO COOK MS", Color3.fromRGB(180, 40, 40), function()
    if not IsNearPanci() then 
        Notify("ANDA HARUS DIDEKAT PANCI", Color3.fromRGB(200, 50, 50)) 
        return 
    end
    _G_AutoCook = not _G_AutoCook
    Notify(_G_AutoCook and "Auto Cook: AKTIF" or "Auto Cook: MATI")
    
    task.spawn(function()
        while _G_AutoCook do
            if not IsNearPanci() then 
                _G_AutoCook = false 
                Notify("Gagal: Jauh dari Panci!", Color3.fromRGB(200, 50, 50))
                break 
            end
            
            local function Crafting(item, wt)
                if not _G_AutoCook then return end
                local t = LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item)
                if t then
                    LocalPlayer.Character.Humanoid:EquipTool(t)
                    task.wait(0.5)
                    if workspace:FindFirstChild("Cooker") and workspace.Cooker:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(workspace.Cooker.ProximityPrompt)
                        task.wait(wt)
                    end
                end
            end
            
            Crafting("Water", 23.5)
            Crafting("Sugar", 3.5)
            Crafting("Gelatin", 63.5)
            task.wait(1)
        end
    end)
end)

-- [[ TELEPORT SECTION ]] --
local tpPoints = {
    {"👤", "Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Car Dealer", CFrame.new(731, 7, 443)},
    {"📍", "GS Mid Area", CFrame.new(215, 7, -132)},
    {"🏢", "Apartment 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apartment 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apartment 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apartment 4", CFrame.new(894, 11, 40)}
}

for _, v in pairs(tpPoints) do
    AddButton(TelePage, v[1], "Tele ke " .. v[2], Color3.fromRGB(30, 30, 38), function()
        if not IsOnMotor() then 
            Notify("Gagal: Wajib Naik Motor!", Color3.fromRGB(200, 50, 50)) 
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = v[3]
        end
    end)
end

-- [[ SIDEBAR TABS ]] --
local function AddTab(txt, page, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 48)
    b.Position = UDim2.new(0.05, 0, 0, 75 + (pos * 58))
    b.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = Sidebar
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[page].Visible = true
    end)
end

AddTab("🎭 TELEPORT", "TP", 0)
AddTab("🍃 AUTO FARM", "Farm", 1)
AddTab("⭐ CREDIT", "Cred", 2)

-- [[ CREDITS PAGE CONTENT ]] --
local CredFrame = Instance.new("Frame")
CredFrame.Size = UDim2.new(0.96, 0, 0, 150)
CredFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
CredFrame.Parent = CredPage
local cfc = Instance.new("UICorner") cfc.Parent = CredFrame
local DevName = Instance.new("TextLabel")
DevName.Text = "LYZEEN HUB V6.7"
DevName.Size = UDim2.new(1, 0, 0.5, 0)
DevName.TextColor3 = Color3.fromRGB(255, 255, 255)
DevName.Font = Enum.Font.GothamBold
DevName.BackgroundTransparency = 1
DevName.Parent = CredFrame

-- [[ KEY AUTHENTICATION SYSTEM ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 380, 0, 220)
KeyUI.Position = UDim2.new(0.5, -190, 0.5, -110)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI
local kStroke = Instance.new("UIStroke") kStroke.Thickness = 2 kStroke.Color = Color3.fromRGB(40, 40, 50) kStroke.Parent = KeyUI

local KeyIn = Instance.new("TextBox")
KeyIn.Size = UDim2.new(0.8, 0, 0, 45)
KeyIn.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyIn.PlaceholderText = "Enter Access Key..."
KeyIn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyIn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyIn.Parent = KeyUI
local kic = Instance.new("UICorner") kic.Parent = KeyIn

local LogBtn = Instance.new("TextButton")
LogBtn.Size = UDim2.new(0.8, 0, 0, 50)
LogBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
LogBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
LogBtn.Text = "LOGIN"
LogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LogBtn.Font = Enum.Font.GothamBold
LogBtn.Parent = KeyUI
local lbc = Instance.new("UICorner") lbc.Parent = LogBtn

LogBtn.MouseButton1Click:Connect(function()
    if KeyIn.Text == CorrectKey then
        KeyUI:Destroy()
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 560, 0, 390)}):Play()
        Pages["TP"].Visible = true
        Notify("Welcome Back, Lyzeen!", Color3.fromRGB(0, 160, 255))
    else
        Notify("ACCESS DENIED!", Color3.fromRGB(220, 40, 40))
    end
end)
