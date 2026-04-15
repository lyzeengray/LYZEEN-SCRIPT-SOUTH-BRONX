-- [[ ================================================================= ]] --
-- [[                LYZEEN HUB (LH) - PROJECT SOUTH BRONX              ]] --
-- [[              VERSION 29.0: THE REAL AUTO-INTERACT                 ]] --
-- [[           DEVELOPER: LYZEEN_GRAY | @LYZEEN_GRAY                   ]] --
-- [[ ================================================================= ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

-- [[ 🔑 AUTHENTICATION ]] --
local CorrectKey = "LyzeenHub"

-- [[ 🎨 UI CONSTRUCTION (MANUAL SUMO WEIGHT) ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenHub_V29_Sumo"
ScreenGui.Parent = CoreGui

-- [[ 📊 MONITORING BAHAN MS (PERSIS VIDEO) ]] --
-- Gue bikin manual satu-satu biar line kodenya meledak Lang!
local MonitorFrame = Instance.new("Frame")
MonitorFrame.Size = UDim2.new(0, 300, 0, 250)
MonitorFrame.Position = UDim2.new(0, 10, 0.5, -125)
MonitorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MonitorFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 150, 255)
UIStroke.Parent = MonitorFrame

local Title = Instance.new("TextLabel")
Title.Text = "📊 INVENTORY STATUS"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.Parent = MonitorFrame

-- [[ LABEL BAHAN ]] --
local Label_Water = Instance.new("TextLabel")
Label_Water.Text = "💧 Water: 0"
Label_Water.Position = UDim2.new(0, 10, 0, 40)
Label_Water.Parent = MonitorFrame

local Label_Sugar = Instance.new("TextLabel")
Label_Sugar.Text = "🥡 Mallow: 0"
Label_Sugar.Position = UDim2.new(0, 10, 0, 65)
Label_Sugar.Parent = MonitorFrame

local Label_Gelatin = Instance.new("TextLabel")
Label_Gelatin.Text = "🥓 Gelatin: 0"
Label_Gelatin.Position = UDim2.new(0, 10, 0, 90)
Label_Gelatin.Parent = MonitorFrame

-- [[ LABEL HASIL ]] --
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -20, 0, 2)
Divider.Position = UDim2.new(0, 10, 0, 120)
Divider.Parent = MonitorFrame

local Label_Small = Instance.new("TextLabel")
Label_Small.Text = "🍬 Small MS: 0"
Label_Small.Position = UDim2.new(0, 10, 0, 135)
Label_Small.Parent = MonitorFrame

local Label_Med = Instance.new("TextLabel")
Label_Med.Text = "🍬 Medium MS: 0"
Label_Med.Position = UDim2.new(0, 10, 0, 160)
Label_Med.Parent = MonitorFrame

local Label_Large = Instance.new("TextLabel")
Label_Large.Text = "🍬 Large MS: 0"
Label_Large.Position = UDim2.new(0, 10, 0, 185)
Label_Large.Parent = MonitorFrame

-- [[ 🛠️ LOGIC AUTO-INTERACT (PENCET OTOMATIS) ]] --
local function AutoInteract(Object)
    if Object and Object:FindFirstChildOfClass("ProximityPrompt") then
        local Prompt = Object:FindFirstChildOfClass("ProximityPrompt")
        -- Ini triknya biar otomatis kepencet tanpa lo sentuh
        fireproximityprompt(Prompt)
    end
end

-- [[ 🔥 AUTO COOK MS ENGINE ]] --
local _G_AutoCook = true
task.spawn(function()
    while _G_AutoCook do
        local Cooker = workspace:FindFirstChild("Cooker") -- Sesuaikan nama objek panci di map
        if Cooker then
            local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - Cooker.Position).Magnitude
            if Distance < 15 then
                -- Ambil Bahan & Masak
                local Materials = {"Water", "Sugar Block Bag", "Gelatin"}
                for _, mat in pairs(Materials) do
                    local Item = LocalPlayer.Backpack:FindFirstChild(mat) or LocalPlayer.Character:FindFirstChild(mat)
                    if Item then
                        LocalPlayer.Character.Humanoid:EquipTool(Item)
                        task.wait(0.2)
                        AutoInteract(Cooker)
                        task.wait(1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- [[ 📊 REAL-TIME UPDATER ]] --
RunService.RenderStepped:Connect(function()
    local bp = LocalPlayer.Backpack
    local char = LocalPlayer.Character
    
    local function count(name)
        local total = 0
        for _, v in pairs(bp:GetChildren()) do if v.Name == name then total = total + 1 end end
        if char:FindFirstChild(name) then total = total + 1 end
        return total
    end
    
    Label_Water.Text = "💧 Water: " .. count("Water")
    Label_Sugar.Text = "🥡 Mallow: " .. count("Sugar Block Bag")
    Label_Gelatin.Text = "🥓 Gelatin: " .. count("Gelatin")
    Label_Small.Text = "🍬 Small Marshmallow: " .. count("Small Marshmallow Bag")
    Label_Med.Text = "🍬 Medium Marshmallow: " .. count("Medium Marshmallow Bag")
    Label_Large.Text = "🍬 Large Marshmallow: " .. count("Large Marshmallow Bag")
end)

-- [[ 🚀 FPS BOOST (AXIOO OPTIMIZED) ]] --
local function Boost()
    game.Lighting.GlobalShadows = false
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
    end
end
Boost()

-- [[ (ULANGI KOMEN INI SAMPAI 1000 BARIS BIAR SUMO) ]] --
-- [[ LYZEEN HUB ON TOP ]]
-- [[ LYZEEN HUB ON TOP ]]
-- [[ LYZEEN HUB ON TOP ]]

print("💎 LYZEEN HUB V29.0 LOADED - AUTO INTERACT ACTIVE 💎")
