--[[
    🌟 CARSONN HUB - UNIVERSAL LOADER (FIXED)
    Auto Detect Game & Load Script
]]

local PlaceId = game.PlaceId
local MarketService = game:GetService("MarketplaceService")

local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 5;
    })
end

Notify("Carsonn Hub", "Checking Game ID...")

----------------------------------------------------------------
-- 1. KONFIGURASI GAME ID & SCRIPT LINK
----------------------------------------------------------------
-- PERHATIAN: Di sini cukup taruh LINK (URL) nya saja.
-- Jangan pakai loadstring(...) di sini.

local Games = {
    [76558904092080] = { -- The Forge (Island 1)
        Name = "The Forge (Island 1)",
        -- Masukkan Link Raw-nya saja di sini
        Link = "https://pandadevelopment.net/virtual/file/7f9190d52884159e" 
    },

    [129009554587176] = { -- The Forge (Island 2)
        Name = "The Forge (Island 2)",
        Link = "https://pandadevelopment.net/virtual/file/7f9190d52884159e" 
    },

    [131884594917121] = { -- The Forge (Island 3)
        Name = "The Forge (Island 3)",
        Link = "https://pandadevelopment.net/virtual/file/7f9190d52884159e" 
    },
    
    [121864768012064] = { -- Fish It
        Name = "Fish It",
        -- Contoh link lain (sesuaikan dengan link kamu yang benar)
        Link = "https://pandadevelopment.net/virtual/file/0d524390990c9bd9"
    }
}

----------------------------------------------------------------
-- 2. LOGIKA DETEKSI (SUDAH DIPERBAIKI)
----------------------------------------------------------------
local Detected = Games[PlaceId]

if Detected then
    Notify("Game Detected!", "Loading " .. Detected.Name .. " Script...")
    print("[Carsonn Hub] Game Found: " .. Detected.Name)
    
    -- Eksekusi Script (Diperbaiki)
    -- Kita panggil loadstring & HttpGet di sini secara langsung
    local success, err = pcall(function()
        loadstring(game:HttpGet(Detected.Link))()
    end)

    if not success then
        warn("[Carsonn Hub] Error Loading Script: " .. err)
        Notify("Error!", "Script error! Check Console (F9).")
    end
else
    -- Jika game tidak terdaftar
    local success, info = pcall(function() return MarketService:GetProductInfo(PlaceId) end)
    local GameName = success and info.Name or "Unknown Game"
    
    Notify("Unsupported Game", GameName .. " is not supported yet.")
    print("[Carsonn Hub] Unsupported Place ID: " .. PlaceId)
    
    if setclipboard then
        setclipboard(tostring(PlaceId))
        Notify("Copied ID", "Place ID copied to clipboard.")
    end
end
