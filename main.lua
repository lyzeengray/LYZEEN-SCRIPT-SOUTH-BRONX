-- [[ LYZEEN GRAY HUB: AETHER 1.0 - ORION STABLE ]] --
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "LyzeenGray Hub | Aether 1.0", 
    HidePremium = false, 
    SaveConfig = false, 
    ConfigFolder = "AetherConfig",
    IntroText = "Aether System Loading..."
})

-- [[ FUNGSI TP MOTOR SAKTI ]] --
local function SafeVehicleTP(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    local Hum = Char and Char:FindFirstChild("Humanoid")
    
    if Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        OrionLib:MakeNotification({Name = "Gagal!", Content = "Wajib naik Motor!", Image = "rbxassetid://4483345998", Time = 3})
    end
end

-- [[ TAB 1: TELEPORT (🚀) ]] --
local TeleportTab = Window:MakeTab({
	Name = "Teleport 🚀",
	Icon = "rbxassetid://4483345998",
	Premium = false
})

TeleportTab:AddSection({Name = "LOKASI UTAMA"})

TeleportTab:AddButton({Name = "🚗 Dealership", Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end})
TeleportTab:AddButton({Name = "👤 Npc Ms", Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end})
TeleportTab:AddButton({Name = "🔫 Gs mid", Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end})

TeleportTab:AddSection({Name = "LOKASI APARTEMEN"})

TeleportTab:AddButton({Name = "🏢 APT 1", Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 448)) end})
TeleportTab:AddButton({Name = "🏢 APT 2", Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 420)) end})
TeleportTab:AddButton({Name = "🏢 APT 3", Callback = function() SafeVehicleTP(CFrame.new(923, 11, 41)) end})
TeleportTab:AddButton({Name = "🏢 APT 4", Callback = function() SafeVehicleTP(CFrame.new(894, 11, 40)) end})

-- [[ TAB 2: COMBAT (⚔️) ]] --
local CombatTab = Window:MakeTab({
	Name = "Combat ⚔️",
	Icon = "rbxassetid://4483362458",
	Premium = false
})

_G.HeadSize = 1
CombatTab:AddSlider({
	Name = "KEPALA GEDE (Anti-Freeze)",
	Min = 1, Max = 10, Default = 1, Color = Color3.fromRGB(50, 255, 50),
	Increment = 1, ValueName = "Size",
	Callback = function(Value) _G.HeadSize = Value end    
})

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

-- [[ TAB 3: AUTO MS (🪔) ]] --
local FarmTab = Window:MakeTab({
	Name = "Auto MS 🪔",
	Icon = "rbxassetid://4483362748",
	Premium = false
})

_G.AutoCook = false
FarmTab:AddToggle({
	Name = "START AUTO COOK",
	Default = false,
	Callback = function(Value)
		_G.AutoCook = Value
        if _G.AutoCook then
            spawn(function()
                while _G.AutoCook do
                    local function Act(Item)
                        if not _G.AutoCook then return end
                        local P = game.Players.LocalPlayer
                        local T = P.Backpack:FindFirstChild(Item) or P.Character:FindFirstChild(Item)
                        if T then
                            P.Character.Humanoid:EquipTool(T)
                            task.wait(0.6)
                            local interacted = false
                            for i = 1, 15 do
                                if not _G.AutoCook then break end
                                for _, v in pairs(workspace:GetDescendants()) do
                                    if v:IsA("ProximityPrompt") then
                                        local dist = (v.Parent.Position - P.Character.HumanoidRootPart.Position).Magnitude
                                        if dist < 15 then fireproximityprompt(v) interacted = true end
                                    end
                                end
                                if interacted then break end
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
	end    
})

OrionLib:Init()
