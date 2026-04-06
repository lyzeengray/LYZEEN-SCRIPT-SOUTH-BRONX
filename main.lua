-- [[ AETHER 1.0 - STABLE TAB SYSTEM ]] --
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local TabHolder = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
Main.Name = "AetherFinal"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Position = UDim2.new(0.5, -175, 0.5, -125)
Main.Size = UDim2.new(0, 350, 0, 250)
Main.Active = true
Main.Draggable = true

-- Sidebar (Tempat Pilih Menu)
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.Size = UDim2.new(0, 85, 1, 0)

Title.Parent = Sidebar
Title.Text = "AETHER"
Title.TextColor3 = Color3.fromRGB(50, 255, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

-- Tab Holder (Tempat Isi Konten)
TabHolder.Name = "TabHolder"
TabHolder.Parent = Main
TabHolder.Position = UDim2.new(0.25, 5, 0.05, 5)
TabHolder.Size = UDim2.new(0.73, 0, 0.9, 0)
TabHolder.BackgroundTransparency = 1

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
    Layout.Padding = UDim.new(0, 5)
    return Page
end

local PageTP = CreatePage("TeleportPage")
local PageCombat = CreatePage("CombatPage")
local PageCook = CreatePage("CookPage")

-- Fungsi Switch Tab
local function ShowPage(page)
    PageTP.Visible = false
    PageCombat.Visible = false
    PageCook.Visible = false
    page.Visible = true
end

local function AddTabBtn(txt, page, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (pos * 35))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.MouseButton1Click:Connect(function() ShowPage(page) end)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 4) c.Parent = btn
end

AddTabBtn("🚀 Teleport", PageTP, 0)
AddTabBtn("⚔️ Combat", PageCombat, 1)
AddTabBtn("🪔 Cooking", PageCook, 2)

-- Fungsi Komponen
local function AddBtn(parent, txt, callback)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(0.95, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.MouseButton1Click:Connect(callback)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 4) c.Parent = b
end

-- [[ ISI TAB TELEPORT ]] --
local function TP(cf)
    local Hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if Hum and Hum.SeatPart then Hum.SeatPart.Parent:SetPrimaryPartCFrame(cf) end
end

AddBtn(PageTP, "🚗 Dealership", function() TP(CFrame.new(731, 6.5, 443)) end)
AddBtn(PageTP, "👤 Npc Ms", function() TP(CFrame.new(517, 6.5, 604)) end)
AddBtn(PageTP, "🔫 Gs mid", function() TP(CFrame.new(215, 6.5, -132)) end)
AddBtn(PageTP, "🏢 APT 1", function() TP(CFrame.new(1140, 11, 448)) end)
AddBtn(PageTP, "🏢 APT 2", function() TP(CFrame.new(1140, 11, 420)) end)
AddBtn(PageTP, "🏢 APT 3", function() TP(CFrame.new(923, 11, 41)) end)
AddBtn(PageTP, "🏢 APT 4", function() TP(CFrame.new(894, 11, 40)) end)

-- [[ ISI TAB COMBAT ]] --
_G.HB = 1
local function ToggleHB(btn)
    if _G.HB == 1 then _G.HB = 5 btn.Text = "⚔️ HITBOX: ON" btn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    else _G.HB = 1 btn.Text = "⚔️ HITBOX: OFF" btn.BackgroundColor3 = Color3.fromRGB(255, 100, 100) end
end
AddBtn(PageCombat, "⚔️ HITBOX: OFF", function() ToggleHB(PageCombat:FindFirstChild("TextButton")) end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HB > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function() v.Character.Head.Size = Vector3.new(_G.HB, _G.HB, _G.HB) v.Character.Head.CanCollide = false end)
            end
        end
    end
end)

-- [[ ISI TAB COOKING ]] --
_G.Cook = false
AddBtn(PageCook, "🪔 AUTO MS: OFF", function()
    _G.Cook = not _G.Cook
    PageCook:FindFirstChild("TextButton").Text = _G.Cook and "🪔 AUTO MS: ON" or "🪔 AUTO MS: OFF"
end)

ShowPage(PageTP) -- Start Page
