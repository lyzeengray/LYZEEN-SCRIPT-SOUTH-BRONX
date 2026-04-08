-- [[ LOAD SERVICES ]] --
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

-- [[ GUI BASE ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenPlatinum"
ScreenGui.Parent = game.CoreGui

-- [[ MODERN NOTIFICATION ]] --
local function Notify(msg, color)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 280, 0, 45)
    n.Position = UDim2.new(0.5, -140, -0.1, 0)
    n.BackgroundColor3 = color or Color3.fromRGB(35, 35, 45)
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.Text = msg
    n.Font = Enum.Font.GothamBold
    n.Parent = ScreenGui
    local nc = Instance.new("UICorner") nc.Parent = n
    n:TweenPosition(UDim2.new(0.5, -140, 0.05, 0), "Out", "Back", 0.5)
    task.delay(2, function()
        n:TweenPosition(UDim2.new(0.5, -140, -0.1, 0), "In", "Quad", 0.5)
        task.wait(0.5) n:Destroy()
    end)
end

-- [[ MAIN UI STRUCTURE ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Main.ClipsDescendants = true
Main.Visible = false
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.CornerRadius = UDim.new(0, 15) mc.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Sidebar.Parent = Main

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 170, 0, 15)
Container.Size = UDim2.new(0, 365, 0, 350)
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
    Layout.Padding = UDim.new(0, 12)
    Pages[name] = Page
    return Page
end

local TelePage = CreatePage("TP")
local FarmPage = CreatePage("Farm")
local CredPage = CreatePage("Cred")

-- [[ CHECKER FUNCTIONS ]] --
local function IsOnMotor()
    return (LocalPlayer.Character and LocalPlayer.Character.Humanoid.SeatPart ~= nil)
end

local function NearNPC()
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and LocalPlayer.Character then
        return (LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 15
    end
    return false
end

-- [[ COMPONENT FACTORY ]] --
local function AddButton(parent, txt, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.95, 0, 0, 45)
    b.BackgroundColor3 = color
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(callback)
end

-- [[ AUTO FARM - FULL LOGIC ]] --
AddButton(FarmPage, "🛒 START AUTO BUY MS", Color3.fromRGB(0, 120, 255), function()
    if not NearNPC() then 
        Notify("ERROR: Harus dekat NPC Lamont Bell!", Color3.fromRGB(200, 0, 0)) 
        return 
    end
    Notify("Auto Buying Started...", Color3.fromRGB(0, 200, 0))
    for i = 1, 5 do -- Contoh 5x buy
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Water") task.wait(0.5)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Sugar Block Bag") task.wait(0.5)
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer("Gelatin") task.wait(0.5)
    end
end)

local _G_AutoCook = false
AddButton(FarmPage, "🔥 START AUTO COOK", Color3.fromRGB(200, 50, 50), function()
    if not IsOnMotor() then 
        Notify("ERROR: Wajib naik motor!", Color3.fromRGB(200, 0, 0)) 
        return 
    end
    _G_AutoCook = not _G_AutoCook
    Notify(_G_AutoCook and "Auto Cook: ON" or "Auto Cook: OFF")
    spawn(function()
        while _G_AutoCook do
            if not IsOnMotor() then _G_AutoCook = false break end
            -- Crafting logic with ProxPrompt
            fireproximityprompt(workspace.Cooker.ProximityPrompt)
            task.wait(1.5)
        end
    end)
end)

-- [[ TELEPORT - FULL LIST ]] --
local tpLocations = {
    {"👤 Lamont Bell", CFrame.new(517, 7, 604)},
    {"🏎️ Car Dealer", CFrame.new(731, 7, 443)},
    {"🏢 Apart 1", CFrame.new(1140, 11, 448)},
    {"🏢 Apart 2", CFrame.new(1140, 11, 420)},
    {"🏢 Apart 3", CFrame.new(923, 11, 41)},
    {"🏢 Apart 4", CFrame.new(894, 11, 40)},
    {"🏢 Apart 5", CFrame.new(100, 11, 200)}, -- Coord dummy
    {"🏢 Apart 6", CFrame.new(150, 11, 250)}  -- Coord dummy
}

for _, data in pairs(tpLocations) do
    AddButton(TelePage, "GO TO " .. data[1], Color3.fromRGB(35, 35, 45), function()
        if not IsOnMotor() then 
            Notify("Gagal: Harus naik motor!", Color3.fromRGB(200, 0, 0)) 
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = data[2]
        end
    end)
end

-- [[ TABS ]] --
local function CreateTab(txt, pageName, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, 70 + (pos * 55))
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.Parent = Sidebar
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[pageName].Visible = true
    end)
end
CreateTab("TELEPORT", "TP", 0)
CreateTab("FARMING", "Farm", 1)
CreateTab("CREDITS", "Cred", 2)

-- [[ KEY SYSTEM WITH ANIMATION ]] --
local KeyUI = Instance.new("Frame")
KeyUI.Size = UDim2.new(0, 350, 0, 200)
KeyUI.Position = UDim2.new(0.5, -175, 0.5, -100)
KeyUI.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyUI.Parent = ScreenGui
local kc2 = Instance.new("UICorner") kc2.Parent = KeyUI

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "Input Key..."
KeyInput.Parent = KeyUI

local Login = Instance.new("TextButton")
Login.Size = UDim2.new(0.8, 0, 0, 40)
Login.Position = UDim2.new(0.1, 0, 0.65, 0)
Login.Text = "VALIDATE"
Login.Parent = KeyUI

Login.MouseButton1Click:Connect(function()
    if KeyInput.Text == "LYZEENHUB-ON-TOP" then
        KeyUI:Destroy()
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 550, 0, 380)}):Play()
        Pages["TP"].Visible = true
    else
        Notify("KEY SALAH!", Color3.fromRGB(200, 0, 0))
    end
end)
