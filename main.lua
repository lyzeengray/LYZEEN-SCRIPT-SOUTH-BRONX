-- JANGAN JALANIN SCRIPT ORANG DULU! Jalanin ini dulu:
local oldHook; oldHook = hookfunction(game.HttpGet, function(self, url)
    print("[🌀] Lyzeen Detected Link: " .. url)
    
    -- Ambil data asli dari web orang itu
    local data asli = oldHook(self, url)
    
    -- Simpan isinya ke folder 'workspace' di folder Executor lu
    writefile("HASIL_NYOLONG.lua", "-- Sumber: " .. url .. "\n\n" .. data asli)
    
    warn("[🌀] Akar script berhasil dicopy ke folder workspace!")
    
    return data asli
end)
