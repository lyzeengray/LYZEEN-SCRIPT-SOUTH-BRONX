-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS ]] --
-- Fitur: Aimbot, ESP Chams, Kepala Gede (1-5), Safe Speed 20

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"}
})

-- [[ TAB COMBAT: AIMBOT & KEPALA GEDE ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Aimbot & Hitbox")

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

-- [[ FITUR KEPALA GEDE (HITBOX) ]] --
CombatTab:CreateSlider({
   Name = "KEPALA GEDE (Hitbox)",
   Range = {1, 5},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value)
      _G.HeadSize = Value
      spawn(function()
         while task.wait(1) do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                  v.Character.Head.Size = Vector3.new(Value * 2, Value * 2, Value * 2) -- Skala 1-5
                  v.Character.Head.CanCollide = false
                  v.Character.Head.Transparency = 0.5 -- Biar gak terlalu nutupin pandangan
               end
            end
         end
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Remove Recoil (Lurus)",
   Callback = function()
      for _, v in pairs(getgc(true)) do
         if type(v) == "table" and rawget(v, "Recoil") then
            v.Recoil = 0
            v.Spread = 0
         end
      end
   end,
})

-- [[ TAB VISUALS: ESP CHAMS FIX ]] --
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
VisualsTab:CreateSection("ESP Settings")

_G.ESP_Enabled = false
local function ApplyESP(v)
    if v ~= game.Players.LocalPlayer and v.Character then
        if v.Character:FindFirstChild("LyzeenChams") then v.Character.LyzeenChams:Destroy() end
        
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "LyzeenChams"
        Highlight.Parent = v.Character
        Highlight.FillColor = Color3.fromRGB(0, 255, 0)
        Highlight.Enabled = _G.ESP_Enabled
        
        if v.Character:FindFirstChild("Head") then
            local Billboard = Instance.new("BillboardGui", v.Character.Head)
            Billboard.Name = "LyzeenInfo"
            Billboard.Size = UDim2.new(0, 100, 0, 50)
            Billboard.StudsOffset = Vector3.new(0, 3, 0)
            Billboard.AlwaysOnTop = true
            Billboard.Enabled = _G.ESP_Enabled

            local Text = Instance.new("TextLabel", Billboard)
            Text.BackgroundTransparency = 1
            Text.Size = UDim2.new(1, 0, 1, 0)
            Text.TextColor3 = Color3.fromRGB(0, 255, 0)
            Text.Font = Enum.Font.GothamBold
            Text.TextSize = 12
            
            spawn(function()
                while v.Character and v.Character:FindFirstChild("Humanoid") do
                    local hp = math.floor(v.Character.Humanoid.Health)
                    Text.Text = v.Name .. "\n[ HP: " .. hp .. " ]"
                    task.wait(1)
                end
            end)
        end
    end
end

VisualsTab:CreateToggle({
   Name = "Master ESP (Chams + Name + HP)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP_Enabled = Value
      for _, v in pairs(game.Players:GetPlayers()) do ApplyESP(v) end
   end,
})

-- [[ TAB MOVEMENT: SAFE SPEED ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateSlider({
   Name = "WalkSpeed (Max 20)",
   Range = {16, 20},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      _G.Speed = Value
      spawn(function()
         while _G.Speed == Value do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
            task.wait()
         end
      end)
   end,
})
