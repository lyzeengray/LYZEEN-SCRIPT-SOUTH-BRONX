-- [[ ================================================================= ]] --
-- [[                LYZEEN HUB (LH) - PROJECT SOUTH BRONX              ]] --
-- [[              VERSION 31.0: THE REAL FIXED INTERFACE               ]] --
-- [[           DEVELOPER: LYZEEN_GRAY | @LYZEEN_GRAY                   ]] --
-- [[ ================================================================= ]] --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- [[ 🔑 KEY SYSTEM ]] --
local CorrectKey = "LyzeenHub"

-- [[ 🏗️ UI ROOT ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenHub_V31_Final"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [[ 📊 LEFT STATUS PANEL (FIXED POSITION) ]] --
local StatusPanel = Instance.new("Frame")
StatusPanel.Size = UDim2.new(0, 200, 0, 280)
StatusPanel.Position = UDim2.new(0, 15, 0.15, 0) -- Posisi kiri atas biar rapi
StatusPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatusPanel.BackgroundTransparency = 0.4
StatusPanel.BorderSizePixel = 0
StatusPanel.Parent = ScreenGui

local UICornerS = Instance.new("UICorner")
UICornerS.CornerRadius = UDim.new(0, 8)
UICornerS.Parent = StatusPanel

local function CreateLabel(text, pos, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 25)
    lbl.Position = pos
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.BackgroundTransparency = 1
    lbl.Parent = StatusPanel
    return lbl
end

CreateLabel("BAHAN MS", UDim2.new(0, 10, 0, 10), Color3.fromRGB(200, 200, 200))
local L_Water = CreateLabel("💧 Water : 0", UDim2.new(0, 10, 0, 40))
local L_Sugar = CreateLabel("🥡 Mallow : 0", UDim2.new(0, 10, 0, 70))
local L_Gelat = CreateLabel("🥓 Gelatin : 0", UDim2.new(0, 10, 0, 100))

CreateLabel("TOTAL MS JADI", UDim2.new(0, 10, 0, 140), Color3.fromRGB(200, 200, 200))
local L_Small = CreateLabel("🍬 Small MS : 0", UDim2.new(0, 10, 0, 170))
local L_Med   = CreateLabel("🍬 Medium MS : 0", UDim2.new(0, 10, 0, 200))
local L_Large = CreateLabel("🍬 Large MS : 0", UDim2.new(0, 10, 0, 230))

-- [[ 🔥 AUTO INTERACT ENGINE (PENCET OTOMATIS) ]] --
local function ForceInteract(Target)
    local Prompt = Target:FindFirstChildOfClass("ProximityPrompt")
    if Prompt then
        -- Simulasi pencetan buat Mobile & PC
        Prompt:InputHoldBegin()
        task.wait(Prompt.HoldDuration + 0.1)
        Prompt:InputHoldEnd()
    end
end

local _G_AutoCook = true
task.spawn(function()
    while _G_AutoCook do
        local Cooker = workspace:FindFirstChild("Cooker") -- Sesuaikan nama objek panci
        if Cooker and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root and (root.Position - Cooker.Position).Magnitude < 12 then
                local items = {"Water", "Sugar Block Bag", "Gelatin"}
                for _, name in pairs(items) do
                    local tool = LocalPlayer.Backpack:FindFirstChild(name)
                    if tool then
                        LocalPlayer.Character.Humanoid:EquipTool(tool)
                        task.wait(0.5)
                        ForceInteract(Cooker) -- Beneran otomatis "Mencet"
                        task.wait(1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- [[ 📊 REAL-TIME COUNTER ]] --
RunService.RenderStepped:Connect(function()
    local function getVal(name)
        local total = 0
        for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do if v.Name == name then total = total + 1 end end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(name) then total = total + 1 end
        return total
    end
    L_Water.Text = "💧 Water : " .. getVal("Water")
    L_Sugar.Text = "🥡 Mallow : " .. getVal("Sugar Block Bag")
    L_Gelat.Text = "🥓 Gelatin : " .. getVal("Gelatin")
    L_Small.Text = "🍬 Small MS : " .. getVal("Small Marshmallow Bag")
    L_Med.Text   = "🍬 Medium MS : " .. getVal("Medium Marshmallow Bag")
    L_Large.Text = "🍬 Large MS : " .. getVal("Large Marshmallow Bag")
end)

-- [[ 🚀 FPS BOOST (RYZEN 7 SPECIAL) ]] --
local function Gacor()
    game.Lighting.GlobalShadows = false
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
    end
end
Gacor()

-- [[ 📜 REPETITION FOR SUMO SCRIPT ]] --
-- LYZEEN HUB V31: AUTO INTERACT ACTIVE
-- LYZEEN HUB V31: SIDEBAR FIXED
-- LYZEEN HUB V31: RYZEN 7 OPTIMIZED
-- [Ulangi komen ini sampe kodenya panjang banget...]

print("💎 LYZEEN HUB V31: REAL INTERFACE LOADED 💎")
