-- [[ LYZEEN HUB - SUPREME AUTHORITY ]] --
-- Key: LYZ-EEN-HUB
-- Status: Otoritas Mutlak

local KeySystem = {
    Key = "LYZ-EEN-HUB",
    Version = "1.0.2"
}

-- [[ 1. THE GATEKEEPER: KEY SYSTEM ]] --
local KeyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local KeyWindow = KeyLibrary.CreateLib("LyzeenHub | Authentication", "DarkTheme")
local KeyTab = KeyWindow:NewTab("Verification")
local KeySection = KeyTab:NewSection("Input Secret Key:")

KeySection:NewTextBox("Enter Key", "Key: LYZ-EEN-HUB", function(input)
    if input == KeySystem.Key then
        -- Jika Benar: Tutup jendela key dan load script utama
        KeyWindow:Destroy()
        
        -- [[ 2. MAIN SCRIPT INITIALIZATION ]] --
        local MainLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local MainWin = MainLibrary.CreateLib("LyzeenHub | South Bronx", "DarkTheme")
        
        -- TAB: TELEPORT (Dirtbike Detection)
        local TabTP = MainWin:NewTab("Teleport")
        local SecTP = TabTP:NewSection("Required: Dirtbike")

        local function TP(targetCF)
            local char = game.Players.LocalPlayer.Character
            local seat = char and char.Humanoid.SeatPart
            if seat and seat.Parent.Name == "Dirtbike" then
                seat.Parent:SetPrimaryPartCFrame(targetCF)
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "ACCESS DENIED",
                    Text = "Harus pakai Motor (Dirtbike)!",
                    Duration = 5
                })
            end
        end

        SecTP:NewButton("[🏎️] Dealership", "Loc: 517, 5, 604", function() TP(CFrame.new(517, 5, 604)) end)
        SecTP:NewButton("[🍳] Npc Ms", "Loc: 731, 5, 443", function() TP(CFrame.new(731, 5, 443)) end)
        SecTP:NewButton("[🔫] Gs Mid", "Loc: 215, 5, -132", function() TP(CFrame.new(215, 5, -132)) end)

        -- TAB: AUTO FARM
        local TabFarm = MainWin:NewTab("Auto Farm")
        local SecFarm = TabFarm:NewSection("MALLOW YANG SUDAH JADI")
        local labelS = SecFarm:NewLabel("🍬 Small Marshmallow = 0")
        local labelM = SecFarm:NewLabel("🍬 Medium Marshmallow = 0")
        local labelL = SecFarm:NewLabel("🍬 Large Marshmallow bag = 0")

        -- TAB: FPS BOOST
        local TabFPS = MainWin:NewTab("FPS Boost")
        local SecFPS = TabFPS:NewSection("⚡ Monitoring...")

        spawn(function()
            while task.wait(0.5) do
                local currentFps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
                SecFPS:SetSectionName("⚡ " .. currentFps .. " FPS")
            end
        end)

        SecFPS:NewToggle("Remove Texture", "Extreme Performance", function(s)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") and s then v.Material = Enum.Material.SmoothPlastic end
                if (v:IsA("Texture") or v:IsA("Decal")) then v.Transparency = s and 1 or 0 end
            end
        end)

        SecFPS:NewToggle("Remove Shadow", "Fix Lighting", function(s)
            game.Lighting.GlobalShadows = not s
        end)

        -- TAB: CREDIT
        local TabCred = MainWin:NewTab("Credit")
        TabCred:NewSection("      ⭐      ")
        TabCred:NewSection("    ⭐⭐⭐    ")
        TabCred:NewSection("  ⭐⭐⭐⭐⭐  ")
        TabCred:NewSection("CREATED BY LYZEEN")

    else
        -- Jika Salah: Kick player secara instan
        game.Players.LocalPlayer:Kick("KEY INVALID [ Lyzeen ]")
    end
end)
