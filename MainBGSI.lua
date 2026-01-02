-- [[ SILENCED BGSI - Maclib EDITION ]] --

-- 1. LOAD LIBRARY (Using your link)
local Maclib = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2Swiftz/UI-Library/refs/heads/main/Libraries/Maclib%20-%20Library.lua"))()

-- 2. CREATE WINDOW
local Window = Maclib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(550, 350),
    DragStyle = 1
})

-- 3. DATA TABLES
local EggData = {
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36)
}

-- 4. CREATE TABS
local Tabs = {
    Main = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" }),
    Farm = Window:Tab({ Name = "Auto Farm", Image = "rbxassetid://10709819149" }),
    Eggs = Window:Tab({ Name = "Teleports", Image = "rbxassetid://10709761066" })
}

-- 5. MAIN TAB
local MainGroup = Tabs.Main:Section({ Name = "Utility" })

MainGroup:Button({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
    end
})

MainGroup:Button({
    Name = "Copy Discord",
    Callback = function()
        setclipboard("https://discord.gg/YOUR_INVITE")
    end
})

-- 6. AUTO FARM TAB
local FarmGroup = Tabs.Farm:Section({ Name = "Farming Settings" })
local SellWait = 5

FarmGroup:Toggle({
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

FarmGroup:Slider({
    Name = "Sell Interval",
    Min = 5, Max = 100, Default = 5,
    Callback = function(Value) SellWait = Value end
})

FarmGroup:Toggle({
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

-- 7. EGG TAB
local EggGroup = Tabs.Eggs:Section({ Name = "Locations" })
local SelectedEgg = "Common Egg"

EggGroup:Dropdown({
    Name = "Select Egg",
    Items = {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"},
    Default = "Common Egg",
    Callback = function(Value) SelectedEgg = Value end
})

EggGroup:Button({
    Name = "Teleport",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggData[SelectedEgg] then
            hrp.CFrame = EggData[SelectedEgg]
        end
    end
})

-- Initialization
setclipboard("https://discord.gg/YOUR_INVITE")
