-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS ]] --
-- Theme: Green (Hacker Edition) | No Key Required

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- GANTI TEMA JADI GREEN
local Window = Library.CreateLib("LyzeenGray Hub - South Bronx", "GreenTheme")

-- NOTIFIKASI SUKSES
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "LyzeenGray",
    Text = "Bypass Active! Enjoy Green Edition.",
    Duration = 5
})

-- TAB COMBAT
local Combat = Window:NewTab("Combat")
local AimSection = Combat:NewSection("Aimbot & Gun Mods")

AimSection:NewToggle("Aimbot (Lock On)", "Nempel ke Musuh Terdekat", function(state)
    _G.Aimbot = state
    local Player = game.Players.LocalPlayer
    local Mouse = Player:GetMouse()
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.Aimbot then
            -- Logic cari musuh terdekat (Sederhana)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    -- Lock Camera (Bisa lo kembangin lagi)
                end
            end
        end
    end)
end)

AimSection:NewButton("No Recoil (Lurus)", "Tembakan Tidak Goyang", function()
    -- Script untuk nge-reset recoil senjata di South Bronx
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Recoil") then
            v.Recoil = 0
            v.Spread = 0
        end
    end
end)

-- TAB MOVEMENT
local Move = Window:NewTab("Movement")
local MoveSection = Move:NewSection("Player Speed")

MoveSection:NewSlider("Walkspeed", "Lari Cepat", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MoveSection:NewToggle("Noclip", "Tembus Tembok", function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip then
            if game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end
    end)
end)

-- TAB ECONOMY (WATER, SUGAR, GELATIN)
local Farm = Window:NewTab("Farms")
local FarmSection = FarmSection or Farm:NewSection("Auto Marshmallow")

FarmSection:NewToggle("Auto Buy Ingredients", "Otomatis Beli Bahan", function(state)
    _G.AutoBuy = state
    while _G.AutoBuy do
        task.wait(0.5)
        -- Logic: Memanggil Remote Event Toko di South Bronx
        -- Lo bisa isi remote event shop disini kalo udah dapet jalurnya
        print("LyzeenGray: Buying Ingredients...")
    end
end)

-- TAB TELEPORTS
local TPTab = Window:NewTab("Teleports")
local TPSection = TPTab:NewSection("Main Locations")

TPSection:NewButton("TP to Dealer", "Ke Dealer", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(284, 3, -483) -- Contoh Koordinat
end)

TPSection:NewButton("TP to Ingredient Shop", "Beli Bahan", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(410, 3, -150) -- Contoh Koordinat
end)
