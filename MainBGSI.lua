-- [[ SILENCED BGSI - DUMMY/DRRAY STABLE ]] --

-- 1. STABLE LOADER
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

-- 2. CREATE WINDOW (Dummy UI Style)
local Window = Library:Load("SILENCED BGSI", "Default")

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

-- 3. CREATE PAGES (Tabs)
local MainTab = Library:CreatePage("Main")
local FarmTab = Library:CreatePage("Auto Farm")
local EggTab = Library:CreatePage("Egg TPs")

-- [[ MAIN TAB ]] --
MainTab:CreateButton("Redeem All Codes", function()
    local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
    for _, code in ipairs(codes) do
        pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
        task.wait(0.1)
    end
end)

MainTab:CreateButton("Copy Discord Link", function()
    setclipboard("https://discord.gg/YOUR_INVITE")
end)

-- [[ AUTO FARM TAB ]] --
local SellWait = 5

FarmTab:CreateToggle("Auto Blow Bubbles", function(state)
    getgenv().AutoBlow = state
    task.spawn(function()
        while getgenv().AutoBlow do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble") end)
            task.wait(0.1)
        end
    end)
end)

FarmTab:CreateSlider("Sell Delay (Seconds)", 5, 100, 5, function(v)
    SellWait = v
end)

FarmTab:CreateToggle("Auto Sell", function(state)
    getgenv().AutoSell = state
    task.spawn(function()
        while getgenv().AutoSell do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble") end)
            task.wait(SellWait)
        end
    end)
end)

-- [[ EGG TELEPORTS ]] --
local SelectedEgg = "Common Egg"
local EggNames = {}
for name, _ in pairs(EggData) do table.insert(EggNames, name) end
table.sort(EggNames)

EggTab:CreateDropdown("Select Egg", EggNames, function(v)
    SelectedEgg = v
end)

EggTab:CreateButton("Teleport to Selected Egg", function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and EggData[SelectedEgg] then
        hrp.CFrame = EggData[SelectedEgg]
    end
end)

-- INITIALIZE
setclipboard("https://discord.gg/YOUR_INVITE")
