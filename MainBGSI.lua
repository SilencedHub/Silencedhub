-- [[ SILENCED BGSI - DUMMY UI FIXED ]] --

-- 1. LOAD LIBRARY
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

-- 2. CREATE WINDOW
-- This creates the main frame. 
local Window = Library:Load("SILENCED BGSI", "Default")

-- 3. CLOCK LOGIC (Fixed Time)
local function getLocalTime()
    return os.date("%I:%M %p") -- Example: 03:45 PM
end

-- 4. DATA
local EggData = {
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8),
    ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36)
}

-- 5. CREATE PAGES (Wait for Window to exist first)
local MainTab = Library:CreatePage("Main")
local FarmTab = Library:CreatePage("Auto Farm")
local EggTab = Library:CreatePage("Teleports")

-- [[ MAIN TAB ]] --
MainTab:CreateLabel("Current Time: " .. getLocalTime())

MainTab:CreateButton("Redeem All Codes", function()
    local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs", "release"}
    for _, code in ipairs(codes) do
        pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
        task.wait(0.1)
    end
end)

MainTab:CreateButton("Copy Discord", function()
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

FarmTab:CreateSlider("Sell Delay", 5, 100, 5, function(v)
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

-- [[ EGG TAB ]] --
local SelectedEgg = "Common Egg"

EggTab:CreateDropdown("Select Egg", {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"}, function(v)
    SelectedEgg = v
end)

EggTab:CreateButton("Teleport", function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and EggData[SelectedEgg] then
        hrp.CFrame = EggData[SelectedEgg]
    end
end)

-- AUTO COPY ON START
setclipboard("https://discord.gg/YOUR_INVITE")
