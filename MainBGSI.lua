-- [[ SILENCED BGSI - Maclib ]] --
local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local VIM = game:GetService("VirtualInputManager")

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

-- [[ DATA ]] --
local EggData = { 
    ["Common Egg"] = CFrame.new(-83, 9, 3), ["Spotted Egg"] = CFrame.new(-94, 9, 8), 
    ["Void Egg"] = CFrame.new(-146, 9, -26), ["Hell Egg"] = CFrame.new(-145, 9, -36) 
}
local WorldData = { 
    ["Overworld"] = CFrame.new(-33, 9, 2), ["Toy World"] = CFrame.new(623, 15, 11), 
    ["Candy World"] = CFrame.new(1234, 15, 20) 
}

-- [[ WINDOW CREATION ]] --
local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(580, 460),
    DragStyle = 1
})

-- CRITICAL FIX: Wait for the black frame to initialize before adding content
repeat task.wait() until Window
task.wait(0.5) 

-- [[ TAB BUILDER ]] --
local MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
local HunterTab = Window:Tab({ Name = "Hunter", Image = "rbxassetid://10709819149" })
local TeleportTab = Window:Tab({ Name = "Eggs & Worlds", Image = "rbxassetid://10709761066" })

-- [[ MAIN TAB ]] --
local SettingsGroup = MainTab:Groupbox({ Name = "General Settings", Side = "Left" })
SettingsGroup:Toggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(v) getgenv().HideHatch = v end
})
SettingsGroup:Button({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "ogbgs"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.05)
        end
    end
})

-- [[ HUNTER TAB ]] --
local PingGroup = HunterTab:Groupbox({ Name = "Ping Rarity", Side = "Left" })
PingGroup:Toggle({ Name = "Ping for Secret", Default = true, Callback = function(v) getgenv().PingSecret = v end })
PingGroup:Toggle({ Name = "Ping for Mythic", Default = false, Callback = function(v) getgenv().PingMythic = v end })
PingGroup:Toggle({ Name = "Ping for Shiny", Default = false, Callback = function(v) getgenv().PingShiny = v end })

-- [[ TELEPORT & EGG TAB ]] --
local EggGroup = TeleportTab:Groupbox({ Name = "Egg Teleports", Side = "Left" })
local SelectedEgg = "Common Egg"
EggGroup:Dropdown({ Name = "Select Egg", Items = {"Common Egg", "Spotted Egg", "Void Egg", "Hell Egg"}, Default = "Common Egg", Callback = function(v) SelectedEgg = v end })
EggGroup:Button({ Name = "Teleport to Egg", Callback = function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and EggData[SelectedEgg] then hrp.CFrame = EggData[SelectedEgg] end
end})

local HatchTools = TeleportTab:Groupbox({ Name = "Hatching Tools", Side = "Left" })
HatchTools:Toggle({
    Name = "Auto Spam E (Hatch/Blow)",
    Default = false,
    Callback = function(Value)
        getgenv().SpamE = Value
        task.spawn(function()
            while getgenv().SpamE do
                VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(0.01)
                VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(0.01)
            end
        end)
    end
})

local WorldGroup = TeleportTab:Groupbox({ Name = "World Teleports", Side = "Right" })
local SelectedWorld = "Overworld"
WorldGroup:Dropdown({ Name = "Select World", Items = {"Overworld", "Toy World", "Candy World"}, Default = "Overworld", Callback = function(v) SelectedWorld = v end })
WorldGroup:Button({ Name = "Teleport to World", Callback = function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and WorldData[SelectedWorld] then hrp.CFrame = WorldData[SelectedWorld] end
end})
