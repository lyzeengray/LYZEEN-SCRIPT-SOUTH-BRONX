-- [[ LYZEEN GRAY: KEY SYSTEM LOADER ]] --
-- UI dirancang untuk Mobile (Neon Green Theme)

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer

-- Hapus UI lama jika ada agar tidak double
if CoreGui:FindFirstChild("LyzeenLoader") then
    CoreGui.LyzeenLoader:Destroy()
end

-- 1. SETUP MAIN SCREEN
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "LyzeenLoader"
LoaderGui.Parent = CoreGui
LoaderGui.ResetOnSpawn = false

-- 2. SETUP FRAME UTAMA (Mirip di gambar)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = LoaderGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Gelap (Base)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Neon Green Border
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90) -- Tengah layar mobile
MainFrame.Size = UDim2.new(0, 320, 0, 180) -- Ukuran pas buat HP
MainFrame.Visible = true

-- Menambahkan corner radius biar mulus
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = MainFrame

-- [[ HEADER BAGIAN ATAS ]] --
-- 3. JUDUL: LyzeenGray (Kiri Atas)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 30) -- Bar bagian atas
Title.Font = Enum.Font.GothamBold
Title.Text = "  LyzeenGray" -- Ada jeda spasi biar pas
Title.TextColor3 = Color3.fromRGB(0, 255, 0) -- Neon Green Text
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left -- Kiri Atas
local TitleCorner = Instance.new("UICorner") -- Corner buat header
TitleCorner.CornerRadius = UDim.new(0, 6)
TitleCorner.Parent = Title

-- 4. Tombol Tutup (X) - Kanan Atas
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Title
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
    LoaderGui:Destroy() -- Hapus UI kalau ditekan
end)

-- [[ BAGIAN INPUT KEY ]] --
-- 5. TextBox buat input Key
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Sedikit lebih terang
KeyInput.BorderColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.Position = UDim2.new(0.5, -125, 0.5, -30) -- Tengah frame
KeyInput.Size = UDim2.new(0, 250, 0, 35) -- Ukuran mobile friendly
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Masukkan Key Anda..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(200, 200, 200)
KeyInput.TextSize = 12
local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 4)
KeyCorner.Parent = KeyInput

-- 6. Tombol LOGIN
local LoginBtn = Instance.new("TextButton")
LoginBtn.Name = "LoginBtn"
LoginBtn.Parent = MainFrame
LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Hijau Pekat (Normal)
LoginBtn.BorderSizePixel = 0
LoginBtn.Position = UDim2.new(0.5, -125, 0.5, 25)
LoginBtn.Size = UDim2.new(0, 250, 0, 35)
LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.Text = "LOGIN"
LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginBtn.TextSize = 14
local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 4)
LoginCorner.Parent = LoginBtn

-- [[ LOGIC VALIDASI KEY & MEKONGGUKAN main.lua (SINKRONISASI) ]] --
LoginBtn.MouseButton1Click:Connect(function()
    local input = KeyInput.Text
    local KeyBackendURL = "https://project-kamu.repl.co/cek-key?key=" .. input
    
    -- Efek Loading (UI Hijau Neon berkedip)
    LoginBtn.Text = "Menghubungkan..."
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
    local blinkTween = TweenService:Create(MainFrame, tweenInfo, {BorderColor3 = Color3.fromRGB(15, 15, 15)})
    blinkTween:Play()

    -- Validasi ke Replit
    local checkSuccess, response = pcall(function()
        return game:HttpGet(KeyBackendURL)
    end)

    blinkTween:Cancel() -- Stop efek kedip
    MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Kembalikan warna neon

    if checkSuccess and response == "VALID" then
        LoginBtn.Text = "SUKSES! Selamat Datang."
        LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Hijau Terang
        task.wait(1.5)
        LoaderGui:Destroy() -- Hapus UI Loader
        
        -- [[ PANGGIL main.lua LYZEEN GRAY DARI GITHUB ]] --
        -- Ganti LINK_RAW_GITHUB_LO di bawah ini dengan link dari Github!
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LyzeenGray/SB-Project/main/main.lua"))()
        
    else
        LoginBtn.Text = "KEY SALAH / EXPIRED!"
        LoginBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Merah
        task.wait(2)
        LoginBtn.Text = "LOGIN"
        LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Kembali ke hijau normal
    end
end)
