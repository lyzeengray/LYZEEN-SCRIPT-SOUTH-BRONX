-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE COOKING ]] --
-- Fitur: Auto Cook Loop (Water-Sugar-Gelatin-Bag), Aimbot, Big Head, TP Motor

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"},
   KeySystem = false,
   Theme = "Green"
})

-- [[ FUNGSI AUTO EQUIP & INTERACT ]] --
local function CookAction(ToolName)
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local BackPack = Player.Backpack
    
    -- Cari Tool di Backpack terus pake (Equip)
    local Tool = BackPack:FindFirstChild(ToolName)
    if Tool then
        Character.Humanoid:EquipTool(Tool)
        task.wait(0.5)
        -- Simulasi Pencet "E" via Virtual Input
        keypress(Enum.KeyCode.E)
        task.wait(0.1)
        keyrelease(Enum.KeyCode.E)
    end
end

-- [[ TAB COOKING ]] --
local CookingTab = Window:CreateTab("Cooking", 4483362458)
_G.AutoCook = false

CookingTab:CreateToggle({
   Name = "AUTO COOK LOOP (Marshmallow)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCook = Value
      spawn(function()
         while _G.AutoCook do
            -- 1. Megang Water & Pencet E
            CookAction("Water")
            task.wait(20) -- Tunggu 20 detik
            
            if not _G.AutoCook then break end
            
            -- 2. Megang Sugar & Pencet E
            CookAction("Sugar")
            task.wait(1) -- Jeda sebentar biar gak glich
            
            if not _G.AutoCook then break end
            
            -- 3. Megang Gelatin & Pencet E
            CookAction("Gelatin")
            task.wait(60) -- Tunggu 60 detik (Proses Masak)
            
            if not _G.AutoCook then break end
            
            -- 4. Megang Empty Bag & Pencet E
            CookAction("Empty Bag")
            task.wait(2) -- Ambil hasil
            
            -- Ngulang lagi dari awal (Water)
         end
      end)
   end,
})

-- [[ TAB TELEPORT (KORDINAT PRESISI) ]] --
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
TPTab:CreateButton({Name = "TP ke NPC MS", Callback = function() SafeVehicleTP(CFrame.new(517.5, 5, 604)) end})
TPTab:CreateButton({Name = "TP ke DEALER", Callback = function() SafeVehicleTP(CFrame.new(731.5, 5, 443)) end})
TPTab:CreateButton({Name = "TP ke GS MID", Callback = function() SafeVehicleTP(CFrame.new(215.5, 5, -132)) end})

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
                v.Character.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                v.Character.Head.CanCollide = false
            end
        end
    end
end)
