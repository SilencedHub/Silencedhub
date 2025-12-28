if not getgenv().Config or not getgenv().Config.FastHatch then
    warn("[Alert] Auto-hatch disabled in Config.")
end

print("[OK] Fast Hatch enabled.")

local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local stopKeys = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.F] = true,
    [Enum.KeyCode.Q] = true,
    [Enum.KeyCode.G] = true,
}
local lastStopKeyPress = 0
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if stopKeys[input.KeyCode] then
        lastStopKeyPress = tick()
    end
end)

while task.wait(0.1) do
    if tick() - lastStopKeyPress >= 30 then
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    else
    end
end
