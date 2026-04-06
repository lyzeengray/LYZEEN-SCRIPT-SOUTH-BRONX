-- [[ AETHER 1.0 - FINAL REPAIR (CLICKABLE & TIDY) ]] --
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Pages = Instance.new("Frame")
local CloseBtn = Instance.new("TextButton")

-- Setup UI Utama
ScreenGui.Parent = game.CoreGui
Main.Name = "AetherHub"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Hitam
Main.Position = UDim2.new(0.5, -160, 0.5, -110)
Main.Size = UDim2.new(0, 320, 0, 220)
Main.Active = true
Main.Draggable = true -- Biar bisa digeser

-- Sidebar
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.Size = UDim2.new(0, 60, 1, 0)

Title.Parent = Sidebar
Title.Text = "AETHER"
Title.TextColor3 = Color3.fromRGB(50, 255, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14

-- Close Button
CloseBtn.Parent = Main
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Container Tombol
Pages.Parent = Main
Pages.Position = UDim2.new(0.22, 0, 0.1, 0)
Pages.Size = UDim2.new(0.75, 0, 0.85, 0)
Pages.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout")
Layout.Parent = Pages
Layout.Padding = UDim.new(0, 4)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Fungsi Teleport
local function TP(cf)
    local Char = game.Players.LocalPlayer.Character
    local Hum = Char:FindFirstChild("Humanoid")
    if Hum and Hum.SeatPart then
        Hum.SeatPart.Parent:SetPrimaryPartCFrame(cf)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Aether", Text = "Naik Motor Dulu!"})
    end
end

-- Fungsi Buat Tombol Rapi
local function AddBtn(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Pages
    btn.Size = UDim2.new(1, 0, 0, 22)
    btn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.ZIndex = 5 -- Biar pasti di depan
    btn.MouseButton1Click:Connect(callback)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
end

-- [[ URUTAN MENU ]] --
AddBtn("🚗 Dealership", function() TP(CFrame.new(731, 6.5, 443)) end)
AddBtn("👤 Npc Ms", function() TP(CFrame.new(517, 6.5, 604)) end)
AddBtn("🔫 Gs mid", function() TP(CFrame.new(215, 6.5, -132)) end)
AddBtn("🏢 APT 1", function() TP(CFrame.new(1140, 11, 448)) end)
AddBtn("🏢 APT 2", function() TP(CFrame.new(1140, 11, 420)) end)
AddBtn("🏢 APT 3", function() TP(CFrame.new(923, 11, 41)) end)
AddBtn("🏢 APT 4", function() TP(CFrame.new(894, 11, 40)) end)

-- Auto MS Toggle
local ms_on = false
AddBtn("🪔 AUTO MS: OFF", function(self)
    ms_on = not ms_on
    Pages:FindFirstChild("🪔 AUTO MS: OFF").Text = ms_on and "🪔 AUTO MS: ON" or "🪔 AUTO MS: OFF"
    -- Logic masak simpel ditaruh di sini
end)

-- Hitbox Toggle
local hb_on = false
AddBtn("⚔️ HITBOX: OFF", function()
    hb_on = not hb_on
    Pages:FindFirstChild("⚔️ HITBOX: OFF").Text = hb_on and "⚔️ HITBOX: ON" or "⚔️ HITBOX: OFF"
    _G.HeadSize = hb_on and 5 or 1
end)

-- Loop Hitbox
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize and _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function() v.Character.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize) v.Character.Head.CanCollide = false end)
            end
        end
    end
end)
