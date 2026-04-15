-- [[ 🔵 LYZEEN HUB v2.2 - SUPREME REPLICA 🔵 ]] --
-- Fix: Item Tracker, Dynamic FPS, Real FPS Booster, Star Credit

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(20, 20, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(25, 25, 40)
}

local MainWin = Kavo.CreateLib("🔵 LYZEEN HUB | v2.2", Colors)

-- [[ 🌾 TAB: AUTO FARM ]] --
local TabFarm = MainWin:NewTab("Auto Farm")
local SecBuy = TabFarm:NewSection("Auto Buy & Sell")

local buyAmt = 50
SecBuy:NewSlider("Jumlah Buy:", "", 101, 1, function(s) buyAmt = s end)

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

local SecInv = TabFarm:NewSection("Bahan & Hasil")
local labelS = SecInv:NewLabel("🍬 SMALL MARSHMALLOW = 0")
local labelM = SecInv:NewLabel("🍬 MEDIUM MARSHMALLOW = 0")
local labelL = SecInv:NewLabel("🍬 LARGE MARSHMALLOW BAG = 0")

-- Loop Tracker (Update tiap 1 detik)
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

-- [[ 🚀 TAB: TELEPORT ]] --
local TabTP = MainWin:NewTab("Teleport")
local SecTP = TabTP:NewSection("Vehicle Teleport 🏍️")
local function VTP(cf)
    local v = game.Players.LocalPlayer.Character.Humanoid.SeatPart
    if v and v.Parent.Name == "Dirtbike" then v.Parent:SetPrimaryPartCFrame(cf) end
end
SecTP:NewButton("● MS Dealer", "TP Motor", function() VTP(CFrame.new(731, 5, 443)) end)
SecTP:NewButton("● Casino", "TP Motor", function() VTP(CFrame.new(517, 5, 604)) end)

-- [[ ⚡ TAB: FPS BOOST ]] --
local TabFPS = MainWin:NewTab("FPS Boost")
local SecFPS = TabFPS:NewSection("⚡ 0 FPS")

-- FPS Counter Dinamis
spawn(function()
    while task.wait(0.5) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
    end
end)

SecFPS:NewToggle("Remove Texture", "Hapus tekstur untuk boost", function(state)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and state then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Texture") or v:IsA("Decal") then
            v.Transparency = state and 1 or 0
        end
    end
end)

SecFPS:NewToggle("Remove Shadow", "Matikan bayangan", function(state)
    game.Lighting.GlobalShadows = not state
end)

-- [[ ⭐ TAB: CREDITS ]] --
local TabCred = MainWin:NewTab("Credits")
TabCred:NewSection("⭐")
TabCred:NewSection("CREATED BY LYZ-EEN")

-- [[ 🔳 MINIMIZE SYSTEM ]] --
local MinimizeUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local LH = Instance.new("TextButton", MinimizeUI)
LH.Size = UDim2.new(0, 60, 0, 60)
LH.Position = UDim2.new(0, 10, 0, 150)
LH.Text = "LH"
LH.Font = Enum.Font.LuckiestGuy
LH.TextColor3 = Color3.new(1,1,1)
LH.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH.Visible = false
LH.Draggable = true
Instance.new("UICorner", LH).CornerRadius = UDim.new(0, 15)

LH.MouseButton1Click:Connect(function()
    game:GetService("CoreGui"):FindFirstChild("🔵 LYZEEN HUB | v2.2").Main.Visible = true
    LH.Visible = false
end)
