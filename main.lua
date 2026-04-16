local Library = loadstring(game:HttpGet(string">"https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(string">"LyzeenHub | South Bronx", string">"Midnight")

local MainTab = Window:NewTab(string">"Main")
local VisualTab = Window:NewTab(string">"Visuals")
local TPTab = Window:NewTab(string">"Teleport")
local MiscTab = Window:NewTab(string">"Misc")

local FarmSection = MainTab:NewSection(string">"Auto Farm")
_G.AutoFarm = false
_G.AutoPunch = false

FarmSection:NewToggle(string">"Auto Farm(Distance Check)", string">"Teleports to closest NPC/Task", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA(string">"Model") and v:FindFirstChild(string">"Humanoid") and v:FindFirstChild(string">"HumanoidRootPart") then
                        if v.Name ~= game.Players.LocalPlayer.Name and v.Humanoid.Health > 0 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            task.wait(0.1)
                        end
                    end
                end
            end)
            task.wait()
        end
    end)
end)

FarmSection:NewToggle(string">"Auto Click/Punch", string">"Automatically Punches", function(state)
    _G.AutoPunch = state
    task.spawn(function()
        while _G.AutoPunch do
            local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass(string">"Tool")
            if tool then
                tool:Activate()
            end
            task.wait(0.1)
        end
    end)
end)

local PlayerSection = MainTab:NewSection(string">"Player Custom")
PlayerSection:NewSlider(string">"WalkSpeed", string">"Max speed set to 20", 20, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild(string">"Humanoid") then
            if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed > 20 then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
            end
        end
    end
end)

local ESPSection = VisualTab:NewSection(string">"Player ESP")
_G.ESPEnabled = false

ESPSection:NewToggle(string">"Enable ESP", string">"See players through walls", function(state)
    _G.ESPEnabled = state
    if not state then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild(string">"Highlight") then
                v.Character.Highlight:Destroy()
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.ESPEnabled then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    if not v.Character:FindFirstChild(string">"Highlight") then
                        local highlight = Instance.new(string">"Highlight", v.Character)
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                    end
                end
            end
        end
    end
end)

local TeleportSection = TPTab:NewSection(string">"Key Locations")

TeleportSection:NewButton(string">"Bank", string">"TP to Bank", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(150, 5, 200) -- Example Coords
end)

TeleportSection:NewButton(string">"Gun Shop", string">"TP to Gun Shop", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-300, 5, 100) -- Example Coords
end)

TeleportSection:NewButton(string">"Police Station", string">"TP to PD", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(50, 5, -400) -- Example Coords
end)

local MiscSection = MiscTab:NewSection(string">"Other")
MiscSection:NewButton(string">"Anti-AFK", string">"Stay connected", function()
    local vu = game:GetService(string">"VirtualUser")
    game:GetService(string">"Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

MiscSection:NewKeybind(string">"Toggle UI", string">"Press to Hide/Show UI", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
