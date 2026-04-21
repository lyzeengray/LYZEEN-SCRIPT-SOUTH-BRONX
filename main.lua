-- [🌀] LYZEEN FINAL PROTOCOL v6 (LOADSTRING BYPASS)
-- Tanpa menyentuh HttpGet, langsung nangkep kodenya di gerbang eksekusi
print("[🌀] Memulai protokol akhir: Loadstring Ambush...")

local old_load; old_load = hookfunction(loadstring, function(code, ...)
    -- Jika yang masuk ke loadstring adalah kode script (bukan kosong)
    if code and type(code) == "string" and #code > 100 then 
        local name = "HASIL_AKAR_" .. math.random(1000, 9999) .. ".lua"
        writefile(name, "-- [🌀] LYZEEN CAPTURED CODE --\n\n" .. code)
        warn("[🌀] AKAR TERCIDUK DI LOADSTRING! Cek workspace: " .. name)
    end
    return old_load(code, ...)
end)

print("[🌀] Jaring aktif di gerbang eksekusi. Hajar Majesty!")
