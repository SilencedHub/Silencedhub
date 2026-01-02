
local Library = nil


local function LoadUI()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/vozoid/source.lua"))()
    end)
    if success then Library = result end
end


local retries = 0
repeat
    LoadUI()
    if not Library then 
        retries = retries + 1
        task.wait(1) 
    end
until Library or retries > 5

if not Library then
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LOAD ERROR",
        Text = "Potassium blocked the UI download. Try a VPN or restart.",
        Duration = 10
    })
end


local Window = Library:Load{
    Name = "SILENCED BGSI",
    SizeX = 500,
    SizeY = 550,
    Theme = "Midnight",
}


local EggData = {
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36)
}


local MainTab = Window:Tab("Main")
local FarmTab = Window:Tab("Auto Farm")
local EggTab = Window:Tab("Teleports")


local Rewards = MainTab:Section{ Name = "Rewards", Side = "Left" }
Rewards:Button{
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs", "release"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
    end
}


local Farm = FarmTab:Section{ Name = "Farming", Side = "Left" }
local SellWait = 5

Farm:Toggle({
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

Farm:Slider({
    Name = "Sell Delay",
    Min = 5, Max = 100, Default = 5,
    Callback = function(v) SellWait = v end
})

Farm:Toggle({
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


local EggSec = EggTab:Section{ Name = "Egg TP", Side = "Left" }
local SelectedEgg = "Common Egg"

EggSec:Dropdown({
    Name = "Select Egg",
    Content = {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"},
    Callback = function(v) SelectedEgg = v end
})

EggSec:Button({
    Name = "Teleport",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggData[SelectedEgg] then hrp.CFrame = EggData[SelectedEgg] end
    end
})


setclipboard("https://discord.gg/YOUR_INVITE")
