-- ts file was generated at discord.gg/25ms


local vu1 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local v2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/SilencedHub/Silencedhub/refs/heads/main/SaveManager.lua"))()
local v3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/SilencedHub/Silencedhub/refs/heads/main/InterfaceManager.lua"))()
local v4 = vu1
local v5 = vu1.CreateWindow(v4, {
    Title = "Silenced Bgsi",
    SubTitle = "Version: BETA",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local v6 = {
    Update = v5:AddTab({
        Title = "Changelog",
        Icon = "rbxassetid://85502241059648"
    }),
    Main = v5:AddTab({
        Title = "Main",
        Icon = "rbxassetid://79927907097265"
    }),
    AutoFarm = v5:AddTab({
        Title = "Auto Farm",
        Icon = "rbxassetid://134753546344234"
    }),
    Minigames = v5:AddTab({
        Title = "Minigames",
        Icon = "rbxassetid://16781755256"
    }),
    Buy = v5:AddTab({
        Title = "Auto Buy",
        Icon = "rbxassetid://11807308234"
    }),
    Eggs = v5:AddTab({
        Title = "Eggs",
        Icon = "rbxassetid://11637882493"
    }),
    Teleport = v5:AddTab({
        Title = "Teleport",
        Icon = "rbxassetid://11715804797"
    }),
    Settings = v5:AddTab({
        Title = "Settings",
        Icon = "settings"
    })
}
v6.Update:AddButton({
    Title = "View Latest Update",
    Description = "Check what\'s new",
    Callback = function()
        vu1:Notify({
            Title = "Changelog",
            Content = "Latest: v0.01 - Added Auto blow, auto collect, auto enchant and Much more!",
            Duration = 5
        })
    end
})
v6.Update:AddParagraph({
    Title = "Update v1.4",
    Content = "- Changed UI So It Works With All Executors\n- Added OG Egg To Egg TP\n- Removed Rifts Tab\n- Added Auto Buy Dice Shop"
})
v6.Update:AddParagraph({
    Title = "Update v1.3",
    Content = "- Added Auto Admin Abuse Egg TP (When The Egg Spawns)\n- Added The New Codes To (Redeem All Codes)\n- Updated Auto Sell (Removed Teleport)\n- Added Auto Buy Tab\n- Added Auto Dice Roll (BoardGame)\n- Added Auto Complete Minigames\n- Removed Auto Dark And Halloween Wheel Spin"
})
v6.Update:AddParagraph({
    Title = "Update v1.2",
    Content = "- Added Auto Open Mystery Box\'s\n- Added Unlock All World 2 Islands (Must Have World 2 Already)\n- Added Auto Use Tickets (Spin, Festival, Dark, Halloween)\n- Added Secret Hatch Webhook"
})
v6.Update:AddParagraph({
    Title = "Update v1.1",
    Content = "- Added Auto Summon Rifts\n- Auto Buy Flavours and Auto Sell\n- New Teleporting System For All World 1 Islands\n- Bug fixes\n- Optimized Performance For All Auto Farm Features"
})
v6.Main:AddParagraph({
    Title = "Depending On Your Executor eg., (Xeno, Solara)",
    Content = "\239\191\189\239\191\189\239\184\143 Not All Features Will Work Because Of Low sUNC/UNC \226\154\160\239\184\143"
})
local vu7 = {
    "maidnert",
    "ripsoulofplant",
    "halloween",
    "superpuff",
    "cornmaze",
    "autumn",
    "obby",
    "retroslop",
    "milestones",
    "season7",
    "bugfix",
    "plasma",
    "update16",
    "season6",
    "fishfix",
    "onemorebonus",
    "fishe",
    "world3",
    "update15",
    "update13",
    "update12",
    "update11",
    "update10",
    "update9",
    "update8",
    "update7",
    "update6",
    "update5",
    "update4",
    "update3",
    "update2",
    "sylentlyssorry",
    "easter",
    "lucky",
    "release",
    "ogbgs",
    "adminabuse"
}
local v8 = v6.Main:AddSection("Codes/Worlds")
v8:AddButton({
    Title = "Redeem All Codes",
    Description = "Redeems all available codes automatically",
    Callback = function()
        local vu9 = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteFunction
        local v10, v11, v12 = ipairs(vu7)
        while true do
            local vu13
            v12, vu13 = v10(v11, v12)
            if v12 == nil then
                break
            end
            pcall(function()
                vu9:InvokeServer("RedeemCode", vu13)
            end)
            wait(0.1)
        end
        vu1:Notify({
            Title = "Codes Redeemed",
            Content = "All codes have been redeemed!",
            Duration = 3
        })
    end
})
local vu14 = {
    Spawn = CFrame.new(58, 22, - 71),
    ["Floating Island"] = CFrame.new(- 16, 423, 143),
    ["Outer Space"] = CFrame.new(41, 2663, - 7),
    Twilight = CFrame.new(- 78, 6862, 88),
    ["The Void"] = CFrame.new(16, 10146, 151),
    Zen = CFrame.new(36, 15971, 41)
}
local vu15 = {
    "Spawn",
    "Floating Island",
    "Outer Space",
    "Twilight",
    "The Void",
    "Zen"
}
v8:AddButton({
    Title = "Unlock World 1 Islands",
    Description = "Teleports To All World 1 Islands",
    Callback = function()
        local v16 = game.Players.LocalPlayer
        local vu17 = (v16.Character or v16.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10)
        if vu17 then
            local vu18 = v16:WaitForChild("PlayerGui"):FindFirstChild("TeleportingGui")
            if vu18 then
                vu18.Enabled = true
            end
            spawn(function()
                local v19, v20, v21 = ipairs(vu15)
                while true do
                    local v22
                    v21, v22 = v19(v20, v21)
                    if v21 == nil then
                        break
                    end
                    local v23 = vu14[v22]
                    if v23 then
                        for _ = 1, 3 do
                            vu17.CFrame = v23
                            wait(0.2)
                        end
                        wait(0.5)
                    end
                end
                if vu18 then
                    vu18.Enabled = false
                end
                vu1:Notify({
                    Title = "World 1 Unlocked",
                    Content = "All World 1 Islands Have Been Unlocked",
                    Duration = 3
                })
            end)
        else
            vu1:Notify({
                Title = "Error",
                Content = "Could not find HumanoidRootPart",
                Duration = 3
            })
        end
    end
})
local vu24 = {
    Spawn = CFrame.new(9981, 26, 172),
    ["Dice Island"] = CFrame.new(9900, 2907, 208),
    ["Minecart Forest"] = CFrame.new(9882, 7681, 203),
    ["Robot Factory"] = CFrame.new(9887, 13408, 227),
    ["Hyperwave Island"] = CFrame.new(9885, 20088, 226)
}
local vu25 = {
    "Spawn",
    "Dice Island",
    "Minecart Forest",
    "Robot Factory",
    "Hyperwave Island"
}
v8:AddButton({
    Title = "Unlock World 2 Islands",
    Description = "Teleports To All World 2 Islands (You Must Have World 2)",
    Callback = function()
        local v26 = game.Players.LocalPlayer
        local vu27 = (v26.Character or v26.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10)
        if vu27 then
            local vu28 = v26:WaitForChild("PlayerGui"):FindFirstChild("TeleportingGui")
            if vu28 then
                vu28.Enabled = true
            end
            spawn(function()
                local v29, v30, v31 = ipairs(vu25)
                while true do
                    local v32
                    v31, v32 = v29(v30, v31)
                    if v31 == nil then
                        break
                    end
                    local v33 = vu24[v32]
                    if v33 then
                        for _ = 1, 3 do
                            vu27.CFrame = v33
                            wait(0.2)
                        end
                        wait(0.5)
                    end
                end
                if vu28 then
                    vu28.Enabled = false
                end
                vu1:Notify({
                    Title = "World 2 Unlocked",
                    Content = "All World 2 Islands Have Been Unlocked",
                    Duration = 3
                })
            end)
        else
            vu1:Notify({
                Title = "Error",
                Content = "Could not find HumanoidRootPart",
                Duration = 3
            })
        end
    end
})
local vu34 = {
    ["Common Egg"] = CFrame.new(- 83, 9, 3),
    ["Spotted Egg"] = CFrame.new(- 94, 9, 8),
    ["Iceshard Egg"] = CFrame.new(- 118, 9, 10),
    ["Spikey Egg"] = CFrame.new(- 126, 9, 6),
    ["Magma Egg"] = CFrame.new(- 135, 9, 1),
    ["Crystal Egg"] = CFrame.new(- 140, 9, - 7),
    ["Lunar Egg"] = CFrame.new(- 144, 9, - 16),
    ["Void Egg"] = CFrame.new(- 146, 9, - 26),
    ["Hell Egg"] = CFrame.new(- 145, 9, - 36),
    ["Nightmare Egg"] = CFrame.new(- 142, 9, - 45),
    ["Rainbow Egg"] = CFrame.new(- 137, 9, - 54),
    ["Snowman Egg"] = CFrame.new(- 130, 9, - 60),
    ["Mining Egg"] = CFrame.new(- 120, 9, - 64),
    ["Cyber Egg"] = CFrame.new(- 94, 9, - 63),
    ["Neon Egg"] = CFrame.new(- 83, 10, - 58),
    ["Infinity Egg"] = CFrame.new(- 99, 8, - 27),
    ["OG Egg"] = CFrame.new(69, 8, 27)
}
local v35 = v6.Eggs:AddSection("Egg Teleport")
local vu36 = "Common Egg"
v35:AddDropdown("EggDropdown", {
    Title = "Select Egg",
    Values = {
        "Common Egg",
        "Spotted Egg",
        "Iceshard Egg",
        "Spikey Egg",
        "Magma Egg",
        "Crystal Egg",
        "Lunar Egg",
        "Void Egg",
        "Hell Egg",
        "Nightmare Egg",
        "Rainbow Egg",
        "Snowman Egg",
        "Mining Egg",
        "Cyber Egg",
        "Neon Egg",
        "Infinity Egg",
        "OG Egg"
    },
    Multi = false,
    Default = 1,
    Callback = function(p37)
        vu36 = p37
    end
})
v35:AddButton({
    Title = "Teleport To Selected Egg",
    Description = "",
    Callback = function()
        if vu34[vu36] then
            local v38 = game.Players.LocalPlayer
            local v39 = (v38.Character or v38.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10)
            if not v39 then
                vu1:Notify({
                    Title = "Error",
                    Content = "Could not find HumanoidRootPart",
                    Duration = 3
                })
                return
            end
            v39.CFrame = vu34[vu36]
            vu1:Notify({
                Title = "Teleported To" .. vu36,
                Content = "",
                Duration = 3
            })
        else
            vu1:Notify({
                Title = "Error",
                Content = "No CFrame found for " .. vu36,
                Duration = 3
            })
        end
    end
})
local v40 = v6.Eggs:AddSection("Admin Abuse Egg TP")
local vu41 = false
local vu42 = nil
local function vu48()
    local v43 = game:GetService("Workspace")
    local v44 = game.Players.LocalPlayer.Character
    if v44 then
        v44 = v44:FindFirstChild("HumanoidRootPart")
    end
    if v44 then
        local v45 = v43:FindFirstChild("Rendered")
        if v45 then
            local v46 = v45:GetChildren()
            local v47 = 13
            if v46[v47] then
                if v46[v47]:FindFirstChild("Super Silly Egg") then
                    if not vu42 then
                        vu42 = v44.CFrame
                    end
                    v44.CFrame = CFrame.new(130, 8, 96)
                elseif vu42 then
                    v44.CFrame = vu42
                    vu42 = nil
                end
            end
        end
    end
end
v40:AddToggle("AdminEggToggle", {
    Title = "Admin Abuse Egg TP",
    Default = false,
    Callback = function(p49)
        vu41 = p49
        vu1:Notify({
            Title = "Admin Abuse Egg",
            Content = vu41 and "Enabled: Waiting For Admin Abuse/Super Silly Egg To Spawn" or "Disabled: No Longer Waiting For Admin Abuse/Super Silly Egg To Spawn",
            Duration = 3
        })
        if vu41 then
            vu48()
            spawn(function()
                while vu41 do
                    vu48()
                    wait(1)
                end
            end)
        else
            local v50 = game.Players.LocalPlayer.Character
            if v50 then
                v50 = v50:FindFirstChild("HumanoidRootPart")
            end
            if v50 and vu42 then
                v50.CFrame = vu42
                vu42 = nil
            end
        end
    end
})
local v51 = v6.Eggs:AddSection("Egg Misc")
getgenv().Config = {
    Webhook_enabled = false,
    Webhook = "",
    Ignore_AutoDeleted = true,
    Secret_Only = true
}
v51:AddInput("HatchWebhook", {
    Title = "Hatch Webhook",
    Default = "",
    Placeholder = "Enter your webhook URL...",
    Callback = function(p52)
        getgenv().Config.Webhook = p52
        vu1:Notify({
            Title = "Webhook Updated",
            Content = "Webhook Set",
            Duration = 3
        })
    end
})
v51:AddToggle("SecretHatchWebhook", {
    Title = "Secret Hatch Webhook",
    Default = false,
    Callback = function(p53)
        getgenv().Config.Webhook_enabled = p53
        if p53 then
            vu1:Notify({
                Title = "Webhook Enabled",
                Content = "Webhook alerts are now active",
                Duration = 3
            })
        else
            vu1:Notify({
                Title = "Webhook Disabled",
                Content = "Webhook alerts are now turned off",
                Duration = 3
            })
        end
    end
})
local vu54 = syn and syn.request or (http and http.request or http_request or (fluxus and fluxus.request or request))
if vu54 then
    local vu55 = game.Players.LocalPlayer
    local vu56 = game:GetService("HttpService")
    local v57 = game:GetService("RunService")
    local vu58 = {}
    local function vu61(p59)
        local v60 = tostring(p59)
        if vu58[v60] and tick() - vu58[v60] < 5 then
            return true
        end
        vu58[v60] = tick()
        return false
    end
    local function vu80(p62, p63, p64, p65)
        if getgenv().Config.Webhook_enabled then
            if getgenv().Config.Webhook ~= "" then
                if not p65 or string.find(p65, " in ", 1, true) then
                    local v66 = p63 and (p63:lower() or "") or ""
                    local v67 = os.time()
                    local v68 = "N/A"
                    local v69 = vu55:FindFirstChild("leaderstats")
                    if v69 then
                        local v70 = v69:FindFirstChild("\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 Hatches")
                        if v70 and v70:IsA("IntValue") then
                            v68 = tostring(v70.Value)
                        end
                    end
                    local v71 = ""
                    local v72 = p62:gsub("%s+", "_"):lower()
                    local v73 = 0
                    local v74 = "https://img.files.cheap/u/TvQtay.webp"
                    local v75, v76
                    if p64 and v66:find("mythic") then
                        v75 = "You\'ve hatched a Shiny Mythic " .. p63
                        p62 = "Shiny Mythic " .. p62
                        v76 = "https://content.bgsi.io/shiny_mythic_" .. v72 .. ".webp"
                    elseif v66:find("mythic") then
                        v75 = "You\'ve hatched a Mythic " .. p63
                        p62 = "Mythic " .. p62
                        v76 = "https://content.bgsi.io/mythic_" .. v72 .. ".webp"
                    elseif p64 then
                        v75 = "You\'ve hatched a Shiny " .. p63
                        p62 = "Shiny " .. p62
                        v76 = "https://content.bgsi.io/shiny_" .. v72 .. ".webp"
                    else
                        v75 = "You\'ve hatched a " .. p63
                        v76 = "https://content.bgsi.io/" .. v72 .. ".webp"
                    end
                    local v77 = {
                        username = "Silenced Bgsi",
                        avatar_url = "https://img.files.cheap/u/BxwpBG.webp",
                        content = v71,
                        embeds = {
                            {
                                author = {
                                    name = v75,
                                    icon_url = v74
                                },
                                color = v73,
                                thumbnail = {
                                    url = v76
                                },
                                title = p62,
                                description = string.format("\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189  __**Chance**__: %s\n\226\143\177\239\184\143 **Hatch Date**: <t:%d:R>\n\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189  __**Hatches**__: %s\n\226\132\185\239\184\143  __**Hatched By**__: %s", p65 or "N/A", v67, v68, vu55.Name),
                                fields = {}
                            }
                        }
                    }
                    local v78 = vu54
                    local v79 = {
                        Url = getgenv().Config.Webhook,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = vu56:JSONEncode(v77)
                    }
                    v78(v79)
                end
            else
                return
            end
        else
            return
        end
    end
    local function vu103()
        local v81 = vu55:FindFirstChild("PlayerGui")
        if v81 then
            v81 = vu55.PlayerGui:FindFirstChild("ScreenGui")
        end
        if v81 then
            local v82 = v81:FindFirstChild("Hatching")
            if v82 then
                local v83, v84, v85 = ipairs(v82:GetChildren())
                while true do
                    local v86
                    v85, v86 = v83(v84, v85)
                    if v85 == nil then
                        break
                    end
                    if v86:IsA("Frame") and (v86:FindFirstChild("Label") and v86:FindFirstChild("Rarity")) then
                        local v87 = v86.Label.Text
                        local v88 = v86.Rarity.Text
                        local v89
                        if v86:FindFirstChild("Shiny") then
                            v89 = v86.Shiny.Visible or false
                        else
                            v89 = false
                        end
                        local v90
                        if v86:FindFirstChild("Deleted") then
                            v90 = v86.Deleted.Visible or false
                        else
                            v90 = false
                        end
                        local v91
                        if v86:FindFirstChild("Chance") then
                            v91 = v86.Chance.Text or nil
                        else
                            v91 = nil
                        end
                        local v92 = v88:lower()
                        if getgenv().Config.Ignore_AutoDeleted or not v90 then
                            if (v92:find("legendary") or v92:find("mythic")) and not (getgenv().Config.Secret_Only or vu61(v86)) then
                                vu80(v87, v88, v89, v91)
                            end
                            if v92:find("secret") and not vu61(v86) then
                                vu80(v87, "Secret", v89, v91)
                            end
                        end
                    end
                end
            end
            local v93 = v81:FindFirstChild("Template")
            if v93 then
                local v94, v95, v96 = ipairs(v93:GetDescendants())
                while true do
                    local v97
                    v96, v97 = v94(v95, v96)
                    if v96 == nil then
                        break
                    end
                    if v97:IsA("TextLabel") and (v97.Name == "Rarity" and v97.Visible) and (v97.Text:lower():find("secret") and not vu61(v97)) then
                        local v98 = v97.Parent
                        local v99 = "Unknown"
                        local v100 = "N/A"
                        local v101 = false
                        local v102 = false
                        if v98 then
                            if v98:FindFirstChild("Label") then
                                v99 = v98.Label.Text
                            end
                            if v98:FindFirstChild("Chance") then
                                v100 = v98.Chance.Text
                            end
                            if v98:FindFirstChild("Shiny") then
                                v101 = v98.Shiny.Visible
                            end
                            if v98:FindFirstChild("Deleted") then
                                v102 = v98.Deleted.Visible
                            end
                        end
                        if getgenv().Config.Ignore_AutoDeleted or not v102 then
                            vu80(v99, "Secret", v101, v100)
                            print("[DEBUG] Secret detected:", v99, v100)
                        end
                    end
                end
            end
        end
    end
    v57.Heartbeat:Connect(function()
        if getgenv().Config.Webhook_enabled then
            vu103()
        end
    end)
    local vu104 = false
    v51:AddToggle("FastHatchEggs", {
        Title = "Fast Hatch Eggs",
        Default = false,
        Callback = function(p105)
            vu104 = p105
            if p105 then
                vu1:Notify({
                    Title = "Fast Hatch",
                    Content = "Started fast hatching eggs",
                    Duration = 3
                })
                task.spawn(function()
                    while vu104 do
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.05)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                        task.wait(0.05)
                    end
                end)
            else
                vu1:Notify({
                    Title = "Fast Hatch",
                    Content = "Stopped fast hatching eggs",
                    Duration = 3
                })
            end
        end
    })
    local v106 = game:GetService("ReplicatedStorage")
    local vu107 = game:GetService("Workspace")
    local vu108 = v106.Shared.Framework.Network.Remote.RemoteEvent
    local vu109 = v106.Remotes.Pickups:WaitForChild("CollectPickup")
    local vu110 = false
    local vu111 = false
    local vu112 = false
    local vu113 = 5
    local v114 = v6.AutoFarm:AddSection("Main Farm")
    v114:AddToggle("AutoBubble", {
        Title = "Auto Bubble",
        Default = false,
        Callback = function(p115)
            vu110 = p115
            vu1:Notify({
                Title = "Auto Bubble",
                Content = p115 and "Started" or "Stopped Blowing Bubbles",
                Duration = 3
            })
            if p115 then
                task.spawn(function()
                    while vu110 do
                        pcall(function()
                            vu108:FireServer("BlowBubble")
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })
    v114:AddSlider("SellCooldown", {
        Title = "Sell Cooldown (Seconds)",
        Min = 5,
        Max = 100,
        Default = 5,
        Rounding = 1,
        Color = Color3.fromRGB(0, 0, 255),
        Callback = function(p116)
            vu113 = p116 or 5
        end
    })
    task.spawn(function()
        while true do
            while vu111 do
                pcall(function()
                    vu108:FireServer("SellBubble")
                end)
                task.wait(vu113)
            end
            task.wait(0.1)
        end
    end)
    v114:AddToggle("AutoSellToggleID", {
        Title = "Auto Sell",
        Default = false,
        Callback = function(p117)
            vu111 = p117
            vu1:Notify({
                Title = "Auto Sell",
                Content = p117 and "Enabled" or "Disabled",
                Duration = 3
            })
        end
    })
    local function vu124()
        local v118 = vu107:FindFirstChild("Rendered")
        if not v118 then
            return nil
        end
        local v119, v120, v121 = ipairs(v118:GetChildren())
        while true do
            local v122
            v121, v122 = v119(v120, v121)
            if v121 == nil then
                break
            end
            if v122:IsA("Folder") and # v122:GetChildren() > 0 then
                local v123 = v122:GetChildren()[1]
                if v123 and (v123:IsA("Model") or v123:IsA("Part")) and # v123.Name >= 30 then
                    return v122
                end
            end
        end
        return nil
    end
    v114:AddToggle("AutoCollect", {
        Title = "Auto Collect Coins & Gems",
        Default = false,
        Callback = function(p125)
            vu112 = p125
            vu1:Notify({
                Title = "Auto Collect",
                Content = p125 and "Started" or "Stopped Collecting Coins & Gems",
                Duration = 3
            })
            if p125 then
                task.spawn(function()
                    while vu112 do
                        pcall(function()
                            local v126 = vu124()
                            if v126 then
                                local v127, v128, v129 = ipairs(v126:GetChildren())
                                while true do
                                    local v130
                                    v129, v130 = v127(v128, v129)
                                    if v129 == nil then
                                        break
                                    end
                                    if v130:IsA("Model") or v130:IsA("Part") then
                                        vu109:FireServer(v130.Name)
                                        v130:Destroy()
                                    end
                                end
                            end
                        end)
                        task.wait(0.3)
                    end
                end)
            end
        end
    })
    local v131 = game:GetService("ReplicatedStorage")
    local vu132 = v131.Shared.Framework.Network.Remote.RemoteFunction
    local vu133 = v131.Shared.Framework.Network.Remote.RemoteEvent
    local v134 = v6.AutoFarm:AddSection("Auto Claim")
    local vu135 = false
    v134:AddToggle("AutoClaimPlaytimeToggle", {
        Title = "Auto Claim Playtime",
        Default = false,
        Callback = function(p136)
            vu135 = p136
            if p136 then
                vu1:Notify({
                    Title = "Auto Claim",
                    Content = "Started claiming playtime rewards",
                    Duration = 3
                })
                task.spawn(function()
                    while true do
                        if not vu135 then
                            return
                        end
                        for v137 = 1, 9 do
                            local vu138 = v137
                            if not vu135 then
                                break
                            end
                            pcall(function()
                                vu132:InvokeServer("ClaimPlaytime", vu138)
                                print("Claimed playtime reward:", vu138)
                            end)
                            task.wait(1)
                        end
                        task.wait(10)
                    end
                end)
            else
                vu1:Notify({
                    Title = "Auto Claim",
                    Content = "Stopped claiming playtime rewards",
                    Duration = 3
                })
            end
        end
    })
    local vu139 = false
    v134:AddToggle("AutoClaimSeasonToggle", {
        Title = "Auto Claim Season Pass",
        Default = false,
        Callback = function(p140)
            vu139 = p140
            vu1:Notify({
                Title = "Auto Claim Season Pass",
                Content = p140 and "Started claiming" or "Stopped claiming",
                Duration = 3
            })
            if p140 then
                task.spawn(function()
                    while vu139 do
                        pcall(function()
                            vu133:FireServer("ClaimSeason")
                        end)
                        task.wait(0.01)
                    end
                end)
            end
        end
    })
    local v141 = v6.AutoFarm:AddSection("Auto Tickets")
    local vu142 = false
    v141:AddToggle("AutoSpinTicketsToggle", {
        Title = "Auto Use Spin Tickets",
        Default = false,
        Callback = function(p143)
            vu142 = p143
            vu1:Notify({
                Title = "Auto Spin Tickets",
                Content = p143 and "Started" or "Stopped",
                Duration = 3
            })
            if p143 then
                task.spawn(function()
                    while vu142 do
                        pcall(function()
                            vu132:InvokeServer("WheelSpin")
                            task.wait(0.01)
                            vu133:FireServer("ClaimWheelSpinQueue")
                        end)
                        task.wait(0.01)
                    end
                end)
            end
        end
    })
    local vu144 = false
    v141:AddToggle("AutoFestivalTicketsToggle", {
        Title = "Auto Use Festival Tickets",
        Default = false,
        Callback = function(p145)
            vu144 = p145
            vu1:Notify({
                Title = "Auto Festival Tickets",
                Content = p145 and "Started" or "Stopped",
                Duration = 3
            })
            if p145 then
                task.spawn(function()
                    while vu144 do
                        pcall(function()
                            vu132:InvokeServer("FestivalWheelSpin")
                            task.wait(0.01)
                            vu133:FireServer("ClaimFestivalWheelSpinQueue")
                        end)
                        task.wait(0.01)
                    end
                end)
            end
        end
    })
    local v146 = v6.AutoFarm:AddSection("Auto Mystery Box")
    local vu147 = v131.Shared.Framework.Network.Remote.RemoteEvent
    local vu148 = 50
    local vu149 = false
    local function vu151(pu150)
        pcall(function()
            vu147:FireServer("UseGift", "Mystery Box", pu150)
        end)
    end
    local function vu163()
        local vu152 = vu107:FindFirstChild("Rendered")
        if vu152 then
            vu152 = vu107.Rendered:FindFirstChild("Gifts")
        end
        if vu152 then
            local v153, v154, v155 = ipairs(vu152:GetChildren())
            local v156 = {}
            while true do
                local v157
                v155, v157 = v153(v154, v155)
                if v155 == nil then
                    break
                end
                table.insert(v156, v157.Name)
            end
            local v158, v159, v160 = ipairs(v156)
            while true do
                local vu161
                v160, vu161 = v158(v159, v160)
                if v160 == nil then
                    break
                end
                pcall(function()
                    vu147:FireServer("ClaimGift", vu161)
                    local v162 = vu152:FindFirstChild(vu161)
                    if v162 then
                        v162:Destroy()
                    end
                end)
            end
        end
    end
    local function vu164()
        while vu149 do
            vu151(vu148)
            task.wait(0.5)
            vu163()
            task.wait(3)
        end
    end
    v146:AddToggle("AutoOpenMysteryBoxToggle", {
        Title = "Auto Open Mystery Boxes",
        Default = false,
        Callback = function(p165)
            vu149 = p165
            if p165 then
                task.spawn(vu164)
                vu1:Notify({
                    Title = "Mystery Box",
                    Content = "Started auto-opening mystery boxes",
                    Duration = 3
                })
            else
                vu1:Notify({
                    Title = "Mystery Box",
                    Content = "Stopped auto-opening mystery boxes",
                    Duration = 3
                })
            end
        end
    })
    local v166 = v6.Minigames:AddSection("Dice Roll")
    local vu167 = v6.Minigames:AddSection("Minigames")
    local vu168 = "Dice"
    v166:AddDropdown("DiceRollDropdown", {
        Title = "Select Dice",
        Default = "Dice",
        Values = {
            "Dice",
            "Giant Dice",
            "Golden Dice"
        },
        Callback = function(p169)
            vu168 = p169
        end
    })
    AutoRollDiceToggle = v166:AddToggle("AutoRollDiceToggle", {
        Title = "Auto Roll Dice",
        Default = false,
        Callback = function(p170)
            if p170 then
                task.spawn(function()
                    while AutoRollDiceToggle.Value do
                        local _, _ = pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction"):InvokeServer("RollDice", vu168)
                            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer("ClaimTile")
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })
    local vu171 = "Easy"
    local v172 = vu167
    local v174 = {
        Title = "Select Difficulty (For Minigames)",
        Default = "Easy",
        Values = {
            "Easy",
            "Medium",
            "Hard",
            "Insane"
        },
        Callback = function(p173)
            vu171 = p173
        end
    }
    vu167.AddDropdown(v172, "DifficultySelectDropdown", v174)
    local function v182(p175, pu176, pu177)
        local vu178 = nil
        local v181 = vu167:AddToggle(p175 .. "Toggle", {
            Title = "Auto " .. p175,
            Default = false,
            Callback = function(p179)
                if p179 then
                    task.spawn(function()
                        while vu178.Value do
                            pcall(function()
                                local v180 = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent")
                                v180:FireServer("SkipMinigameCooldown", pu176)
                                task.wait(pu177[1])
                                v180:FireServer("StartMinigame", pu176, vu171)
                                task.wait(pu177[2])
                                v180:FireServer("FinishMinigame")
                                task.wait(pu177[3])
                            end)
                            task.wait(0.1)
                        end
                    end)
                end
            end
        })
        return v181
    end
    v182("HyperDarts", "Hyper Darts", {
        2.5,
        30,
        2.5
    })
    v182("RobotClaw", "Robot Claw", {
        0.5,
        3,
        2.5
    })
    v182("CartEscape", "Cart Escape", {
        3,
        22,
        2.5
    })
    v182("PetMatch", "Pet Match", {
        0.5,
        0.5,
        0.1
    })
    local v183 = v6.Buy:AddSection("Shops")
    local vu184 = {
        "BlueBerry",
        "Cherry",
        "Pizza",
        "Watermelon",
        "Chocolate",
        "Contrast",
        "Gold",
        "Lemon",
        "Donut",
        "Swirl",
        "Molten",
        "Abstract",
        "Classic"
    }
    local vu185 = {
        "Stretchy Gum",
        "Chewy Gum",
        "Epic Gum",
        "Ultra Gum",
        "Omega Gum",
        "Unreal Gum",
        "Cosmic Gum",
        "XL Gum",
        "Mega Gum",
        "Quantum Gum",
        "Alien Gum",
        "Radioactive Gum",
        "Experiment #52",
        "Void Gum",
        "RoboGum",
        "Retro Gum"
    }
    local vu186 = {
        "Buffs",
        "Pets",
        "Shops",
        "Rifts"
    }
    local vu187 = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
    local vu188 = nil
    vu188 = v183:AddToggle("autobuygum", {
        Title = "Auto Buy Flavours",
        Default = false,
        Callback = function(p189)
            if p189 then
                task.spawn(function()
                    while vu188.Value do
                        local v190, v191, v192 = ipairs(vu184)
                        while true do
                            local vu193
                            v192, vu193 = v190(v191, v192)
                            if v192 == nil or not vu188.Value then
                                break
                            end
                            pcall(function()
                                vu187:FireServer("GumShopPurchase", vu193)
                            end)
                            task.wait(2)
                        end
                        task.wait(5)
                    end
                end)
            end
        end
    })
    local vu194 = nil
    vu194 = v183:AddToggle("autobuystorage", {
        Title = "Auto Buy Storage",
        Default = false,
        Callback = function(p195)
            if p195 then
                task.spawn(function()
                    while vu194.Value do
                        local v196, v197, v198 = ipairs(vu185)
                        while true do
                            local vu199
                            v198, vu199 = v196(v197, v198)
                            if v198 == nil or not vu194.Value then
                                break
                            end
                            pcall(function()
                                vu187:FireServer("GumShopPurchase", vu199)
                            end)
                            task.wait(2)
                        end
                        task.wait(5)
                    end
                end)
            end
        end
    })
    local vu200 = nil
    vu200 = v183:AddToggle("autoupgrademastery", {
        Title = "Auto Upgrade Mastery",
        Default = false,
        Callback = function(p201)
            if p201 then
                task.spawn(function()
                    while vu200.Value do
                        local v202, v203, v204 = ipairs(vu186)
                        while true do
                            local vu205
                            v204, vu205 = v202(v203, v204)
                            if v204 == nil or not vu200.Value then
                                break
                            end
                            pcall(function()
                                vu187:FireServer("UpgradeMastery", vu205)
                            end)
                            task.wait(1)
                        end
                        task.wait(10)
                    end
                end)
            end
        end
    })
    local vu206 = nil
    vu206 = v183:AddToggle("autobuyblackmarket", {
        Title = "Auto Buy Blackmarket Shop",
        Default = false,
        Callback = function(p207)
            if p207 then
                task.spawn(function()
                    local v208 = 1
                    while vu206.Value do
                        vu187:FireServer("BuyShopItem", "shard-shop", v208, true)
                        v208 = v208 % 3 + 1
                        task.wait(1)
                    end
                end)
            end
        end
    })
    local vu209 = nil
    vu209 = v183:AddToggle("autobuyalien", {
        Title = "Auto Buy Alien Shop",
        Default = false,
        Callback = function(p210)
            if p210 then
                task.spawn(function()
                    local v211 = 1
                    while vu209.Value do
                        vu187:FireServer("BuyShopItem", "alien-shop", v211, true)
                        v211 = v211 % 3 + 1
                        task.wait(1)
                    end
                end)
            end
        end
    })
    local vu212 = nil
    vu212 = v183:AddToggle("autobuyfestival", {
        Title = "Auto Buy Festival Shop",
        Default = false,
        Callback = function(p213)
            if p213 then
                task.spawn(function()
                    local v214 = 1
                    while vu212.Value do
                        vu187:FireServer("BuyShopItem", "festival-shop", v214, true)
                        v214 = v214 % 3 + 1
                        task.wait(1)
                    end
                end)
            end
        end
    })
    local vu215 = nil
    vu215 = v183:AddToggle("autobuydice", {
        Title = "Auto Buy Dice Shop",
        Default = false,
        Callback = function(p216)
            local vu217 = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent
            if p216 then
                task.spawn(function()
                    local vu218 = 1
                    while vu215.Value do
                        pcall(function()
                            vu217:FireServer("BuyShopItem", "dice-shop", vu218, true)
                        end)
                        local v219 = vu218 % 3 + 1
                        task.wait(1)
                        vu218 = v219
                    end
                end)
            end
        end
    })
    local v220 = v6.Teleport:AddSection("World 1")
    local v221 = {
        Spawn = CFrame.new(58, 22, - 71),
        ["Floating Island"] = CFrame.new(- 16, 423, 143),
        ["Outer Space"] = CFrame.new(41, 2663, - 7),
        Twilight = CFrame.new(- 78, 6862, 88),
        ["The Void"] = CFrame.new(16, 10146, 151),
        Zen = CFrame.new(36, 15971, 41)
    }
    local v222, v223, v224 = ipairs({
        "Spawn",
        "Floating Island",
        "Outer Space",
        "Twilight",
        "The Void",
        "Zen"
    })
    local v225 = vu1
    while true do
        local v226
        v224, v226 = v222(v223, v224)
        if v224 == nil then
            break
        end
        local vu227 = v221[v226]
        v220:AddButton({
            Title = "Teleport To " .. v226,
            Callback = function()
                local v228 = game.Players.LocalPlayer;
                (v228.Character or v228.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = vu227
            end
        })
    end
    v2:SetLibrary(v225)
    v3:SetLibrary(v225)
    v2:IgnoreThemeSettings()
    v2:SetIgnoreIndexes({})
    v3:SetFolder("FluentScriptHub")
    v2:SetFolder("FluentScriptHub/specific-game")
    v3:BuildInterfaceSection(v6.Settings)
    v2:BuildConfigSection(v6.Settings)
    v5:SelectTab(1)
    v225:Notify({
        Title = "Bgsi Script Loaded",
        Content = "",
        Duration = 5
    })
    v2:LoadAutoloadConfig()
else
    warn("[WARN] HTTP Support not found.")
end
