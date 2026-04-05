-- [[ LYZEEN GRAY: SOUTH BRONX FINAL PROTECTED ]] --
-- Fitur: TP Motor Only (Anti-Ban), Aimbot Fix, Big Head, Full Auto Cook

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
        -- JIKA NAIK MOTOR: Teleport Kendaraannya
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        Rayfield:Notify({Title = "Success", Content = "Motor Berhasil Teleport!", Duration = 2})
    else
        -- JIKA JALAN KAKI: Batalkan & Kasih Peringatan
        Rayfield:Notify({
            Title = "Gagal Teleport!", 
            Content = "Anda harus mengendarai Motor untuk teleport!", 
            Duration = 5
        })
    end
end

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

-- LOCK KEPALA GEDE (ANTI KEDAP-KEDIP)
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

-- [[ TAB TELEPORT (MOTOR ONLY) ]] --
local TPTab = Window:CreateTab("Teleports", 4483362458)
TPTab:CreateSection("Wajib Naik Motor!")

TPTab:CreateButton({
   Name = "Teleport ke DS (Ingredients Shop)",
   Callback = function()
      -- Koordinat dalam toko DS
      SafeVehicleTP(CFrame.new(396.5, 3.5, -155.2))
   end,
})

TPTab:CreateButton({
   Name = "Teleport ke Dealer (Senjata)",
   Callback = function()
      SafeVehicleTP(CFrame.new(280.2, 3.5, -480.8))
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

CookingTab:CreateButton({
   Name = "Auto Cook (Marshmallow)",
   Callback = function()
      game:GetService("ReplicatedStorage").Events.CookEvent:FireServer("Start")
      Rayfield:Notify({Title = "Cooking", Content = "Mulai Masak Otomatis...", Duration = 2})
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
