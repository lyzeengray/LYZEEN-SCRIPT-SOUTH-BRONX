-- [[ LYZEEN GRAY: OFFICIAL MOBILE LOADER ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Hapus UI lama kalau ada
if CoreGui:FindFirstChild("LyzeenLoader") then CoreGui.LyzeenLoader:Destroy() end

local Loader = Instance.new("ScreenGui")
Loader.Name = "LyzeenLoader"
Loader.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Parent = Loader
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Neon Green
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.5, -135, 0.5, -70)
Main.Size = UDim2.new(0, 270, 0, 140)

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Text = "  LyzeenGray"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local Input = Instance.new("TextBox")
Input.Parent = Main
Input.PlaceholderText = "Masukkan Key..."
Input.Size = UDim2.new(0, 220, 0, 35)
Input.Position = UDim2.new(0.5, -110, 0.5, -15)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner").Parent = Input

local Btn = Instance.new("TextButton")
Btn.Parent = Main
Btn.Text = "LOGIN"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.Font = Enum.Font.GothamBold
Btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
Btn.Size = UDim2.new(0, 220, 0, 35)
Btn.Position = UDim2.new(0.5, -110, 0.5, 30)
Instance.new("UICorner").Parent = Btn

-- [[ LOGIC VALIDASI ]] --
Btn.MouseButton1Click:Connect(function()
    Btn.Text = "Checking..."
    
    -- LINK RAW GITHUB LO (Sesuai yang lo kasih)
    local raw_main = "https://raw.githubusercontent.com/lyzeengray/LYZEEN-SCRIPT-SOUTH-BRONX/refs/heads/main/main.lua"
    local raw_keys = "https://raw.githubusercontent.com/lyzeengray/LYZEEN-SCRIPT-SOUTH-BRONX/refs/heads/main/keys.txt"
    
    local success, all_keys = pcall(function() return game:HttpGet(raw_keys) end)
    
    if success and string.find(all_keys, Input.Text) then
        Btn.Text = "SUCCESS!"
        task.wait(1)
        Loader:Destroy()
        -- Eksekusi Script Utama LyzeenGray
        loadstring(game:HttpGet(raw_main))()
    else
        Btn.Text = "KEY INVALID!"
        Btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.wait(2)
        Btn.Text = "LOGIN"
        Btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    end
end)
