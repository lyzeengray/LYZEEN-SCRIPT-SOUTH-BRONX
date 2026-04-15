-- [[ 🔵 LYZEEN HUB - SUPREME REBORN 🔵 ]] --
-- Key: LYZ-EEN-HUB
-- Status: Otoritas Mutlak (Fix Total)

local LyzeenHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Content = Instance.new("ScrollingFrame")
local TabButtons = Instance.new("Frame")
local LH_Logo = Instance.new("TextButton")

-- [ 🎨 TEMA BIRU LYZEEN ] --
LyzeenHub.Name = "LyzeenHub"
LyzeenHub.Parent = game:GetService("CoreGui")
LyzeenHub.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = LyzeenHub
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- MENU BISA DIGERAKKAN

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
TopBar.Size = UDim2.new(1, 0, 0, 35)

Title.Parent = TopBar
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "🔵 LyzeenHub | SOUTH BRONX"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [ 🔳 SISTEM MINIMIZE LH ] --
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.Text = "🔳"
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 180)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

LH_Logo.Parent = LyzeenHub
LH_Logo.Size = UDim2.new(0, 60, 0, 60)
LH_Logo.Position = UDim2.new(0, 20, 0, 150)
LH_Logo.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH_Logo.Text = "LH"
LH_Logo.Font = Enum.Font.LuckiestGuy
LH_Logo.TextSize = 30
LH_Logo.TextColor3 = Color3.new(1, 1, 1)
LH_Logo.Visible = false
LH_Logo.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = LH_Logo

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    LH_Logo.Visible = true
end)

LH_Logo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    LH_Logo.Visible = false
end)

-- [ 🔑 KEY SYSTEM LOGIN ] --
local KeyOverlay = Instance.new("Frame")
KeyOverlay.Parent = MainFrame
KeyOverlay.Size = UDim2.new(1, 0, 1, 0)
KeyOverlay.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
KeyOverlay.ZIndex = 5

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyOverlay
KeyInput.Size = UDim2.new(0, 250, 0, 40)
KeyInput.Position = UDim2.new(0.5, -125, 0.4, -20)
KeyInput.PlaceholderText = "Input Key: LYZ-EEN-HUB"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyInput.TextColor3 = Color3.new(1, 1, 1)

local ContinueBtn = Instance.new("TextButton")
ContinueBtn.Parent = KeyOverlay
ContinueBtn.Size = UDim2.new(0, 200, 0, 40)
ContinueBtn.Position = UDim2.new(0.5, -100, 0.6, 0)
ContinueBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ContinueBtn.Text = "➡ CONTINUE ➡"
ContinueBtn.TextColor3 = Color3.new(1, 1, 1)

ContinueBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "LYZ-EEN-HUB" then
        KeyOverlay:Destroy()
    else
        game.Players.LocalPlayer:Kick("❌ KEY INVALID [ Lyzeen ] ❌")
    end
end)

-- [ 🍳 AUTO COOK LOGIC ] --
local CookSec = Instance.new("TextButton")
CookSec.Parent = MainFrame
CookSec.Size = UDim2.new(0, 180, 0, 40)
CookSec.Position = UDim2.new(0, 10, 0, 50)
CookSec.Text = "🔥 Start Auto Cook"
CookSec.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
CookSec.TextColor3 = Color3.new(1, 1, 1)

local isCooking = false
CookSec.MouseButton1Click:Connect(function()
    isCooking = not isCooking
    CookSec.BackgroundColor3 = isCooking and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
    
    spawn(function()
        while isCooking do
            local p = game.Players.LocalPlayer
            local function use(name, waitTime)
                local tool = p.Backpack:FindFirstChild(name) or p.Character:FindFirstChild(name)
                if tool then
                    p.Character.Humanoid:EquipTool(tool)
                    task.wait(0.2)
                    -- Trigger E
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and p:DistanceFromCharacter(v.Parent.Position) < 15 then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(waitTime)
                end
            end
            
            use("Water", 23)
            if not isCooking then break end
            use("Sugar Block Bag", 1)
            if not isCooking then break end
            use("Gelatin", 63)
            if not isCooking then break end
            use("Empty Bag", 2)
            task.wait(1)
        end
    end)
end)

-- [ 🚀 TELEPORT LOGIC ] --
local function CreateTP(name, pos, yOffset)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 180, 0, 35)
    btn.Position = UDim2.new(0.5, 10, 0, yOffset)
    btn.Text = "📍 " .. name
    btn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
    btn.TextColor3 = Color3.new(1, 1, 1)
    
    btn.MouseButton1Click:Connect(function()
        local seat = game.Players.LocalPlayer.Character.Humanoid.SeatPart
        if seat and seat.Parent.Name == "Dirtbike" then
            seat.Parent:SetPrimaryPartCFrame(CFrame.new(pos))
        else
            print("Butuh Dirtbike!")
        end
    end)
end

CreateTP("Dealership", Vector3.new(517, 5, 604), 50)
CreateTP("Npc Ms", Vector3.new(731, 5, 443), 90)
CreateTP("Gs Mid", Vector3.new(215, 5, -132), 130)

-- [ ⭐ CREDIT ] --
local cr = Instance.new("TextLabel")
cr.Parent = MainFrame
cr.Size = UDim2.new(1, 0, 0, 30)
cr.Position = UDim2.new(0, 0, 1, -30)
cr.Text = "🌟 CREATED BY LYZEEN 🌟"
cr.TextColor3 = Color3.fromRGB(0, 85, 255)
cr.BackgroundTransparency = 1
