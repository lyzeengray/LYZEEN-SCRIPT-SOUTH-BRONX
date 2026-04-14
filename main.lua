-- [[ 🔵 LYZEEN HUB - SUPREME COOKING EDITION 🔵 ]] --
-- Fitur: Auto Cook (23s, 1s, 63s), Draggable, Logo LH

local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Colors = {
    SchemeColor = Color3.fromRGB(0, 85, 255),
    Background = Color3.fromRGB(10, 10, 15),
    Header = Color3.fromRGB(15, 15, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 35)
}

-- [[ 🛠️ UI INITIALIZATION ]] --
local MainWin = Kavo.CreateLib("🔵 LyzeenHub | SOUTH BRONX 🔵", Colors)
local ScreenGui = game:GetService("CoreGui"):FindFirstChild("🔵 LyzeenHub | SOUTH BRONX 🔵")
local MainFrame = ScreenGui.Main

-- [[ 🔳 SMART MINIMIZE SYSTEM ]] --
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "LyzeenToggle"
ToggleGui.Parent = game:GetService("CoreGui")

local LH_Logo = Instance.new("TextButton")
LH_Logo.Parent = ToggleGui
LH_Logo.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
LH_Logo.Position = UDim2.new(0, 20, 0, 200)
LH_Logo.Size = UDim2.new(0, 65, 0, 65)
LH_Logo.Text = "LH"
LH_Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
LH_Logo.Font = Enum.Font.LuckiestGuy 
LH_Logo.TextSize = 35
LH_Logo.Visible = false
LH_Logo.Draggable = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 20)
Corner.Parent = LH_Logo

local function ToggleUI()
    local isVisible = MainFrame.Visible
    MainFrame.Visible = not isVisible
    LH_Logo.Visible = isVisible
end
LH_Logo.MouseButton1Click:Connect(ToggleUI)

-- [[ 🌾 TAB: AUTO FARM & COOK ]] --
local TabFarm = MainWin:NewTab("🌾 Auto Farm")
local SecCook = TabFarm:NewSection("🍳 Auto Cook Sequence ⏱️")

SecCook:NewButton("🔳 MINIMIZE MENU", "Sembunyikan menu & munculkan LH", function()
    ToggleUI()
end)

-- LOGIC AUTO COOK
_G.AutoCook = false
SecCook:NewToggle("🔥 Start Auto Masak", "Otomatis Proses Bahan", function(state)
    _G.AutoCook = state
    spawn(function()
        while _G.AutoCook do
            local p = game.Players.LocalPlayer
            local char = p.Character
            
            -- FUNGSI INTERAKSI E (Sesuaikan nama ProximityPrompt jika beda)
            local function Interact()
                -- Mengasumsikan ada ProximityPrompt di dekat pemain
                local root = char:FindFirstChild("HumanoidRootPart")
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") and p:DistanceFromCharacter(v.Parent.Position) < 10 then
                        fireproximityprompt(v)
                    end
                end
            end

            -- STEP 1: WATER (23 Detik)
            if char:FindFirstChild("Water") or p.Backpack:FindFirstChild("Water") then
                p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Water") or char:FindFirstChild("Water"))
                Interact()
                task.wait(23)
            end
            
            if not _G.AutoCook then break end

            -- STEP 2: SUGAR BLOCK BAG (1 Detik)
            if char:FindFirstChild("Sugar Block Bag") or p.Backpack:FindFirstChild("Sugar Block Bag") then
                p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Sugar Block Bag") or char:FindFirstChild("Sugar Block Bag"))
                Interact()
                task.wait(1)
            end

            if not _G.AutoCook then break end

            -- STEP 3: GELATIN (63 Detik)
            if char:FindFirstChild("Gelatin") or p.Backpack:FindFirstChild("Gelatin") then
                p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Gelatin") or char:FindFirstChild("Gelatin"))
                Interact()
                task.wait(63)
            end

            if not _G.AutoCook then break end

            -- STEP 4: EMPTY BAG (Ambil Hasil)
            if char:FindFirstChild("Empty Bag") or p.Backpack:FindFirstChild("Empty Bag") then
                p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Empty Bag") or char:FindFirstChild("Empty Bag"))
                Interact()
                task.wait(2)
            end
            
            task.wait(1)
        end
    end)
end)

local SecInv = TabFarm:NewSection("🍬 MALLOW YANG SUDAH JADI 🍬")
local labelS = SecInv:NewLabel("🍬 Small Marshmallow = 0")
local labelM = SecInv:NewLabel("🍬 Medium Marshmallow = 0")
local labelL = SecInv:NewLabel("🍬 Large Marshmallow bag = 0")

-- Loop Tracker Inventory
spawn(function()
    while true do
        local bp = game.Players.LocalPlayer.Backpack
        local ch = game.Players.LocalPlayer.Character
        local s, m, l = 0, 0, 0
        for _, v in pairs(bp:GetChildren()) do
            if v.Name == "Small Marshmallow Bag" then s = s + 1
            elseif v.Name == "Medium Marshmallow Bag" then m = m + 1
            elseif v.Name == "Large Marshmallow bag" then l = l + 1 end
        end
        labelS:SetText("🍬 Small Marshmallow = " .. s)
        labelM:SetText("🍬 Medium Marshmallow = " .. m)
        labelL:SetText("🍬 Large Marshmallow bag = " .. l)
        task.wait(2)
    end
end)

-- [[ 🚀 TAB: TELEPORT ]] --
local TabTP = MainWin:NewTab("🚀 Teleport")
local SecTP = TabTP:NewSection("🏍️ Dirtbike Required 🏍️")
local function TP(cf)
    local seat = game.Players.LocalPlayer.Character.Humanoid.SeatPart
    if seat and seat.Parent.Name == "Dirtbike" then
        seat.Parent:SetPrimaryPartCFrame(cf)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "❌ ERROR", Text = "Gunakan Dirtbike!"})
    end
end
SecTP:NewButton("[🏎️] Dealership", "📍 517, 5, 604", function() TP(CFrame.new(517, 5, 604)) end)
SecTP:NewButton("[🍳] Npc Ms", "📍 731, 5, 443", function() TP(CFrame.new(731, 5, 443)) end)
SecTP:NewButton("[🔫] Gs Mid", "📍 215, 5, -132", function() TP(CFrame.new(215, 5, -132)) end)

-- [[ ⭐ TAB: CREDITS ]] --
local TabCred = MainWin:NewTab("⭐ Credits")
TabCred:NewSection("          🌟          ")
TabCred:NewSection("      ⭐ LYZEEN ⭐     ")
TabCred:NewSection("🔵 CREATED BY LYZEEN 🔵")
