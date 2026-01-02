local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDZ3112/RedzLibV2/main/Source.lua"))()

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

local function SendHatchWebhook(petName, petStats, rarityType)
    local player = game.Players.LocalPlayer
    local stats = player.leaderstats
    local rarityColors = {
        ["Secret"] = 16768256, -- Gold
        ["Mythic"] = 16729856, -- Orange
        ["Shiny"] = 58879,     -- Cyan
        ["Shiny Mythic"] = 16711935 -- Magenta
    }

    local data = {
        ["content"] = "@everyone **" .. rarityType:upper() .. " HATCHED!**",
        ["embeds"] = {{
            ["title"] = "||" .. player.Name .. "|| hatched a " .. petName,
            ["color"] = rarityColors[rarityType] or 16777215,
            ["fields"] = {
                {["name"] = "User Info:", ["value"] = "🧼 **Bubbles:** " .. stats.Bubbles.Value .. "\n💰 **Coins:** " .. stats.Coins.Value .. "\n💎 **Gems:** " .. stats.Gems.Value, ["inline"] = false},
                {["name"] = "Pet Info (" .. rarityType .. "):", ["value"] = petStats, ["inline"] = false}
            },
            ["footer"] = {["text"] = "Silenced BGSI • Stable Redz"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({Url = WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(data)})
    end
end

-- [[ WINDOW ]] --
local Window = RedzLib:MakeWindow({
  Name = "SILENCED BGSI",
  Info = "Bubble Gum Simulator",
  Color = Color3.fromRGB(0, 255, 150)
})

-- [[ TABS ]] --
local MainTab = Window:MakeTab("Main", "home")
local HunterTab = Window:MakeTab("Hunter", "search")
local EggTab = Window:MakeTab("Eggs", "egg")

-- [[ MAIN TAB ]] --
MainTab:AddSection("Automation")

MainTab:AddToggle({
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

-- [[ HUNTER TAB ]] --
HunterTab:AddSection("Webhook Settings")

HunterTab:AddToggle({
  Name = "Ping for Secret",
  Default = true,
  Callback = function(v) getgenv().PingSecret = v end
})

HunterTab:AddButton({
  Name = "Test Webhook",
  Callback = function()
    SendHatchWebhook("Test Pet", "🔥 **Multi:** x500", "Secret")
  end
})

-- [[ EGG & WORLD TAB ]] --
EggTab:AddSection("Hatch Tools")

EggTab:AddToggle({
  Name = "Auto Spam E",
  Default = false,
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
  end
})

EggTab:AddSection("Teleports")

local SelectedTP = "Common Egg"
EggTab:AddDropdown({
  Name = "Select Location",
  Options = {"Common Egg", "Void Egg", "Hell Egg", "Overworld", "Toy World"},
  Default = "Common Egg",
  Callback = function(v) SelectedTP = v end
})

EggTab:AddButton({
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
  end
})

-- [[ DETECTION ]] --
game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent.OnClientEvent:Connect(function(name, data)
    if name == "OpenEgg" and data then
        local rarity = data.Rarity or "Unknown"
        local statsStr = "🔥 **Multiplier:** x" .. (data.Multiplier or "1") .. "\n⚡ **Speed:** " .. (data.Speed or "1")
        
        if rarity == "Secret" and getgenv().PingSecret then
            SendHatchWebhook(data.PetName, statsStr, "Secret")
        end
    end
end)
