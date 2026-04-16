-- [[ 🔵 LYZEEN HUB v2.2 - INDUSTRIAL GRADE 🔵 ]] --
-- Optimizer: Delta & Xeno Stable
-- Features: Precise Auto Cook, Vehicle Teleport, Live Inventory

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(20, 20, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(25, 25, 40)
}

-- [[ 🛠️ UI INITIALIZATION ]] --
local MainWin = Kavo.CreateLib("🔵 LYZEEN HUB | v2.2", Colors)
local MainFrame = game:GetService("CoreGui"):FindFirstChild("🔵 LYZEEN HUB | v2.2").Main

-- [[ 🔳 MINIMIZE SYSTEM (LH LOGO) ]] --
local MinimizeUI = Instance.new("ScreenGui")
MinimizeUI.Name = "LyzeenMinimize"
MinimizeUI.Parent = game:GetService("CoreGui")

local LH = Instance.new("TextButton")
LH.Parent = MinimizeUI
LH.Size = UDim2.new(0, 60, 0, 60)
LH.Position = UDim2.new(0, 20, 0, 200)
LH.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH.Text = "LH"
LH.Font = Enum.Font.LuckiestGuy
LH.TextSize = 30
LH.TextColor3 = Color3.new(1, 1, 1)
LH.Visible = false
LH.Draggable = true -- Support Mobile Drag
Instance.new("UICorner", LH).CornerRadius = UDim.new(0, 15)

local function ToggleUI()
    local isVisible = MainFrame.Visible
    MainFrame.Visible = not isVisible
    LH.Visible = isVisible
end

LH.MouseButton1Click:Connect(ToggleUI)

-- [[ 🌾 TAB 1: AUTO FARM (MASTER ENGINE) ]] --
local TabFarm = MainWin:NewTab("🌾 Auto Farm")

-- Section: Auto Buy
local SecBuy = TabFarm:NewSection("🛒 Auto Buy & Sell 💵")
SecBuy:NewButton("🔳 MINIMIZE MENU", "Klik untuk munculkan logo LH", ToggleUI)

local buyAmt = 50
SecBuy:NewSlider("🔢 Jumlah Buy:", "Geser jumlah item", 101, 1, function(s) buyAmt = s end)

SecBuy:NewButton("🔵 BUY ALL (Materials)", "Beli Water, Sugar, Gelatin", function()
    local shop = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ShopEvent")
    for i = 1, buyAmt do
        shop:FireServer("Water")
        task.wait(0.08)
        shop:FireServer("Sugar Block Bag")
        task.wait(0.08)
        shop:FireServer("Gelatin")
        task.wait(0.1)
    end
end)

-- Section: Auto Cook (The Precise Sequence)
local SecCook = TabFarm:NewSection("🍳 Auto Cook Sequence ⏱️")
_G.AutoCook = false
SecCook:NewToggle("🔥 START AUTO MASAK", "Sekuens Masak Otomatis", function(state)
    _G.AutoCook = state
    spawn(function()
        while _G.AutoCook do
            local p = game.Players.LocalPlayer
            local function cook(name, duration)
                if not _G.AutoCook then return end
                local tool = p.Backpack:FindFirstChild(name) or p.Character:FindFirstChild(name)
                if tool then
                    p.Character.Humanoid:EquipTool(tool)
                    task.wait(0.5)
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and p:DistanceFromCharacter(v.Parent.Position) < 12 then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(duration)
                end
            end
            cook("Water", 23)
            cook("Sugar Block Bag", 1)
            cook("Gelatin", 63)
            cook("Empty Bag", 2)
            task.wait(1)
        end
    end)
end)

-- Section: Inventory Tracker
local SecInv = TabFarm:NewSection("🍬 Inventory Tracker 🍬")
local labelS = SecInv:NewLabel("🍬 SMALL MARSHMALLOW = 0")
local labelM = SecInv:NewLabel("🍬 MEDIUM MARSHMALLOW = 0")
local labelL = SecInv:NewLabel("🍬 LARGE MARSHMALLOW BAG = 0")

spawn(function()
    while true do
        local bp = game.Players.LocalPlayer.Backpack
        local s, m, l = 0, 0, 0
        for _, v in pairs(bp:GetChildren()) do
            if v.Name == "Small Marshmallow Bag" then s = s + 1
            elseif v.Name == "Medium Marshmallow Bag" then m = m + 1
            elseif v.Name == "Large Marshmallow bag" then l = l + 1 end
        end
        labelS:SetText("🍬 SMALL MARSHMALLOW = " .. s)
        labelM:SetText("🍬 MEDIUM MARSHMALLOW = " .. m)
        labelL:SetText("🍬 LARGE MARSHMALLOW BAG = " .. l)
        task.wait(1)
    end
end)

-- [[ 🚀 TAB 2: TELEPORT (VEHICLE SYNC) ]] --
local TabTP = MainWin:NewTab("🚀 Teleport")
local SecTP = TabTP:NewSection("🏍️ Vehicle Teleport (Dirtbike) 🏍️")

local function VehicleTP(cf)
    local char = game.Players.LocalPlayer.Character
    local seat = char and char.Humanoid.SeatPart
    if seat and seat.Parent.Name == "Dirtbike" then
        seat.Parent:SetPrimaryPartCFrame(cf)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ ERROR",
            Text = "Gunakan Kendaraan!",
            Duration = 3
        })
    end
end

SecTP:NewButton("📍 GS Mid", "Teleport ke GS Mid", function() VehicleTP(CFrame.new(215, 5, -132)) end)
SecTP:NewButton("📍 MS Dealer", "Teleport ke MS Dealer", function() VehicleTP(CFrame.new(731, 5, 443)) end)
SecTP:NewButton("📍 Dealership", "Teleport ke Dealership", function() VehicleTP(CFrame.new(517, 5, 604)) end)

-- [[ ⚡ TAB 3: FPS BOOST (HARDWARE OPTIMIZATION) ]] --
local TabFPS = MainWin:NewTab("⚡ FPS Boost")
local SecFPS = TabFPS:NewSection("⚡ 0 FPS")

spawn(function()
    while task.wait(0.5) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
    end
end)

SecFPS:NewToggle("🗑️ Remove Texture", "Boost Performa Nyata", function(state)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and state then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Texture") or v:IsA("Decal") then
            v.Transparency = state and 1 or 0
        end
    end
end)

SecFPS:NewToggle("🌑 Remove Shadow", "Matikan Bayangan", function(state)
    game.Lighting.GlobalShadows = not state
end)

-- [[ ⭐ TAB 4: CREDITS ]] --
local TabCred = MainWin:NewTab("⭐ Credits")
TabCred:NewSection("⭐")
TabCred:NewSection("CREATED BY LYZ-EEN")

-- Fix for Delta/Xeno Dragging
MainFrame.Active = true
MainFrame.Draggable = true
