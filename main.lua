-- [[ LYZEEN GRAY: SOUTH BRONX AUTO COOK FAST SUGAR ]] --
-- Fix: Sugar -> Gelatin (No Delay) | Wait 63s for Empty Bag

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualUser = game:GetService("VirtualUser")

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green"
})

-- [[ TAB COOKING (TIMING RE-FIX) ]] --
local CookingTab = Window:CreateTab("Cooking", 4483362458)
_G.AutoCook = false

CookingTab:CreateToggle({
   Name = "AUTO COOK MS (FAST SUGAR)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            -- Fungsi bantu buat pegang item & interaksi
            local function Action(Item)
               if not _G.AutoCook then return end
               
               local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
               if Tool then
                  -- 1. Equip Item
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                  task.wait(0.6)
                  
                  -- 2. Paksa Pencet E (Interact)
                  for _, v in pairs(workspace:GetDescendants()) do
                     if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        fireproximityprompt(v)
                     end
                  end
                  task.wait(0.4)
               end
            end
            
            -- [[ ALUR MASAK FAST SUGAR ]] --
            
            -- 1. Water & Interact (E)
            Action("Water")
            task.wait(0.5) 
            
            if not _G.AutoCook then break end
            
            -- 2. Sugar & Interact (E) - LANGSUNG LANJUT
            Action("Sugar")
            task.wait(0.5) 
            
            if not _G.AutoCook then break end
            
            -- 3. Gelatin & Interact (E)
            Action("Gelatin")
            
            -- 4. TUNGGU 63 DETIK SETELAH GELATIN (Proses Masak)
            task.wait(63) 
            
            if not _G.AutoCook then break end
            
            -- 5. Empty Bag & Interact (E)
            Action("Empty Bag")
            task.wait(3) -- Jeda sebelum loop balik ke awal
         end
      end)
   end,
})

-- [[ TAB TELEPORT (KORDINAT PRESISI LO) ]] --
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

local TPTab = Window:CreateTab("Teleports", 4483362458)
TPTab:CreateButton({Name = "TP ke NPC MS", Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end})
TPTab:CreateButton({Name = "TP ke DEALER", Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end})
TPTab:CreateButton({Name = "TP ke GS MID", Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end})

-- [[ TAB COMBAT (AIMBOT & KEPALA GEDE) ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
_G.HeadSize = 1
CombatTab:CreateSlider({
   Name = "KEPALA GEDE",
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
               end)
            end
        end
    end
end)
