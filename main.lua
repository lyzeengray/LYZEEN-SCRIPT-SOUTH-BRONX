-- [[ LYZEEN GRAY HUB: AETHER 1.0 - FINAL STABLE ]] --
-- Theme: Hijau Muda & Dark Grey | Fitur: 3 TP, Auto MS, Anti-Stuck Hitbox

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LYZEEN-GRAY/RedzLibV2/main/Source.lua"))()

local Window = Library:MakeWindow({
  Title = "LyzeenGray Hub | Aether 1.0",
  SubTitle = "South Bronx Edition",
  SideColor = Color3.fromRGB(50, 255, 50), -- Hijau Muda Neon
  MainColor = Color3.fromRGB(30, 30, 30)   -- Abu-Abu Gelap (Bukan Hitam)
})

-- [[ FUNGSI TELEPORT MOTOR SAKTI ]] --
local function SafeVehicleTP(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    local Hum = Char and Char:FindFirstChild("Humanoid")
    
    if Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        -- Double TP biar posisi terkunci & gak kena ban
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        Library:Notify("Gagal!", "Wajib naik Motor!", 3)
    end
end

-- [[ TAB TELEPORT ]] --
local TeleportTab = Window:MakeTab({"Teleport", "map"})
TeleportTab:AddSection("LOKASI (WAJIB MOTOR)")

TeleportTab:AddButton({
  Name = "NPC MS (Ingredients)",
  Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end
})

TeleportTab:AddButton({
  Name = "DEALER (Gun Shop)",
  Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end
})

TeleportTab:AddButton({
  Name = "GS MID (Gas Station)",
  Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end
})

-- [[ TAB FARMING (AUTO MS) ]] --
local FarmTab = Window:MakeTab({"Farm", "zap"})
_G.AutoCook = false

FarmTab:AddToggle({
  Name = "Auto Cook MS (Logic Fix)",
  Default = false,
  Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            local function Action(Item)
               if not _G.AutoCook then return end
               local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
               if Tool then
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                  task.wait(0.7)
                  for _, v in pairs(workspace:GetDescendants()) do
                     if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        fireproximityprompt(v)
                     end
                  end
                  task.wait(0.4)
               end
            end
            
            -- URUTAN MASAK LO:
            Action("Water")      -- 1. Water (E)
            task.wait(23)         -- 2. Tunggu 23 detik
            if not _G.AutoCook then break end
            
            Action("Sugar")      -- 3. Sugar (E)
            task.wait(0.5)
            if not _G.AutoCook then break end
            
            Action("Gelatin")    -- 4. Gelatin (E)
            task.wait(63)         -- 5. Tunggu 63 detik
            if not _G.AutoCook then break end
            
            Action("Empty Bag")  -- 6. Empty Bag (E)
            task.wait(5)
         end
      end)
  end
})

-- [[ TAB COMBAT (ANTI-STUCK HITBOX) ]] --
local CombatTab = Window:MakeTab({"Combat", "crosshair"})
_G.HeadSize = 1

CombatTab:AddSlider({
  Name = "KEPALA GEDE (Anti-Freeze)",
  Min = 1,
  Max = 10,
  Default = 1,
  Color = Color3.fromRGB(50, 255, 50),
  Callback = function(Value) _G.HeadSize = Value end
})

-- LOOP OPTIMASI BIAR GAK STUCK PAS NEMBAK
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               pcall(function()
                  local Head = v.Character.Head
                  Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                  Head.CanCollide = false -- Agar peluru lewat tanpa lag fisika
                  Head.Massless = true    -- Menghilangkan berat part agar CPU gak spike
               end)
            end
        end
    end
end)
