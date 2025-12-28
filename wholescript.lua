--// BGSI Script | Rev. 1.1.8 | BGSI Build v10134
getgenv().Config = {
    --// General Settings
    ClaimPlaytime = true,
    MaxPotionCraft = false,
    SeasonPassClaim = true,
    AntiAFK = false,
    FastHatch = true,
    Metrics = true,

    --// Auto Potion
    InfinityElixir = true, --// Will use 1 every 6min
    SecretElixir = true, --// Will use 1 every 12min
    EggElixir = true, --// will use 1 every 25min
    LuckyInf = true, --// Will use 1 every 37min
    SpeedInf = true, --// Will use 1 every 37min
    MythicInf = true, --// Will use 1 every 37min

    --// OG Event
    OGSpin = true,

    --// Webhook Settings
    Webhook_enabled = true,
    Discord_ID = "1",
    Webhook = "https://discord.com/api/webhooks/",
    Ignore_AutoDeleted = true,
    Secret_Only = false,

    --// Performance Boost
    FPS = "5",
    LowGraphics = true,

    --// Anti Scam Settings
    Allowed_User = "Changeme",
    AntiTrade = true,

    --// Script Files
    WebhookScript = "https://raw.bgsi-botting.xyz/core/webhook.lua",
    AutoPotionScript = "https://raw.bgsi-botting.xyz/core/autopotion.lua",
    OGSpinScript = "https://raw.bgsi-botting.xyz/v10134/events/ogspin.lua",
    AntiAFKScript = "https://raw.bgsi-botting.xyz/core/antiafk.lua",
    PlaytimeScript = "https://raw.bgsi-botting.xyz/core/playtime.lua",
    SeasonPassScript = "https://raw.bgsi-botting.xyz/core/seasonpass.lua",
    PotionScript = "https://raw.bgsi-botting.xyz/core/potioncraft.lua",
    BoosterScript = "https://raw.bgsi-botting.xyz/core/booster.lua",
    FastHatchScript = "https://raw.bgsi-botting.xyz/core/fasthatch.lua",
    MetricsScript = "https://raw.bgsi-botting.xyz/core/metrics.lua",
}

loadstring(game:HttpGet(getgenv().Config.WebhookScript))()
loadstring(game:HttpGet(getgenv().Config.MetricsScript))()
loadstring(game:HttpGet(getgenv().Config.PlaytimeScript))()
loadstring(game:HttpGet(getgenv().Config.SeasonPassScript))()
loadstring(game:HttpGet(getgenv().Config.PotionScript))()
loadstring(game:HttpGet(getgenv().Config.AntiAFKScript))()
loadstring(game:HttpGet(getgenv().Config.OGSpinScript))()
loadstring(game:HttpGet(getgenv().Config.AutoPotionScript))()
loadstring(game:HttpGet(getgenv().Config.BoosterScript))()
loadstring(game:HttpGet(getgenv().Config.FastHatchScript))()
