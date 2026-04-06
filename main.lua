-- [[ LYZEEN GRAY HUB: AETHER 1.0 - FLUENT STABLE ]] --
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Aether 1.0 | LyzeenGray",
    SubTitle = "South Bronx Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Biar gak lag di HP
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Custom Warna Hijau Muda
Fluent:SetTheme("Darker") 

local Tabs = {
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Farm = Window:AddTab({ Title = "Farming", Icon = "zap" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "crosshair" })
}

-- [[ TELEPORT LOKASI ]] --
local function SafeVehicleTP(TargetCFrame)
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        Fluent:Notify({Title = "Gagal", Content = "Wajib naik Motor!", Duration = 3})
    end
end

Tabs.Teleport:AddButton({
    Title = "NPC MS (Ingredients)",
    Callback = function() SafeVehicleTP(CFrame.new(517, 6.5, 604)) end
})

Tabs.Teleport:AddButton({
    Title = "DEALER (Gun Shop)",
    Callback = function() SafeVehicleTP(CFrame.new(731, 6.5, 443)) end
})

Tabs.Teleport:AddButton({
    Title = "GS MID (Gas Station)",
    Callback = function() SafeVehicleTP(CFrame.new(215, 6.5, -132)) end
})

-- [[ AUTO COOK MS ]] --
_G.AutoCook = false
local FarmToggle = Tabs.Farm:AddToggle("AutoMS", {Title = "Auto Cook MS", Default = false})

FarmToggle:OnChanged(function(Value)
    _G.AutoCook = Value
    spawn(function()
        while _G.AutoCook do
            local function Action(Item)
                if not _G.AutoCook then return end
                local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
                if Tool then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                    task.wait(0.7)
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(0.4)
                end
            end
            Action("Water") task.wait(23)
            if not _G.AutoCook then break end
            Action("Sugar") task.wait(0.5)
            if not _G.AutoCook then break end
            Action("Gelatin") task.wait(63)
            if not _G.AutoCook then break end
            Action("Empty Bag") task.wait(5)
        end
    end)
end)

-- [[ COMBAT (ANTI-STUCK) ]] --
_G.HeadSize = 1
local HeadSlider = Tabs.Combat:AddSlider("HeadSlider", {
    Title = "Kepala Gede (Anti-Freeze)",
    Description = "Biar nembak gak stuck",
    Min = 1, Max = 10, Default = 1, Rounded = 1,
    Callback = function(Value) _G.HeadSize = Value end
})

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function()
                    local h = v.Character.Head
                    h.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    h.CanCollide = false
                    h.Massless = true
                end)
            end
        end
    end
end)

Fluent:Notify({Title = "Aether 1.0", Content = "Script Loaded Successfully!", Duration = 5})
