-- Wait for game to load to prevent "Infinite Yield" errors
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
getgenv().Config = { Webhook_enabled = false, Webhook = "", Ignore_AutoDeleted = true, Secret_Only = true }
local AutoBubble, AutoSell, AutoCollect = false, false, false
local AdminEggLoop = false
local SellCooldown = 5
local SelectedEgg = "Common Egg"

-- Data Tables
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
local World1Points = {Spawn = CFrame.new(58, 22, -71), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)}
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)}
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)}

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-------------------------------------------------------------------------------
-- LOGIC FUNCTIONS (wrapped in pcalls to prevent crashes)
-------------------------------------------------------------------------------
local function GetRemotes()
    return pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        local Net = RS:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote")
        return Net:WaitForChild("RemoteEvent"), Net:WaitForChild("RemoteFunction"), RS:WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup")
    end)
end

-------------------------------------------------------------------------------
-- UI ELEMENTS
-------------------------------------------------------------------------------
MainTab:CreateSection("Redeemers")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local success, Event, Func = GetRemotes()
        if success then
            for _, code in pairs(Codes) do
                task.spawn(function() Func:InvokeServer("RedeemCode", code) end)
                task.wait(0.1)
            end
            Rayfield:Notify({Title = "Success", Content = "Codes Redeemed", Duration = 3})
        end
    end,
})

FarmTab:CreateSection("Bubble Farming")
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
    Flag = "BubbleToggle",
    Callback = function(Value)
        AutoBubble = Value
        task.spawn(function()
            local success, Event = GetRemotes()
            while AutoBubble and success do
                Event:FireServer("BlowBubble")
                task.wait(0.1)
            end
        end)
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "SellToggle",
    Callback = function(Value)
        AutoSell = Value
        task.spawn(function()
            local success, Event = GetRemotes()
            while AutoSell and success do
                Event:FireServer("SellBubble")
                task.wait(SellCooldown)
            end
        end)
    end,
})

FarmTab:CreateSection("Collection")
FarmTab:CreateToggle({
    Name = "Auto Collect Coins/Gems",
    CurrentValue = false,
    Flag = "CollectToggle",
    Callback = function(Value)
        AutoCollect = Value
        task.spawn(function()
            local success, _, _, CollectRem = GetRemotes()
            while AutoCollect do
                pcall(function()
                    local rendered = workspace:FindFirstChild("Rendered")
                    if rendered then
                        for _, folder in pairs(rendered:GetChildren()) do
                            for _, item in pairs(folder:GetChildren()) do
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

EggTab:CreateSection("Egg Management")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg","Spotted Egg","Iceshard Egg","Spikey Egg","Magma Egg","Crystal Egg","Lunar Egg","Void Egg","Hell Egg","Nightmare Egg","Rainbow Egg","Snowman Egg","Mining Egg","Cyber Egg","Neon Egg","Infinity Egg","New Years Egg"},
    CurrentOption = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end,
})

EggTab:CreateButton({
    Name = "Teleport to Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then hrp.CFrame = EggPoints[SelectedEgg] end
    end,
})

TeleportTab:CreateSection("World 1")
for name, cf in pairs(World1Points) do
    TeleportTab:CreateButton({Name = name, Callback = function() 
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = cf end 
    end})
end

TeleportTab:CreateSection("World 2")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({Name = name, Callback = function() 
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = cf end 
    end})
end

Rayfield:LoadConfiguration()
