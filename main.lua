-- [🌀] LYZEEN ULTIMATE HOOKER v2
print("[🌀] Lyzeen AI: Memasang jaring di memori...")

local function capture(url, data)
    local filename = "DUMP_" .. tick() .. ".lua"
    writefile(filename, "-- SOURCE URL: " .. tostring(url) .. "\n\n" .. tostring(data))
    warn("[🌀] AKAR BERHASIL DICOPY! Cek file: " .. filename)
end

-- Hook HttpGet (Cara Standar)
local oldGet; oldGet = hookfunction(game.HttpGet, function(self, url, ...)
    local result = oldGet(self, url, ...)
    capture(url, result)
    return result
end)

-- Hook HttpGetAsync (Cara Cadangan)
local oldAsync; oldAsync = hookfunction(game.HttpGetAsync, function(self, url, ...)
    local result = oldAsync(self, url, ...)
    capture(url, result)
    return result
end)

-- Antisipasi kalau dia pake Request (Executor High-End)
if syn and syn.request then
    local oldReq; oldReq = hookfunction(syn.request, function(req)
        local res = oldReq(req)
        capture(req.Url, res.Body)
        return res
    end)
elseif request then
    local oldReq; oldReq = hookfunction(request, function(req)
        local res = oldReq(req)
        capture(req.Url, res.Body)
        return res
    end)
end

print("[🌀] Jaring Aktif. Silakan jalanin script target sekarang!")
