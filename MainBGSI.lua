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
    KeySystem = false
})

-- Global State & Configuration
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

-- Core Data Tables from Source
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"} [cite: 194, 195, 196]

local World1Points = {Spawn = CFrame.new(58, 22, -71), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)} [cite: 198, 199, 374]
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)} [cite: 207, 208]
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)} [cite: 216, 217]

-- Safety Check: ReplicatedStorage Remotes
local RemoteFunc = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction") [cite: 196, 332]
local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent") [cite: 281, 333]
local CollectRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup") [cite: 281, 297]

-------------------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------------------
local MainTab = Window:CreateTab("Main", 79927907097265) [cite: 191]
local FarmTab = Window:CreateTab("Auto Farm", 134753546344234) [cite: 191]
local EggTab = Window:CreateTab("Eggs", 11637882493) [cite: 192]
local TeleportTab = Window:CreateTab("Teleports", 11715804797) [cite: 192]

-------------------------------------------------------------------------------
-- MAIN TAB
-------------------------------------------------------------------------------
MainTab:CreateSection("Redeemers")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        for _, code in pairs(Codes) do
            pcall(function() RemoteFunc:InvokeServer("RedeemCode", code) end) [cite: 197]
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Success", Content = "All codes redeemed!", Duration = 3}) [cite: 198]
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Bubble Farm")
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Callback = function(Value)
        AutoBubble = Value
        task.spawn(function()
            while AutoBubble do
                pcall(function() RemoteEvent:FireServer("BlowBubble") end) [cite: 283]
                task.wait(0.1)
            end
        end)
    end,
})

FarmTab:CreateSlider({
    Name = "Sell Cooldown",
    Range = {5, 100},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(Value) SellCooldown = Value end, [cite: 285]
})

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(Value)
        AutoSell = Value
        task.spawn(function()
            while AutoSell do
                pcall(function() RemoteEvent:FireServer("SellBubble") end) [cite: 286]
                task.wait(SellCooldown)
            end
        end)
    end,
})

FarmTab:CreateSection("Collection")
FarmTab:CreateToggle({
    Name = "Auto Collect Coins/Gems",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollect = Value
        task.spawn(function()
            while AutoCollect do
                pcall(function()
                    local rendered = workspace:FindFirstChild("Rendered")
                    if rendered then
                        for _, folder in pairs(rendered:GetChildren()) do
                            for _, item in pairs(folder:GetChildren()) do
                                if #item.Name >= 30 then 
                                    CollectRemote:FireServer(item.Name) [cite: 297]
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
EggTab:CreateSection("Teleport")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg", "Spotted Egg", "Iceshard Egg", "Spikey Egg", "Magma Egg", "Crystal Egg", "Lunar Egg", "Void Egg", "Hell Egg", "Nightmare Egg", "Rainbow Egg", "Snowman Egg", "Mining Egg", "Cyber Egg", "Neon Egg", "Infinity Egg", "New Years Egg"},
    CurrentOption = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end, [cite: 218, 219]
})

EggTab:CreateButton({
    Name = "Teleport to Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then 
            hrp.CFrame = EggPoints[SelectedEgg] [cite: 222]
        end
    end,
})

EggTab:CreateSection("Admin Egg")
EggTab:CreateToggle({
    Name = "Wait for Admin Abuse Egg",
    CurrentValue = false,
    Callback = function(Value)
        AdminEggLoop = Value
        task.spawn(function()
            local originalPos = nil
            while AdminEggLoop do
                pcall(function()
                    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local egg = workspace.Rendered:GetChildren()[13]:FindFirstChild("Super Silly Egg")
                    if egg and hrp then
                        if not originalPos then originalPos = hrp.CFrame end
                        hrp.CFrame = CFrame.new(130, 8, 96) [cite: 226]
                    elseif originalPos and hrp then
                        hrp.CFrame = originalPos [cite: 226]
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
        Callback = function() 
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = cf end [cite: 377]
        end
    })
end

TeleportTab:CreateSection("World 2")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({
        Name = "Go to " .. name,
        Callback = function() 
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = cf end [cite: 211]
        end
    })
end

Rayfield:LoadConfiguration()
