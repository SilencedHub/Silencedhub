
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local WindUI = nil
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluwwy/WindUI/main/Main.lua", true))()
end)

if success and result then
    WindUI = result
else
    -- Fallback link
    WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/main/windui"))()
end

-- Potassium specific: wait for the library to initialize in memory
local waitTimer = 0
while not WindUI and waitTimer < 50 do
    waitTimer = waitTimer + 1
    task.wait(0.1)
end

if not WindUI then
    return warn("WindUI failed to load. Check Potassium API settings.")
end

local DiscordLink = "https://discord.gg/YOUR_LINK_HERE" 

-- 1. WINDOW CREATION
local Window = WindUI:CreateWindow({
    Title = "SILENCED BGSI",
    SubTitle = "Bubble Gum Simulator",
    Icon = "rbxassetid://10734950309", 
    Author = "Silenced",
    Folder = "SilencedConfig"
})

-- 2. TABS
local MainTab = Window:CreateTab("Main", "home")
local AutoFarmTab = Window:CreateTab("Auto Farm", "swords")
local EggsTab = Window:CreateTab("Eggs", "egg")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- [[ DATA ]] --
local World1Data = {
    ["Spawn"] = CFrame.new(58, 9, -103), ["Floating Island"] = CFrame.new(-16, 423, 143),
    ["Outer Space"] = CFrame.new(41, 2663, -7), ["Twilight"] = CFrame.new(-78, 6862, 88),
    ["The Void"] = CFrame.new(16, 10146, 151), ["Zen"] = CFrame.new(36, 15971, 41)
}

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

-- [[ MAIN LOGIC ]] --
MainTab:AddSection("Rewards"):AddButton({
    Title = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        WindUI:Notify({Title = "Success", Content = "Codes Redeemed!", Type = "Success"})
    end
})

MainTab:AddSection("Teleport"):AddButton({
    Title = "Unlock World 1 Islands",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, cf in pairs(World1Data) do hrp.CFrame = cf task.wait(0.4) end
        end
    end
})

-- [[ AUTO FARM LOGIC ]] --
local FarmSec = AutoFarmTab:AddSection("Farming")
local SellCooldown = 5

FarmSec:AddToggle({
    Title = "Auto Blow Bubbles",
    Value = false,
    Callback = function(v) getgenv().AutoBlow = v
        task.spawn(function()
            while getgenv().AutoBlow do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble") end)
                task.wait(0.1)
            end
        end)
    end
})

FarmSec:AddSlider({
    Title = "Sell Wait Time",
    Min = 5, Max = 100, Default = 5,
    Callback = function(v) SellCooldown = v end
})

FarmSec:AddToggle({
    Title = "Auto Sell",
    Value = false,
    Callback = function(v) getgenv().AutoSell = v
        task.spawn(function()
            while getgenv().AutoSell do
                pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble") end)
                task.wait(SellCooldown)
            end
        end)
    end
})

-- [[ EGGS LOGIC ]] --
local SelectedEgg = "Common Egg"
local EggNames = {}
for name, _ in pairs(EggData) do table.insert(EggNames, name) end
table.sort(EggNames)

EggsTab:AddSection("Locations"):AddDropdown({
    Title = "Select Egg",
    Values = EggNames,
    Default = "Common Egg",
    Callback = function(v) SelectedEgg = v end
})

EggsTab:AddButton({
    Title = "Teleport to Egg",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = EggData[SelectedEgg] end
    end
})

-- [[ SETTINGS LOGIC ]] --
SettingsTab:AddSection("UI Style"):AddDropdown({
    Title = "Theme",
    Values = {"Dark", "Light", "Aqua", "Amethyst", "Rose"},
    Default = "Dark",
    Callback = function(v) WindUI:SetTheme(v) end
})

SettingsTab:AddSection("Socials"):AddButton({
    Title = "Copy Discord Link",
    Callback = function() setclipboard(DiscordLink) WindUI:Notify({Title = "Copied", Content = "Link saved to clipboard!"}) end
})

-- Initialization
setclipboard(DiscordLink)
WindUI:Notify({Title = "Ready", Content = "Silenced BGSI Loaded", Type = "Success"})
