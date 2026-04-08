-- [[ LYZEENHUB V6.5 PLATINUM - FULL VERSION ]] --
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenPremium"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- [[ CONFIGURATION ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"
local _G_AutoCook = false

-- [[ NOTIFICATION SYSTEM ]] --
local function Notify(msg, color)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 280, 0, 45)
    n.Position = UDim2.new(0.5, -140, -0.1, 0)
    n.BackgroundColor3 = color or Color3.fromRGB(30, 30, 35)
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.Text = "  " .. msg
    n.Font = Enum.Font.GothamBold
    n.Parent = ScreenGui
    local nc = Instance.new("UICorner") nc.Parent = n
    n:TweenPosition(UDim2.new(0.5, -140, 0.05, 0), "Out", "Back", 0.5)
    task.delay(2, function()
        n:TweenPosition(UDim2.new(0.5, -140, -0.1, 0), "In", "Quad", 0.5)
        task.wait(0.5) n:Destroy()
    end)
end

-- [[ DRAG SYSTEM ]] --
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = gui.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    gui.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- [[ MAIN UI ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.Parent = Main
MakeDraggable(Main)

-- [[ CLOSE BUTTON ]] --
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main
local cc = Instance.new("UICorner") cc.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.Parent = Main
local sc = Instance.new("UICorner") sc.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 175, 0, 55)
Container.Size = UDim2.new(0, 360, 0, 310)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.Parent = Container
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 10)
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local CredPage = CreatePage("Cred")

-- [[ CHECKERS ]] --
local function IsOnMotor() return (LocalPlayer.Character and LocalPlayer.Character.Humanoid.SeatPart ~= nil) end
local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    return npc and (LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 18
end

-- [[ MODERN BUTTON FACTORY ]] --
local function AddModernButton(parent, emoji, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.96, 0, 0, 48)
    b.BackgroundColor3 = color
    b.Text = ""
    b.Parent = parent
    local c = Instance.new("UICorner") c.Parent = b
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.Padding = UDim.new(0, 15)
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Parent = b
    local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0, 18) pad.Parent = b
    local Icon = Instance.new("TextLabel")
    Icon.Text = emoji Icon.Size = UDim2.new(0, 30, 1, 0) Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255) Icon.Font = Enum.Font.GothamBold Icon.TextSize = 20 Icon.Parent = b
    local Label = Instance.new("TextLabel")
    Label.Text = txt Label.Size = UDim2.new(0, 220, 1, 0) Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255) Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left Label.TextSize = 14 Label.Parent = b
    b.MouseButton1Click:Connect(callback)
end

-- [[ AUTO FARM LOGIC ]] --
local BuyAmount = 1
local AmountInp = Instance.new("TextBox")
AmountInp.Size = UDim2.new(0.96, 0, 0, 40)
AmountInp.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
AmountInp.PlaceholderText = "Jumlah Beli MS..."
AmountInp.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountInp.Parent = FarmPage
local ac = Instance.new("UICorner") ac.Parent = AmountInp
AmountInp.FocusLost:Connect(function() BuyAmount = tonumber(AmountInp.Text) or 1 end)

AddModernButton(FarmPage, "🛒", "START AUTO BUY MS", Color3.fromRGB(0, 120, 255), function()
    if not NearNPC() then Notify("Gagal: Harus dekat Lamont!", Color3.fromRGB(200, 0, 0)) return end
    Notify("Buying " .. BuyAmount .. " Sets...", Color3.fromRGB(0, 200, 0))
    for i = 1, BuyAmount do
        local RE = game:GetService("ReplicatedStorage").Events.ShopEvent
        RE:FireServer("Water") task.wait(0.4)
        RE:FireServer("Sugar Block Bag") task.wait(0.4)
        RE:FireServer("Gelatin") task.wait(0.4)
        RE:FireServer("Empty Bag") task.wait(0.4)
    end
end)

AddModernButton(FarmPage, "🔥", "START AUTO COOK", Color3.fromRGB(180, 40, 40), function()
    if not IsOnMotor() then Notify("Gagal: Naik motor dulu!", Color3.fromRGB(200, 0, 0)) return end
    _G_AutoCook = not _G_AutoCook
    Notify(_G_AutoCook and "Cook: ON" or "Cook: OFF")
    task.spawn(function()
        while _G_AutoCook do
            if not IsOnMotor() then _G_AutoCook = false break end
            local function Craft(item, wt)
                local t = LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item)
                if t then LocalPlayer.Character.Humanoid:EquipTool(t) task.wait(0.5) fireproximityprompt(workspace.Cooker.ProximityPrompt) task.wait(wt) end
            end
            Craft("Water", 23.5) Craft("Sugar", 3.5) Craft("Gelatin", 63.5) Craft("Empty Bag", 5.5) task.wait(1)
        end
    end)
end)

-- [[ TELEPORTS ]] --
local tps = {
    {"👤", "Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️", "Dealer", CFrame.new(731, 7, 443)},
    {"📍", "GS Mid Area", CFrame.new(215, 7, -132)},
    {"🏢", "Apartment 1", CFrame.new(1140, 11, 448)},
    {"🏢", "Apartment 2", CFrame.new(1140, 11, 420)},
    {"🏢", "Apartment 3", CFrame.new(923, 11, 41)},
    {"🏢", "Apartment 4", CFrame.new(894, 11, 40)}
}
for _, v in pairs(tps) do
    AddModernButton(TelePage, v[1], "Teleport ke " .. v[2], Color3.fromRGB(35, 35, 45), function()
        if IsOnMotor() then LocalPlayer.Character.HumanoidRootPart.CFrame = v[3] else Notify("Gagal: Naik motor!", Color3.fromRGB(200, 0, 0)) end
    end)
end

-- [[ TABS ]] --
local function AddTab(txt, page, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, 70 + (pos * 55))
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.Parent = Sidebar
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end Pages[page].Visible = true end)
end
AddTab("🎭 TELEPORT", "TP", 0)
AddTab("🍃 AUTO FARM", "Farm", 1)
AddTab("⭐ CREDIT", "Cred", 2)

-- [[ KEY SYSTEM ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 360, 0, 200)
KeyUI.Position = UDim2.new(0.5, -180, 0.5, -100)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI
local KeyIn = Instance.new("TextBox")
KeyIn.Size = UDim2.new(0.8, 0, 0, 45)
KeyIn.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyIn.PlaceholderText = "Input Key..."
KeyIn.Parent = KeyUI
local LogBtn = Instance.new("TextButton")
LogBtn.Size = UDim2.new(0.8, 0, 0, 45)
LogBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
LogBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
LogBtn.Text = "LOGIN"
LogBtn.Parent = KeyUI
LogBtn.MouseButton1Click:Connect(function()
    if KeyIn.Text == CorrectKey then
        KeyUI:Destroy()
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 550, 0, 380)}):Play()
        Pages["TP"].Visible = true
    end
end)
