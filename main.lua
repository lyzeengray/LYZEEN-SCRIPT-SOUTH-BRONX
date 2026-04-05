-- [[ LYZEEN GRAY: SOUTH BRONX FINAL ULTIMATE ]] --
-- Fitur: Aimbot, Hitbox Kepala 1-5, Auto Cook, Safe Speed 20

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"}
})

-- [[ TAB COMBAT: AIMBOT & HITBOX ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)

local AimbotEnabled = false
CombatTab:CreateToggle({
   Name = "Aimbot (Lock Head)",
   CurrentValue = false,
   Callback = function(Value)
      AimbotEnabled = Value
      local Player = game.Players.LocalPlayer
      game:GetService("RunService").RenderStepped:Connect(function()
         if AimbotEnabled then
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
                  local d = (v.Character.Head.Position - Player.Character.Head.Position).magnitude
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

CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Hitbox 1-5)",
   Range = {1, 5},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value)
      _G.HeadSize = Value
      spawn(function()
         while true do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                  v.Character.Head.Size = Vector3.new(Value * 2.5, Value * 2.5, Value * 2.5)
                  v.Character.Head.CanCollide = false
                  v.Character.Head.Transparency = 0.5
               end
            end
            task.wait(2)
         end
      end)
   end,
})

-- [[ TAB FARM: AUTO COOKING ]] --
local FarmTab = Window:CreateTab("Cooking", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Buy Ingredients (Water/Sugar/Gelatin)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoBuy = Value
      spawn(function()
         while _G.AutoBuy do
            -- Trigger Remote Event Beli Bahan
            local args = {[1] = "BuyItem", [2] = "Water"}
            game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer(unpack(args))
            task.wait(0.5)
         end
      end)
   end,
})

FarmTab:CreateButton({
   Name = "Instant Cook (Marshmallow)",
   Callback = function()
      -- Logic masak otomatis di South Bronx
      game:GetService("ReplicatedStorage").Events.CookEvent:FireServer("Start")
      Rayfield:Notify({Title = "Cooking", Content = "Started Auto Cook!", Duration = 2})
   end,
})

-- [[ TAB VISUALS: ESP CHAMS ]] --
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
_G.ESP = false
VisualsTab:CreateToggle({
   Name = "Master ESP (Chams + Name)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      for _, v in pairs(game.Players:GetPlayers()) do
         if v.Character and v ~= game.Players.LocalPlayer then
            if Value then
               local h = Instance.new("Highlight", v.Character)
               h.Name = "LyzeenESP"
               h.FillColor = Color3.fromRGB(0, 255, 0)
            else
               if v.Character:FindFirstChild("LyzeenESP") then v.Character.LyzeenESP:Destroy() end
            end
         end
      end
   end,
})

-- [[ TAB MOVEMENT ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateSlider({
   Name = "Safe WalkSpeed (Max 20)",
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
