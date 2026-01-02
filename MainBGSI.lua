-- [[ SILENCED BGSI - MACLIB ]] --
local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local VIM = game:GetService("VirtualInputManager")

-- [[ WINDOW ]] --
local Window = MacLib:Window({
    Title = "SILENCED BGSI",
    Subtitle = "Bubble Gum Simulator",
    Size = UDim2.fromOffset(580, 460),
    DragStyle = 1
})

-- FORCED RENDER LOGIC: 
-- This prevents the "Black Screen" by waiting for the UI to exist in the game engine
local UI_Container = game:GetService("CoreGui"):WaitForChild("Maclib", 10)
task.wait(1) 

-- [[ TABS ]] --
-- We wrap these in a pcall to prevent the "Missing Method" error from your screenshot
local MainTab, HunterTab, EggTab
local success = pcall(function()
    MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
    HunterTab = Window:Tab({ Name = "Hunter", Image = "rbxassetid://10709819149" })
    EggTab = Window:Tab({ Name = "Eggs & Worlds", Image = "rbxassetid://10709761066" })
end)

if not success then
    warn("Maclib Tab Error: The UI failed to initialize methods. Retrying...")
    task.wait(1)
    -- Final attempt to build
    MainTab = Window:Tab({ Name = "Main", Image = "rbxassetid://10734950309" })
    HunterTab = Window:Tab({ Name = "Hunter", Image = "rbxassetid://10709819149" })
    EggTab = Window:Tab({ Name = "Eggs & Worlds", Image = "rbxassetid://10709761066" })
end

-- [[ TAB CONTENT ]] --
-- Content is added only after the tabs are confirmed to exist
local MainGroup = MainTab:Groupbox({ Name = "Automation", Side = "Left" })
MainGroup:Toggle({
    Name = "Hide Hatch Animation",
    Default = false,
    Callback = function(v) getgenv().HideHatch = v end
})

local EggGroup = EggTab:Groupbox({ Name = "Teleports", Side = "Left" })
local SelectedTP = "Common Egg"
EggGroup:Dropdown({
    Name = "Select Location",
    Items = {"Common Egg", "Void Egg", "Hell Egg", "Overworld"},
    Default = "Common Egg",
    Callback = function(v) SelectedTP = v end
})

EggGroup:Button({
    Name = "Teleport",
    Callback = function()
        local coords = {
            ["Common Egg"] = CFrame.new(-83, 9, 3),
            ["Void Egg"] = CFrame.new(-146, 9, -26),
            ["Hell Egg"] = CFrame.new(-145, 9, -36),
            ["Overworld"] = CFrame.new(-33, 9, 2)
        }
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and coords[SelectedTP] then hrp.CFrame = coords[SelectedTP] end
    end
})

local HatchGroup = EggTab:Groupbox({ Name = "Hatch Tools", Side = "Right" })
HatchGroup:Toggle({
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

MacLib:SetFolder("SilencedBGSI")
