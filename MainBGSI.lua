local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Silenced Bgsi | Rayfield Edition",
   LoadingTitle = "Silenced Hub",
   LoadingSubtitle = "Version: BETA",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SilencedBgsi",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "25ms",
      RememberJoins = true
   },
   KeySystem = false
})

-- Variables for toggles
local AutoBubble = false
local AutoSell = false
local AutoCollect = false
local SellCooldown = 5
local FastHatch = false

-- Data Tables
local Codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "season6", "fishfix", "onemorebonus", "fishe", "world3", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
local World1Points = {Spawn = CFrame.new(58, 9, -103), ["Floating Island"] = CFrame.new(-16, 423, 143), ["Outer Space"] = CFrame.new(41, 2663, -7), Twilight = CFrame.new(-78, 6862, 88), ["The Void"] = CFrame.new(16, 10146, 151), Zen = CFrame.new(36, 15971, 41)}

-------------------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------------------
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Eggs", 4483362458)
local ShopTab = Window:CreateTab("Auto Buy", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-------------------------------------------------------------------------------
-- MAIN TAB
-------------------------------------------------------------------------------
MainTab:CreateSection("Codes & Management")

MainTab:CreateButton({
   Name = "Redeem All Codes",
   Callback = function()
       local Remote = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
       for _, code in pairs(Codes) do
           pcall(function() Remote:InvokeServer("RedeemCode", code) end)
           task.wait(0.1)
       end
       Rayfield:Notify({Title = "Codes", Content = "All codes redeemed!", Duration = 3})
   end,
})

-------------------------------------------------------------------------------
-- AUTO FARM TAB
-------------------------------------------------------------------------------
FarmTab:CreateSection("Bubbles & Selling")

FarmTab:CreateToggle({
   Name = "Auto Bubble",
   CurrentValue = false,
   Callback = function(Value)
      AutoBubble = Value
      if Value then
          task.spawn(function()
              while AutoBubble do
                  game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble")
                  task.wait(0.1)
              end
          end)
      end
   end,
})

FarmTab:CreateSlider({
   Name = "Sell Cooldown",
   Range = {5, 100},
   Increment = 1,
   Suffix = "s",
   CurrentValue = 5,
   Callback = function(Value)
      SellCooldown = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Callback = function(Value)
      AutoSell = Value
      if Value then
          task.spawn(function()
              while AutoSell do
                  game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble")
                  task.wait(SellCooldown)
              end
          end)
      end
   end,
})

FarmTab:CreateSection("Collection")

FarmTab:CreateToggle({
   Name = "Auto Collect Coins/Gems",
   CurrentValue = false,
   Callback = function(Value)
      AutoCollect = Value
      if Value then
          task.spawn(function()
              local CollectRemote = game:GetService("ReplicatedStorage").Remotes.Pickups.CollectPickup
              while AutoCollect do
                  pcall(function()
                      local rendered = workspace:FindFirstChild("Rendered")
                      if rendered then
                          for _, folder in pairs(rendered:GetChildren()) do
                              if folder:IsA("Folder") then
                                  for _, item in pairs(folder:GetChildren()) do
                                      if (item:IsA("Model") or item:IsA("Part")) and #item.Name >= 30 then
                                          CollectRemote:FireServer(item.Name)
                                          item:Destroy()
                                      end
                                  end
                              end
                          end
                      end
                  end)
                  task.wait(0.3)
              end
          end)
      end
   end,
})

-------------------------------------------------------------------------------
-- EGGS TAB
-------------------------------------------------------------------------------
EggTab:CreateSection("Hatching")

EggTab:CreateToggle({
   Name = "Fast Hatch (Hold E)",
   CurrentValue = false,
   Callback = function(Value)
      FastHatch = Value
      if Value then
          task.spawn(function()
              local VIM = game:GetService("VirtualInputManager")
              while FastHatch do
                  VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                  task.wait(0.05)
                  VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                  task.wait(0.05)
              end
          end)
      end
   end,
})

-------------------------------------------------------------------------------
-- TELEPORTS TAB
-------------------------------------------------------------------------------
TeleportTab:CreateSection("World 1 Locations")

for name, cframe in pairs(World1Points) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. name,
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = cframe end
        end,
    })
end

Rayfield:Notify({Title = "Script Loaded", Content = "Welcome to Silenced Bgsi Rayfield!", Duration = 5})
