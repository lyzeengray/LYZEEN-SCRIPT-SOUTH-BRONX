-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS FIX ]] --
-- ESP: Box, Name, Health (On/Off) | Theme: Neon Green

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LyzeenGray Hub | South Bronx",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by LyzeenGray",
   ConfigurationSaving = {Enabled = true, FolderName = "LyzeenSB", FileName = "Config"}
})

-- [[ SISTEM ESP GLOBAL (SIAP PAKE) ]] --
local ESPLibrary = {
    Enabled = false,
    Boxes = false,
    Names = false,
    Health = false,
    Players = {}
}

local function CreateESP(Player)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Head = Character:WaitForChild("Head")
    local Humanoid = Character:WaitForChild("Humanoid")

    local ESP = {}

    -- [[ ESP BOX ]] --
    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "LyzeenBox"
    Box.Parent = Head
    Box.Size = Vector3.new(4, 6, 0.5) -- Sedikit tebal biar keliatan
    Box.Adornee = Character
    Box.AlwaysOnTop = true
    Box.ZIndex = 10
    Box.Color3 = Color3.fromRGB(0, 255, 0) -- Hijau Neon
    Box.Transparency = 0.5
    Box.Visible = false -- Mati dulu
    ESP.Box = Box

    -- [[ ESP NAME (NAMA) ]] --
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "LyzeenNames"
    Billboard.Parent = Head
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(0, 100, 0, 50)
    Billboard.StudsOffset = Vector3.new(0, 2.5, 0) -- Diatas kepala
    Billboard.Visible = false

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Billboard
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.TextSize = 14
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Putih biar jelas
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.Text = Player.Name
    ESP.NameLabel = TextLabel
    ESP.NameBillboard = Billboard

    -- [[ ESP HEALTH (DARAH) ]] --
    local HealthLabel = Instance.new("TextLabel")
    HealthLabel.Parent = Billboard
    HealthLabel.BackgroundTransparency = 1
    HealthLabel.Position = UDim2.new(0, 0, 0.5, 0) -- Dibawah nama
    HealthLabel.Size = UDim2.new(1, 0, 0.5, 0)
    HealthLabel.TextSize = 12
    HealthLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Mulai Hijau
    HealthLabel.Font = Enum.Font.GothamMedium
    HealthLabel.Text = "HP: 100"
    ESP.HealthLabel = HealthLabel

    -- [[ UPDATE DARAH OTOMATIS ]] --
    local function UpdateHealth()
        if Humanoid and ESPLibrary.Health then
            local Hp = math.floor(Humanoid.Health)
            HealthLabel.Text = "HP: " .. Hp
            -- Ganti warna kalo sekarat (Opsional tapi keren)
            if Hp < 50 then
                HealthLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Kuning
            elseif Hp < 20 then
                HealthLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Merah
            else
                HealthLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
            end
        end
    end

    local Connection = Humanoid.HealthChanged:Connect(UpdateHealth)
    ESP.HealthConnection = Connection

    ESPLibrary.Players[Player.Name] = ESP
end

-- [[ REAKSI KALO PLAYER BARU MASUK ]] --
game.Players.PlayerAdded:Connect(CreateESP)
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        spawn(function() CreateESP(v) end)
    end
end

-- [[ REAKSI KALO PLAYER KELUAR (BERSIHIN ESP) ]] --
game.Players.PlayerRemoving:Connect(function(Player)
    if ESPLibrary.Players[Player.Name] then
        local ESP = ESPLibrary.Players[Player.Name]
        if ESP.HealthConnection then ESP.HealthConnection:Disconnect() end
        if ESP.NameBillboard then ESP.NameBillboard:Destroy() end
        if ESP.Box then ESP.Box:Destroy() end
        ESPLibrary.Players[Player.Name] = nil
    end
end)

-- [[ FUNGSI GLOBAL BUAT ON/OFF ]] --
local function UpdateESPVisibility()
    for _, ESP in pairs(ESPLibrary.Players) do
        ESP.Box.Visible = ESPLibrary.Enabled and ESPLibrary.Boxes
        ESP.NameBillboard.Visible = ESPLibrary.Enabled
        ESP.NameLabel.Visible = ESPLibrary.Names
        ESP.HealthLabel.Visible = ESPLibrary.Health
    end
end

-- [[ TAB COMBAT ]] --
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Aimbot & Weapon")

CombatTab:CreateButton({
   Name = "No Recoil (Lurus)",
   Callback = function()
      for _, v in pairs(getgc(true)) do
         if type(v) == "table" and rawget(v, "Recoil") then
            v.Recoil = 0
            v.Spread = 0
         end
      end
      Rayfield:Notify({Title = "Success", Content = "Recoil Removed!", Duration = 2})
   end,
})

-- [[ TAB MOVEMENT ]] --
local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateSection("Safe Speed")

MoveTab:CreateSlider({
   Name = "WalkSpeed (Safe Limit)",
   Range = {16, 20},
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

-- [[ TAB ECONOMY ]] --
local FarmTab = Window:CreateTab("Economy", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Buy Ingredients",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      while _G.AutoFarm do
         task.wait(0.8)
         print("LyzeenGray: Purchasing Water, Sugar, Gelatin...")
      end
   end,
})

-- [[ TAB VISUALS (ESP FULL SETTINGS) ]] --
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
VisualsTab:CreateSection("ESP Player (On/Off)")

-- [[ TOGGLE INDUK (HARUS NYALA BIAR ESP JALAN) ]] --
VisualsTab:CreateToggle({
   Name = "Master ESP",
   CurrentValue = false,
   Callback = function(Value)
      ESPLibrary.Enabled = Value
      UpdateESPVisibility()
   end,
})

VisualsTab:CreateSection("ESP Features")

VisualsTab:CreateToggle({
   Name = "ESP Box (Green Neon)",
   CurrentValue = false,
   Callback = function(Value)
      ESPLibrary.Boxes = Value
      UpdateESPVisibility()
   end,
})

VisualsTab:CreateToggle({
   Name = "ESP Name (Nama)",
   CurrentValue = false,
   Callback = function(Value)
      ESPLibrary.Names = Value
      UpdateESPVisibility()
   end,
})

VisualsTab:CreateToggle({
   Name = "ESP Health (Darah)",
   CurrentValue = false,
   Callback = function(Value)
      ESPLibrary.Health = Value
      UpdateESPVisibility()
   end,
})

Rayfield:Notify({Title = "LyzeenGray Hub", Content = "Loaded ESP Full Edition!", Duration = 3})
