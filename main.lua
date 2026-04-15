-- [[ 🔵 LYZEEN HUB - MOBILE OPTIMIZED (DELTA/XENO) 🔵 ]] --
-- Fix: UI Visibility, No Key (Instant Load), Draggable

local Player = game:GetService("Players").LocalPlayer
local UI_Parent = Player:WaitForChild("PlayerGui") -- Lebih stabil untuk Delta/Xeno

-- Hapus UI lama jika ada
if UI_Parent:FindFirstChild("LyzeenHub_Extreme") then
    UI_Parent.LyzeenHub_Extreme:Destroy()
end

local LyzeenHub = Instance.new("ScreenGui")
LyzeenHub.Name = "LyzeenHub_Extreme"
LyzeenHub.Parent = UI_Parent
LyzeenHub.ResetOnSpawn = false

-- [[ 🔳 MAIN FRAME ]] --
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = LyzeenHub
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa digeser di layar

local Corner = Instance.new("UICorner")
Corner.Parent = MainFrame

-- [[ 🔵 TOP BAR ]] --
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
TopBar.Size = UDim2.new(1, 0, 0, 35)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "🔵 LyzeenHub v4"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [[ 🔳 MINIMIZE BUTTON ]] --
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.Text = "🔳"
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 200)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

local LH_Logo = Instance.new("TextButton")
LH_Logo.Parent = LyzeenHub
LH_Logo.Size = UDim2.new(0, 55, 0, 55)
LH_Logo.Position = UDim2.new(0, 10, 0, 150)
LH_Logo.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH_Logo.Text = "LH"
LH_Logo.Font = Enum.Font.LuckiestGuy
LH_Logo.TextSize = 25
LH_Logo.TextColor3 = Color3.new(1, 1, 1)
LH_Logo.Visible = false
LH_Logo.Draggable = true -- Logo bisa digeser manual

local LH_Corner = Instance.new("UICorner")
LH_Corner.CornerRadius = UDim.new(0, 15)
LH_Corner.Parent = LH_Logo

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    LH_Logo.Visible = true
end)

LH_Logo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    LH_Logo.Visible = false
end)

-- [[ 🍳 AUTO COOK SECTION ]] --
local CookBtn = Instance.new("TextButton")
CookBtn.Parent = MainFrame
CookBtn.Size = UDim2.new(0, 130, 0, 40)
CookBtn.Position = UDim2.new(0, 10, 0, 50)
CookBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
CookBtn.Text = "🔥 Start Auto Cook"
CookBtn.TextColor3 = Color3.new(1, 1, 1)
CookBtn.Font = Enum.Font.SourceSansBold

local isCooking = false
CookBtn.MouseButton1Click:Connect(function()
    isCooking = not isCooking
    CookBtn.Text = isCooking and "🛑 Stop Cooking" or "🔥 Start Auto Cook"
    CookBtn.BackgroundColor3 = isCooking and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 45)
    
    spawn(function()
        while isCooking do
            local char = Player.Character
            local function cook(item, waitTime)
                if not isCooking then return end
                local tool = Player.Backpack:FindFirstChild(item) or char:FindFirstChild(item)
                if tool then
                    char.Humanoid:EquipTool(tool)
                    task.wait(0.5)
                    -- Trigger Proximity Prompt
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and Player:DistanceFromCharacter(v.Parent.Position) < 12 then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(waitTime)
                end
            end
            
            cook("Water", 23) --
            cook("Sugar Block Bag", 1) --
            cook("Gelatin", 63) --
            cook("Empty Bag", 2)
            task.wait(1)
        end
    end)
end)

-- [[ 🚀 TELEPORT SECTION ]] --
local function AddTP(name, pos, x, y)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 130, 0, 35)
    btn.Position = UDim2.new(x, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
    btn.Text = "📍 " .. name
    btn.TextColor3 = Color3.new(1, 1, 1)
    
    btn.MouseButton1Click:Connect(function()
        local seat = Player.Character.Humanoid.SeatPart
        if seat and seat.Parent.Name == "Dirtbike" then
            seat.Parent:SetPrimaryPartCFrame(CFrame.new(pos))
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LyzeenHub", Text = "Naik Dirtbike Dulu!"})
        end
    end)
end

-- Koordinat Berdasarkan Gambar
AddTP("Dealership", Vector3.new(517, 5, 604), 0.5, 50)
AddTP("Npc Ms", Vector3.new(731, 5, 443), 0.5, 95)
AddTP("Gs Mid", Vector3.new(215, 5, -132), 0.5, 140)

-- [[ ⭐ CREDIT ]] --
local Credit = Instance.new("TextLabel")
Credit.Parent = MainFrame
Credit.Size = UDim2.new(1, 0, 0, 30)
Credit.Position = UDim2.new(0, 0, 1, -30)
Credit.Text = "🌟 CREATED BY LYZEEN 🌟"
Credit.TextColor3 = Color3.fromRGB(0, 85, 255)
Credit.BackgroundTransparency = 1
