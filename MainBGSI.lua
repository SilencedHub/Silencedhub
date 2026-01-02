-- [[ RAYFIELD SAFE LOADER ]] --
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    warn("SILENCED BGSI: Rayfield failed to load. Check your internet or executor.")
    return
end

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

-- [[ WINDOW ]] --
local Window = Rayfield:CreateWindow({
   Name = "SILENCED BGSI",
   LoadingTitle = "Fixing Black Screen...",
   LoadingSubtitle = "by Silenced",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- [[ TABS ]] --
-- Using CreateTab as per latest Sirius Rayfield documentation
local MainTab = Window:CreateTab("Main", 4483362458) 
local HunterTab = Window:CreateTab("Hunter", 4483362458)
local EggTab = Window:CreateTab("Eggs & Worlds", 4483362458)

-- [[ MAIN TAB ]] --
MainTab:CreateSection("Automation")

MainTab:CreateToggle({
   Name = "Hide Hatch Animation",
   CurrentValue = false,
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
   end,
})

-- [[ HUNTER TAB ]] --
HunterTab:CreateSection("Webhook Settings")

HunterTab:CreateToggle({
   Name = "Ping for Secret",
   CurrentValue = true,
   Callback = function(v) getgenv().PingSecret = v end,
})

HunterTab:CreateButton({
   Name = "Test Webhook",
   Callback = function()
      -- Internal Webhook Test logic
      print("Testing Webhook...")
   end,
})

-- [[ EGG & WORLD TAB ]] --
EggTab:CreateSection("Hatching Tools")

EggTab:CreateToggle({
   Name = "Auto Spam E",
   CurrentValue = false,
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
   end,
})

EggTab:CreateSection("Teleports")

local SelectedTP = "Common Egg"
EggTab:CreateDropdown({
   Name = "Select Location",
   Options = {"Common Egg", "Void Egg", "Hell Egg", "Overworld", "Toy World"},
   CurrentOption = {"Common Egg"},
   MultipleOptions = false,
   Callback = function(Option) SelectedTP = Option[1] end,
})

EggTab:CreateButton({
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
   end,
})

Rayfield:Notify({
   Title = "Success!",
   Content = "Silenced BGSI has loaded without errors.",
   Duration = 5,
   Image = 4483362458,
})
