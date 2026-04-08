-- [[ LYZEENHUB V6.0 PLATINUM - FULL VERSION ]] --
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenPremium"
ScreenGui.Parent = game.CoreGui

-- [[ CONFIGURATION ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"
local _G_AutoCook = false

-- [[ NOTIFICATION SYSTEM ]] --
local function Notify(msg, color)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 280, 0, 45)
    n.Position = UDim2.new(0.5, -140, -0.1, 0)
    n.BackgroundColor3 = color or Color3.fromRGB(30, 30, 35)
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.Text = "  " .. msg
    n.Font = Enum.Font.GothamBold
    n.Parent = ScreenGui
    local nc = Instance.new("UICorner") nc.Parent = n
    n:TweenPosition(UDim2.new(0.5, -140, 0.05, 0), "Out", "Back", 0.5)
    task.delay(2, function()
        n:TweenPosition(UDim2.new(0.5, -140, -0.1, 0), "In", "Quad", 0.5)
        task.wait(0.5) n:Destroy()
    end)
end

-- [[ MAIN UI ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.CornerRadius = UDim.new(0, 15) mc.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 15) sc.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 175, 0, 15)
Container.Size = UDim2.new(0, 360, 0, 350)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.Parent = Container
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 10)
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local CredPage = CreatePage("Cred")

-- [[ CHECKER FUNCTIONS ]] --
local function IsOnMotor()
    return (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart ~= nil)
end

local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and LocalPlayer.Character then
        return (LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 18
    end
    return false
end

-- [[ MODERN BUTTON FACTORY (EMOJI KIRI) ]] --
local function AddModernButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.96, 0, 0, 48)
    b.BackgroundColor3 = color
    b.Text = ""
    b.Parent = parent
    local c = Instance.new("UICorner") c.Parent = b

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.Padding = UDim.new(0, 12)
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Parent = b

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 15)
    pad.Parent = b

    local Icon = Instance.new("TextLabel")
    Icon.Text = emoji
    Icon.Size = UDim2.new(0, 30, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 20
    Icon.Parent = b

    local Label = Instance.new("TextLabel")
    Label.Text = txt
    Label.Size = UDim2.new(0, 220, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 14
    Label.Parent = b

    b.MouseButton1Click:Connect(callback)
end

-- [[ AUTO FARM - FULL LOGIC ]] --
local BuyAmount = 1
local AmountInp = Instance.new("TextBox")
AmountInp.Size = UDim2.new(0.96, 0, 0, 40)
AmountInp.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
AmountInp.PlaceholderText = "Input Jumlah Beli (Angka)..."
AmountInp.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountInp.Font = Enum.Font.Gotham
AmountInp.Parent = FarmPage
local ac = Instance.new("UICorner") ac.Parent = AmountInp
AmountInp.FocusLost:Connect(function() BuyAmount = tonumber(AmountInp.Text) or 1 end)

AddModernButton(FarmPage, "🛒", "START AUTO BUY MS", Color3.fromRGB(0, 120, 255), function()
    if not NearNPC() then 
        Notify("ERROR: Harus dekat NPC Lamont Bell!", Color3.fromRGB(200, 0, 0)) 
        return 
    end
    Notify("Membeli " .. BuyAmount .. " Set Bahan...", Color3.fromRGB(0, 200, 0))
    for i = 1, BuyAmount do
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Water") task.wait(0.4)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Sugar Block Bag") task.wait(0.4)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Gelatin") task.wait(0.4)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Empty Bag") task.wait(0.4)
    end
    Notify("Selesai Membeli!", Color3.fromRGB(0, 200, 0))
end)

AddModernButton(FarmPage, "🔥", "START AUTO COOK", Color3.fromRGB(180, 40, 40), function()
    if not IsOnMotor() then 
        Notify("ERROR: Wajib naik motor!", Color3.fromRGB(200, 0, 0)) 
        return 
    end
    _G_AutoCook = not _G_AutoCook
    Notify(_G_AutoCook and "Auto Cook: AKTIF" or "Auto Cook: MATI")
    
    task.spawn(function()
        while _G_AutoCook do
            if not IsOnMotor() then 
                _G_AutoCook = false 
                Notify("Auto Cook Berhenti: Turun Motor", Color3.fromRGB(200, 0, 0))
                break 
            end
            
            local function ProcessCraft(item, waitTime)
                if not _G_AutoCook then return end
                local tool = LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item)
                if tool then
                    LocalPlayer.Character.Humanoid:EquipTool(tool)
                    task.wait(0.5)
                    fireproximityprompt(workspace.Cooker.ProximityPrompt)
                    task.wait(waitTime)
                end
            end
            
            ProcessCraft("Water", 23.5)
            ProcessCraft("Sugar", 3.5)
            ProcessCraft("Gelatin", 63.5)
            ProcessCraft("Empty Bag", 5.5)
            task.wait(1)
        end
    end)
end)

-- [[ TELEPORTS - FULL LIST ]] --
local tps = {
    {"👤", "NPC Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Car Dealer", CFrame.new(731, 7, 443)},
    {"📍", "GS Mid Area", CFrame.new(215, 7, -132)},
    {"🏢", "Apartment 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apartment 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apartment 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apartment 4", CFrame.new(894, 11, 40)},
    {"🏢", "Apartment 5", CFrame.new(1048, 11, 350)},
    {"🏢", "Apartment 6", CFrame.new(1048, 11, 300)}
}

for _, v in pairs(tps) do
    AddModernButton(TelePage, v[1], "Teleport ke " .. v[2], Color3.fromRGB(35, 35, 45), function()
        if not IsOnMotor() then 
            Notify("Gagal: Harus naik motor!", Color3.fromRGB(200, 0, 0)) 
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = v[3]
        end
    end)
end

-- [[ CREDITS ]] --
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0.96, 0, 0, 160)
Card.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Card.Parent = CredPage
local cc = Instance.new("UICorner") cc.Parent = Card

local Name = Instance.new("TextLabel")
Name.Text = "⭐ LYZEEN ⭐"
Name.Size = UDim2.new(1, 0, 0, 60)
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.Font = Enum.Font.GothamBold
Name.TextSize = 24
Name.BackgroundTransparency = 1
Name.Parent = Card

local WarnBox = Instance.new("Frame")
WarnBox.Size = UDim2.new(0.9, 0, 0, 45)
WarnBox.Position = UDim2.new(0.05, 0, 0.6, 0)
WarnBox.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
WarnBox.Parent = Card
local wc = Instance.new("UICorner") wc.Parent = WarnBox

local WarnTxt = Instance.new("TextLabel")
WarnTxt.Text = "Dont share this script"
WarnTxt.Size = UDim2.new(1, 0, 1, 0)
WarnTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
WarnTxt.Font = Enum.Font.GothamBold
WarnTxt.BackgroundTransparency = 1
WarnTxt.Parent = WarnBox

-- [[ TABS ]] --
local function AddTab(emoji, txt, page, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, 70 + (pos * 55))
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = emoji .. "  " .. txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.Parent = Sidebar
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[page].Visible = true
    end)
end
AddTab("📍", "TELEPORT", "TP", 0)
AddTab("🍃", "FARMING", "Farm", 1)
AddTab("👤", "CREDITS", "Cred", 2)

-- [[ KEY SYSTEM & ANIMATION ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 360, 0, 200)
KeyUI.Position = UDim2.new(0.5, -180, 0.5, -100)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI

local KeyIn = Instance.new("TextBox")
KeyIn.Size = UDim2.new(0.8, 0, 0, 45)
KeyIn.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyIn.PlaceholderText = "Input Key..."
KeyIn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyIn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyIn.Parent = KeyUI
local kinc = Instance.new("UICorner") kinc.Parent = KeyIn

local LogBtn = Instance.new("TextButton")
LogBtn.Size = UDim2.new(0.8, 0, 0, 45)
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
        TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 550, 0, 380)}):Play()
        Pages["TP"].Visible = true
        Notify("Welcome Back, Lyzeen!", Color3.fromRGB(0, 180, 255))
    else
        Notify("ACCESS DENIED!", Color3.fromRGB(200, 0, 0))
    end
end)
