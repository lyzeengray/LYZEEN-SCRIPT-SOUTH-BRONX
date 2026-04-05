-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE MAIN ]] --
-- Fitur: Aimbot, Big Head, TP Motor Only (NPC MS, Dealer, GS MID)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green"
})

-- [[ FUNGSI PROTEKSI TELEPORT MOTOR ]] --
local function SafeVehicleTP(TargetCFrame)
    local Player = game.Players.LocalPlayer
    local Char = Player.Character
    local Hum = Char and Char:FindFirstChild("Humanoid")
    
    if Hum and Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        -- Ngunci posisi biar gak rubberband
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        Rayfield:Notify({Title = "Success", Content = "Motor Berhasil Teleport!", Duration = 2})
    else
        -- Notifikasi peringatan kalo jalan kaki
        Rayfield:Notify({
            Title = "Gagal Teleport!", 
            Content = "Anda harus mengendarai Motor untuk teleport!", 
            Duration = 5
        })
    end
end

-- [[ TAB TELEPORT (KORDINAT PRESISI) ]] --
local TPTab = Window:CreateTab("Teleports", 4483362458)
TPTab:CreateSection("Wajib Naik Motor!")

TPTab:CreateButton({
   Name = "Teleport ke NPC MS",
   Callback = function()
      -- Kordinat dari user: 517.5, 5, 604
      SafeVehicleTP(CFrame.new(517.5, 5, 604))
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke DEALER",
   Callback = function()
      -- Kordinat dari user: 731.5, 5, 443
      SafeVehicleTP(CFrame.new(731.5, 5, 443))
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke GS MID",
   Callback = function()
      -- Kordinat dari user: 215.5, 5, -132
      SafeVehicleTP(CFrame.new(215.5, 5, -132))
   end,
})

-- [[ TAB COMBAT ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Aimbot & Hitbox")

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

-- LOCK KEPALA GEDE ANTI FLICKER
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

-- [[ TAB COOKING & MOVEMENT ]] --
local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateButton({
   Name = "Auto Cook (Marshmallow)",
   Callback = function()
      game:GetService("ReplicatedStorage").Events.CookEvent:FireServer("Start")
   end,
})

MiscTab:CreateSlider({
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
