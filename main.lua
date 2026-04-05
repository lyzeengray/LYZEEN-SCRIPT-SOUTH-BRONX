-- [[ LYZEEN GRAY: SOUTH BRONX FINAL FIX ]] --
-- Kordinat: NPC MS, Dealer, GS MID (Fixed Height)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green"
})

-- [[ FUNGSI TELEPORT MOTOR SAKTI ]] --
local function SafeVehicleTP(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    local Hum = Char and Char:FindFirstChild("Humanoid")
    
    if Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        -- Set Position 3x biar gak mental balik (Anti-Cheat Bypass)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        Rayfield:Notify({Title = "Success", Content = "Motor Berhasil Teleport!", Duration = 2})
    else
        Rayfield:Notify({
            Title = "Gagal Teleport!", 
            Content = "Anda harus mengendarai Motor untuk teleport!", 
            Duration = 5
        })
    end
end

-- [[ TAB TELEPORT (KORDINAT PRESISI LO) ]] --
local TPTab = Window:CreateTab("Teleports", 4483362458)
TPTab:CreateSection("Wajib Di Atas Motor!")

TPTab:CreateButton({
   Name = "Teleport ke NPC MS",
   Callback = function()
      -- Kordinat lo: 517, 5, 604 (Gue naikin Y jadi 6.5 biar gak nyangkut)
      SafeVehicleTP(CFrame.new(517, 6.5, 604))
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke DEALER",
   Callback = function()
      -- Kordinat lo: 731, 5, 443
      SafeVehicleTP(CFrame.new(731, 6.5, 443))
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke GS MID",
   Callback = function()
      -- Kordinat lo: 215, 5, -132
      SafeVehicleTP(CFrame.new(215, 6.5, -132))
   end,
})

-- [[ TAB COMBAT (AIMBOT & KEPALA GEDE) ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
local AimbotEnabled = false
CombatTab:CreateToggle({
   Name = "Aimbot (Lock Head)",
   CurrentValue = false,
   Callback = function(Value)
      AimbotEnabled = Value
      game:GetService("RunService").RenderStepped:Connect(function()
         if AimbotEnabled then
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                  local d = (v.Character.Head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude
                  if d < dist then dist = d target = v end
               end
            end
            if target then
               workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
            end
         end
      end)
   end,
})

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
                v.Character.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                v.Character.Head.CanCollide = false
            end
        end
    end
end)

-- [[ TAB COOKING (AUTO LOOP) ]] --
local CookingTab = Window:CreateTab("Cooking", 4483362458)
_G.AutoCook = false
CookingTab:CreateToggle({
   Name = "AUTO COOK LOOP (FIX)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            -- Fungsi bantu buat pegang item & pencet E
            local function Action(Item)
               if not _G.AutoCook then return end
               local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item)
               if Tool then
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                  task.wait(0.5)
                  keypress(Enum.KeyCode.E)
                  task.wait(0.1)
                  keyrelease(Enum.KeyCode.E)
               end
            end
            
            Action("Water") task.wait(20)
            Action("Sugar") task.wait(1)
            Action("Gelatin") task.wait(60)
            Action("Empty Bag") task.wait(2)
         end
      end)
   end,
})
