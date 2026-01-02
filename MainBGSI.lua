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
    Discord = {
        Enabled = false,
        Invite = "25ms",
        RememberJoins = true
    },
    KeySystem = false
})

-- Global Variables & State
getgenv().Config = { Webhook_enabled = false, Webhook = "", Ignore_AutoDeleted = true, Secret_Only = true }
local AutoBubble, AutoSell, AutoCollect, FastHatch = false, false, false, false
local AdminEggLoop = false
local AdminEggCFrame = nil
local SelectedEgg = "Common Egg"

-- Data Tables
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
local World1Points = {Spawn = CFrame.new(58, 9, -103), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)}
local World2Points = {Spawn = CFrame.new(9981, 26, 172), ["Dice Island"] = CFrame.new(9900, 2907, 208), ["Minecart Forest"] = CFrame.new(9882, 7681, 203), ["Robot Factory"] = CFrame.new(9887, 13408, 227), ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)}
local EggPoints = {["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6), ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7), ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45), ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60), ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63), ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27), ["New Years Egg"] = CFrame.new(83, 9, -13)}

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-------------------------------------------------------------------------------
-- MAIN TAB
-------------------------------------------------------------------------------
MainTab:CreateSection("Executor Info")
MainTab:CreateParagraph({Title = "Notice", Content = "Some features may not work on low-UNC executors like Xeno or Solara."})

MainTab:CreateSection("Codes")
MainTab:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local Remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in pairs(Codes) do
            pcall(function() Remote:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Codes", Content = "All codes redeemed!", Duration = 3})
    end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateToggle({
    Name = "Auto Bubble",
    CurrentValue = false,
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

FarmTab:CreateToggle({
    Name = "Auto Collect Pickups",
    CurrentValue = false,
    Callback = function(Value)
        AutoCollect = Value
        task.spawn(function()
            local Remote = game:GetService("ReplicatedStorage").Remotes.Pickups.CollectPickup
            while AutoCollect do
                pcall(function()
                    local folder = workspace:FindFirstChild("Rendered")
                    if folder then
                        for _, sub in pairs(folder:GetChildren()) do
                            for _, item in pairs(sub:GetChildren()) do
                                if #item.Name >= 30 then Remote:FireServer(item.Name) item:Destroy() end
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
EggTab:CreateSection("Teleports")
EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {"Common Egg","Spotted Egg","Iceshard Egg","Spikey Egg","Magma Egg","Crystal Egg","Lunar Egg","Void Egg","Hell Egg","Nightmare Egg","Rainbow Egg","Snowman Egg","Mining Egg","Cyber Egg","Neon Egg","Infinity Egg","New Years Egg"},
    CurrentOption = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end,
})

EggTab:CreateButton({
    Name = "Teleport to Selected Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggPoints[SelectedEgg] then hrp.CFrame = EggPoints[SelectedEgg] end
    end,
})

EggTab:CreateSection("Admin Abuse Egg")
EggTab:CreateToggle({
    Name = "Wait for Admin Egg",
    CurrentValue = false,
    Callback = function(Value)
        AdminEggLoop = Value
        task.spawn(function()
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            while AdminEggLoop do
                pcall(function()
                    local egg = workspace.Rendered:GetChildren()[13]:FindFirstChild("Super Silly Egg")
                    if egg then
                        if not AdminEggCFrame then AdminEggCFrame = hrp.CFrame end
                        hrp.CFrame = CFrame.new(130, 8, 96)
                    elseif AdminEggCFrame then
                        hrp.CFrame = AdminEggCFrame
                        AdminEggCFrame = nil
                    end
                end)
                task.wait(1)
            end
        end)
    end,
})

EggTab:CreateSection("Webhooks")
EggTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "Paste Discord Webhook Here",
    Callback = function(Text) getgenv().Config.Webhook = Text end,
})

-------------------------------------------------------------------------------
-- TELEPORTS TAB
-------------------------------------------------------------------------------
TeleportTab:CreateSection("World 1")
for name, cf in pairs(World1Points) do
    TeleportTab:CreateButton({Name = name, Callback = function() 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf 
    end})
end

TeleportTab:CreateSection("World 2")
for name, cf in pairs(World2Points) do
    TeleportTab:CreateButton({Name = name, Callback = function() 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf 
    end})
end

Rayfield:LoadConfiguration()
