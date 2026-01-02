local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/vozoid/source.lua"))()

local Window = Library:Load{
    Name = "SILENCED BGSI",
    SizeX = 500,
    SizeY = 550,
    Theme = "Midnight",
    Folder = "SilencedBGS"
}

local MainTab = Window:Tab("Main")
local FarmTab = Window:Tab("Auto Farm")
local EggTab = Window:Tab("Eggs")

-- MAIN TAB
local MainSec = MainTab:Section{ Name = "Rewards", Side = "Left" }
MainSec:Button{
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
    end
}

-- AUTO FARM TAB
local FarmSec = FarmTab:Section{ Name = "Farming", Side = "Left" }
local SellWait = 5

FarmSec:Toggle({
    Name = "Auto Blow Bubbles",
    Callback = function(v)
        getgenv().AutoBlow = v
        task.spawn(function()
            while getgenv().AutoBlow do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble") end)
                task.wait(0.1)
            end
        end)
    end
})

FarmSec:Slider({
    Name = "Sell Interval",
    Min = 5, Max = 100, Default = 5,
    Callback = function(v) SellWait = v end
})

FarmSec:Toggle({
    Name = "Auto Sell",
    Callback = function(v)
        getgenv().AutoSell = v
        task.spawn(function()
            while getgenv().AutoSell do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble") end)
                task.wait(SellWait)
            end
        end)
    end
})

-- EGG TAB
local EggSec = EggTab:Section{ Name = "Teleports", Side = "Left" }
local SelectedEgg = "Common Egg"
local EggList = {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"} -- Example list

EggSec:Dropdown({
    Name = "Select Egg",
    Content = EggList,
    Callback = function(v) SelectedEgg = v end
})

EggSec:Button({
    Name = "Teleport",
    Callback = function() print("Teleporting to " .. SelectedEgg) end
})
