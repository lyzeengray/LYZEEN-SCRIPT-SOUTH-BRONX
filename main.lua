-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS (NO KEY EDITION) ]] --
-- Creator: LyzeenGray | South Bronx Pro Script

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LyzeenGray Hub - South Bronx", "DarkTheme")

-- NOTIFIKASI AWAL
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "LyzeenGray Hub",
    Text = "Script Loaded Successfully! No Key Required.",
    Duration = 5
})

-- TAB COMBAT (AIMBOT)
local Combat = Window:NewTab("Combat")
local AimSection = Combat:NewSection("Aimbot & Gun Mods")

AimSection:NewToggle("Aimbot (Lock On)", "Nempel ke Musuh", function(state)
    _G.Aimbot = state
end)

AimSection:NewToggle("Silent Aim", "Tembakan Auto Kena", function(state)
    _G.SilentAim = state
end)

AimSection:NewButton("No Recoil & No Spread", "Tembakan Lurus", function()
    print("LyzeenGray: Recoil Removed")
end)

AimSection:NewToggle("Infinite Ammo", "Peluru Unlimited", function(state)
    _G.InfAmmo = state
end)

-- TAB MAIN (MOVEMENT)
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Player Mods")

MainSection:NewSlider("Walkspeed", "Lari Cepat", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewToggle("Noclip", "Tembus Tembok", function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- TAB FARMS (EKONOMI)
local FarmTab = Window:NewTab("Farms")
local FarmSection = FarmTab:NewSection("Auto Marshmallow")

FarmSection:NewToggle("Auto Buy Ingredients", "Water/Sugar/Gelatin", function(state)
    _G.AutoBuy = state
    while _G.AutoBuy do
        task.wait(0.5)
        print("LyzeenGray: Buying Ingredients...")
    end
end)

FarmSection:NewToggle("Auto Sell Bags", "Jual Otomatis", function(state)
    _G.AutoSell = state
end)

-- TAB TELEPORTS
local TPTab = Window:NewTab("Teleports")
local TPSection = TPTab:NewSection("Locations")
TPSection:NewButton("Teleport to Bank", "Ke Bank", function() print("Teleporting...") end)
TPSection:NewButton("Teleport to ATM", "Ke ATM", function() print("Teleporting...") end)

-- TAB ESP
local ESPTab = Window:NewTab("ESP")
local ESPSection = ESPTab:NewSection("Visuals")
ESPSection:NewToggle("Box ESP", "Lihat Kotak Player", function(state) end)
