local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local coord = tostring(math.floor(pos.X)) .. ", " .. tostring(math.floor(pos.Y + 2)) .. ", " .. tostring(math.floor(pos.Z))

-- BIAR MUNCUL DI LAYAR (NOTIFIKASI)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KOORDINAT LO:",
    Text = coord,
    Duration = 20
})

-- AUTO COPY (Kalo executor lo support)
if setclipboard then
    setclipboard(coord)
    print("Koordinat udah ke-copy ke Clipboard, Bos!")
end
