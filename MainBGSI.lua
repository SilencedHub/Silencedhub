-- [[ SILENCED BGSI - POTASSIUM STABLE ]] --

-- 1. CLOUD LOADING (Optimized for Potassium)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- 2. WINDOW CREATION
local Window = Rayfield:CreateWindow({
   Name = "SILENCED BGSI",
   LoadingTitle = "Bubble Gum Simulator",
   LoadingSubtitle = "by Silenced",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SilencedConfig",
      FileName = "BGS_Script"
   },
   Discord = {
      Enabled = true,
      Invite = "YOUR_CODE", -- Put your discord invite code here
      RememberJoins = true
   }
})

-- [[ DATA TABLES ]] --
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

-- [[ TABS ]] --
local MainTab = Window:CreateTab("Main", 4483362458) 
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local EggTab = Window:CreateTab("Egg TP", 4483362458)

-- [[ MAIN TAB ]] --
MainTab:CreateSection("Rewards")
MainTab:CreateButton({
   Name = "Redeem All Codes",
   Callback = function()
        local codes = {"maidnert", "ripsoulofplant", "halloween", "superpuff", "cornmaze", "autumn", "obby", "retroslop", "milestones", "season7", "bugfix", "plasma", "update16", "update15", "update13", "update12", "update11", "update10", "update9", "update8", "update7", "update6", "update5", "update4", "update3", "update2", "sylentlyssorry", "easter", "lucky", "release", "ogbgs", "adminabuse", "2xinfinity", "elf", "jolly", "christmas", "throwback"}
        for _, code in ipairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction:InvokeServer("RedeemCode", code) end)
            task.wait(0.1)
        end
        Rayfield:Notify({Title = "Success", Content = "Codes Redeemed!"})
   end,
})

-- [[ AUTO FARM TAB ]] --
FarmTab:CreateSection("Farming")
local SellWait = 5

FarmTab:CreateToggle({
   Name = "Auto Blow Bubbles",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoBlow = Value
      task.spawn(function()
          while getgenv().AutoBlow do
              pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble") end)
              task.wait(0.1)
          end
      end)
   end,
})

FarmTab:CreateSlider({
   Name = "Sell Wait Time",
   Range = {5, 100},
   Increment = 1,
   CurrentValue = 5,
   Callback = function(Value) SellWait = Value end,
})

FarmTab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoSell = Value
      task.spawn(function()
          while getgenv().AutoSell do
              pcall(function() game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("SellBubble") end)
              task.wait(SellWait)
          end
      end)
   end,
})

-- [[ EGG TAB ]] --
local SelectedEgg = "Common Egg"
local EggList = {}
for name, _ in pairs(EggData) do table.insert(EggList, name) end
table.sort(EggList)

EggTab:CreateDropdown({
   Name = "Select Egg Location",
   Options = EggList,
   CurrentOption = "Common Egg",
   Callback = function(Option) SelectedEgg = Option end,
})

EggTab:CreateButton({
   Name = "Teleport",
   Callback = function()
      local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if hrp then hrp.CFrame = EggData[SelectedEgg] end
   end,
})

-- Copy Discord link on execute
setclipboard("https://discord.gg/YOUR_INVITE")
