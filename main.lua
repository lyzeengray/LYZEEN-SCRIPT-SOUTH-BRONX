local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenPlatinum"
ScreenGui.Parent = game.CoreGui

-- [[ NOTIFIKASI SYSTEM ]] --
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

-- [[ MAIN HUB ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 520, 0, 350)
Main.Position = UDim2.new(0.5, -260, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.Parent = Main

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 165, 0, 15)
Container.Size = UDim2.new(0, 340, 0, 320)
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
    Layout.Padding = UDim.new(0, 10)
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local CredPage = CreatePage("Cred")

-- [[ MODERN BUTTON FACTORY (Emoji di Kiri) ]] --
local function AddModernButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.98, 0, 0, 45)
    b.BackgroundColor3 = color
    b.Text = ""
    b.Parent = parent
    local c = Instance.new("UICorner") c.Parent = b

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.Padding = UDim.new(0, 15)
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Parent = b

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 15)
    pad.Parent = b

    local Icon = Instance.new("TextLabel")
    Icon.Text = emoji
    Icon.Size = UDim2.new(0, 25, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 18
    Icon.Parent = b

    local Label = Instance.new("TextLabel")
    Label.Text = txt
    Label.Size = UDim2.new(0, 200, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 14
    Label.Parent = b

    b.MouseButton1Click:Connect(callback)
end

-- [[ AUTO FARM LOGIC ]] --
local function IsOnMotor() return (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil) end
local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    return npc and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 15
end

AddModernButton(FarmPage, "🛒", "START AUTO BUY MS", Color3.fromRGB(0, 120, 255), function()
    if not NearNPC() then Notify("Gagal: Harus dekat NPC Lamont Bell!", Color3.fromRGB(200, 0, 0)) return end
    Notify("Membeli Bahan MS...", Color3.fromRGB(0, 200, 0))
    for i=1, 5 do
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Water") task.wait(0.3)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Sugar Block Bag") task.wait(0.3)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Gelatin") task.wait(0.3)
    end
end)

local _G_Cook = false
AddModernButton(FarmPage, "🔥", "START AUTO COOK", Color3.fromRGB(180, 40, 40), function()
    if not IsOnMotor() then Notify("Gagal: Harus naik motor!", Color3.fromRGB(200, 0, 0)) return end
    _G_Cook = not _G_Cook
    Notify(_G_Cook and "Auto Cook: ON" or "Auto Cook: OFF")
    spawn(function()
        while _G_Cook do
            if not IsOnMotor() then _G_Cook = false break end
            fireproximityprompt(workspace.Cooker.ProximityPrompt)
            task.wait(1.5)
        end
    end)
end)

-- [[ TELEPORTS ]] --
local locs = {
    {"👤", "Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Car Dealer", CFrame.new(731, 7, 443)},
    {"🏢", "Apartment 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apartment 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apartment 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apartment 4", CFrame.new(894, 11, 40)}
}
for _, l in pairs(locs) do
    AddModernButton(TelePage, l[1], "Teleport ke " .. l[2], Color3.fromRGB(35, 35, 45), function()
        if not IsOnMotor() then Notify("Gagal: Harus naik motor!", Color3.fromRGB(200, 0, 0))
        else game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = l[3] end
    end)
end

-- [[ TABS ]] --
local function AddTab(emoji, txt, page, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, 65 + (pos * 55))
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
AddTab("📍", "MAPS", "TP", 0)
AddTab("🍃", "FARM", "Farm", 1)
AddTab("⭐", "DEV", "Cred", 2)

-- [[ KEY SYSTEM & ANIMATION ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 340, 0, 180)
KeyUI.Position = UDim2.new(0.5, -170, 0.5, -90)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI

local KeyIn = Instance.new("TextBox")
KeyIn.Size = UDim2.new(0.8, 0, 0, 40)
KeyIn.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyIn.PlaceholderText = "Input Access Key..."
KeyIn.Parent = KeyUI

local Log = Instance.new("TextButton")
Log.Size = UDim2.new(0.8, 0, 0, 40)
Log.Position = UDim2.new(0.1, 0, 0.65, 0)
Log.Text = "LOGIN"
Log.Parent = KeyUI

Log.MouseButton1Click:Connect(function()
    if KeyIn.Text == "LYZEENHUB-ON-TOP" then
        KeyUI:Destroy()
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 520, 0, 350)}):Play()
        Pages["TP"].Visible = true
    end
end)
