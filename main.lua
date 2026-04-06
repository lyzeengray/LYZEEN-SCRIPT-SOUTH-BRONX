-- [[ LYZEEN GRAY HUB: AETHER 1.0 - FINAL STABLE EDITION ]] --
-- Theme: Hijau & Hitam | Fitur: 7 TP, Auto MS (Fixed E), Anti-Stuck Hitbox

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | Aether 1.0",
   LoadingTitle = "Aether System Loading...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
   Theme = "Dark" -- Background Hitam Pekat
})

-- [[ FUNGSI TELEPORT MOTOR SAKTI ]] --
local function SafeVehicleTP(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    local Hum = Char and Char:FindFirstChild("Humanoid")
    
    if Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        -- Double TP agar posisi terkunci
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

-- 1. 🚗 Dealership
TeleportTab:CreateButton({
   Name = "🚗 Dealership",
   Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end,
})

-- 2. 👤 Npc Ms
TeleportTab:CreateButton({
   Name = "👤 Npc Ms",
   Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end,
})

-- 3. 🔫 Gs mid
TeleportTab:CreateButton({
   Name = "🔫 Gs mid",
   Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end,
})

TeleportTab:CreateSection("LOKASI APARTEMEN")

-- 4. 🏢 APT 1
TeleportTab:CreateButton({
   Name = "🏢 APT 1",
   Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 448)) end,
})

-- 5. 🏢 APT 2
TeleportTab:CreateButton({
   Name = "🏢 APT 2",
   Callback = function() SafeVehicleTP(CFrame.new(1140, 11, 420)) end,
})

-- 6. 🏢 APT 3
TeleportTab:CreateButton({
   Name = "🏢 APT 3",
   Callback = function() SafeVehicleTP(CFrame.new(923, 11, 41)) end,
})

-- 7. 🏢 APT 4
TeleportTab:CreateButton({
   Name = "🏢 APT 4",
   Callback = function() SafeVehicleTP(CFrame.new(894, 11, 40)) end,
})

-- [[ TAB 2: COMBAT (⚔️) ]] --
local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)
_G.HeadSize = 1

CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Anti-Freeze)",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value) _G.HeadSize = Value end,
})

-- Loop Render Hitbox (Anti-Stuck Fix)
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
   Name = "START AUTO COOK (Fixed Interact)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            local function Act(Item)
               if not _G.AutoCook then return end
               local P = game.Players.LocalPlayer
               local T = P.Backpack:FindFirstChild(Item) or P.Character:FindFirstChild(Item)
               
               if T then
                  P.Character.Humanoid:EquipTool(T)
                  task.wait(0.5) -- Jeda agar animasi tool keluar dulu
                  
                  -- Logic Fix Interact E
                  local interacted = false
                  for i = 1, 15 do -- Coba interact berulang kali
                     if not _G.AutoCook then break end
                     for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then
                           local dist = (v.Parent.Position - P.Character.HumanoidRootPart.Position).Magnitude
                           if dist < 15 then
                              fireproximityprompt(v)
                              interacted = true
                           end
                        end
                     end
                     if interacted then break end
                     task.wait(0.2)
                  end
                  task.wait(0.4)
               end
            end
            
            -- URUTAN MASAK
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

Rayfield:Notify({Title = "Aether 1.0 Loaded", Content = "Siap Tempur, Bos LyzeenGray!", Duration = 5})
