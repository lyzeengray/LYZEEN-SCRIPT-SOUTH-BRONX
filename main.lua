-- [[ LYZEEN GRAY: SOUTH BRONX MOTOR TP FIX ]] --
-- Fitur: TP Motor (Anti-Ban), Fixed DS & Dealer, Kepala Gede, Safe Speed 20

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green"
})

-- [[ FUNGSI TELEPORT MOTOR ]] --
local function TPWithVehicle(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    if Char and Char:FindFirstChild("Humanoid") then
        local Seat = Char.Humanoid.SeatPart
        if Seat and Seat:IsA("VehicleSeat") then
            -- Kalo lagi di motor, yang di-teleport motornya (Root dari motor)
            local Vehicle = Seat.Parent
            Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        else
            -- Kalo gak ada motor, baru teleport badan (Resiko Ban lebih tinggi)
            Char.HumanoidRootPart.CFrame = TargetCFrame
        end
    end
end

-- [[ TAB COMBAT ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
_G.HeadSize = 1
CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Hitbox)",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value) _G.HeadSize = Value end,
})

-- SCRIPT PENGUNCI KEPALA GEDE
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

-- [[ TAB TELEPORT ]] --
local TPTab = Window:CreateTab("Teleports", 4483362458)
TPTab:CreateSection("Location List (Naik Motor Dulu!)")

TPTab:CreateButton({
   Name = "Teleport ke DS (Ingredients)",
   Callback = function()
      -- Koordinat BARU (Langsung di depan NPC/Meja DS)
      local Target = CFrame.new(396.5, 3.5, -155.2)
      TPWithVehicle(Target)
      Rayfield:Notify({Title = "Teleport", Content = "Motor TP ke DS Berhasil!", Duration = 2})
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke Dealer (Gun Shop)",
   Callback = function()
      local Target = CFrame.new(280.2, 3.5, -480.8)
      TPWithVehicle(Target)
   end,
})

-- [[ TAB COOKING ]] --
local CookingTab = Window:CreateTab("Cooking", 4483362458)
CookingTab:CreateToggle({
   Name = "Auto Buy Ingredients",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoBuy = Value
      spawn(function()
         while _G.AutoBuy do
            game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("BuyItem", "Water")
            task.wait(1.5)
         end
      end)
   end,
})

-- [[ TAB MOVEMENT ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateSlider({
   Name = "WalkSpeed (Safe 20)",
   Range = {16, 20},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      _G.WS = Value
      spawn(function()
         while _G.WS == Value do
            if game.Players.LocalPlayer.Character then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
            task.wait()
         end
      end)
   end,
})
