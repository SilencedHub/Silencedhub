-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Silenced Bgsi | Rayfield Edition",
    LoadingTitle = "Silenced Hub",
    LoadingSubtitle = "by 25ms",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SilencedHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- Global Variables
getgenv().Config = { Webhook_enabled = false, Webhook = "", Secret_Only = true }
local AutoBubble, AutoSell, AutoCollect = false, false, false
local AutoSpamE = false
local AutoBuyGum, AutoBuyUpgrades = false, false
local SelectedEgg = "Common Egg"

-- Data Tables
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}

local EggPoints = {
    ["Common Egg"] = CFrame.new(-83, 9, 3),
    ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Iceshard Egg"] = CFrame.new(-118, 9, 10),
    ["Spikey Egg"] = CFrame.new(-126, 9, 6),
    ["Magma Egg"] = CFrame.new(-135, 9, 1),
    ["Crystal Egg"] = CFrame.new(-140, 9, -7),
    ["Lunar Egg"] = CFrame.new(-144, 9, -16),
    ["Void Egg"] = CFrame.new(-146, 9, -26),
    ["Hell Egg"] = CFrame.new(-145, 9, -36),
    ["Nightmare Egg"] = CFrame.new(-142, 9, -45),
    ["Rainbow Egg"] = CFrame.new(-137, 9, -54),
    ["Snowman Egg"] = CFrame.new(-130, 9, -60),
    ["Mining Egg"] = CFrame.new(-120, 9, -64),
    ["Cyber Egg"] = CFrame.new(-94, 9, -63),
    ["Neon Egg"] = CFrame.new(-83, 10, -58),
    ["Infinity Egg"] = CFrame.new(-99, 8, -27),
    ["New Years Egg"] = CFrame.new(83, 9, -13)
}

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local WebhookTab = Window:CreateTab("Webhook", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-------------------------------------------------------------------------------
-- MAIN TAB (Added Auto Buy)
-------------------------------------------------------------------------------
MainTab:CreateSection("Auto Shop")

MainTab:CreateToggle({
    Name = "Auto Buy Gum",
    CurrentValue = false,
    Flag = "AutoGum",
    Callback = function(Value)
        AutoBuyGum = Value
        task.spawn(function()
            local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
            while AutoBuyGum do
                pcall(function() RF:InvokeServer("GumShopPurchaseAll") end)
                task.wait(2)
            end
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
            while AutoBuyUpgrades do
                -- Loops through potential upgrade IDs
                for i = 1, 15 do
                    pcall(function() RF:InvokeServer("UpgradeMastery", i) end)
                end
                task.wait(5)
            end
        end)
    end,
})

MainTab:CreateSection("Codes")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local RF = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in pairs(Codes) do
            pcall(function() RF:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Codes", Content = "Redemption Complete!", Duration = 3})
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Farming")
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Callback = function(Value)
        AutoBubble = Value
        task.spawn(function()
            local RE = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            while AutoBubble do
                RE:FireServer("BlowBubble")
                task.wait(0.1)
            end
        end)
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Collect Items",
    CurrentValue = false,
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
                                if #item.Name >= 30 then 
                                    CollectRem:FireServer(item.Name)
                                    item:Destroy()
                                end
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
-- EGGS TAB (Fixed Teleports)
-------------------------------------------------------------------------------
EggTab:CreateSection("Hatching")
EggTab:CreateToggle({
    Name = "Auto Spam E (Hatch)",
    CurrentValue = false,
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

EggTab:CreateSection("Fixed Egg Teleports")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg","Spotted Egg","Iceshard Egg","Spikey Egg","Magma Egg","Crystal Egg","Lunar Egg","Void Egg","Hell Egg","Nightmare Egg","Rainbow Egg","Snowman Egg","Mining Egg","Cyber Egg","Neon Egg","Infinity Egg","New Years Egg"},
    CurrentOption = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end,
})

EggTab:CreateButton({
    Name = "Teleport to Selected Egg",
    Callback = function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and EggPoints[SelectedEgg] then
                -- Add a tiny offset so you don't get stuck inside the egg part
                hrp.CFrame = EggPoints[SelectedEgg] + Vector3.new(0, 3, 0)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- WEBHOOK TAB
-------------------------------------------------------------------------------
WebhookTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "Paste Here",
    Callback = function(Text) getgenv().Config.Webhook = Text end,
})

WebhookTab:CreateToggle({
    Name = "Enable Webhook",
    CurrentValue = false,
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
                Body = game:GetService("HttpService"):JSONEncode({embeds={{title="Webhook Test", description="Working!"}}})
            })
        end
    end,
})

Rayfield:LoadConfiguration()
