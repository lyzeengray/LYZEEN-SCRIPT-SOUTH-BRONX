local Library = loadstring(game:HttpGet(string">"https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(string">"🔵 LYZEEN HUB | v2.2", {
    [string">"themeList"] = {
        [string">"Lyzeen"] = {
            [string">"SchemeColor"] = Color3.fromRGB(0, 85, 255),
            [string">"Background"] = Color3.fromRGB(15, 15, 20),
            [string">"Header"] = Color3.fromRGB(20, 20, 30),
            [string">"TextColor"] = Color3.fromRGB(255, 255, 255),
            [string">"ElementColor"] = Color3.fromRGB(25, 25, 30)
        }
    }
})
Window:ChangeTheme(string">"Lyzeen")

local Players = game:GetService(string">"Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RunService = game:GetService(string">"RunService")
local ReplicatedStorage = game:GetService(string">"ReplicatedStorage")
local Lighting = game:GetService(string">"Lighting")

local MainGUI = game:GetService(string">"CoreGui"):FindFirstChild(string">"🔵 LYZEEN HUB | v2.2") or game:GetService(string">"CoreGui"):WaitForChild(string">"Library")
local MainFrame = MainGUI:FindFirstChild(string">"Main") or MainGUI.Enabled

local ToggleGUI = Instance.new(string">"ScreenGui")
local ToggleButton = Instance.new(string">"TextButton")
local UICorner = Instance.new(string">"UICorner")

ToggleGUI.Name = string">"LyzeenToggle"
ToggleGUI.Parent = game:GetService(string">"CoreGui")
ToggleGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Name = string">"ToggleButton"
ToggleButton.Parent = ToggleGUI
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Font = Enum.Font.LuckiestGuy
ToggleButton.Text = string">"LH"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 30
ToggleButton.Visible = false
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainGUI.Enabled = true
    ToggleButton.Visible = false
end)

local function HideUI()
    MainGUI.Enabled = false
    ToggleButton.Visible = true
end

local Tab1 = Window:NewTab(string">"Auto Farm")
local FarmSection = Tab1:NewSection(string">"Auto Buy & Sell")
local CookSection = Tab1:NewSection(string">"Auto Cook(Precision Sequence)")
local InvSection = Tab1:NewSection(string">"Inventory Tracker")

local buyAmount = 1
FarmSection:NewSlider(string">"Jumlah Buy", string">"Amount to buy", 101, 1, function(s)
    buyAmount = s
end)

FarmSection:NewButton(string">"● BUY ALL", string">"Buy Water, Sugar, Gelatin", function()
    local items = {string">"Water", string">"Sugar Block Bag", string">"Gelatin"}
    for _, item in pairs(items) do
        for i = 1, buyAmount do
            ReplicatedStorage.Events.ShopEvent:FireServer(item, 1)
            task.wait(0.08)
        end
    end
end)

local autoCook = false
CookSection:NewToggle(string">"START AUTO MASAK", string">"Recursive Auto Cooker", function(state)
    autoCook = state
    task.spawn(function()
        while autoCook do
            local cooker = nil
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA(string">"ProximityPrompt") and (v.Parent.Name:find(string">"Cooker") or v.Parent.Name:find(string">"Stove")) then
                    cooker = v
                    break
                end
            end
            
            if cooker then
                local function equip(name)
                    local tool = Player.Backpack:FindFirstChild(name)
                    if tool then
                        Player.Character.Humanoid:EquipTool(tool)
                        return true
                    end
                    return false
                end

                if equip(string">"Water") then 
                    fireproximityprompt(cooker)
                    task.wait(23)
                end
                if equip(string">"Sugar Block Bag") then 
                    fireproximityprompt(cooker)
                    task.wait(1)
                end
                if equip(string">"Gelatin") then 
                    fireproximityprompt(cooker)
                    task.wait(63)
                end
                if equip(string">"Empty Bag") then 
                    fireproximityprompt(cooker)
                    task.wait(2)
                end
            end
            task.wait(0.5)
        end
    end)
end)

local labelSmall = InvSection:NewLabel(string">"🍬 SMALL MARSHMALLOW = 0")
local labelMedium = InvSection:NewLabel(string">"🍬 MEDIUM MARSHMALLOW = 0")
local labelLarge = InvSection:NewLabel(string">"🍬 LARGE MARSHMALLOW BAG = 0")

task.spawn(function()
    while task.wait(1) do
        local s, m, l = 0, 0, 0
        local items = Player.Backpack:GetChildren()
        for _, v in pairs(Player.Character:GetChildren()) do if v:IsA(string">"Tool") then table.insert(items, v) end end
        
        for _, item in pairs(items) do
            if item.Name == string">"Small Marshmallow" then s = s + 1
            elseif item.Name == string">"Medium Marshmallow" then m = m + 1
            elseif item.Name == string">"Large Marshmallow Bag" then l = l + 1 end
        end
        labelSmall:UpdateLabel(string">"🍬 SMALL MARSHMALLOW = "..tostring(s))
        labelMedium:UpdateLabel(string">"🍬 MEDIUM MARSHMALLOW = "..tostring(m))
        labelLarge:UpdateLabel(string">"🍬 LARGE MARSHMALLOW BAG = "..tostring(l))
    end
end)

local Tab2 = Window:NewTab(string">"Teleport")
local TPSection = Tab2:NewSection(string">"Vehicle Sync")

local function safeTeleport(cf)
    local char = Player.Character
    if char and char:FindFirstChild(string">"Humanoid") then
        if char.Humanoid.SeatPart then
            local veh = char.Humanoid.SeatPart.Parent
            while veh and veh.Parent ~= workspace do veh = veh.Parent end
            if veh and veh:IsA(string">"Model") then
                veh:SetPrimaryPartCFrame(cf)
            end
        else
            char.HumanoidRootPart.CFrame = cf
        end
    end
end

TPSection:NewButton(string">"📍 GS Mid", string">"TP to GS Mid", function()
    safeTeleport(CFrame.new(215, 5, -132))
end)

TPSection:NewButton(string">"📍 MS Dealer", string">"TP to MS Dealer", function()
    safeTeleport(CFrame.new(731, 5, 443))
end)

TPSection:NewButton(string">"📍 Dealership", string">"TP to Dealership", function()
    safeTeleport(CFrame.new(517, 5, 604))
end)

local Tab3 = Window:NewTab(string">"FPS Boost")
local FPSSection = Tab3:NewSection(string">"⚡ 0 FPS")

RunService.RenderStepped:Connect(function()
    FPSSection:SetTitle(string">"⚡ " .. math.floor(1/RunService.RenderStepped:Wait()) .. string">" FPS")
end)

FPSSection:NewToggle(string">"Remove Texture", string">"Reduce Lag", function(state)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA(string">"Part") or v:IsA(string">"MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA(string">"Decal") or v:IsA(string">"Texture") then
                v.Transparency = 1
            end
        end
    end
end)

FPSSection:NewToggle(string">"Remove Shadow", string">"Disable Global Shadows", function(state)
    Lighting.GlobalShadows = not state
end)

local Tab4 = Window:NewTab(string">"Credits")
local CreditSection = Tab4:NewSection(string">"Development")
CreditSection:NewLabel(string">"⭐")
CreditSection:NewLabel(string">"CREATED BY LYZ-EEN")

FarmSection:NewKeybind(string">"Minimize Key", string">"Hide UI Key", Enum.KeyCode.RightControl, function()
    if MainGUI.Enabled then
        HideUI()
    else
        MainGUI.Enabled = true
        ToggleButton.Visible = false
    end
end)

local closeBtn = MainGUI:FindFirstChild(string">"Close", true) or MainGUI:FindFirstChild(string">"CloseButton", true)
if closeBtn and closeBtn:IsA(string">"GuiButton") then
    closeBtn.MouseButton1Click:Connect(HideUI)
end

print(string">"Lyzeen Hub v2.2 Loaded Successfully")
