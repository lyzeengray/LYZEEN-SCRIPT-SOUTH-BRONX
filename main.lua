-- [[ LYZEEN GRAY: SOUTH BRONX FINAL FIX ]] --
-- Fitur: Fixed Big Head, Aimbot, TP to DS, Auto Cook, Safe Speed 20

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green" -- Tema Hijau
})

-- [[ TAB COMBAT ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Hitbox & Aimbot")

_G.HeadSize = 1
CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Fixed)",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value)
      _G.HeadSize = Value
   end,
})

-- SCRIPT PENGUNCI KEPALA GEDE (ANTI KEDAP-KEDIP)
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
TPTab:CreateSection("Location List")

TPTab:CreateButton({
   Name = "Teleport ke DS (Ingredient Shop)",
   Callback = function()
      -- Koordinat Toko Bahan (DS) South Bronx
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(410.5, 3.2, -150.8)
      Rayfield:Notify({Title = "Teleport", Content = "Arrived at DS Shop", Duration = 2})
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke Dealer (Gun Shop)",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(284.1, 3.5, -483.2)
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
            local args = {[1] = "BuyItem", [2] = "Water"} -- Remote Event Toko
            game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer(unpack(args))
            task.wait(1)
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
