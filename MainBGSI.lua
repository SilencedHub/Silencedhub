local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/oc9h/MacLib/main/maclib.lua"))()

local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(550, 350),
    DragStyle = 1
})

-- DATA
local EggData = {
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Iceshard Egg"] = CFrame.new(-118, 9, 10), ["Spikey Egg"] = CFrame.new(-126, 9, 6),
    ["Magma Egg"] = CFrame.new(-135, 9, 1), ["Crystal Egg"] = CFrame.new(-140, 9, -7),
    ["Lunar Egg"] = CFrame.new(-144, 9, -16), ["Void Egg"] = CFrame.new(-146, 9, -26),
    ["Hell Egg"] = CFrame.new(-145, 9, -36), ["Nightmare Egg"] = CFrame.new(-142, 9, -45),
    ["Rainbow Egg"] = CFrame.new(-137, 9, -54), ["Snowman Egg"] = CFrame.new(-130, 9, -60),
    ["Mining Egg"] = CFrame.new(-120, 9, -64), ["Cyber Egg"] = CFrame.new(-94, 9, -63),
    ["Neon Egg"] = CFrame.new(-83, 10, -58), ["Infinity Egg"] = CFrame.new(-99, 8, -27),
    ["New Years Egg"] = CFrame.new(83, 9, -13)
}

-- TABS
local MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
local FarmTab = Window:Tab({ Name = "Auto Farm", Image = "rbxassetid://10709819149" })
local EggTab = Window:Tab({ Name = "Egg Teleport", Image = "rbxassetid://10709761066" })

-- MAIN TAB
MainTab:Section({ Name = "Codes & Worlds" })
MainTab:Button({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
    end
})

-- AUTO FARM TAB
FarmTab:Section({ Name = "Farming Settings" })
local SellWait = 5

FarmTab:Toggle({
    Name = "Auto Blow Bubbles",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBlow = Value
        task.spawn(function()
            while getgenv().AutoBlow do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble") end)
                task.wait(0.1)
            end
        end)
    end
})

FarmTab:Slider({
    Name = "Sell Interval",
    Min = 5,
    Max = 100,
    Default = 5,
    Callback = function(Value) SellWait = Value end
})

FarmTab:Toggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSell = Value
        task.spawn(function()
            while getgenv().AutoSell do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble") end)
                task.wait(SellWait)
            end
        end)
    end
})

-- EGG TAB
EggTab:Section({ Name = "Teleports" })
local SelectedEgg = "Common Egg"
local EggList = {}
for name, _ in pairs(EggData) do table.insert(EggList, name) end
table.sort(EggList)

EggTab:Dropdown({
    Name = "Select Egg",
    Options = EggList,
    Default = "Common Egg",
    Callback = function(Option) SelectedEgg = Option end
})

EggTab:Button({
    Name = "Teleport",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = EggData[SelectedEgg] end
    end
})

-- INITIALIZATION
setclipboard("https://discord.gg/YOUR_INVITE")
