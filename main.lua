-- [[ 🔵 LYZEEN HUB v2.2 - PURE INSTANCE EDITION 🔵 ]] --
-- Optimizer: Delta & Xeno (No External Library)
-- Fix: UI Always Visible, Draggable, Auto Cook 23s/1s/63s

local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Hapus UI lama agar tidak menumpuk
if CoreGui:FindFirstChild("LyzeenHub_Supreme") then CoreGui.LyzeenHub_Supreme:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "LyzeenHub_Supreme"

-- [[ 🔳 MAIN MENU FRAME ]] --
local Main = Instance.new("Frame", Screen)
Main.Name = "Main"
Main.Size = UDim2.new(0, 350, 0, 280)
Main.Position = UDim2.new(0.5, -175, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Pastikan bisa digeser di Mobile

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

-- [[ 🔵 HEADER ]] --
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "🔵 LYZEEN HUB | v2.2"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [[ 🔳 MINIMIZE BUTTON (Top Right) ]] --
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 5)
MinBtn.Text = "🔳"
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

-- [[ 🔘 FLOATING LOGO LH ]] --
local LH = Instance.new("TextButton", Screen)
LH.Size = UDim2.new(0, 60, 0, 60)
LH.Position = UDim2.new(0, 20, 0, 150)
LH.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH.Text = "LH"
LH.Font = Enum.Font.LuckiestGuy
LH.TextSize = 30
LH.TextColor3 = Color3.new(1, 1, 1)
LH.Visible = false
LH.Draggable = true
Instance.new("UICorner", LH).CornerRadius = UDim.new(0, 15)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    LH.Visible = true
end)
LH.MouseButton1Click:Connect(function()
    Main.Visible = true
    LH.Visible = false
end)

-- [[ 📜 CONTENT SCROLLING ]] --
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -50)
Scroll.Position = UDim2.new(0, 10, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
Scroll.ScrollBarThickness = 2

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 8)

-- [[ 🚜 FITUR AUTO COOK ]] --
local CookBtn = Instance.new("TextButton", Scroll)
CookBtn.Size = UDim2.new(1, 0, 0, 40)
CookBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
CookBtn.Text = "🔥 START AUTO COOK"
CookBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CookBtn)

local cooking = false
CookBtn.MouseButton1Click:Connect(function()
    cooking = not cooking
    CookBtn.Text = cooking and "🛑 STOP COOKING" or "🔥 START AUTO COOK"
    CookBtn.BackgroundColor3 = cooking and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(25, 25, 40)
    
    spawn(function()
        while cooking do
            local function use(toolName, waitTime)
                if not cooking then return end
                local t = Player.Backpack:FindFirstChild(toolName) or Player.Character:FindFirstChild(toolName)
                if t then
                    Player.Character.Humanoid:EquipTool(t)
                    task.wait(0.5)
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and Player:DistanceFromCharacter(v.Parent.Position) < 12 then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(waitTime)
                end
            end
            use("Water", 23)
            use("Sugar Block Bag", 1)
            use("Gelatin", 63)
            use("Empty Bag", 2)
            task.wait(1)
        end
    end)
end)

-- [[ 🚀 VEHICLE TELEPORT ]] --
local function AddTP(name, pos)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
    btn.Text = "📍 " .. name
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        local seat = Player.Character.Humanoid.SeatPart
        if seat and seat.Parent.Name == "Dirtbike" then
            seat.Parent:SetPrimaryPartCFrame(CFrame.new(pos))
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title="❌ ERROR", Text="Naik Dirtbike Dulu!"})
        end
    end)
end

AddTP("GS Mid", Vector3.new(215, 5, -132))
AddTP("MS Dealer", Vector3.new(731, 5, 443))
AddTP("Dealership", Vector3.new(517, 5, 604))

-- [[ ⭐ CREDITS ]] --
local Credit = Instance.new("TextLabel", Scroll)
Credit.Size = UDim2.new(1, 0, 0, 50)
Credit.Text = "⭐\nCREATED BY LYZ-EEN"
Credit.TextColor3 = Color3.fromRGB(0, 85, 255)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.FredokaOne
