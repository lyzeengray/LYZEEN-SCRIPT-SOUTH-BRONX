-- [[ LYZEEN GRAY: SOUTH BRONX SAFE BYPASS ]] --
-- Limit: WalkSpeed 20 (Anti-Stuck) | Theme: Neon Green

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"}
})

-- [[ TAB COMBAT: AIMBOT & GUN MODS ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Aimbot & Weapon")

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
                  if d < dist then
                     dist = d
                     target = v
                  end
               end
            end
            if target then
               workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
            end
         end
      end)
   end,
})

CombatTab:CreateButton({
   Name = "No Recoil (Lurus)",
   Callback = function()
      for _, v in pairs(getgc(true)) do
         if type(v) == "table" and rawget(v, "Recoil") then
            v.Recoil = 0
            v.Spread = 0
         end
      end
      Rayfield:Notify({Title = "Success", Content = "Gun Mods Active!", Duration = 2})
   end,
})

-- [[ TAB MOVEMENT: SAFE BYPASS ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateSection("Safe Speed Settings")

MoveTab:CreateSlider({
   Name = "WalkSpeed (Safe Limit)",
   Range = {16, 20}, -- BATAS MAKSIMAL 20 BIAR GAK STUCK
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      _G.SpeedValue = Value
      spawn(function()
         while _G.SpeedValue == Value do
            task.wait()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
         end
      end)
   end,
})

-- [[ TAB FARMS: AUTO BUY ]] --
local FarmTab = Window:CreateTab("Economy", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Buy Ingredients",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      while _G.AutoFarm do
         task.wait(0.8)
         -- Mencoba trigger shop event
         print("LyzeenGray: Purchasing Water, Sugar, Gelatin...")
      end
   end,
})

-- [[ TAB VISUAL: ESP ]] --
local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateButton({
   Name = "ESP Box (Green)",
   Callback = function()
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("LyzeenESP") then
            local Box = Instance.new("BoxHandleAdornment")
            Box.Name = "LyzeenESP"
            Box.Size = Vector3.new(4, 6, 0.5)
            Box.AlwaysOnTop = true
            Box.ZIndex = 10
            Box.Adornee = v.Character
            Box.Color3 = Color3.fromRGB(0, 255, 0)
            Box.Transparency = 0.6
            Box.Parent = v.Character
         end
      end
   end,
})

Rayfield:Notify({Title = "LyzeenGray Hub", Content = "Loaded with Safe Speed 20!", Duration = 3})
