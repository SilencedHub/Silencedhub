-- [[ SILENCED BGSI MASTER SCRIPT - POTASSIUM STABLE ]] --
if not game:IsLoaded() then game.Loaded:Wait() end

-- Clear previous UI if it exists to prevent overlap
local oldUI = game.CoreGui:FindFirstChild("SydeUI")
if oldUI then oldUI:Destroy() end

local syde = loadstring(game:HttpGet("https://raw.githubusercontent.com/essencejs/syde/refs/heads/main/source", true))()

-- Global Configurations
getgenv().AntiAFK = true

-- 1. LOAD THE CORE (Wait for it to finish)
syde:Load({
    Logo = '93269097446618',
    Name = 'Silenced Hub',
    Status = 'Stable',
    Accent = Color3.fromRGB(251, 144, 255),
    HitBox = Color3.fromRGB(251, 144, 255),
    AutoLoad = true
})

-- 2. INITIALIZE WINDOW
local Window = syde:Init({
    Title = 'Silenced Hub',
    SubText = 'Master Edition'
})

-- 3. CREATE TABS (Defining them strictly)
local MainTab = Window:InitTab('Main')
local FarmTab = Window:InitTab('Auto Farm')
local SettingsTab = Window:InitTab('Settings')

-------------------------------------------------------------------------------
-- MAIN TAB CONTENT
-------------------------------------------------------------------------------
MainTab:Section('Server Utilities')

MainTab:Button({
    Title = "Rejoin Server",
    Description = "Reconnect to the same instance",
    CallBack = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

MainTab:Button({
    Title = "Server Hop",
    Description = "Find a new server",
    CallBack = function()
        local Servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
        for _, s in pairs(Servers) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, game.Players.LocalPlayer)
                break
            end
        end
    end
})

MainTab:Section('Player Info (Educational)')
local p = game.Players.LocalPlayer

MainTab:Button({
    Title = "Log My Stats",
    Description = "Prints your public data to F9 Console",
    CallBack = function()
        print("--- DEBUG INFO ---")
        print("Username: " .. p.Name)
        print("UserID: " .. p.UserId)
        print("Account Age: " .. p.AccountAge .. " days")
        syde:Notify({Title = "Debug", Content = "Stats printed to Console (F9)", Duration = 3})
    end
})

-------------------------------------------------------------------------------
-- FARM TAB CONTENT
-------------------------------------------------------------------------------
FarmTab:Section('Farming Options')

FarmTab:Toggle({
    Title = 'Anti-AFK Protection',
    Value = true,
    CallBack = function(v) getgenv().AntiAFK = v end
})

FarmTab:Toggle({
    Title = 'Auto Bubble',
    Value = false,
    CallBack = function(v) 
        _G.AutoBubble = v 
        task.spawn(function()
            while _G.AutoBubble do
                game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble")
                task.wait(0.1)
            end
        end)
    end
})

-------------------------------------------------------------------------------
-- SETTINGS TAB
-------------------------------------------------------------------------------
SettingsTab:Section('UI Settings')

SettingsTab:Button({
    Title = "Destroy UI",
    CallBack = function()
        game.CoreGui.SydeUI:Destroy()
    end
})

-- Anti-AFK Logic
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if getgenv().AntiAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

-- Force UI to select the first tab to fix "Black Screen" rendering
task.wait(0.5)
Window:SelectTab(1)
