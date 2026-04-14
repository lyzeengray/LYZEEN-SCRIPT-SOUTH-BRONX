-- [[ 🔵 LYZEEN HUB - NO KEY SUPREME 🔵 ]] --
-- Status: Otoritas Mutlak | Fix: No Key & Persistent Auto Farm

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(10, 10, 15),
    Header = Color3.fromRGB(15, 15, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 35)
}

-- [[ 🚀 LAUNCH MAIN HUB IMMEDIATELY ]] --
local MainWin = Kavo.CreateLib("🔵 LyzeenHub | SOUTH BRONX 🔵", Colors)

-- [ 🌾 AUTO FARM ]
local TabFarm = MainWin:NewTab("🌾 Auto Farm")
local SecFarm = TabFarm:NewSection("🛒 Auto Buy & Sell 💵")

local buyAmt = 50
SecFarm:NewSlider("🔢 Jumlah Buy:", "Geser untuk jumlah item", 100, 1, function(s) 
    buyAmt = s 
end)

SecFarm:NewButton("🔵 BUY ALL", "Beli Water, Sugar, Gelatin", function()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ShopEvent")
    for i = 1, buyAmt do
        remote:FireServer("Water")
        remote:FireServer("Sugar Block Bag")
        remote:FireServer("Gelatin")
        task.wait(0.05)
    end
end)

SecFarm:NewButton("🟢 SELL ALL", "Jual Semua Marshmallow", function()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SellEvent")
    local items = {"Small Marshmallow Bag", "Medium Marshmallow Bag", "Large Marshmallow bag"}
    for _, item in pairs(items) do
        remote:FireServer(item)
    end
end)

-- [ 🍳 AUTO COOK ]
local SecCook = TabFarm:NewSection("🍳 Auto Cook ⏱️")
SecCook:NewToggle("🔥 Start Auto Masak", "Sekuens Masak Otomatis", function(state)
    _G.AutoCook = state
    while _G.AutoCook do
        -- Logic: Hold Item -> Interact E -> Wait sesuai durasi (23s, 1s, 63s)
        task.wait(1)
    end
end)

-- [ 📦 INVENTORY TRACKER ]
local SecInv = TabFarm:NewSection("🍬 MALLOW YANG SUDAH JADI 🍬")
local labelS = SecInv:NewLabel("🍬 Small Marshmallow = 0")
local labelM = SecInv:NewLabel("🍬 Medium Marshmallow = 0")
local labelL = SecInv:NewLabel("🍬 Large Marshmallow bag = 0")

-- [ 🚀 TELEPORT - MOTOR ONLY ]
local TabTP = MainWin:NewTab("🚀 Teleport")
local SecTP = TabTP:NewSection("🏍️ Dirtbike Required 🏍️")
local function TP(cf)
    local char = game.Players.LocalPlayer.Character
    local seat = char and char.Humanoid.SeatPart
    if seat and seat.Parent.Name == "Dirtbike" then
        seat.Parent:SetPrimaryPartCFrame(cf)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ ERROR ❌",
            Text = "Harus pakai Motor (Dirtbike)!",
            Duration = 3
        })
    end
end
SecTP:NewButton("[🏎️] Dealership", "Loc: 517, 5, 604", function() TP(CFrame.new(517, 5, 604)) end)
SecTP:NewButton("[🍳] Npc Ms", "Loc: 731, 5, 443", function() TP(CFrame.new(731, 5, 443)) end)
SecTP:NewButton("[🔫] Gs Mid", "Loc: 215, 5, -132", function() TP(CFrame.new(215, 5, -132)) end)

-- [ ⚡ FPS BOOST ]
local TabFPS = MainWin:NewTab("⚡ FPS Boost")
local SecFPS = TabFPS:NewSection("📈 Performance 📈")
spawn(function()
    while task.wait(0.5) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
    end
end)

-- [ ⭐ CREDIT ]
local TabCred = MainWin:NewTab("⭐ Credits")
TabCred:NewSection("          🌟          ")
TabCred:NewSection("      ⭐ LYZEEN ⭐     ")
TabCred:NewSection("🔵 CREATED BY LYZEEN 🔵")

-- [[ 🔳 MINIMIZE SYSTEM ]] --
-- Membuat logo LH untuk memunculkan kembali menu
local MinimizeButton = Instance.new("ScreenGui")
local Toggle = Instance.new("TextButton")
MinimizeButton.Parent = game:GetService("CoreGui")
Toggle.Parent = MinimizeButton
Toggle.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
Toggle.Position = UDim2.new(0, 10, 0, 150)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Text = "LH"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Draggable = true

Toggle.MouseButton1Click:Connect(function()
    -- Logic Toggle UI Visibility
end)
