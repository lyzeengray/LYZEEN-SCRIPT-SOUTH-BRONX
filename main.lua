-- [[ CONFIGURASI ]] --
local CorrectKey = "LYZEENHUB-ON-TOP"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- [[ UI KEY SYSTEM ]] --
local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 300, 0, 150)
KeyMain.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyMain.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
KeyMain.Parent = ScreenGui
local kc = Instance.new("UICorner") kc.Parent = KeyMain

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Text = "LyzeenHub Key System"
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.TextColor3 = Color3.fromRGB(80, 200, 255)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.Parent = KeyMain

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "Input Key Here..."
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = KeyMain

local KeyBtn = Instance.new("TextButton")
KeyBtn.Size = UDim2.new(0.8, 0, 0, 35)
KeyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 255)
KeyBtn.Text = "CHECK KEY"
KeyBtn.Parent = KeyMain

-- [[ MAIN HUB (HIDDEN) ]] --
local Main = Instance.new("Frame")
Main.Name = "LyzeenHub"
Main.Size = UDim2.new(0, 480, 0, 350)
Main.Position = UDim2.new(0.5, -240, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
local mainCorner = Instance.new("UICorner") mainCorner.Parent = Main

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
Sidebar.Parent = Main
local Title = Instance.new("TextLabel")
Title.Text = "LyzeenHub 🍃"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(80, 200, 255)
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 140, 0, 10)
Container.Size = UDim2.new(0, 330, 0, 330)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.Parent = Container
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 8)
    Pages[name] = Page
    return Page
end

local TeleportP = CreatePage("Teleport")
local FarmP = CreatePage("AutoFarm")
local CreditsP = CreatePage("Credits")

local function AddTab(txt, name, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, 60 + (pos * 45))
    b.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Parent = Sidebar
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[name].Visible = true
    end)
    local c = Instance.new("UICorner") c.Parent = b
end

AddTab("🎭 Teleport", "Teleport", 0)
AddTab("🍃 Auto Farm", "AutoFarm", 1)
AddTab("⭐ Credits", "Credits", 2)

-- [[ FITUR AUTO FARM ]] --
local BuyAmount = 1
local AmountBox = Instance.new("TextBox")
AmountBox.Size = UDim2.new(0.95, 0, 0, 35)
AmountBox.PlaceholderText = "Jumlah Beli MS"
AmountBox.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.Parent = FarmP
AmountBox.FocusLost:Connect(function() BuyAmount = tonumber(AmountBox.Text) or 1 end)

local function BuyItem(item)
    local npc = workspace:FindFirstChild("Lamont Bell")
    if npc and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude < 15 then
        game:GetService("ReplicatedStorage").Events.ShopEvent:FireServer(item)
    else
        local n = Instance.new("Hint") n.Text = "Anda harus berada di dekat npc ms" n.Parent = game.Workspace
        task.wait(2) n:Destroy()
        return false
    end
    return true
end

local BuyBtn = Instance.new("TextButton")
BuyBtn.Size = UDim2.new(0.95, 0, 0, 35)
BuyBtn.Text = "🛒 Start Auto Buy"
BuyBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 255)
BuyBtn.Parent = FarmP
BuyBtn.MouseButton1Click:Connect(function()
    for i = 1, BuyAmount do
        if not BuyItem("Water") then break end
        task.wait(0.5)
        if not BuyItem("Sugar Block Bag") then break end
        task.wait(0.5)
        if not BuyItem("Gelatin") then break end
        task.wait(0.5)
    end
end)

local _G_Cook = false
local CookBtn = Instance.new("TextButton")
CookBtn.Size = UDim2.new(0.95, 0, 0, 35)
CookBtn.Text = "🔥 Start Auto Cook"
CookBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
CookBtn.Parent = FarmP
CookBtn.MouseButton1Click:Connect(function()
    _G_Cook = not _G_Cook
    CookBtn.Text = _G_Cook and "🔥 Stop Auto Cook" or "🔥 Start Auto Cook"
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

-- [[ TELEPORT ]] --
local function AddTP(name, cf)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.95, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Parent = TeleportP
    b.MouseButton1Click:Connect(function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf end)
    local c = Instance.new("UICorner") c.Parent = b
end
AddTP("👤 NPC Lamont Bell", CFrame.new(517, 7, 604))
AddTP("🏎️ Dealer", CFrame.new(731, 7, 443))
AddTP("📍 GS Mid", CFrame.new(215, 7, -132))
AddTP("🏢 APT 1", CFrame.new(1140, 11, 448))
AddTP("🏢 APT 2", CFrame.new(1140, 11, 420))
AddTP("🏢 APT 3", CFrame.new(923, 11, 41))
AddTP("🏢 APT 4", CFrame.new(894, 11, 40))

-- [[ CREDITS ]] --
local MainCred = Instance.new("Frame")
MainCred.Size = UDim2.new(0.95, 0, 0, 120)
MainCred.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
MainCred.Parent = CreditsP
local mc = Instance.new("UICorner") mc.Parent = MainCred

local StarIcon = Instance.new("TextLabel")
StarIcon.Text = "⭐" StarIcon.Size = UDim2.new(1, 0, 0, 50) StarIcon.BackgroundTransparency = 1 StarIcon.Parent = MainCred
local OwnerName = Instance.new("TextLabel")
OwnerName.Text = "Lyzeen" OwnerName.Position = UDim2.new(0, 0, 0.5, 0) OwnerName.Size = UDim2.new(1, 0, 0, 30) OwnerName.TextColor3 = Color3.fromRGB(255, 255, 255) OwnerName.BackgroundTransparency = 1 OwnerName.Parent = MainCred

local WarnFrame = Instance.new("Frame")
WarnFrame.Size = UDim2.new(0.95, 0, 0, 40) WarnFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0) WarnFrame.Parent = CreditsP
local WarnText = Instance.new("TextLabel")
WarnText.Text = "Dont share this script" WarnText.Size = UDim2.new(1, 0, 1, 0) WarnText.TextColor3 = Color3.fromRGB(255, 255, 255) WarnText.BackgroundTransparency = 1 WarnText.Parent = WarnFrame

-- [[ KEY CHECK ]] --
KeyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyMain.Visible = false
        Main.Visible = true
        Pages["Teleport"].Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY!"
        task.wait(1)
        KeyInput.PlaceholderText = "Input Key Here..."
    end
end)
