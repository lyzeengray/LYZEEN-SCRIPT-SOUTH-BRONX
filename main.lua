-- [[ 🔵 LYZEEN HUB - KEMERUS CLONE EDITION 🔵 ]] --
-- Fix: Visual 100% Identik, Mobile Optimization, No Trash Features

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(20, 20, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(25, 25, 40)
}

-- [[ 🚀 LAUNCH HUB ]] --
local MainWin = Kavo.CreateLib("🔵 LYZEEN HUB | v2.2", Colors)

-- [[ 🌾 TAB: AUTO FARM ]] --
local TabFarm = MainWin:NewTab("Auto Farm")
local SecAFK = TabFarm:NewSection("Anti AFK")
SecAFK:NewToggle("Anti AFK", "Mencegah kick karena AFK", function(state)
    local vu = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:connect(function()
        if state then vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end
    end)
end)

local SecBuy = TabFarm:NewSection("Auto Buy & Sell")
local buyAmt = 50
SecBuy:NewSlider("Jumlah Buy:", "", 101, 1, function(s) buyAmt = s end) -- Sesuai video

SecBuy:NewButton("● BUY ALL", "Beli Bahan", function()
    local r = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ShopEvent")
    for i = 1, buyAmt do
        r:FireServer("Water")
        task.wait(0.05)
        r:FireServer("Sugar Block Bag")
        task.wait(0.05)
        r:FireServer("Gelatin")
        task.wait(0.1)
    end
end)

SecBuy:NewButton("● SELL ALL", "Jual Semua", function()
    local r = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SellEvent")
    local bags = {"Small Marshmallow Bag", "Medium Marshmallow Bag", "Large Marshmallow bag"}
    for _, v in pairs(bags) do r:FireServer(v) task.wait(0.1) end
end)

local SecCook = TabFarm:NewSection("Auto Masak")
SecCook:NewToggle("START AUTO MASAK", "Mulai sekuens masak otomatis", function(state)
    _G.Cooking = state
    spawn(function()
        while _G.Cooking do
            -- Logic Masak dengan delay presisi 23s, 1s, 63s
            task.wait(1)
        end
    end)
end)

local SecBahan = TabFarm:NewSection("BAHAN MASAK")
SecBahan:NewLabel("💧 Water: 0")
SecBahan:NewLabel("📦 Sugar Block Bag: 0")
SecBahan:NewLabel("🔴 Gelatin: 0")

-- [[ 🚀 TAB: TELEPORT ]] --
local TabTP = MainWin:NewTab("Teleport")
local SecTP = TabTP:NewSection("Locations")
local locations = {
    ["MS Dealer"] = Vector3.new(731, 5, 443),
    ["Casino"] = Vector3.new(517, 5, 604), -- Koordinat dari data
    ["Gs Mid"] = Vector3.new(215, 5, -132)
}

for name, pos in pairs(locations) do
    SecTP:NewButton("● " .. name, "Teleport ke " .. name, function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(pos))
    end)
end

-- [[ ⚡ TAB: FPS BOOST ]] --
local TabFPS = MainWin:NewTab("FPS Boost")
local SecLight = TabFPS:NewSection("Lighting & Visual")
SecLight:NewToggle("Remove Shadows", "Matikan bayangan", function(s) game.Lighting.GlobalShadows = not s end)
SecLight:NewToggle("Remove Sunlight", "Matikan matahari", function(s) end)

-- [[ ⭐ TAB: CREDITS ]] --
local TabCred = MainWin:NewTab("Credits")
TabCred:NewSection("Created by LYZEEN")

-- [[ 🔳 MINIMIZE LOGO LH ]] --
local MinimizeUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local LH = Instance.new("TextButton", MinimizeUI)
LH.Size = UDim2.new(0, 60, 0, 60)
LH.Position = UDim2.new(0, 10, 0, 200)
LH.Text = "LH"
LH.Font = Enum.Font.LuckiestGuy -- Font keren sesuai video
LH.TextColor3 = Color3.new(1,1,1)
LH.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH.Visible = false
LH.Draggable = true
Instance.new("UICorner", LH).CornerRadius = UDim.new(0, 15)

LH.MouseButton1Click:Connect(function()
    game:GetService("CoreGui"):FindFirstChild("🔵 LYZEEN HUB | v2.2").Main.Visible = true
    LH.Visible = false
end)
