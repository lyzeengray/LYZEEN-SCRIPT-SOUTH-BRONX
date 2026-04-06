-- [[ LYZEEN GRAY HUB: AETHER 1.0 - ICONIC EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | Aether 1.0",
   LoadingTitle = "Loading Aether System...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Theme = "Green" -- Base theme hijau
})

-- [[ FUNGSI TP MOTOR ]] --
local function SafeVehicleTP(TargetCFrame)
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        Rayfield:Notify({Title = "Gagal!", Content = "Wajib naik Motor!", Duration = 3})
    end
end

-- [[ TAB 1: TELEPORT (🚀) ]] --
local TeleportTab = Window:CreateTab("Teleport 🚀", 4483362458) 

TeleportTab:CreateSection("LOKASI STRATEGIS")

TeleportTab:CreateButton({
   Name = "TP NPC MS (517, 604)",
   Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end,
})

TeleportTab:CreateButton({
   Name = "TP DEALER (731, 443)",
   Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end,
})

TeleportTab:CreateButton({
   Name = "TP GS MID (215, -132)",
   Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end,
})

-- [[ TAB 2: COMBAT (⚔️) ]] --
local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)

_G.HeadSize = 1
CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Anti-Freeze)",
   Range = {1, 10},
   Increment = 1,
   Suffix = "Size",
   CurrentValue = 1,
   Callback = function(Value) _G.HeadSize = Value end,
})

-- Loop Render Hitbox
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
local FarmTab = Window:CreateTab("Auto MS 🪔", 4483362458)

_G.AutoCook = false
FarmTab:CreateToggle({
   Name = "START AUTO COOK",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            local function Act(Item)
               if not _G.AutoCook then return end
               local T = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
               if T then
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(T)
                  task.wait(0.7)
                  for _, v in pairs(workspace:GetDescendants()) do
                     if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        fireproximityprompt(v)
                     end
                  end
                  task.wait(0.4)
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
   end,
})
