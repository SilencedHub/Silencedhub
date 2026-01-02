local function GetLibrary()
    local url = "https://raw.githubusercontent.com/Fluwwy/WindUI/main/Main.lua"
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and result then
        local loadSuccess, lib = pcall(function()
            return loadstring(result)()
        end)
        if loadSuccess then return lib end
    end
    return nil
end

local WindUI = GetLibrary()

-- If GitHub fails, try the Mirror link
if not WindUI then
    local mirrorUrl = "https://tree-hub.vercel.app/api/main/windui"
    local success, result = pcall(function()
        return game:HttpGet(mirrorUrl)
    end)
    if success and result then
        WindUI = loadstring(result)()
    end
end

-- CRITICAL CHECK
if not WindUI then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "POTASSIUM BLOCK",
        Text = "The executor is blocking the download. Try disabling your Anti-Virus or switching APIs.",
        Duration = 10
    })
    return
end

-- [[ THE REST OF YOUR SCRIPT ]] --
local Window = WindUI:CreateWindow({
    Title = "SILENCED BGSI",
    SubTitle = "Bubble Gum Simulator",
    Icon = "rbxassetid://10734950309", 
    Author = "Silenced",
    Folder = "SilencedConfig"
})

-- (Rest of the script logic continues below...)
print("UI Successfully Loaded!")
