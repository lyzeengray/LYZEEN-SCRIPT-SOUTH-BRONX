-- [[ LYZEEN GRAY HUB: AETHER 1.0 - GREEN EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | Aether 1.0",
   LoadingTitle = "Aether System Loading...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Theme = "Green" -- Biar ada aksen Hijau Neon
})

-- [[ FUNGSI TELEPORT MOTOR ]] --
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

TeleportTab:CreateSection("LOKASI UTAMA")
TeleportTab:CreateButton({
   Name = "🚗 Dealership",
   Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end,
})
TeleportTab:CreateButton({
   Name = "👤 Npc Ms",
   Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end,
})
TeleportTab:CreateButton({
   Name = "🔫 Gs mid",
   Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end,
})

TeleportTab:CreateSection("LOKASI APARTEMEN")
TeleportTab:CreateButton({
   Name = "🏢 APT 1",
   Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 448)) end, -- Kordinat Foto 1
})
TeleportTab:CreateButton({
   Name = "🏢 APT 2",
   Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 420)) end, -- Kordinat Foto 2
})
TeleportTab:CreateButton({
   Name = "🏢 APT 3",
   Callback = function() SafeVehicleTP(CFrame.new(923, 11, 41)) end, -- Kordinat Foto 3
})
TeleportTab:CreateButton({
   Name = "🏢 APT 4",
   Callback = function() SafeVehicleTP(CFrame.new(894, 11, 40)) end, -- Kordinat Foto 4
})

-- [[ TAB 2: COMBAT (⚔️) ]] --
local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)
_G.HeadSize = 1

CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Hitbox)",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value) _G.HeadSize = Value end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               pcall(function()
                  v.Character.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                  v.Character.Head.CanCollide = false
                  v.Character.Head.Massless = true
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
                  -- Spam Interact biar gak gagal
                  for i = 1, 10 do
                      if not _G.AutoCook then break end
                      for _, v in pairs(workspace:GetDescendants()) do
                         if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                            fireproximityprompt(v)
                         end
                      end
                      task.wait(0.1)
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
   end,
})
