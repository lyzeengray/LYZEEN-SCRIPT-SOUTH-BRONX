-- [[ LYZEEN HUB - SOUTH BRONX SUPREME ]] --
-- Key: LYZ-EEN-HUB
-- Status: Otoritas Mutlak

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LyzeenHub | South Bronx", "DarkTheme")

-- [[ DATA TABLES ]] --
local LyzeenData = {
    Key = "LYZ-EEN-HUB",
    Positions = {
        Dealership = CFrame.new(517, 5, 604),
        NpcMs = CFrame.new(731, 5, 443),
        GsMid = CFrame.new(215, 5, -132)
    },
    Items = {"Water", "Sugar Block Bag", "Gelatin", "Empty Bag"},
    Mallows = {
        ["Small Marshmallow Bag"] = 0,
        ["Medium Marshmallow Bag"] = 0,
        ["Large Marshmallow Bag"] = 0
    }
}

-- [[ TAB: TELEPORT ]] --
local TabTP = Window:NewTab("Teleport")
local SecTP = TabTP:NewSection("World Locations")

SecTP:NewButton("[🏎️] Dealership", "Teleport ke Dealer", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LyzeenData.Positions.Dealership
end)

SecTP:NewButton("[🍳] Npc Ms", "Teleport ke NPC MS", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LyzeenData.Positions.NpcMs
end)

SecTP:NewButton("[🔫] Gs Mid", "Teleport ke Gun Shop Mid", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LyzeenData.Positions.GsMid
end)

-- [[ TAB: AUTO FARM ]] --
local TabFarm = Window:NewTab("Auto Farm")
local SecBuy = TabFarm:NewSection("Auto Buy & Sell (Lamont Bell)")

local buyAmount = 1
SecBuy:NewSlider("Jumlah Beli", "Max 100", 100, 1, function(s)
    buyAmount = s
end)

SecBuy:NewButton("Start Auto Buy", "Beli Water, Sugar, Gelatin", function()
    -- Logic: Pergi ke Lamont Bell & Fire Server untuk 3 item
    for i = 1, buyAmount do
        -- Trigger Remote Beli Water
        -- Trigger Remote Beli Sugar Block Bag
        -- Trigger Remote Beli Gelatin
    end
end)

SecBuy:NewButton("Auto Sell All Mallows", "Jual semua stok mallow", function()
    -- Logic: Cek inventory dan Fire Server untuk setiap bag yang ada
end)

local SecCook = TabFarm:NewSection("Auto Cook Sequence")
SecCook:NewToggle("Auto Cook", "Sekuens Masak Otomatis", function(state)
    _G.Cooking = state
    while _G.Cooking do
        -- Step 1: Water
        -- Hold Water -> Interact E -> wait(23)
        -- Step 2: Sugar Block
        -- Hold Sugar -> Interact E -> wait(1)
        -- Step 3: Gelatin
        -- Hold Gelatin -> Interact E -> wait(63)
        -- Step 4: Empty Bag
        -- Hold Empty Bag -> Interact E
        task.wait(1)
    end
end)

local SecInv = TabFarm:NewSection("MALLOW YANG SUDAH JADI")
local labelSmall = SecInv:NewLabel("🍬 Small Marshmallow = 0")
local labelMed = SecInv:NewLabel("🍬 Medium Marshmallow = 0")
local labelLarge = SecInv:NewLabel("🍬 Large Marshmallow bag = 0")

-- Inventory Tracker Loop
spawn(function()
    while true do
        -- Update labels based on player backpack/character inventory
        task.wait(2)
    end
end)

-- [[ TAB: FPS BOOST ]] --
local TabFPS = Window:NewTab("FPS Boost")
local SecFPS = TabFPS:NewSection("⚡ Calculating FPS...")

-- FPS Counter
spawn(function()
    local RunService = game:GetService("RunService")
    while true do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
        task.wait(0.5)
    end
end)

SecFPS:NewToggle("Remove Texture", "Performa Maksimal", function(state)
    -- Logic destroy textures
end)

SecFPS:NewToggle("Remove Shadow", "Matikan bayangan", function(state)
    game.Lighting.GlobalShadows = not state
end)

-- [[ TAB: CREDITS ]] --
local TabCred = Window:NewTab("Credit")
local SecCred = TabCred:NewSection("⭐")
SecCred:NewLabel("CREATED BY LYZEEN")

print("[🌀] LyzeenHub: Operasional.")
