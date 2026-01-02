-- [[ SILENCED BGSI - RAYFIELD ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

local function SendHatchWebhook(petName, petStats, rarityType)
    local player = game.Players.LocalPlayer
    local stats = player.leaderstats
    local rarityColors = {
        ["Secret"] = 16768256,      -- Gold
        ["Mythic"] = 16729856,      -- Orange
        ["Shiny"] = 58879,         -- Cyan
        ["Shiny Mythic"] = 16711935 -- Magenta
    }

    local data = {
        ["content"] = "@everyone **" .. rarityType:upper() .. " HATCHED!**",
        ["embeds"] = {{
            ["title"] = "||" .. player.Name .. "|| hatched a " .. petName,
            ["color"] = rarityColors[rarityType] or 16777215,
            ["fields"] = {
                {["name"] = "User Info:", ["value"] = "🧼 **Bubbles:** " .. stats.Bubbles.Value .. "\n💰 **Coins:** " .. stats.Coins.Value, ["inline"] = false},
                {["name"] = "Pet Info (" .. rarityType .. "):", ["value"] = petStats, ["inline"] = false}
            },
            ["footer"] = {["text"] = "Silenced BGSI • Rayfield Stable"},
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
local Window = Rayfield:CreateWindow({
   Name = "SILENCED BGSI",
   LoadingTitle = "Rayfield Booting...",
   LoadingSubtitle = "by Silenced",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- [[ TABS ]] --
local MainTab = Window:CreateTab("Main", 4483362458) 
local HunterTab = Window:CreateTab("Hunter", 4483362458)
local EggTab = Window:CreateTab("Eggs & Worlds", 4483362458)

-- [[ MAIN TAB ]] --
MainTab:CreateSection("Automation")

MainTab:CreateToggle({
   Name = "Hide Hatch Animation",
   CurrentValue = false,
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
   end,
})

-- [[ HUNTER TAB ]] --
HunterTab:CreateSection("Webhook Pings")

HunterTab:CreateToggle({
   Name = "Ping for Secret",
   CurrentValue = true,
   Callback = function(Value) getgenv().PingSecret = Value end,
})

HunterTab:CreateToggle({
   Name = "Ping for Mythic",
   CurrentValue = false,
   Callback = function(Value) getgenv().PingMythic = Value end,
})

HunterTab:CreateToggle({
   Name = "Ping for Shiny",
   CurrentValue = false,
   Callback = function(Value) getgenv().PingShiny = v end,
})

-- [[ EGGS & WORLDS TAB ]] --
EggTab:CreateSection("Hatching Tools")

EggTab:CreateToggle({
   Name = "Auto Spam E",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().SpamE = Value
      task.spawn(function()
         local VIM = game:GetService("VirtualInputManager")
         while getgenv().SpamE do
            VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.01)
            VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            task.wait(0.01)
         end
      end)
   end,
})

EggTab:CreateSection("Teleports")

local SelectedTP = "Common Egg"
EggTab:CreateDropdown({
   Name = "Select Location",
   Options = {"Common Egg", "Void Egg", "Hell Egg", "Overworld", "Toy World"},
   CurrentOption = {"Common Egg"},
   MultipleOptions = false,
   Callback = function(Option) SelectedTP = Option[1] end,
})

EggTab:CreateButton({
   Name = "Teleport",
   Callback = function()
      local coords = {
         ["Common Egg"] = CFrame.new(-83, 9, 3),
         ["Void Egg"] = CFrame.new(-146, 9, -26),
         ["Hell Egg"] = CFrame.new(-145, 9, -36),
         ["Overworld"] = CFrame.new(-33, 9, 2),
         ["Toy World"] = CFrame.new(623, 15, 11)
      }
      local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if hrp and coords[SelectedTP] then hrp.CFrame = coords[SelectedTP] end
   end,
})

-- [[ DETECTION ENGINE ]] --
game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent.OnClientEvent:Connect(function(name, data)
    if name == "OpenEgg" and data then
        local isShiny = data.Shiny or false
        local isMythic = data.Mythic or false
        local rarity = data.Rarity or "Unknown"
        local statsStr = "🔥 **Multiplier:** x" .. (data.Multiplier or "1")
        
        -- Logic for filtering pings
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
