-- [[ LYZHUB V2.2 - AUTO FARM MS UPDATED ]] --
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local TabHolder = Instance.new("Frame")
local TopBar = Instance.new("Frame")

ScreenGui.Parent = game.CoreGui
Main.Name = "LyzHub_Final"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Active = true
Main.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = Main

-- Header
TopBar.Parent = Main
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundTransparency = 1

local Logo = Instance.new("TextLabel")
Logo.Parent = TopBar
Logo.Text = "LH"
Logo.TextColor3 = Color3.fromRGB(80, 200, 255)
Logo.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
Logo.Position = UDim2.new(0, 10, 0, 8)
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Font = Enum.Font.SourceSansBold
Logo.TextSize = 18
local logoCorner = Instance.new("UICorner") logoCorner.CornerRadius = UDim.new(0, 6) logoCorner.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Text = "LyzeenHub | South Bronx"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Position = UDim2.new(0, 50, 0, 8)
Title.Size = UDim2.new(0, 200, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.Position = UDim2.new(1, -35, 0, 8)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
local cBtnCorner = Instance.new("UICorner") cBtnCorner.CornerRadius = UDim.new(0, 6) cBtnCorner.Parent = CloseBtn

-- Sidebar
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.Size = UDim2.new(0, 120, 0, 285)
local sideCorner = Instance.new("UICorner") sideCorner.CornerRadius = UDim.new(0, 8) sideCorner.Parent = Sidebar

-- Tab System
local Pages = {}
TabHolder.Parent = Main
TabHolder.Position = UDim2.new(0, 140, 0, 50)
TabHolder.Size = UDim2.new(0, 395, 0, 285)
TabHolder.BackgroundTransparency = 1

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = TabHolder
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 8)
    Pages[name] = Page
    return Page
end

local CombatP = CreatePage("Combat")
local TeleportP = CreatePage("Teleport")
local FarmP = CreatePage("Auto Farm")
local CreditsP = CreatePage("Credits")

local function AddTab(txt, pageName, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 10 + (pos * 40))
    btn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(function() 
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[pageName].Visible = true 
    end)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

AddTab("⚔️ Combat", "Combat", 0)
AddTab("🚀 Teleport", "Teleport", 1)
AddTab("🔥 Auto Farm", "Auto Farm", 2)
AddTab("⭐ Credits", "Credits", 6)

-- Components
local function AddToggle(parent, txt, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
    frame.Parent = parent
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = frame
    local label = Instance.new("TextLabel")
    label.Text = "  " .. txt
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    local btn = Instance.new("TextButton")
    btn.Text = ""
    btn.Size = UDim2.new(0, 40, 0, 20)
    btn.Position = UDim2.new(1, -50, 0.5, -10)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.Parent = frame
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(1, 0) bc.Parent = btn
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(80, 200, 255) or Color3.fromRGB(80, 80, 80)
        callback(state)
    end)
end

-- [[ TELEPORT LIST ]]
local function AddTP(name, cf)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 55, 75)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = TeleportP
    btn.MouseButton1Click:Connect(function()
        local Hum = game.Players.LocalPlayer.Character.Humanoid
        if Hum.SeatPart then Hum.SeatPart.Parent:SetPrimaryPartCFrame(cf) end
    end)
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

AddTP("🚗 Dealership", CFrame.new(731, 7, 443))
AddTP("👤 Npc Ms", CFrame.new(517, 7, 604))
AddTP("🔫 Gs mid", CFrame.new(215, 7, -132))
AddTP("🏢 APT 1", CFrame.new(1140, 11, 448))
AddTP("🏢 APT 2", CFrame.new(1140, 11, 420))
AddTP("🏢 APT 3", CFrame.new(923, 11, 41))
AddTP("🏢 APT 4", CFrame.new(894, 11, 40))

-- [[ AUTO FARM LOGIC ]]
_G.AutoFarm = false
AddToggle(FarmP, "START AUTO COOK", function(v)
    _G.AutoFarm = v
    spawn(function()
        while _G.AutoFarm do
            local function Use(Item, WaitTime)
                if not _G.AutoFarm then return end
                local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Item) or game.Players.LocalPlayer.Character:FindFirstChild(Item)
                if Tool then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                    task.wait(0.5)
                    for _, p in pairs(workspace:GetDescendants()) do
                        if p:IsA("ProximityPrompt") and (p.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10 then
                            fireproximityprompt(p)
                        end
                    end
                    task.wait(WaitTime)
                end
            end
            Use("Water", 23)
            Use("Sugar", 3)
            Use("Gelatin", 63)
            Use("Empty Bag", 5)
        end
    end)
end)

-- [[ COMBAT ]]
AddToggle(CombatP, "Hitbox (Head 5)", function(v) _G.HB = v and 5 or 1 end)

-- [[ CREDITS ]]
local CreditTxt = Instance.new("TextLabel")
CreditTxt.Size = UDim2.new(1, 0, 1, 0)
CreditTxt.BackgroundTransparency = 1
CreditTxt.Text = "THE SCRIPT CREATED BY Lyzeen\n\nSpecial thanks to Aether Community"
CreditTxt.TextColor3 = Color3.fromRGB(80, 200, 255)
CreditTxt.Font = Enum.Font.SourceSansBold
CreditTxt.TextSize = 16
CreditTxt.Parent = CreditsP

-- Hitbox Loop
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.HB and _G.HB > 1 then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                pcall(function() v.Character.Head.Size = Vector3.new(_G.HB, _G.HB, _G.HB) v.Character.Head.CanCollide = false end)
            end
        end
    end
end)

Pages["Combat"].Visible = true
