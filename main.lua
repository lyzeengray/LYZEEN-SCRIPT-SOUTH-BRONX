-- [[ AETHER 1.0 - KAVO EDITION (ULTRA STABLE) ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aether 1.0 | LyzeenGray", "BloodTheme") -- Warna Merah/Hitam (Bisa diganti nanti)

-- [[ FUNGSI TP MOTOR ]] --
local function SafeVehicleTP(TargetCFrame)
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Aether", Text = "Wajib Naik Motor!"})
    end
end

-- [[ TAB TELEPORT ]] --
local TeleportTab = Window:NewTab("Teleport 🚀")
local TeleportSection = TeleportTab:NewSection("Daftar Lokasi")

TeleportSection:NewButton("🚗 Dealership", "Pindah ke Dealer", function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end)
TeleportSection:NewButton("👤 Npc Ms", "Pindah ke NPC MS", function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end)
TeleportSection:NewButton("🔫 Gs mid", "Pindah ke GS Mid", function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end)

local AptSection = TeleportTab:NewSection("Apartemen")
AptSection:NewButton("🏢 APT 1", "Pindah ke Apt 1", function() SafeVehicleTP(CFrame.new(1140, 11, 448)) end)
AptSection:NewButton("🏢 APT 2", "Pindah ke Apt 2", function() SafeVehicleTP(CFrame.new(1140, 11, 420)) end)
AptSection:NewButton("🏢 APT 3", "Pindah ke Apt 3", function() SafeVehicleTP(CFrame.new(923, 11, 41)) end)
AptSection:NewButton("🏢 APT 4", "Pindah ke Apt 4", function() SafeVehicleTP(CFrame.new(894, 11, 40)) end)

-- [[ TAB COMBAT ]] --
local CombatTab = Window:NewTab("Combat ⚔️")
local CombatSection = CombatTab:NewSection("Hitbox Mod")

_G.HeadSize = 1
CombatSection:NewSlider("Kepala Gede (Anti-Stuck)", "Biar gampang nembak", 10, 1, function(s)
    _G.HeadSize = s
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               pcall(function()
                  local h = v.Character.Head
                  h.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                  h.CanCollide = false
                  h.Massless = true
               end)
            end
        end
    end
end)

-- [[ TAB AUTO MS ]] --
local FarmTab = Window:NewTab("Auto MS 🪔")
local FarmSection = FarmTab:NewSection("Masak Otomatis")
_G.AutoCook = false

FarmSection:NewToggle("Start Auto Cook", "Otomatis Masak MS", function(state)
    _G.AutoCook = state
    if _G.AutoCook then
        spawn(function()
            while _G.AutoCook do
                local function Act(Item)
                    if not _G.AutoCook then return end
                    local T = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
                    if T then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(T)
                        task.wait(0.6)
                        local done = false
                        for i = 1, 15 do
                            if not _G.AutoCook then break end
                            for _, v in pairs(workspace:GetDescendants()) do
                                if v:IsA("ProximityPrompt") then
                                    if (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                                        fireproximityprompt(v)
                                        done = true
                                    end
                                end
                            end
                            if done then break end
                            task.wait(0.2)
                        end
                    end
                end
                Act("Water") task.wait(23)
                if not _G.AutoCook then break end
                Act("Sugar") task.wait(0.5)
                if not _G.AutoCook then break end
                Act("Gelatin") task.wait(63)
                if not _G.AutoCook then break end
                Act("Empty Bag") task.wait(5)
            end
        end)
    end
end)
