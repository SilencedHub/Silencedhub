-- [[ SILENCED BGSI - MacLib STABLE ]] --

local MacLib = nil
local success, err = pcall(function()
    return loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
end)

-- Retry loop for Potassium stability
local retries = 0
while (not success or not MacLib) and retries < 15 do
    task.wait(0.5)
    retries = retries + 1
    success, MacLib = pcall(function()
        return loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
    end)
end

if not MacLib then return warn("Maclib failed to load.") end

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

local function SendHatchWebhook(petName, petStats, rarityType)
    local player = game.Players.LocalPlayer
    local stats = player.leaderstats
    local rarityColors = {
        ["Secret"] = 0xFFD700, ["Mythic"] = 0xFF4500, 
        ["Shiny"] = 0x00E5FF, ["Shiny Mythic"] = 0xFF00FF
    }

    local data = {
        ["content"] = "@everyone **" .. rarityType:upper() .. " HATCHED!**",
        ["embeds"] = {{
            ["title"] = "||" .. player.Name .. "|| hatched a " .. petName,
            ["color"] = rarityColors[rarityType] or 0xFFFFFF,
            ["fields"] = {
                {["name"] = "User Info:", ["value"] = "🧼 **Bubbles:** " .. stats.Bubbles.Value .. "\n💰 **Coins:** " .. stats.Coins.Value .. "\n💎 **Gems:** " .. stats.Gems.Value, ["inline"] = false},
                {["name"] = "Pet Info (" .. rarityType .. "):", ["value"] = petStats, ["inline"] = false}
            },
            ["footer"] = {["text"] = "Silenced BGSI • by discord.gg/eaAKTc64s"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({Url = WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(data)})
    end
end

-- [[ WINDOW CREATION ]] --
local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(550, 420),
    DragStyle = 1
})

-- [[ TABS ]] --
local MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
local HunterTab = Window:Tab({ Name = "Webhook Hunter", Image = "rbxassetid://10709819149" })

-- [[ MAIN TAB CONTENT ]] --
local SettingsGroup = MainTab:Groupbox({ Name = "Farming Settings", Side = "Left" })

SettingsGroup:Toggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(Value)
        getgenv().HideHatch = Value
        task.spawn(function()
            while getgenv().HideHatch do
                local pGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                local ui = pGui and (pGui:FindFirstChild("HatchUI") or pGui:FindFirstChild("EggHatch"))
                if ui then ui.Enabled = false end
                task.wait(0.1)
            end
        end)
    end
})

SettingsGroup:Button({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
    end
})

-- [[ HUNTER TAB CONTENT ]] --
local PingGroup = HunterTab:Groupbox({ Name = "Ping Rarity", Side = "Left" })

PingGroup:Toggle({ Name = "Ping for Secret", Default = true, Callback = function(v) getgenv().PingSecret = v end })
PingGroup:Toggle({ Name = "Ping for Mythic", Default = false, Callback = function(v) getgenv().PingMythic = v end })
PingGroup:Toggle({ Name = "Ping for Shiny", Default = false, Callback = function(v) getgenv().PingShiny = v end })

local TestGroup = HunterTab:Groupbox({ Name = "Testing", Side = "Right" })
TestGroup:Button({
    Name = "Test Shiny Mythic Webhook",
    Callback = function()
        SendHatchWebhook("Shiny Mythic Leviathan", "🔥 **Multi:** x2.5M\n⚡ **Speed:** 100", "Shiny Mythic")
    end
})

-- [[ GAME DETECTION ]] --
game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent.OnClientEvent:Connect(function(name, data)
    if name == "OpenEgg" and data then
        local isShiny = data.Shiny or false
        local isMythic = data.Mythic or false
        local rarity = data.Rarity or "Unknown"
        local statsStr = "🔥 **Multiplier:** x" .. (data.Multiplier or "1") .. "\n⚡ **Speed:** " .. (data.Speed or "1")
        
        if rarity == "Secret" and getgenv().PingSecret then
            SendHatchWebhook(data.PetName, statsStr, "Secret")
        elseif isShiny and isMythic then
            SendHatchWebhook("Shiny Mythic " .. data.PetName, statsStr, "Shiny Mythic")
        elseif isMythic and getgenv().PingMythic then
            SendHatchWebhook("Mythic " .. data.PetName, statsStr, "Mythic")
        elseif isShiny and getgenv().PingShiny then
            SendHatchWebhook("Shiny " .. data.PetName, statsStr, "Shiny")
        end
    end
end)
