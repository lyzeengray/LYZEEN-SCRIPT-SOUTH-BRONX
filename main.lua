-- [[ LYZEEN GRAY HUB: AETHER 1.0 - ULTRA STABLE ]] --
-- Fix: No Library (Langsung Muncul Tanpa Load Link Luar)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local TabContent = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- Setup UI Dasar
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "AetherMain"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Abu-Abu Gelap
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.Size = UDim2.new(0, 100, 1, 0)

Title.Parent = Sidebar
Title.Text = "AETHER 1.0"
Title.TextColor3 = Color3.fromRGB(50, 255, 50) -- Hijau Muda
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- [[ FUNGSI TELEPORT MOTOR ]] --
local function SafeVehicleTP(TargetCFrame)
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.SeatPart and Hum.SeatPart:IsA("VehicleSeat") then
        local Vehicle = Hum.SeatPart.Parent
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
        task.wait(0.1)
        Vehicle:SetPrimaryPartCFrame(TargetCFrame)
    else
        print("Wajib Naik Motor!")
    end
end

-- [[ TOMBOL TP NPC MS ]] --
local TPBtn = Instance.new("TextButton")
TPBtn.Parent = MainFrame
TPBtn.Position = UDim2.new(0.3, 0, 0.2, 0)
TPBtn.Size = UDim2.new(0, 250, 0, 40)
TPBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
TPBtn.Text = "TP NPC MS (517, 604)"
TPBtn.MouseButton1Click:Connect(function()
    SafeVehicleTP(CFrame.new(517, 6.5, 604))
end)

-- [[ TOMBOL TP DEALER ]] --
local DealerBtn = Instance.new("TextButton")
DealerBtn.Parent = MainFrame
DealerBtn.Position = UDim2.new(0.3, 0, 0.4, 0)
DealerBtn.Size = UDim2.new(0, 250, 0, 40)
DealerBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
DealerBtn.Text = "TP DEALER (731, 443)"
DealerBtn.MouseButton1Click:Connect(function()
    SafeVehicleTP(CFrame.new(731, 6.5, 443))
end)

-- [[ TOGGLE AUTO COOK MS ]] --
_G.AutoCook = false
local CookBtn = Instance.new("TextButton")
CookBtn.Parent = MainFrame
CookBtn.Position = UDim2.new(0.3, 0, 0.6, 0)
CookBtn.Size = UDim2.new(0, 250, 0, 40)
CookBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
CookBtn.Text = "AUTO COOK MS: OFF"

CookBtn.MouseButton1Click:Connect(function()
    _G.AutoCook = not _G.AutoCook
    CookBtn.Text = _G.AutoCook and "AUTO COOK MS: ON" or "AUTO COOK MS: OFF"
    CookBtn.BackgroundColor3 = _G.AutoCook and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(150, 150, 150)
    
    if _G.AutoCook then
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
    end
end)

-- [[ SLIDER HITBOX (ANTI STUCK) ]] --
_G.HeadSize = 1
local HitBtn = Instance.new("TextButton")
HitBtn.Parent = MainFrame
HitBtn.Position = UDim2.new(0.3, 0, 0.8, 0)
HitBtn.Size = UDim2.new(0, 250, 0, 40)
HitBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
HitBtn.Text = "SET HITBOX (PALA GEDE)"

HitBtn.MouseButton1Click:Connect(function()
    _G.HeadSize = (_G.HeadSize == 1) and 5 or 1
    HitBtn.Text = "HITBOX: " .. _G.HeadSize
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HeadSize > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function()
                    v.Character.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.Head.CanCollide = false
                    v.Character.Head.Massless = true
                end)
            end
        end
    end
end)

print("Aether 1.0 Loaded - LyzeenGray")
