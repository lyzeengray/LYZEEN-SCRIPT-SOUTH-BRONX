-- [🌀] LYZEEN SPY v5 (NO-HOOK METHOD)
-- Dirancang khusus untuk Executor yang sensitif kayak Xeno
print("[🌀] Memulai pengintaian pasif...")

-- Kita pake cara manual: Kita ganti fungsi HttpGet cuma di level variabel
local original_http_get = game.HttpGet
local original_http_async = game.HttpGetAsync

-- Fungsi buat nyimpen data
local function dump(url, content)
    local name = "DUMP_HASIL_" .. math.random(100, 999) .. ".lua"
    writefile(name, "-- URL SOURCE: " .. url .. "\n\n" .. content)
    warn("[🌀] DATA TERCIDUK! Cek folder workspace: " .. name)
end

-- Override manual (Bukan Hooking sistem, jadi lebih aman)
game.HttpGet = function(self, url, ...)
    local data = original_http_get(self, url, ...)
    dump(url, data)
    return data
end

game.HttpGetAsync = function(self, url, ...)
    local data = original_http_async(self, url, ...)
    dump(url, data)
    return data
end

print("[🌀] Pengintaian pasif aktif. Silakan jalankan Majesty Store!")
