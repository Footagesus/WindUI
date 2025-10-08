

--[[

    Luarmor API   |   https://luarmor.net
    
]]

local Luarmor = {}


function Luarmor.New(scriptId, discord)
    local APIURL = "https://sdkapi-public.luarmor.net/library.lua"

    local API = loadstring(
        game.HttpGetAsync and game:HttpGetAsync(APIURL)
        or HttpService:GetAsync(APIURL)
    )()
    local fsetclipboard = setclipboard or toclipboard

    API.script_id = scriptId
    
    function ValidateKey(key)
        local status = API.check_key(key);
        --print(status)
        
        if (status.code == "KEY_VALID") then
            return true, "Whitelisted!"
            
        elseif (status.code == "KEY_HWID_LOCKED") then
            return false, "Key linked to a different HWID. Please reset it using our bot"
            
        elseif (status.code == "KEY_INCORRECT") then
            return false, "Key is wrong or deleted!"
        else
            return false, "Key check failed:" .. status.message .. " Code: " .. status.code
        end
    end
    
    function CopyLink()
        fsetclipboard(tostring(discord))
    end
    
    return {
        Verify = ValidateKey,
        Copy = CopyLink
    }
end


return Luarmor