local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- if not RunService:IsStudio() and writefile then
--     warn("[Icons] This loader only works in Studio!")
--     return
-- end

print("[Icons] Loading icons from GitHub...")

local IconsURL = "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"
local Icons = nil

local success, result = pcall(function()
    local code = HttpService:GetAsync(IconsURL)
    return loadstring(code)()
end)

if success and result then
    Icons = result
    Icons.SetIconsType("lucide")
    print("[Icons] ✓ Icons loaded successfully!")
else
    warn("[Icons] ✗ Failed to load icons:", result)
    return
end

local RemoteFunction = Instance.new("RemoteFunction")
RemoteFunction.Name = "GetIcons"
RemoteFunction.Parent = ReplicatedStorage

RemoteFunction.OnServerInvoke = function(player, methodName, ...)
    if not Icons then
        return nil
    end
    
    if methodName and Icons[methodName] then
        return Icons[methodName](...)
    end
    
    return Icons
end

print("[Icons] ✓ RemoteFunction created! Clients can access icons.")
