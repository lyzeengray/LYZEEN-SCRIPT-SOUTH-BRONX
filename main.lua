-- [[ AETHER 1.0 - ULTRA BYPASS (NO LIBRARY) ]] --
-- Fix: Pasti Muncul, Ringan, Warna Hijau & Hitam

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Setup UI Dasar
ScreenGui.Parent = game.CoreGui
Main.Name = "AetherFinal"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Hitam Pekat
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.Size = UDim2.new(0, 350, 0, 220)
Main.Active = true
Main.Draggable = true

Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.Size = UDim2.new(0, 70, 1, 0)

Title.Parent = Sidebar
Title.Text = "AETHER"
Title.TextColor3 = Color3.fromRGB(50, 255, 50) -- Hijau Muda
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

Container.Parent = Main
Container.Position = UDim2.new(0.25, 0, 0.1, 0)
Container.Size = UDim2.new(0.7, 0, 0.85, 0)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
Container.CanvasSize = UDim2.new(0, 0, 2, 0)

UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi TP Motor
local function TP(cf)
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.SeatPart then
        Hum.SeatPart.Parent:SetPrimaryPartCFrame(cf)
    else
        print("Wajib Naik Motor!")
    end
end

-- Fungsi Buat Tombol
local function AddBtn(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.Size = UDim2.new(0.95, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    btn.Text = txt
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
end

-- [[ DAFTAR MENU SESUAI REQUEST ]] --
AddBtn("🚗 Dealership", function() TP(CFrame.new(731, 6.5, 443)) end)
AddBtn("👤 Npc Ms", function() TP(CFrame.new(517, 6.5, 604)) end)
AddBtn("🔫 Gs mid", function() TP(CFrame.new(215, 6.5, -132)) end)
AddBtn("🏢 APT 1", function() TP(CFrame.new(1140, 11, 448)) end)
AddBtn("🏢 APT 2", function() TP(CFrame.new(1140, 11, 420)) end)
AddBtn("🏢 APT 3", function() TP(CFrame.new(923, 11, 41)) end)
AddBtn("🏢 APT 4", function() TP(CFrame.new(894, 11, 40)) end)

-- Fitur Tambahan
_G.AutoMS = false
AddBtn("🪔 AUTO MS: OFF", function(self)
    _G.AutoMS = not _G.AutoMS
    script.Parent.Text = _G.AutoMS and "🪔 AUTO MS: ON" or "🪔 AUTO MS: OFF"
    -- Logic masak simpel di sini...
end)

_G.PalaGede = 1
AddBtn("⚔️ HITBOX: OFF", function()
    _G.PalaGede = (_G.PalaGede == 1) and 5 or 1
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.PalaGede > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               pcall(function() v.Character.Head.Size = Vector3.new(_G.PalaGede, _G.PalaGede, _G.PalaGede) v.Character.Head.CanCollide = false end)
            end
        end
    end
end)
