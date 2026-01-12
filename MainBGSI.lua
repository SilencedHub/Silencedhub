-- [[ SILENCED BGSI MASTER SCRIPT - UPDATED ]] --
if not game:IsLoaded() then game.Loaded:Wait() end

-- [[ UI INITIALIZATION ]] --
local syde = loadstring(game:HttpGet("https://raw.githubusercontent.com/essencejs/syde/refs/heads/main/source", true))()

syde:Load({
    Logo = '93269097446618',
    Name = 'Silenced Bgsi',
    Status = 'Stable',
    Accent = Color3.fromRGB(251, 144, 255),
    AutoLoad = true
})

local Window = syde:Init({
    Title = 'Silenced Hub';
    SubText = 'Master Edition'
})

-- [[ TABS ]] --
local MainTab = Window:InitTab('Main')
local FarmTab = Window:InitTab('Auto Farm')

-------------------------------------------------------------------------------
-- MAIN TAB (Server Utilities Added)
-------------------------------------------------------------------------------
MainTab:Section('Server Utilities')

MainTab:Button({
    Title = "Rejoin Server",
    Description = "Reconnects you to this specific server",
    CallBack = function()
        local ts = game:GetService("TeleportService")
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
})

MainTab:Button({
    Title = "Server Hop",
    Description = "Joins a different random server",
    CallBack = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local _Servers = Http:JSONDecode(game:HttpGet(Api))
        local _Server = _Servers.data[math.random(1, #_Servers.data)]
        TPS:TeleportToPlaceInstance(game.PlaceId, _Server.id, game.Players.LocalPlayer)
    end
})

MainTab:Section('Protection')

MainTab:Toggle({
    Title = 'Anti-AFK Protection',
    Value = true,
    CallBack = function(Value)
        getgenv().AntiAFK = Value
    end
})

-------------------------------------------------------------------------------
-- FARM TAB (Example remains)
-------------------------------------------------------------------------------
FarmTab:Section('Auto Farm')
FarmTab:Toggle({
    Title = 'Auto Bubble',
    Value = false,
    CallBack = function(v) _G.AutoBubble = v end
})

-- Re-executing Anti-AFK logic for Potassium
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if getgenv().AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)
