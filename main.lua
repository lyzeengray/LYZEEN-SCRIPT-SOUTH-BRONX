-- [[ LYZEEN GRAY: SOUTH BRONX AUTO COOK V3 ]] --
-- Fix: Auto Interact (E) pake VirtualUser & Equip Tool

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualUser = game:GetService("VirtualUser")

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   Theme = "Green"
})

-- [[ TAB COOKING (LOGIC BARU) ]] --
local CookingTab = Window:CreateTab("Cooking", 4483362458)
_G.AutoCook = false

CookingTab:CreateToggle({
   Name = "AUTO COOK MS (FIX INTERACT)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            -- FUNGSI BARU: PEGANG & INTERAKSI KERAS
            local function Action(Item, WaitTime)
               if not _G.AutoCook then return end
               
               local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item)
               if Tool then
                  -- 1. Pegang Item
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                  task.wait(0.7)
                  
                  -- 2. Simulasi Klik/Interact (Bukan pake keypress lagi)
                  VirtualUser:CaptureController()
                  VirtualUser:Button1Down(Vector2.new(0,0)) -- Simulasi Klik Layar buat aktifin Proximity
                  
                  -- 3. Tembak Remote Interact (Kalau game pake ProximityPrompt)
                  for _, v in pairs(workspace:GetDescendants()) do
                     if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        fireproximityprompt(v) -- Maksa pencet E lewat script
                     end
                  end
                  
                  task.wait(WaitTime)
               end
            end
            
            -- URUTAN MASAK LO:
            Action("Water", 20)      -- Pegang Water, Pencet E, Tunggu 20s
            Action("Sugar", 1)      -- Pegang Sugar, Pencet E, Tunggu 1s
            Action("Gelatin", 60)    -- Pegang Gelatin, Pencet E, Tunggu 60s
            Action("Empty Bag", 2)   -- Pegang Bag, Pencet E, Selesai.
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

-- [[ TAB COMBAT ]] --
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
