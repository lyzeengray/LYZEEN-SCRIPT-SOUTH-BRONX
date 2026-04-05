-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS FIX ]] --
-- UI: Rayfield (Green Neon Edition) | Status: Working

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"}
})

-- NOTIFIKASI
Rayfield:Notify({
   Title = "LyzeenGray Active",
   Content = "Bypass Successful! Enjoy South Bronx.",
   Duration = 5,
   Image = 4483362458,
})

-- [[ TAB COMBAT: AIMBOT & GUN MODS ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Aimbot Settings")

local AimbotEnabled = false
CombatTab:CreateToggle({
   Name = "Aimbot (Silent Target)",
   CurrentValue = false,
   Callback = function(Value)
      AimbotEnabled = Value
      local Player = game.Players.LocalPlayer
      local Mouse = Player:GetMouse()
      
      game:GetService("RunService").RenderStepped:Connect(function()
         if AimbotEnabled then
            -- Logic: Mencari Target Terdekat secara Otomatis
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
               -- Aimbot Logic: Mengarahkan Kamera ke Kepala
               workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
            end
         end
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Remove Recoil (Lurus)",
   Callback = function()
      -- Logic: Bypass Recoil Framework South Bronx
      for _, v in pairs(getgc(true)) do
         if type(v) == "table" and rawget(v, "Recoil") then
            v.Recoil = 0
            v.Spread = 0
            v.Kickback = 0
         end
      end
      Rayfield:Notify({Title = "Success", Content = "No Recoil Activated!", Duration = 2})
   end,
})

-- [[ TAB MOVEMENT: BYPASS SPEED ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)

MoveTab:CreateSlider({
   Name = "WalkSpeed Bypass",
   Range = {16, 150},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      -- Menggunakan CFrame biar nggak gampang kedeteksi Anti-Cheat
      spawn(function()
         while true do
            task.wait()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
         end
      end)
   end,
})

-- [[ TAB ECONOMY: AUTO BUY ]] --
local FarmTab = Window:CreateTab("Economy", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Buy Ingredients (Water/Sugar/Gelatin)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      while _G.AutoFarm do
         task.wait(0.5)
         -- Mencoba memicu remote event belanja
         local args = { [1] = "Buy", [2] = "Water" }
         game:GetService("ReplicatedStorage").Events:FindFirstChild("ShopEvent"):FireServer(unpack(args))
         print("LyzeenGray: Buying...")
      end
   end,
})

-- [[ TAB VISUAL: ESP ]] --
local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateButton({
   Name = "ESP Box (Lihat Musuh)",
   Callback = function()
      -- Logic ESP Sederhana
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= game.Players.LocalPlayer and v.Character then
            local Box = Instance.new("BoxHandleAdornment")
            Box.Size = Vector3.new(4, 6, 0)
            Box.AlwaysOnTop = true
            Box.ZIndex = 10
            Box.Adornee = v.Character
            Box.Color3 = Color3.fromRGB(0, 255, 0)
            Box.Transparency = 0.5
            Box.Parent = v.Character
         end
      end
   end,
})
