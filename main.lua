-- [[ CONFIGURASI ]] --
local CorrectKey = "LYZEENHUB" --
local _G_Cook = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyzeenUI"
ScreenGui.Parent = game.CoreGui

-- [[ MODERN KEY SYSTEM ]] --
local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 320, 0, 180)
KeyMain.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyMain.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyMain.Parent = ScreenGui
local kc = Instance.new("UICorner") kc.Parent = KeyMain

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Text = "LYZEEN HUB | AUTH"
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyMain

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyInput.PlaceholderText = "Enter Access Key..."
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = KeyMain
local ic = Instance.new("UICorner") ic.Parent = KeyInput

local KeyBtn = Instance.new("TextButton")
KeyBtn.Size = UDim2.new(0.85, 0, 0, 40)
KeyBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
KeyBtn.Text = "VALIDATE"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.Parent = KeyMain
local bc = Instance.new("UICorner") bc.Parent = KeyBtn

-- [[ MAIN HUB ]] --
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 520, 0, 340)
Main.Position = UDim2.new(0.5, -260, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
local mc = Instance.new("UICorner") mc.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Sidebar.Parent = Main
local sc = Instance.new("UICorner") sc.Parent = Sidebar

local Logo = Instance.new("TextLabel")
Logo.Text = "LYZEEN HUB"
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.TextColor3 = Color3.fromRGB(0, 170, 255)
Logo.Font = Enum.Font.GothamBold
Logo.BackgroundTransparency = 1
Logo.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 160, 0, 15)
Container.Size = UDim2.new(0, 345, 0, 310)
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

local TeleportP = CreatePage("Teleport")
local FarmP = CreatePage("AutoFarm")
local CreditsP = CreatePage("Credits")

local function AddTab(txt, name, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, 70 + (pos * 50))
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.GothamSemibold
    b.Parent = Sidebar
    local tc = Instance.new("UICorner") tc.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[name].Visible = true
    end)
end

AddTab("Teleport 🗺️", "Teleport", 0)
AddTab("Auto Farm 🪴", "AutoFarm", 1)
AddTab("Credits ⭐", "Credits", 2)

-- [[ FITUR AUTO FARM ]] --
local BuyAmount = 1
local AmountBox = Instance.new("TextBox")
AmountBox.Size = UDim2.new(0.98, 0, 0, 40)
AmountBox.PlaceholderText = "Jumlah Beli MS (Input Angka)"
AmountBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.Parent = FarmP
AmountBox.FocusLost:Connect(function() BuyAmount = tonumber(AmountBox.Text) or 1 end)

local function BuyItem(item)
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 20 then
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer(item)
        return true
    end
    return false
end

local BuyBtn = Instance.new("TextButton")
BuyBtn.Size = UDim2.new(0.98, 0, 0, 45)
BuyBtn.Text = "🛒 START AUTO BUY MS"
BuyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
BuyBtn.Font = Enum.Font.GothamBold
BuyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyBtn.Parent = FarmP
local bc1 = Instance.new("UICorner") bc1.Parent = BuyBtn

BuyBtn.MouseButton1Click:Connect(function()
    for i = 1, BuyAmount do
        BuyItem("Water") task.wait(0.5)
        BuyItem("Sugar Block Bag") task.wait(0.5)
        BuyItem("Gelatin") task.wait(0.5)
    end
end)

local CookBtn = Instance.new("TextButton")
CookBtn.Size = UDim2.new(0.98, 0, 0, 45)
CookBtn.Text = "🔥 START AUTO COOK"
CookBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CookBtn.Font = Enum.Font.GothamBold
CookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CookBtn.Parent = FarmP
local bc2 = Instance.new("UICorner") bc2.Parent = CookBtn

CookBtn.MouseButton1Click:Connect(function()
    _G_Cook = not _G_Cook
    CookBtn.Text = _G_Cook and "🔥 STOP AUTO COOK" or "🔥 START AUTO COOK"
    spawn(function()
        while _G_Cook do
            local function Craft(ToolName, WaitT)
                if not _G_Cook then return end
                local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolName)
                if Tool then 
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
                    task.wait(0.5)
                    fireproximityprompt(workspace.Cooker.ProximityPrompt)
                    task.wait(WaitT)
                end
            end
            Craft("Water", 23)
            Craft("Sugar", 3)
            Craft("Gelatin", 63)
            Craft("Empty Bag", 5)
        end
    end)
end)

-- [[ LIST TELEPORT LENGKAP ]] --
local function AddTP(name, cf)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.98, 0, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamSemibold
    b.Parent = TeleportP
    local c = Instance.new("UICorner") c.Parent = b
    b.MouseButton1Click:Connect(function() 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf 
    end)
end

AddTP("👤 NPC Lamont Bell", CFrame.new(517, 7, 604))
AddTP("🏎️ Dealer", CFrame.new(731, 7, 443))
AddTP("📍 GS Mid", CFrame.new(215, 7, -132))
AddTP("🏢 Apartment 1", CFrame.new(1140, 11, 448))
AddTP("🏢 Apartment 2", CFrame.new(1140, 11, 420))
AddTP("🏢 Apartment 3", CFrame.new(923, 11, 41))
AddTP("🏢 Apartment 4", CFrame.new(894, 11, 40))

-- [[ MODERN CREDITS ]] --
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0.98, 0, 0, 140)
Card.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Card.Parent = CreditsP
local cc = Instance.new("UICorner") cc.Parent = Card

local CLogo = Instance.new("TextLabel")
CLogo.Text = "⭐"
CLogo.Size = UDim2.new(1, 0, 0, 50)
CLogo.TextSize = 35
CLogo.BackgroundTransparency = 1
CLogo.Parent = Card

local CName = Instance.new("TextLabel")
CName.Text = "LYZEEN"
CName.Position = UDim2.new(0, 0, 0.4, 0)
CName.Size = UDim2.new(1, 0, 0, 30)
CName.TextColor3 = Color3.fromRGB(255, 255, 255)
CName.Font = Enum.Font.GothamBold
CName.BackgroundTransparency = 1
CName.Parent = Card

local WarnBox = Instance.new("Frame")
WarnBox.Size = UDim2.new(0.9, 0, 0, 40)
WarnBox.Position = UDim2.new(0.05, 0, 0.65, 0)
WarnBox.BackgroundColor3 = Color3.fromRGB(180, 40, 40) --
WarnBox.Parent = Card
local wc = Instance.new("UICorner") wc.Parent = WarnBox

local WarnTxt = Instance.new("TextLabel")
WarnTxt.Text = "Dont share this script"
WarnTxt.Size = UDim2.new(1, 0, 1, 0)
WarnTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
WarnTxt.Font = Enum.Font.GothamBold
WarnTxt.BackgroundTransparency = 1
WarnTxt.Parent = WarnBox

-- [[ VALIDATION ]] --
KeyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyMain:Destroy()
        Main.Visible = true
        Pages["Teleport"].Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "ACCESS DENIED!"
    end
end)
