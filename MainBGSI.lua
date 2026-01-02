-- [[ SILENCED BGSI MASTER SCRIPT - RAYFIELD EDITION ]] --
-- Master Version: Added Auto Playtime Rewards & Event Teleport

if not game:IsLoaded() then game.Loaded:Wait() end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Silenced Bgsi | Master Edition",
    LoadingTitle = "Silenced Hub",
    LoadingSubtitle = "by 25ms",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SilencedHub",
        FileName = "MasterConfig"
    },
    KeySystem = false
})

-- [[ GLOBAL STATES ]] --
getgenv().Config = { Webhook_enabled = false, Webhook = "", Secret_Only = true }
local AutoBubble, AutoSell, AutoCollect = false, false, false
local AutoSpamE = false
local AutoBuyGum, AutoBuyUpgrades = false, false
local AutoPlaytime = false
local AutoOpenPresents, AutoFestiveSpin = false, false 
local SellCooldown = 5
local SelectedEgg = "Common Egg"

-- [[ DATA TABLES ]] --
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
local World1Points = {Spawn = CFrame.new(58, 22, -71), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)}
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)}
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)}

-- [[ TABS ]] --
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local EventTab = Window:CreateTab("Event", 4483362458) 
local TeleportTab = Window:CreateTab("Teleports", 4483362458)
local WebhookTab = Window:CreateTab("Webhook", 4483362458)

-------------------------------------------------------------------------------
-- MAIN TAB (Added Auto Playtime)
-------------------------------------------------------------------------------
MainTab:CreateSection("Auto Rewards")
MainTab:CreateToggle({
    Name = "Auto Playtime Rewards",
    CurrentValue = false,
    Flag = "AutoPlaytime",
    Callback = function(Value)
        AutoPlaytime = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoPlaytime do
                for i = 1, 12 do -- Tries to claim all 12 potential gift slots
                    pcall(function() RF:InvokeServer("ClaimPlaytimeGift", i) end)
                end
                task.wait(30)
            end
        end)
    end,
})

MainTab:CreateSection("Auto Shop")
MainTab:CreateToggle({
    Name = "Auto Buy Gum",
    CurrentValue = false,
    Flag = "AutoGum",
    Callback = function(Value)
        AutoBuyGum = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoBuyGum do pcall(function() RF:InvokeServer("GumShopPurchaseAll") end) task.wait(2) end
        end)
    end,
})

MainTab:CreateToggle({
    Name = "Auto Buy Upgrades",
    CurrentValue = false,
    Flag = "AutoUpgrades",
    Callback = function(Value)
        AutoBuyUpgrades = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoBuyUpgrades do for i = 1, 15 do pcall(function() RF:InvokeServer("UpgradeMastery", i) end) end task.wait(5) end
        end)
    end,
})

MainTab:CreateSection("Codes")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in pairs(Codes) do pcall(function() RF:InvokeServer("RedeemCode", code) end) task.wait(0.1) end
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Farming")
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Flag = "AutoBubble",
    Callback = function(Value)
        AutoBubble = Value
        task.spawn(function()
            local RE = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            while AutoBubble do RE:FireServer("BlowBubble") task.wait(0.1) end
        end)
    end,
})

FarmTab:CreateSlider({
    Name = "Sell Cooldown",
    Range = {1, 60},
    Increment = 1,
    Suffix = "s",
    CurrentValue = 5,
    Flag = "SellSlider",
    Callback = function(Value) SellCooldown = Value end,
})

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(Value)
        AutoSell = Value
        task.spawn(function()
            local RE = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            while AutoSell do RE:FireServer("SellBubble") task.wait(SellCooldown) end
        end)
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Collect Items",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(Value)
        AutoCollect = Value
        task.spawn(function()
            local CollectRem = game:GetService("ReplicatedStorage").Remotes.Pickups.CollectPickup
            while AutoCollect do
                pcall(function()
                    local folder = workspace:FindFirstChild("Rendered")
                    if folder then
                        for _, sub in pairs(folder:GetChildren()) do
                            for _, item in pairs(sub:GetChildren()) do
                                if #item.Name >= 30 then CollectRem:FireServer(item.Name) item:Destroy() end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- EGGS TAB
-------------------------------------------------------------------------------
EggTab:CreateSection("Hatching")
EggTab:CreateToggle({
    Name = "Auto Spam E (Hold E)",
    CurrentValue = false,
    Flag = "AutoSpamE",
    Callback = function(Value)
        AutoSpamE = Value
        task.spawn(function()
            local VIM = game:GetService("VirtualInputManager")
            while AutoSpamE do
                VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(0.05)
            end
        end)
    end,
})

EggTab:CreateSection("Egg Teleports")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg","Spotted Egg","Iceshard Egg","Spikey Egg","Magma Egg","Crystal Egg","Lunar Egg","Void Egg","Hell Egg","Nightmare Egg","Rainbow Egg","Snowman Egg","Mining Egg","Cyber Egg","Neon Egg","Infinity Egg","New Years Egg"},
    CurrentOption = "Common Egg",
    Flag = "EggDrop",
    Callback = function(Option) SelectedEgg = Option end,
})

EggTab:CreateButton({
    Name = "Teleport to Selected Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then hrp.CFrame = EggPoints[SelectedEgg] + Vector3.new(0, 3, 0) end
    end,
})

-------------------------------------------------------------------------------
-- EVENT TAB (Christmas)
-------------------------------------------------------------------------------
EventTab:CreateSection("Event Teleports")
EventTab:CreateButton({
    Name = "Teleport to Christmas Island",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(78, 9, -15) end -- Approx. Christmas Island Pos
    end,
})

EventTab:CreateSection("Farming")
EventTab:CreateToggle({
    Name = "Auto Open Presents",
    CurrentValue = false,
    Flag = "AutoPresents",
    Callback = function(Value)
        AutoOpenPresents = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoOpenPresents do
                for i = 1, 3 do pcall(function() RF:InvokeServer("ClaimGift", i) end) end
                task.wait(5)
            end
        end)
    end,
})

EventTab:CreateToggle({
    Name = "Auto Festive Wheel Spin",
    CurrentValue = false,
    Flag = "AutoFestiveSpin",
    Callback = function(Value)
        AutoFestiveSpin = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoFestiveSpin do
                pcall(function() RF:InvokeServer("SpinFestiveWheel") end)
                task.wait(5)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- TELEPORTS TAB
-------------------------------------------------------------------------------
TeleportTab:CreateSection("World 1")
for name, cf in pairs(World1Points) do
    TeleportTab:CreateButton({Name = "Go to " .. name, Callback = function() 
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = cf end
    end})
end

TeleportTab:CreateSection("World 2")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({Name = "Go to " .. name, Callback = function() 
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = cf end
    end})
end

-------------------------------------------------------------------------------
-- WEBHOOK TAB
-------------------------------------------------------------------------------
WebhookTab:CreateSection("Discord Webhook")
WebhookTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "Paste Discord Link",
    Flag = "WebUrl",
    Callback = function(Text) getgenv().Config.Webhook = Text end,
})

WebhookTab:CreateToggle({
    Name = "Enable Webhook",
    CurrentValue = false,
    Flag = "WebToggle",
    Callback = function(Value) getgenv().Config.Webhook_enabled = Value end,
})

WebhookTab:CreateButton({
    Name = "Test Webhook",
    Callback = function()
        local req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        if req then
            req({
                Url = getgenv().Config.Webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({embeds={{title="Webhook Test", description="Webhook is working!"}}})
            })
        end
    end,
})

Rayfield:LoadConfiguration()
