-- [[ SILENCED BGSI - FULL VERSION ]] --

local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

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

-- [[ TELEPORT DATA ]] --
local EggData = {
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36)
}
local WorldData = {
    ["Overworld"] = CFrame.new(-33, 9, 2), ["Toy World"] = CFrame.new(623, 15, 11),
    ["Candy World"] = CFrame.new(1234, 15, 20), ["Beach World"] = CFrame.new(2500, 15, 10)
}

-- [[ WINDOW ]] --
local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(580, 450),
    DragStyle = 1
})

task.wait(0.2) -- Render Fix

-- [[ TABS ]] --
local MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
local HunterTab = Window:Tab({ Name = "Hunter", Image = "rbxassetid://10709819149" })
local TeleportTab = Window:Tab({ Name = "Teleports", Image = "rbxassetid://10709761066" })

-- [[ MAIN TAB ]] --
local SettingsGroup = MainTab:Groupbox({ Name = "Farming Settings", Side = "Left" })
SettingsGroup:Toggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(v) getgenv().HideHatch = v end
})
SettingsGroup:Button({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.05)
        end
    end
})

-- [[ HUNTER TAB ]] --
local PingGroup = HunterTab:Groupbox({ Name = "Ping Rarity", Side = "Left" })
PingGroup:Toggle({ Name = "Ping for Secret", Default = true, Callback = function(v) getgenv().PingSecret = v end })
PingGroup:Toggle({ Name = "Ping for Mythic", Default = false, Callback = function(v) getgenv().PingMythic = v end })
PingGroup:Toggle({ Name = "Ping for Shiny", Default = false, Callback = function(v) getgenv().PingShiny = v end })

local TestGroup = HunterTab:Groupbox({ Name = "Testing", Side = "Right" })
TestGroup:Button({
    Name = "Test Webhook",
    Callback = function() SendHatchWebhook("Test Leviathan", "🔥 **Multi:** x2M", "Shiny Mythic") end
})

-- [[ TELEPORT TAB ]] --
local EggGroup = TeleportTab:Groupbox({ Name = "Egg Teleports", Side = "Left" })
local SelectedEgg = "Common Egg"

EggGroup:Dropdown({
    Name = "Select Egg",
    Items = {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"},
    Default = "Common Egg",
    Callback = function(v) SelectedEgg = v end
})

EggGroup:Button({
    Name = "TP to Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggData[SelectedEgg] then hrp.CFrame = EggData[SelectedEgg] end
    end
})

local WorldGroup = TeleportTab:Groupbox({ Name = "World Teleports", Side = "Right" })
local SelectedWorld = "Overworld"

WorldGroup:Dropdown({
    Name = "Select World",
    Items = {"Overworld", "Toy World", "Candy World", "Beach World"},
    Default = "Overworld",
    Callback = function(v) SelectedWorld = v end
})

WorldGroup:Button({
    Name = "TP to World",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and WorldData[SelectedWorld] then hrp.CFrame = WorldData[SelectedWorld] end
    end
})

-- [[ AUTO DETECTION ]] --
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
