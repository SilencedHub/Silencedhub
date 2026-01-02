-- [[ SILENCED BGSI - NO-LOADSTRING EDITION ]] --
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

-- [[ WEBHOOK CONFIG ]] --
local WebhookURL = "YOUR_WEBHOOK_URL_HERE"

local function SendHatchWebhook(petName, petStats, rarityType)
    local player = Players.LocalPlayer
    local stats = player:WaitForChild("leaderstats")
    
    local data = {
        ["content"] = "@everyone **" .. rarityType:upper() .. " HATCHED!**",
        ["embeds"] = {{
            ["title"] = "||" .. player.Name .. "|| hatched a " .. petName,
            ["color"] = 16768256,
            ["fields"] = {
                {["name"] = "User Info:", ["value"] = "🧼 **Bubbles:** " .. stats.Bubbles.Value .. "\n💰 **Coins:** " .. stats.Coins.Value, ["inline"] = false},
                {["name"] = "Pet Info:", ["value"] = petStats, ["inline"] = false}
            }
        }}
    }
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({Url = WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(data)})
    end
end

-- [[ SIMPLE NATIVE UI ]] --
-- This creates a screen GUI directly so it CANNOT fail to load
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0.5, -100, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "SILENCED BGSI"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- AUTO SPAM E BUTTON
local SpamButton = Instance.new("TextButton", Frame)
SpamButton.Size = UDim2.new(0.9, 0, 0, 40)
SpamButton.Position = UDim2.new(0.05, 0, 0.2, 0)
SpamButton.Text = "Auto Spam E: OFF"
SpamButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpamButton.TextColor3 = Color3.new(1, 1, 1)

local spamming = false
SpamButton.MouseButton1Click:Connect(function()
    spamming = not spamming
    SpamButton.Text = "Auto Spam E: " .. (spamming and "ON" or "OFF")
    SpamButton.BackgroundColor3 = spamming and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    
    task.spawn(function()
        while spamming do
            VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.01)
            VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            task.wait(0.01)
        end
    end)
end)

-- HIDE HATCH BUTTON
local HatchButton = Instance.new("TextButton", Frame)
HatchButton.Size = UDim2.new(0.9, 0, 0, 40)
HatchButton.Position = UDim2.new(0.05, 0, 0.4, 0)
HatchButton.Text = "Hide Hatch: OFF"
HatchButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HatchButton.TextColor3 = Color3.new(1, 1, 1)

local hiding = false
HatchButton.MouseButton1Click:Connect(function()
    hiding = not hiding
    HatchButton.Text = "Hide Hatch: " .. (hiding and "ON" or "OFF")
    HatchButton.BackgroundColor3 = hiding and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    
    task.spawn(function()
        while hiding do
            local pGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
            local ui = pGui and (pGui:FindFirstChild("HatchUI") or pGui:FindFirstChild("EggHatch"))
            if ui then ui.Enabled = false end
            task.wait(0.1)
        end
    end)
end)

-- TP TO COMMON EGG
local TPButton = Instance.new("TextButton", Frame)
TPButton.Size = UDim2.new(0.9, 0, 0, 40)
TPButton.Position = UDim2.new(0.05, 0, 0.6, 0)
TPButton.Text = "TP to Common Egg"
TPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TPButton.TextColor3 = Color3.new(1, 1, 1)

TPButton.MouseButton1Click:Connect(function()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(-83, 9, 3) end
end)

-- WEBHOOK DETECTION
game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent.OnClientEvent:Connect(function(name, data)
    if name == "OpenEgg" and data and data.Rarity == "Secret" then
        SendHatchWebhook(data.PetName, "🔥 Multi: " .. (data.Multiplier or "1"), "Secret")
    end
end)
