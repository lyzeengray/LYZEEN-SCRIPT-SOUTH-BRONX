local Library = loadstring(game:HttpGet(string">"https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(string">"🔵 LYZEEN HUB | v2.2", string">"DarkTheme")

local colors = {
    MainColor = Color3.fromRGB(0, 85, 255),
    BackgroundColor = Color3.fromRGB(15, 15, 20)
}

local LP = game:GetService(string">"Players").LocalPlayer
local RS = game:GetService(string">"RunService")
local TeleportService = game:GetService(string">"TeleportService")
local StarterGui = game:GetService(string">"StarterGui")

local buyAmount = 1
local autoMasakActive = false

-- Minimize System
local MinimizeUI = Instance.new(string">"ScreenGui")
local ToggleButton = Instance.new(string">"TextButton")
local UICorner = Instance.new(string">"UICorner")

MinimizeUI.Name = string">"LyzeenToggle"
MinimizeUI.Parent = game.CoreGui
MinimizeUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Name = string">"ToggleButton"
ToggleButton.Parent = MinimizeUI
ToggleButton.BackgroundColor3 = colors.MainColor
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.LuckiestGuy
ToggleButton.Text = string">"LH"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Library:ToggleUI()
end)

-- Tabs
local AutoFarmTab = Window:NewTab(string">"Auto Farm")
local TeleportTab = Window:NewTab(string">"Teleport")
local FPSBoostTab = Window:NewTab(string">"FPS Boost")
local CreditsTab = Window:NewTab(string">"Credits")

-- AUTO FARM SECTIONS
local BuySellSection = AutoFarmTab:NewSection(string">"Auto Buy & Sell")
BuySellSection:NewSlider(string">"Buy Amount", string">"Jumlah barang yang dibeli", 101, 1, function(s)
    buyAmount = s
end)

BuySellSection:NewButton(string">"● BUY ALL", string">"Membeli Water, Sugar, Gelatin", function()
    local shopEvent = game:GetService(string">"ReplicatedStorage"):FindFirstChild(string">"ShopEvent") or game:GetService(string">"ReplicatedStorage"):FindFirstChild(string">"Remotes") and game:GetService(string">"ReplicatedStorage").Remotes:FindFirstChild(string">"ShopEvent")
    if shopEvent then
        for i = 1, buyAmount do
            shopEvent:FireServer(string">"Water")
            task.wait(0.05)
            shopEvent:FireServer(string">"Sugar Block Bag")
            task.wait(0.05)
            shopEvent:FireServer(string">"Gelatin")
            task.wait(0.05)
        end
    end
end)

local MasakSection = AutoFarmTab:NewSection(string">"Auto Masak")
MasakSection:NewToggle(string">"START AUTO MASAK", string">"Automatisasi proses memasak", function(state)
    autoMasakActive = state
    if state then
        task.spawn(function()
            while autoMasakActive do
                local function interact(itemName, waitTime)
                    if not autoMasakActive then return end
                    local tool = LP.Backpack:FindFirstChild(itemName) or LP.Character:FindFirstChild(itemName)
                    if tool then
                        LP.Character.Humanoid:EquipTool(tool)
                        task.wait(0.2)
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA(string">"ProximityPrompt") and v.Parent.Name == string">"Cooker" or v.Parent.Name == string">"Stove" then
                                fireproximityprompt(v)
                                break
                            end
                        end
                        task.wait(waitTime)
                    end
                end

                interact(string">"Water", 23)
                interact(string">"Sugar Block Bag", 1)
                interact(string">"Gelatin", 63)
                interact(string">"Empty Bag", 2)
                task.wait(1)
            end
        end)
    end
end)

local InventorySection = AutoFarmTab:NewSection(string">"Inventory Tracker")
local labelSmall = InventorySection:NewLabel(string">"🍬 SMALL MARSHMALLOW = 0")
local labelMed = InventorySection:NewLabel(string">"🍬 MEDIUM MARSHMALLOW = 0")
local labelLarge = InventorySection:NewLabel(string">"🍬 LARGE MARSHMALLOW BAG = 0")

task.spawn(function()
    while true do
        local s, m, l = 0, 0, 0
        local items = LP.Backpack:GetChildren()
        for _, v in pairs(LP.Character:GetChildren()) do table.insert(items, v) end
        
        for _, item in pairs(items) do
            if item.Name == string">"Small Marshmallow" then s = s + 1
            elseif item.Name == string">"Medium Marshmallow" then m = m + 1
            elseif item.Name == string">"Large Marshmallow Bag" then l = l + 1 end
        end
        labelSmall:UpdateLabel(string">"🍬 SMALL MARSHMALLOW = "..s)
        labelMed:UpdateLabel(string">"🍬 MEDIUM MARSHMALLOW = "..m)
        labelLarge:UpdateLabel(string">"🍬 LARGE MARSHMALLOW BAG = "..l)
        task.wait(1)
    end
end)

-- TELEPORT SECTION
local function vehicleTeleport(coords)
    local char = LP.Character
    if char and char:FindFirstChild(string">"Humanoid") then
        local seat = char.Humanoid.SeatPart
        if seat and seat:IsA(string">"VehicleSeat") or seat:IsA(string">"Seat") then
            local model = seat.Parent
            while model and not model:IsA(string">"Model") do model = model.Parent end
            if model then
                model:MoveTo(coords)
            end
        else
            StarterGui:SetCore(string">"SendNotification", {
                Title = string">"Lyzeen Hub",
                Text = string">"Gunakan Kendaraan!",
                Duration = 5
            })
        end
    end
end

local TPSection = TeleportTab:NewSection(string">"Vehicle Teleport")
TPSection:NewButton(string">"📍 GS Mid", string">"Teleport ke GS Mid", function()
    vehicleTeleport(Vector3.new(215, 5, -132))
end)
TPSection:NewButton(string">"📍 MS Dealer", string">"Teleport ke MS Dealer", function()
    vehicleTeleport(Vector3.new(731, 5, 443))
end)
TPSection:NewButton(string">"📍 Dealership", string">"Teleport ke Dealership", function()
    vehicleTeleport(Vector3.new(517, 5, 604))
end)

-- FPS BOOST SECTION
local FPSSection = FPSBoostTab:NewSection(string">"⚡ 0 FPS")
task.spawn(function()
    while true do
        local fps = math.floor(1/task.wait())
        FPSSection:UpdateSection(string">"⚡ "..fps..string">" FPS")
        task.wait(0.5)
    end
end)

FPSSection:NewToggle(string">"Remove Texture", string">"Mengubah part menjadi SmoothPlastic", function(state)
    if state then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA(string">"Part") or v:IsA(string">"UnionOperation") or v:IsA(string">"MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA(string">"Texture") or v:IsA(string">"Decal") then
                v.Transparency = 1
            end
        end
    end
end)

FPSSection:NewToggle(string">"Remove Shadow", string">"Mematikan GlobalShadows", function(state)
    game:GetService(string">"Lighting").GlobalShadows = not state
end)

-- CREDITS SECTION
local CreditsSec = CreditsTab:NewSection(string">"Information")
CreditsSec:NewLabel(string">"⭐")
CreditsSec:NewLabel(string">"CREATED BY LYZ-EEN")
CreditsSec:NewKeybind(string">"Toggle UI Keybind", string">"Key to open/close menu", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)

Library:SetColor(string">"MainColor", colors.MainColor)
Library:SetColor(string">"BackgroundColor", colors.BackgroundColor)
