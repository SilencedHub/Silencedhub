local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

-- [[ WINDOW ]] --
local Window = OrionLib:MakeWindow({
    Name = "SILENCED BGSI", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading Silenced..."
})

-- [[ TABS ]] --
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local EggTab = Window:MakeTab({
    Name = "Eggs & Worlds",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local HunterTab = Window:MakeTab({
    Name = "Hunter",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- [[ MAIN TAB ]] --
MainTab:AddToggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(Value)
        getgenv().HideHatch = Value
        task.spawn(function()
            while getgenv().HideHatch do
                local pGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                local ui = pGui and (pGui:FindFirstChild("HatchUI") or pGui:FindFirstChild("EggHatch"))
                if ui then ui.Enabled = false end
                task.wait(0.1)
            end
        end)
    end    
})

-- [[ EGG & WORLD TAB ]] --
EggTab:AddSection({
    Name = "Hatching Tools"
})

EggTab:AddToggle({
    Name = "Auto Spam E",
    Default = false,
    Callback = function(Value)
        getgenv().SpamE = Value
        task.spawn(function()
            local VIM = game:GetService("VirtualInputManager")
            while getgenv().SpamE do
                VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(0.01)
                VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(0.01)
            end
        end)
    end    
})

EggTab:AddSection({
    Name = "Teleports"
})

local SelectedTP = "Common Egg"
EggTab:AddDropdown({
    Name = "Select Location",
    Default = "Common Egg",
    Options = {"Common Egg", "Void Egg", "Hell Egg", "Overworld", "Toy World"},
    Callback = function(Value)
        SelectedTP = Value
    end    
})

EggTab:AddButton({
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
        if hrp and coords[SelectedTP] then hrp.CFrame = coords[SelectedTP] end
    end    
})

-- [[ HUNTER TAB ]] --
HunterTab:AddToggle({
    Name = "Ping for Secret",
    Default = true,
    Callback = function(Value) getgenv().PingSecret = Value end    
})

-- [[ INITIALIZE ]] --
OrionLib:Init()
