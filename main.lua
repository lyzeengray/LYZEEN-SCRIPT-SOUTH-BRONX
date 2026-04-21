-- [🌀] LYZEEN GHOST HOOK v3 (Khusus Xeno/Anti-Detect)
print("[🌀] Memasang jaring bayangan...")

local function save_akar(link, konten)
    local nama = "AKAR_" .. math.random(100, 999) .. ".lua"
    writefile(nama, "-- LINK ASLI: " .. tostring(link) .. "\n\n" .. tostring(konten))
    warn("[🌀] BERHASIL! Cek folder workspace: " .. nama)
end

-- Gunakan Metatable Hook (Lebih susah dideteksi daripada hookfunction biasa)
local mt = getrawmetatable(game)
local old_nc = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "HttpGet" or method == "HttpGetAsync" then
        local url = args[1]
        -- Panggil fungsi asli secara diam-diam
        local data_asli = old_nc(self, unpack(args))
        
        -- Simpan data tanpa merusak aliran script target
        spawn(function()
            save_akar(url, data_asli)
        end)
        
        return data_asli
    end
    
    return old_nc(self, ...)
end)

setreadonly(mt, true)
print("[🌀] Jaring Bayangan Aktif. Silakan jalanin Majesty Store!")
