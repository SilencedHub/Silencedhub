-- [[ SILENCED BGSI - MACLIB STABLE ]] --

local Maclib = nil
local LibURL = "https://raw.githubusercontent.com/x2Swiftz/UI-Library/refs/heads/main/Libraries/Maclib%20-%20Library.lua"

-- POWERFUL LOADER: Prevents the "nil" error from your screenshot
for i = 1, 15 do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(LibURL))()
    end)
    if success and type(result) == "table" then
        Maclib = result
        break
    end
    task.wait(1) -- Wait 1 second between retries
end

if not Maclib then
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Loading Error",
        Text = "Executor failed to fetch the UI. Please restart and try again.",
        Duration = 10
    })
end

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

local function SendHatchWebhook(petName, petStats, isTest)
    local player = game.Players.LocalPlayer
    local stats = player.leaderstats
    
    local data = {
        ["content"] = isTest and "Webhook Test" or "@everyone **SECRET HATCHED!**",
        ["embeds"] = {{
            ["title"] = "||" .. player.Name .. "|| hatched a " .. petName,
            ["color"] = isTest and 0x3498db or 0xFFD700,
            ["fields"] = {
                {
                    ["name"] = "User Info:",
                    ["value"] = "🧼 **Current Bubbles:** " .. stats.Bubbles.Value .. 
                               "\n💰 **Coins:** " .. stats.Coins.Value .. 
                               "\n💎 **Gems:** " .. stats.Gems.Value,
                    ["inline"] = false
                },
                {
                    ["name"] = "Pet Info:",
                    ["value"] = petStats,
                    ["inline"] = false
                }
            },
            ["footer"] = {["text"] = "Silenced BGSI • by discord.gg/eaAKTc64s"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end
end

-- [[ WINDOW ]] --
local Window = Maclib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(550, 350),
    DragStyle = 1
})

-- [[ TABS ]] --
local Tabs = {
    Main = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" }),
    Farm = Window:Tab({ Name = "Auto Farm", Image = "rbxassetid://10709819149" })
}

-- [[ MAIN TAB ]] --
local MainGroup = Tabs.Main:Section({ Name = "Webhook Tools" })

MainGroup:Button({
    Name = "Send Test Webhook",
    Callback = function()
        if WebhookURL ~= "YOUR_WEBHOOK_URL_HERE" then
            SendHatchWebhook("Secret Santa's Hat", "❄️ **Snowflakes:** +140\n💎 **Gems:** +130\n🧼 **Bubbles:** +7.8K", true)
        else
            Maclib:Notify({Title = "Error", Content = "Paste your Webhook URL into the script first!"})
        end
    end
})

-- [[ FARM TAB ]] --
local FarmGroup = Tabs.Farm:Section({ Name = "Settings" })

FarmGroup:Toggle({
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

FarmGroup:Toggle({
    Name = "Auto Secret Webhook",
    Default = false,
    Callback = function(Value) getgenv().SecretWebhook = Value end
})

-- AUTO-DETECTION: Sends webhook on real secret hatch
game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent.OnClientEvent:Connect(function(name, data)
    if getgenv().SecretWebhook and name == "OpenEgg" and data.Rarity == "Secret" then
        local statsStr = "🔥 **Multiplier:** x" .. (data.Multiplier or "1") .. "\n⚡ **Speed:** " .. (data.Speed or "1")
        SendHatchWebhook(data.PetName, statsStr, false)
    end
end)
