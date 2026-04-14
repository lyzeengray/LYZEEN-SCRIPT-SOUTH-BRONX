-- [[ LYZEEN HUB - INTEGRATED KEY & MAIN ]] --
-- Theme: Blue | Status: Otoritas Mutlak

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(10, 10, 15),
    Header = Color3.fromRGB(15, 15, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 35)
}

-- [[ 1. THE GATEKEEPER: KEY SYSTEM WINDOW ]] --
local KeyWin = Kavo.CreateLib("LyzeenHub | Authentication", Colors)
local KeyTab = KeyWin:NewTab("Verification")
local KeySec = KeyTab:NewSection("Masukkan key untuk melanjutkan")

local inputKey = ""

KeySec:NewTextBox("KEMERUSHUBFREE", "Ketik Key Di Sini...", function(t)
    inputKey = t
end)

KeySec:NewButton("CONTINUE", "Verifikasi Kunci", function()
    if inputKey == "LYZ-EEN-HUB" then
        KeyWin:Destroy() -- Hancurkan menu key
        
        -- [[ 2. LOADING MAIN HUB ]] --
        local MainWin = Kavo.CreateLib("LyzeenHub | SOUTH BRONX", Colors)
        
        -- TAB: AUTO FARM
        local TabFarm = MainWin:NewTab("Auto Farm")
        local SecFarm = TabFarm:NewSection("Automated Tasks")
        SecFarm:NewToggle("Anti AFK", "Cegah Kick", function() end)
        
        local buyAmt = 50
        SecFarm:NewSlider("Jumlah Buy:", "Max 100", 100, 1, function(s) buyAmt = s end)
        
        SecFarm:NewButton("● BUY ALL", "Beli Bahan", function()
            -- Logic Remote Fire (Water, Sugar, Gelatin)
        end)
        
        SecFarm:NewButton("● SELL ALL", "Jual Mallows", function()
            -- Logic Remote Fire (Small, Med, Large)
        end)

        -- TAB: TELEPORT (Motor Logic)
        local TabTP = MainWin:NewTab("Teleport")
        local SecTP = TabTP:NewSection("Must be on Dirtbike")

        local function TP(cf)
            local char = game.Players.LocalPlayer.Character
            local vehicle = char and char.Humanoid.SeatPart
            if vehicle and vehicle.Parent.Name == "Dirtbike" then
                vehicle.Parent:SetPrimaryPartCFrame(cf)
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "LYZEEN HUB",
                    Text = "Gunakan Dirtbike!",
                    Duration = 3
                })
            end
        end

        SecTP:NewButton("[🏎️] Dealership", "Loc: 517, 5, 604", function() TP(CFrame.new(517, 5, 604)) end)
        SecTP:NewButton("[🍳] Npc Ms", "Loc: 731, 5, 443", function() TP(CFrame.new(731, 5, 443)) end)
        SecTP:NewButton("[🔫] Gs Mid", "Loc: 215, 5, -132", function() TP(CFrame.new(215, 5, -132)) end)

        -- TAB: FPS BOOST
        local TabFPS = MainWin:NewTab("FPS Boost")
        local SecFPS = TabFPS:NewSection("⚡ FPS")
        
        spawn(function()
            while task.wait(0.5) do
                local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
                SecFPS:SetSectionName("⚡ " .. fps .. " FPS")
            end
        end)

        SecFPS:NewToggle("Remove Texture", "Boost Performa", function(s)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") and s then v.Material = Enum.Material.SmoothPlastic end
                if (v:IsA("Texture") or v:IsA("Decal")) then v.Transparency = s and 1 or 0 end
            end
        end)

        -- TAB: CREDIT
        local TabCred = MainWin:NewTab("Credit")
        TabCred:NewSection("      ⭐      ")
        TabCred:NewSection("CREATED BY LYZEEN")
        
    else
        -- Jika salah input dan tekan continue -> KICK
        game.Players.LocalPlayer:Kick("KEY INVALID [ Lyzeen ]")
    end
end)

-- Visual Label di bawah menu
local WaitLabel = Instance.new("TextLabel")
WaitLabel.Parent = game:GetService("CoreGui"):FindFirstChild("LyzeenHub | Authentication")
WaitLabel.Text = "● WAITING KEY..."
WaitLabel.Position = UDim2.new(0, 10, 1, -30)
WaitLabel.Size = UDim2.new(0, 100, 0, 20)
WaitLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
WaitLabel.BackgroundTransparency = 1
WaitLabel.TextXAlignment = Enum.TextXAlignment.Left
