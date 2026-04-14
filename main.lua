-- [[ LYZEEN HUB - EMOJI OVERDRIVE VERSION ]] --
-- Theme: Full Blue & Full Emoji 🔵
-- Key: LYZ-EEN-HUB

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(10, 10, 15),
    Header = Color3.fromRGB(15, 15, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 35)
}

_G.FinalKey = ""

-- [[ 🛠️ FUNCTION: LOAD MAIN HUB ]] --
local function LaunchHub()
    local MainWin = Kavo.CreateLib("🔵 LyzeenHub | SOUTH BRONX 🔵", Colors)
    
    -- [[ 🌾 AUTO FARM TAB ]] --
    local TabFarm = MainWin:NewTab("🌾 Auto Farm")
    local SecBuy = TabFarm:NewSection("🛒 Auto Buy & Sell 💵")
    
    local buyAmt = 50
    SecBuy:NewSlider("🔢 Jumlah Buy:", "Atur jumlah pembelian", 100, 1, function(s) buyAmt = s end)
    
    SecBuy:NewButton("🔵 BUY ALL (Materials)", "Beli Water, Sugar, Gelatin", function()
        -- [LOGIC BUY]
    end)
    
    SecBuy:NewButton("🟢 SELL ALL (Mallows)", "Jual Semua Marshmallow", function()
        -- [LOGIC SELL]
    end)

    local SecCook = TabFarm:NewSection("🍳 Auto Cook Sequence ⏱️")
    SecCook:NewToggle("🔥 Start Auto Masak", "Otomatis memproses bahan", function(state) end)

    local SecInv = TabFarm:NewSection("🍬 MALLOW YANG SUDAH JADI 🍬")
    SecInv:NewLabel("🍬 Small Marshmallow = 0")
    SecInv:NewLabel("🍬 Medium Marshmallow = 0")
    SecInv:NewLabel("🍬 Large Marshmallow bag = 0")

    -- [[ 🚀 TELEPORT TAB ]] --
    local TabTP = MainWin:NewTab("🚀 Teleport")
    local SecTP = TabTP:NewSection("🏍️ Dirtbike Required 🏍️")
    
    local function Teleport(cf)
        local char = game.Players.LocalPlayer.Character
        local seat = char and char.Humanoid.SeatPart
        if seat and seat.Parent.Name == "Dirtbike" then
            seat.Parent:SetPrimaryPartCFrame(cf)
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "❌ ERROR ❌",
                Text = "Harus pakai Motor (Dirtbike)!",
                Icon = "rbxassetid://6034289542"
            })
        end
    end

    SecTP:NewButton("[🏎️] Dealership", "📍 Go to Dealership", function() Teleport(CFrame.new(517, 5, 604)) end)
    SecTP:NewButton("[🍳] Npc Ms", "📍 Go to NPC MS", function() Teleport(CFrame.new(731, 5, 443)) end)
    SecTP:NewButton("[🔫] Gs Mid", "📍 Go to Gun Shop Mid", function() Teleport(CFrame.new(215, 5, -132)) end)

    -- [[ ⚡ FPS BOOST TAB ]] --
    local TabFPS = MainWin:NewTab("⚡ FPS Boost")
    local SecFPS = TabFPS:NewSection("📈 Performance Monitor 📉")
    
    spawn(function()
        while task.wait(0.5) do
            local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
        end
    end)

    SecFPS:NewToggle("🗑️ Remove Texture", "Boost Performa", function(s) end)
    SecFPS:NewToggle("🌑 Remove Shadows", "Matikan Bayangan", function(s) end)

    -- [[ ⭐ CREDIT TAB ]] --
    local TabCred = MainWin:NewTab("⭐ Credits")
    TabCred:NewSection("          🌟          ")
    TabCred:NewSection("        🌟🌟🌟        ")
    TabCred:NewSection("      🌟🌟🌟🌟🌟      ")
    TabCred:NewSection("      ⭐ LYZEEN ⭐     ")
    TabCred:NewSection("🔵 CREATED BY LYZEEN 🔵")
end

-- [[ 🔑 KEY SYSTEM WINDOW ]] --
local KeyWin = Kavo.CreateLib("🔑 LyzeenHub | Auth 🔑", Colors)
local KeyTab = KeyWin:NewTab("🛡️ Verification")
local KeySec = KeyTab:NewSection("🔑 Masukkan key untuk melanjutkan 🔑")

KeySec:NewTextBox("⌨️ Ketik Key Di Sini...", "Validasi Akses", function(t)
    _G.FinalKey = t
end)

KeySec:NewButton("➡ CONTINUE ➡", "Masuk ke Main Hub", function()
    if _G.FinalKey == "LYZ-EEN-HUB" then
        KeyWin:Destroy()
        task.wait(0.2)
        LaunchHub()
    else
        game.Players.LocalPlayer:Kick("❌ KEY INVALID [ Lyzeen ] ❌")
    end
end)

-- Status Label
local L = Instance.new("TextLabel")
L.Parent = game:GetService("CoreGui"):FindFirstChild("🔑 LyzeenHub | Auth 🔑")
L.Text = "🔵 WAITING KEY..."
L.Position = UDim2.new(0, 10, 1, -30)
L.Size = UDim2.new(0, 150, 0, 20)
L.TextColor3 = Color3.fromRGB(0, 85, 255)
L.BackgroundTransparency = 1
L.TextXAlignment = Enum.TextXAlignment.Left
