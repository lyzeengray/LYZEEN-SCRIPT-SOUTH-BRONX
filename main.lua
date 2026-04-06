-- [[ TAB TELEPORT - FITUR AMBIL KORDINAT SAKTI ]] --
TeleportTab:CreateSection("GET COORDINATE")

TeleportTab:CreateButton({
   Name = "AMBIL KORDINAT (AUTO COPY)",
   Callback = function()
      local Char = game.Players.LocalPlayer.Character
      local Root = Char:FindFirstChild("HumanoidRootPart")
      
      if Root then
         local X = math.floor(Root.Position.X)
         local Y = math.floor(Root.Position.Y) + 2 -- Biar gak nyungsep
         local Z = math.floor(Root.Position.Z)
         
         local FinalPos = X .. ", " .. Y .. ", " .. Z
         
         -- 1. Munculin Notifikasi Gede (Biar keliatan)
         Rayfield:Notify({
            Title = "POSISI DITEMUKAN!",
            Content = "Kordinat: " .. FinalPos,
            Duration = 15
         })
         
         -- 2. Munculin Pesan di Chat (Biar lo bisa liat history-nya)
         game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[AETHER] Kordinat lo: " .. FinalPos,
            Color = Color3.fromRGB(50, 255, 50),
            Font = Enum.Font.SourceSansBold
         })
         
         -- 3. Auto Copy (Biar lo tinggal paste di script)
         if setclipboard then
            setclipboard("CFrame.new(" .. FinalPos .. ")")
            Rayfield:Notify({Title = "Copied!", Content = "Kordinat udah ke-copy, tinggal paste!", Duration = 3})
         end
      end
   end,
})
