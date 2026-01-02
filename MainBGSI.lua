-- [[ SILENCED BGSI - MACLIB FIXED ]] --
local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local VIM = game:GetService("VirtualInputManager")

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

-- [[ WINDOW ]] --
local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(580, 460),
    DragStyle = 1
})

-- FIXED: Maclib sometimes fails if tabs are added the same frame as window creation
task.wait(0.5)

-- [[ TABS ]] --
-- Using the exact method from documentation: Window:Tab()
local MainTab = Window:Tab({ 
    Name = "Main", 
    Image = "rbxassetid://10734950309" 
})

local HunterTab = Window:Tab({ 
    Name = "Hunter", 
    Image = "rbxassetid://10709819149" 
})

local EggTab = Window:Tab({ 
    Name = "Eggs & Worlds", 
    Image = "rbxassetid://10709761066" 
})

-- [[ MAIN TAB ]] --
local MainGroup = MainTab:Groupbox({ Name = "Automation", Side = "Left" })

MainGroup:Toggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(v) getgenv().HideHatch = v end
})

MainGroup:Button({
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
local HunterGroup = HunterTab:Groupbox({ Name = "Webhook Pings", Side = "Left" })

HunterGroup:Toggle({ Name = "Ping for Secret", Default = true, Callback = function(v) getgenv().PingSecret = v end })
HunterGroup:Toggle({ Name = "Ping for Mythic", Default = false, Callback = function(v) getgenv().PingMythic = v end })

-- [[ EGG & TELEPORT TAB ]] --
local TeleportGroup = EggTab:Groupbox({ Name = "Teleports", Side = "Left" })
local SelectedTP = "Common Egg"

TeleportGroup:Dropdown({
    Name = "Select Location",
    Items = {"Common Egg", "Void Egg", "Hell Egg", "Overworld", "Toy World"},
    Default = "Common Egg",
    Callback = function(v) SelectedTP = v end
})

TeleportGroup:Button({
    Name = "Teleport",
    Callback = function()
        local coords = {
            ["Common Egg"] = CFrame.new(-83, 9, 3),
            ["Void Egg"] = CFrame.new(-146, 9, -26),
            ["Hell Egg"] = CFrame.new(-145, 9, -36),
            ["Overworld"] = CFrame.new(-33, 9, 2),
            ["Toy World"] = CFrame.new(623, 15, 11)
        }
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and coords[SelectedTP] then
            hrp.CFrame = coords[SelectedTP]
        end
    end
})

local EggTools = EggTab:Groupbox({ Name = "Hatch Tools", Side = "Right" })

EggTools:Toggle({
    Name = "Auto Spam E",
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

-- CONFIG FOLDER (REQUIRED BY MACLIB)
MacLib:SetFolder("SilencedBGSI")
