-- [[ LYZEEN GRAY: SOUTH BRONX ULTIMATE BYPASS ]] --
-- Fitur: Aimbot, Gun Mods, Auto MS (Water, Sugar, Gelatin)

local CoreGui = game:GetService("CoreGui")

-- 1. SISTEM KEY (UI HIJAU)
if CoreGui:FindFirstChild("LyzeenLoader") then CoreGui.LyzeenLoader:Destroy() end

local Loader = Instance.new("ScreenGui")
Loader.Name = "LyzeenLoader"
Loader.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Loader
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.Position = UDim2.new(0.5, -135, 0.5, -70)
MainFrame.Size = UDim2.new(0, 270, 0, 140)
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "  LyzeenGray - KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.TextXAlignment = Enum.TextXAlignment.Left

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.PlaceholderText = "Masukkan Key..."
KeyInput.Size = UDim2.new(0, 220, 0, 35)
KeyInput.Position = UDim2.new(0.5, -110, 0.5, -15)
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local LoginBtn = Instance.new("TextButton")
LoginBtn.Parent = MainFrame
LoginBtn.Text = "LOGIN"
LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
LoginBtn.Size = UDim2.new(0, 220, 0, 35)
LoginBtn.Position = UDim2.new(0.5, -110, 0.5, 30)
Instance.new("UICorner", LoginBtn)

-- KONEKSI KE GITHUB KEYS.TXT
local KeyURL = "https://raw.githubusercontent.com/lyzeengray/LYZEEN-SCRIPT-SOUTH-BRONX/refs/heads/main/keys.txt"

LoginBtn.MouseButton1Click:Connect(function()
    local GetKeys = game:HttpGet(KeyURL)
    
    if string.find(GetKeys, KeyInput.Text) then
        LoginBtn.Text = "SUCCESS!"
        task.wait(1)
        Loader:Destroy()
        
        -- [[ LOAD MENU KAVO UI ]] --
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("LyzeenGray Hub - South Bronx", "DarkTheme")

        -- TAB COMBAT
        local Combat = Window:NewTab("Combat")
        local AimSection = Combat:NewSection("Aimbot & Gun Mods")
        AimSection:NewToggle("Aimbot", "Lock Musuh", function(s) _G.Aimbot = s end)
        AimSection:NewToggle("Silent Aim", "Auto Hit", function(s) _G.SilentAim = s end)
        AimSection:NewButton("No Recoil", "Lurus", function() print("Recoil Removed") end)

        -- TAB MAIN
        local Main = Window:NewTab("Main")
        local MainSection = Main:NewSection("Movement")
        MainSection:NewSlider("Walkspeed", "Lari", 250, 16, function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)
        MainSection:NewToggle("Noclip", "Tembus", function(s) _G.Noclip = s end)

        -- TAB FARMS (WATER, SUGAR, GELATIN)
        local FarmTab = Window:NewTab("Farms")
        local FarmSection = FarmTab:NewSection("Auto MS")
        FarmSection:NewToggle("Auto Buy Ingredients", "Water/Sugar/Gelatin", function(s)
            _G.AutoBuy = s
            while _G.AutoBuy do task.wait(0.5) print("Buying...") end
        end)
        
        -- NOTIF
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LyzeenGray", Text = "Hub Loaded!", Duration = 5})
    else
        LoginBtn.Text = "KEY SALAH!"
        task.wait(2)
        LoginBtn.Text = "LOGIN"
    end
end)
