local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Silenced Bgsi | Rayfield Edition",
    LoadingTitle = "Silenced Hub",
    LoadingSubtitle = "Version: BETA",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SilencedHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- Global Configuration & State
getgenv().Config = {
    Webhook_enabled = false,
    Webhook = "",
    Ignore_AutoDeleted = true,
    Secret_Only = true
}

local AutoBubble, AutoSell, AutoCollect = false, false, false
local AutoClaimPlaytime, AutoClaimSeason = false, false
local AutoSpinTickets, AutoFestivalTickets = false, false
local AutoOpenMysteryBox = false
local AdminEggLoop = false
local SellCooldown = 5
local SelectedEgg = "Common Egg"
local SelectedDice = "Dice"
local SelectedDifficulty = "Easy"

-- Data Tables from Source
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"} [cite: 6, 7]
local World1Points = {Spawn = CFrame.new(58, 22, -71), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)} [cite: 185]
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)} [cite: 19]
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)} [cite: 27, 28]

-- Remotes
local RemoteFunc = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction [cite: 8]
local RemoteEvent = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent [cite: 92]
local CollectRemote = game:GetService("ReplicatedStorage").Remotes.Pickups:WaitForChild("CollectPickup") [cite: 92]

-------------------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------------------
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local MinigameTab = Window:CreateTab("Minigames", 16781755256) [cite: 2]
local EggTab = Window:CreateTab("Eggs", 11637882493) [cite: 3]
local ShopTab = Window:CreateTab("Auto Buy", 11807308234) [cite: 3]
local TeleportTab = Window:CreateTab("Teleports", 11715804797) [cite: 3]

-------------------------------------------------------------------------------
-- MAIN TAB
-------------------------------------------------------------------------------
MainTab:CreateSection("Executor Info")
MainTab:CreateParagraph({Title = "Notice", Content = "Depending on your executor (Xeno, Solara), not all features will work due to low UNC."}) [cite: 5]

MainTab:CreateSection("Codes")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        for _, code in pairs(Codes) do
            pcall(function() RemoteFunc:InvokeServer("RedeemCode", code) end) [cite: 8]
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Codes Redeemed", Content = "All codes have been redeemed!", Duration = 3}) [cite: 9]
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Main Farm")
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Callback = function(Value)
        AutoBubble = Value
        if Value then
            task.spawn(function()
                while AutoBubble do
                    pcall(function() RemoteEvent:FireServer("BlowBubble") end) [cite: 94]
                    task.wait(0.1)
                end
            end)
        end
    end,
})

FarmTab:CreateSlider({
    Name = "Sell Cooldown (Seconds)",
    Range = {5, 100},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(Value) SellCooldown = Value end, [cite: 96]
})

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(Value)
        AutoSell = Value
        if Value then
            task.spawn(function()
                while AutoSell do
                    pcall(function() RemoteEvent:FireServer("SellBubble") end) [cite: 97]
                    task.wait(SellCooldown)
                end
            end)
        end
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Collect Coins & Gems",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollect = Value
        if Value then
            task.spawn(function()
                while AutoCollect do
                    pcall(function()
                        local rendered = workspace:FindFirstChild("Rendered")
                        if rendered then
                            for _, folder in pairs(rendered:GetChildren()) do
                                for _, item in pairs(folder:GetChildren()) do
                                    if #item.Name >= 30 then 
                                        CollectRemote:FireServer(item.Name) [cite: 108]
                                        item:Destroy() 
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end,
})

-------------------------------------------------------------------------------
-- MINIGAMES TAB
-------------------------------------------------------------------------------
MinigameTab:CreateSection("Dice Roll")
MinigameTab:CreateDropdown({
    Name = "Select Dice",
    Options = {"Dice", "Giant Dice", "Golden Dice"},
    CurrentOption = "Dice",
    Callback = function(Option) SelectedDice = Option end, [cite: 142]
})

MinigameTab:CreateToggle({
    Name = "Auto Roll Dice",
    CurrentValue = false,
    Callback = function(Value)
        local rolling = Value
        task.spawn(function()
            while rolling do
                pcall(function() 
                    RemoteFunc:InvokeServer("RollDice", SelectedDice) [cite: 144]
                    RemoteEvent:FireServer("ClaimTile")
                end)
                task.wait(0.1)
            end
        end)
    end,
})

-------------------------------------------------------------------------------
-- EGGS TAB
-------------------------------------------------------------------------------
EggTab:CreateSection("Teleport")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg", "Spotted Egg", "Iceshard Egg", "Spikey Egg", "Magma Egg", "Crystal Egg", "Lunar Egg", "Void Egg", "Hell Egg", "Nightmare Egg", "Rainbow Egg", "Snowman Egg", "Mining Egg", "Cyber Egg", "Neon Egg", "Infinity Egg", "New Years Egg"},
    CurrentOption = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end, [cite: 31]
})

EggTab:CreateButton({
    Name = "Teleport to Selected Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then hrp.CFrame = EggPoints[SelectedEgg] end [cite: 33]
    end,
})

EggTab:CreateSection("Admin Abuse Egg")
EggTab:CreateToggle({
    Name = "Wait for Admin Abuse Egg",
    CurrentValue = false,
    Callback = function(Value)
        AdminEggLoop = Value
        task.spawn(function()
            local originalPos = nil
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            while AdminEggLoop do
                pcall(function()
                    local egg = workspace.Rendered:GetChildren()[13]:FindFirstChild("Super Silly Egg") [cite: 37]
                    if egg then
                        if not originalPos then originalPos = hrp.CFrame end
                        hrp.CFrame = CFrame.new(130, 8, 96) [cite: 37]
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
TeleportTab:CreateSection("World 1")
for name, cf in pairs(World1Points) do
    TeleportTab:CreateButton({
        Name = "Go to " .. name,
        Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf end [cite: 188]
    })
end

TeleportTab:CreateSection("World 2")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({
        Name = "Go to " .. name,
        Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf end [cite: 23]
    })
end

Rayfield:LoadConfiguration()
