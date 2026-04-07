-- [[ LYZHUB V1 - SOUTH BRONX EDITION ]] --
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local TabHolder = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
Main.Name = "LyzHub"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.Position = UDim2.new(0.5, -250, 0.5, -150)
Main.Size = UDim2.new(0, 500, 0, 300)
Main.Active = true
Main.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = Main

-- Sidebar
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 24, 38)
Sidebar.Size = UDim2.new(0, 110, 1, 0)

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = Sidebar

Title.Parent = Sidebar
Title.Text = "LYZ HUB"
Title.TextColor3 = Color3.fromRGB(50, 255, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- Tab Logic
local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = TabHolder
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 8)
    Pages[name] = Page
    return Page
end

TabHolder.Parent = Main
TabHolder.Position = UDim2.new(0, 120, 0, 10)
TabHolder.Size = UDim2.new(0, 370, 0, 280)
TabHolder.BackgroundTransparency = 1

local LocPage = CreatePage("Locations")
local CombatPage = CreatePage("Combat")
local FarmPage = CreatePage("Farm")

local function ShowPage(name)
    for _, p in pairs(Pages) do p.Visible = false end
    Pages[name].Visible = true
end

local function AddTab(txt, pageName, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 36, 56)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(function() ShowPage(pageName) end)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

AddTab("📍 LOCATIONS", "Locations", 50)
AddTab("⚔️ COMBAT", "Combat", 95)
AddTab("🔥 FARM", "Farm", 140)

-- Components
local function AddTeleport(parent, name, cf)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(25, 30, 48)
    frame.Parent = parent
    
    local txt = Instance.new("TextLabel")
    txt.Text = "  " .. name
    txt.Size = UDim2.new(0.6, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Text = "Teleport"
    btn.Size = UDim2.new(0, 80, 0, 25)
    btn.Position = UDim2.new(1, -90, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = frame
    btn.MouseButton1Click:Connect(function()
        local Hum = game.Players.LocalPlayer.Character.Humanoid
        if Hum.SeatPart then Hum.SeatPart.Parent:SetPrimaryPartCFrame(cf) end
    end)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 4) c.Parent = btn
end

-- Content Locations
AddTeleport(LocPage, "🚗 Dealership", CFrame.new(731, 7, 443))
AddTeleport(LocPage, "👤 Npc Ms", CFrame.new(517, 7, 604))
AddTeleport(LocPage, "🔫 Gs mid", CFrame.new(215, 7, -132))
AddTeleport(LocPage, "🏢 Apartment 1", CFrame.new(1140, 11, 448))
AddTeleport(LocPage, "🏢 Apartment 2", CFrame.new(1140, 11, 420))
AddTeleport(LocPage, "🏢 Apartment 3", CFrame.new(923, 11, 41))
AddTeleport(LocPage, "🏢 Apartment 4", CFrame.new(894, 11, 40))

-- Content Combat
_G.HB = 1
local hbBtn = Instance.new("TextButton")
hbBtn.Size = UDim2.new(0.95, 0, 0, 40)
hbBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
hbBtn.Text = "HITBOX MOD: OFF"
hbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hbBtn.Parent = CombatPage
hbBtn.MouseButton1Click:Connect(function()
    if _G.HB == 1 then
        _G.HB = 5
        hbBtn.Text = "HITBOX MOD: ON"
        hbBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    else
        _G.HB = 1
        hbBtn.Text = "HITBOX MOD: OFF"
        hbBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- Content Farm (Auto MS)
_G.Cook = false
local cookBtn = Instance.new("TextButton")
cookBtn.Size = UDim2.new(0.95, 0, 0, 40)
cookBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cookBtn.Text = "AUTO MS: OFF"
cookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cookBtn.Parent = FarmPage
cookBtn.MouseButton1Click:Connect(function()
    _G.Cook = not _G.Cook
    cookBtn.Text = _G.Cook and "AUTO MS: ON" or "AUTO MS: OFF"
    cookBtn.BackgroundColor3 = _G.Cook and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(40, 40, 40)
end)

-- Hitbox Loop
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HB > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function() v.Character.Head.Size = Vector3.new(_G.HB, _G.HB, _G.HB) v.Character.Head.CanCollide = false end)
            end
        end
    end
end)

ShowPage("Locations")
