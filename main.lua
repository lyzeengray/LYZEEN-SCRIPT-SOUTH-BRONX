-- [🌀] LYZEEN HYPER-STEALTH v4 (NO HOOK - ANTI DETECT)
print("[🌀] Memulai penyusupan jalur belakang...")

-- Gak pake hookfunction, kita pake jalur LogService (Nguping apa yang di-print script itu)
local LogService = game:GetService("LogService")
local function dump_akar(msg)
    -- Kadang script loadstring nge-print URL-nya ke log internal
    if msg:find("http") then
        writefile("LINK_RAHASIA_"..math.random(1,999)..".txt", msg)
        warn("[🌀] Link web terdeteksi dan disimpan!")
    end
end
LogService.MessageOut:Connect(dump_akar)

-- Teknik RAW GET (Bypass proteksi Xeno)
local old_get; old_get = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if (method == "HttpGet" or method == "HttpGetAsync") and not checkcaller() then
        local url = args[1]
        -- Panggil asli tapi simpan datanya lewat spawn biar gak ngerusak timing
        task.spawn(function()
            local content = game:HttpGet(url)
            writefile("AKAR_MAJESTY.lua", "-- URL: "..url.."\n\n"..content)
        end)
    end
    return old_get(self, ...)
end)

print("[🌀] Jaring Bayangan Level 2 Aktif. Coba jalankan Majesty!")
