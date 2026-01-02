local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Silenced Bgsi | Rayfield Edition",
    LoadingTitle = "Silenced Hub",
    LoadingSubtitle = "by 25ms",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SilencedHub",
        FileName = "SilencedConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "25ms",
        RememberJoins = true
    },
    KeySystem = false
})

-- State Variables
local AutoBubble = false
local AutoSell = false
local AutoCollect = false
local SellCooldown = 5
local FastHatch = false
local AdminEggLoop = false
local SelectedEgg = "Common Egg"

-- Data Tables
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}

local World1Points = {Spawn = CFrame.new(58, 22, -71), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)}
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)}
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)}

-------------------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------------------
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-------------------------------------------------------------------------------
-- MAIN TAB
-------------------------------------------------------------------------------
MainTab:CreateSection("Code Redeemer")

MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local Remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in pairs(Codes) do
            pcall(function() Remote:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Codes", Content = "Finished redeeming all codes!", Duration = 5})
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Bubble Farming")

FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Flag = "AutoBubbleToggle",
    Callback = function(Value)
        AutoBubble = Value
        task.spawn(function()
            while AutoBubble do
                game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble")
                task.wait(0.1)
            end
        end)
    end,
})

FarmTab:CreateSlider({
    Name = "Sell Cooldown",
    Range = {5, 60},
    Increment = 1,
    Suffix = "s",
    CurrentValue = 5,
    Flag = "SellCooldownSlider",
    Callback = function(Value)
        SellCooldown = Value
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "AutoSellToggle",
    Callback = function(Value)
        AutoSell = Value
        task.spawn(function()
            while AutoSell do
                game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble")
                task.wait(SellCooldown)
            end
        end)
    end,
})

FarmTab:CreateSection("Collection")

FarmTab:CreateToggle({
    Name = "Auto Collect Coins/Gems",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        AutoCollect = Value
        task.spawn(function()
            local CollectRemote = game:GetService("ReplicatedStorage").Remotes.Pickups.CollectPickup
            while AutoCollect do
                pcall(function()
                    local rendered = workspace:FindFirstChild("Rendered")
                    if rendered then
                        for _, folder in pairs(rendered:GetChildren()) do
                            for _, item in pairs(folder:GetChildren()) do
                                if #item.Name >= 30 then
                                    CollectRemote:FireServer(item.Name)
                                    item:Destroy()
                                end
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- EGGS TAB
-------------------------------------------------------------------------------
EggTab:CreateSection("Egg Hatching")

EggTab:CreateDropdown({
    Name = "Select Egg for Teleport",
    Options = {"Common Egg","Spotted Egg","Iceshard Egg","Spikey Egg","Magma Egg","Crystal Egg","Lunar Egg","Void Egg","Hell Egg","Nightmare Egg","Rainbow Egg","Snowman Egg","Mining Egg","Cyber Egg","Neon Egg","Infinity Egg","New Years Egg"},
    CurrentOption = "Common Egg",
    Flag = "EggSelector",
    Callback = function(Option)
        SelectedEgg = Option
    end,
})

EggTab:CreateButton({
    Name = "Teleport to Selected Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then
            hrp.CFrame = EggPoints[SelectedEgg]
        end
    end,
})

EggTab:CreateSection("Admin Egg Loop")

EggTab:CreateToggle({
    Name = "Wait for Admin Egg",
    CurrentValue = false,
    Flag = "AdminEggToggle",
    Callback = function(Value)
        AdminEggLoop = Value
        task.spawn(function()
            local originalPos = nil
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            while AdminEggLoop do
                pcall(function()
                    local egg = workspace.Rendered:GetChildren()[13]:FindFirstChild("Super Silly Egg")
                    if egg then
                        if not originalPos then originalPos = hrp.CFrame end
                        hrp.CFrame = CFrame.new(130, 8, 96)
                    elseif originalPos then
                        hrp.CFrame = originalPos
                        originalPos = nil
                    end
                end)
                task.wait(1)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- TELEPORTS TAB
-------------------------------------------------------------------------------
TeleportTab:CreateSection("World 1 Locations")
for name, cf in pairs(World1Points) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. name,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
        end,
    })
end

TeleportTab:CreateSection("World 2 Locations")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. name,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
        end,
    })
end

-- Load Configuration at the end
Rayfield:LoadConfiguration()
