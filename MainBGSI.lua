-- [[ SILENCED BGSI - COMPLETE VERSION WITH DISCORD ]] --

local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/main/windui"))()
local DiscordLink = "https://discord.gg/YOUR_LINK_HERE" -- Change this to your actual link

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

-- [[ MAIN TAB LOGIC ]] --
local CodeSection = MainTab:AddSection("Rewards & Worlds")
CodeSection:AddButton({
    Title = "Redeem All Codes",
    Desc = "Redeems all active game codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        local remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        for _, code in ipairs(codes) do
            pcall(function() remote:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        WindUI:Notify({Title = "Codes", Content = "Redemption Complete!", Type = "Success"})
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

-- [[ AUTO FARM TAB LOGIC ]] --
local FarmSection = AutoFarmTab:AddSection("Bubble Farming")
local SellCooldown = 5

FarmSection:AddToggle({
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

FarmSection:AddSlider({
    Title = "Auto Sell Interval",
    Min = 5, Max = 100, Default = 5,
    Callback = function(v) SellCooldown = v end
})

FarmSection:AddToggle({
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

-- [[ EGGS TAB LOGIC ]] --
local SelectedEgg = "Common Egg"
local EggNames = {}
for name, _ in pairs(EggData) do table.insert(EggNames, name) end
table.sort(EggNames)

local EggSection = EggsTab:AddSection("Egg Teleports")
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
        if hrp then hrp.CFrame = EggData[SelectedEgg] end
    end
})

-- [[ SETTINGS TAB LOGIC ]] --
local UISettings = SettingsTab:AddSection("Interface Customization")

UISettings:AddDropdown({
    Title = "UI Theme",
    Values = {"Dark", "Light", "Aqua", "Amethyst", "Rose"},
    Default = "Dark",
    Callback = function(v) WindUI:SetTheme(v) end
})

UISettings:AddToggle({
    Title = "Transparency (Acrylic)",
    Value = true,
    Callback = function(v) Window:SetTransparency(v) end
})

local SocialSection = SettingsTab:AddSection("Community")

SocialSection:AddButton({
    Title = "Copy Discord Invite",
    Desc = "Copies link to your clipboard",
    Callback = function()
        setclipboard(DiscordLink)
        WindUI:Notify({Title = "Discord", Content = "Link copied to clipboard!", Type = "Success"})
    end
})

-- [[ INITIALIZATION ]] --

-- Auto-copy on load
setclipboard(DiscordLink)

WindUI:Notify({
    Title = "Silenced BGSI Loaded",
    Content = "Discord link copied to clipboard!",
    Type = "Success",
    Duration = 5
})

-- Simple prompt for Discord (Optional, works on most executors)
local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
if request then
    request({
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            cmd = "INVITE_BROWSER",
            args = { code = "YOUR_CODE_HERE" }, -- Just the code (e.g. "AbC123")
            nonce = game:GetService("HttpService"):GenerateGUID(false)
        }),
    })
end
