-- [[ FITUR AMBIL KORDINAT (UTILITY) ]] --
TeleportTab:CreateSection("UTILITY COORDINATE")

TeleportTab:CreateButton({
   Name = "Get My Position (Ambil Kordinat)",
   Callback = function()
      local Pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
      local X = math.floor(Pos.X)
      local Y = math.ceil(Pos.Y) + 1.5 -- Gue kasih +1.5 biar gak nyungsep pas TP nanti
      local Z = math.floor(Pos.Z)
      
      -- Munculin di Notifikasi Layar
      Rayfield:Notify({
         Title = "Kordinat Ditemukan!",
         Content = "X: "..X..", Y: "..Y..", Z: "..Z,
         Duration = 10
      })
      
      -- Munculin di Console (F9) biar bisa di-copy
      print("Kordinat Baru lo: " .. X .. ", " .. Y .. ", " .. Z)
      print("Format Script: SafeVehicleTP(CFrame.new("..X..", "..Y..", "..Z.."))")
   end,
})
