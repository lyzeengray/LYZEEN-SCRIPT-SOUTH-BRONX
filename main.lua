-- [[ LYZEEN HUB - STABLE INTEGRATION ]] --
-- Theme: Blue | Status: FIXED & OPERATIONAL

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(10, 10, 15),
    Header = Color3.fromRGB(15, 15, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 35)
}

-- Variabel penyimpan key agar tidak hilang saat diketik
_G.LyzeenKeyInput = ""

-- [[ FUNGSI LOAD MAIN HUB ]] --
local function LoadMainHub()
    local MainWin = Kavo.CreateLib("LyzeenHub | SOUTH BRONX", Colors)
    
    -- TAB: AUTO FARM
    local TabFarm = MainWin:NewTab("Auto Farm")
    local SecFarm = TabFarm:NewSection("Automated Tasks")
    
    local buyAmt = 50
    SecFarm:NewSlider("Jumlah Buy:", "Slider pembelian", 100, 1, function(s) buyAmt = s end)
    
    SecFarm:NewButton("● BUY ALL", "Beli Water, Sugar, Gelatin", function()
        print("Membeli " .. buyAmt .. " items...")
        -- Masukkan Remote Event Anda di sini
    end)
    
    SecFarm:NewButton("● SELL ALL", "Jual semua stok", function()
        print("Menjual mallows...")
    end)

    -- TAB: TELEPORT
    local TabTP = MainWin:NewTab("Teleport")
    local SecTP = TabTP:NewSection("Motor (Dirtbike) Required")
    
    local function Teleport(cf)
        local char = game.Players.LocalPlayer.Character
        local seat = char and char.Humanoid.SeatPart
        if seat and seat.Parent.Name == "Dirtbike" then
            seat.Parent:SetPrimaryPartCFrame(cf)
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "LYZEEN HUB",
                Text = "Naik ke Dirtbike dulu!",
                Duration = 3
            })
        end
    end

    SecTP:NewButton("[🏎️] Dealership", "Loc: 517, 5, 604", function() Teleport(CFrame.new(517, 5, 604)) end)
    SecTP:NewButton("[🍳] Npc Ms", "Loc: 731, 5, 443", function() Teleport(CFrame.new(731, 5, 443)) end)
    SecTP:NewButton("[🔫] Gs Mid", "Loc: 215, 5, -132", function() Teleport(CFrame.new(215, 5, -132)) end)

    -- TAB: FPS BOOST
    local TabFPS = MainWin:NewTab("FPS Boost")
    local SecFPS = TabFPS:NewSection("⚡ FPS")
    
    spawn(function()
        while task.wait(0.5) do
            local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
        end
    end)

    SecFPS:NewToggle("Remove Texture", "Boost FPS", function(s)
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") and s then v.Material = Enum.Material.SmoothPlastic end
            if (v:IsA("Texture") or v:IsA("Decal")) then v.Transparency = s and 1 or 0 end
        end
    end)

    -- TAB: CREDIT
    local TabCred = MainWin:NewTab("Credit")
    TabCred:NewSection("      ⭐      ")
    TabCred:NewSection("CREATED BY LYZEEN")
end

-- [[ INITIAL: KEY SYSTEM WINDOW ]] --
local KeyWin = Kavo.CreateLib("LyzeenHub | Authentication", Colors)
local KeyTab = KeyWin:NewTab("Verification")
local KeySec = KeyTab:NewSection("Masukkan key untuk melanjutkan")

KeySec:NewTextBox("KEMERUSHUBFREE", "Ketik Key Di Sini...", function(t)
    _G.LyzeenKeyInput = t
end)

KeySec:NewButton("CONTINUE", "Verifikasi Kunci", function()
    if _G.LyzeenKeyInput == "LYZ-EEN-HUB" then
        print("Key Valid!")
        KeyWin:Destroy()
        task.wait(0.1)
        LoadMainHub()
    else
        game.Players.LocalPlayer:Kick("KEY INVALID [ Lyzeen ]")
    end
end)
