-- [[ SILENCED BGSI - FINAL STABLE VERSION ]] --

-- 1. ROBUST LIBRARY LOADING
local WindUI
local success, err = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluwwy/WindUI/main/Main.lua"))()
end)

if success and err then
    WindUI = err
else
    -- Fallback to secondary source if GitHub is slow
    WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/main/windui"))()
end

local DiscordLink = "https://discord.gg/YOUR_LINK_HERE" -- Replace with your actual invite

-- 2. WINDOW CREATION
local Window = WindUI:CreateWindow({
    Title = "SILENCED BGSI",
    SubTitle = "Bubble Gum Simulator",
    Icon = "rbxassetid://10734950309", 
    Author = "Silenced",
    Folder = "SilencedConfig"
})

-- 3. TABS
local MainTab = Window:CreateTab("Main", "home")
local AutoFarmTab = Window:CreateTab("Auto Farm", "swords")
local EggsTab = Window:CreateTab("Eggs", "egg")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- [[ DATA TABLES ]] --
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

-- [[ MAIN TAB ]] --
local CodeSection = MainTab:AddSection("Rewards & Worlds")
CodeSection:AddButton({
    Title = "Redeem All Codes",
    Desc = "Redeems all active codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        local remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in ipairs(codes) do
            pcall(function() remote:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        WindUI:Notify({Title = "Success", Content = "Codes Redeemed!", Type = "Success"})
    end
})

CodeSection:AddButton({
    Title = "Unlock World 1 Islands",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, cf in pairs(World1Data) do hrp.CFrame = cf task.wait(0.4) end
        end
    end
})

-- [[ AUTO FARM TAB ]] --
local FarmSection = AutoFarmTab:AddSection("Bubble Farming")
local SellCooldown = 5

FarmSection:AddToggle({
    Title = "Auto Blow Bubbles",
    Value = false,
    Callback = function(state)
        getgenv().AutoBlow = state
        task.spawn(function()
            local remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            while getgenv().AutoBlow do
                pcall(function() remote:FireServer("BlowBubble") end)
                task.wait(0.1)
            end
        end)
    end
})

FarmSection:AddSlider({
    Title = "Sell Interval",
    Min = 5, Max = 100, Default = 5,
    Callback = function(v) SellCooldown = v end
})

FarmSection:AddToggle({
    Title = "Auto Sell",
    Value = false,
    Callback = function(state)
        getgenv().AutoSell = state
        task.spawn(function()
            local remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            while getgenv().AutoSell do
                pcall(function() remote:FireServer("SellBubble") end)
                task.wait(SellCooldown)
            end
        end)
    end
})

-- [[ EGGS TAB ]] --
local SelectedEgg = "Common Egg"
local EggNames = {}
for name, _ in pairs(EggData) do table.insert(EggNames, name) end
table.sort(EggNames)

local EggSection = EggsTab:AddSection("Teleports")
EggSection:AddDropdown({
    Title = "Select Egg Location",
    Values = EggNames,
    Default = "Common Egg",
    Callback = function(v) SelectedEgg = v end
})

EggSection:AddButton({
    Title = "Teleport",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and EggData[SelectedEgg] then hrp.CFrame = EggData[SelectedEgg] end
    end
})

-- [[ SETTINGS TAB ]] --
local UISet = SettingsTab:AddSection("Interface")
UISet:AddDropdown({
    Title = "Theme",
    Values = {"Dark", "Light", "Aqua", "Amethyst", "Rose"},
    Default = "Dark",
    Callback = function(v) WindUI:SetTheme(v) end
})

UISet:AddKeybind({
    Title = "Toggle Menu",
    Default = Enum.KeyCode.RightControl,
    Callback = function() end -- Handled internally by WindUI
})

local Socials = SettingsTab:AddSection("Community")
Socials:AddButton({
    Title = "Copy Discord Link",
    Callback = function()
        setclipboard(DiscordLink)
        WindUI:Notify({Title = "Discord", Content = "Copied to clipboard!", Type = "Success"})
    end
})

-- [[ INITIALIZE ]] --
setclipboard(DiscordLink)
WindUI:Notify({
    Title = "Silenced BGSI",
    Content = "Discord link copied to clipboard!",
    Type = "Success",
    Duration = 5
})
