

--[[

    Panda Development API   |   https://pandadevelopment.net/
    
]]

local HttpService = game:GetService("HttpService")
local PandaDevelopment = {}


function PandaDevelopment.New(serviceId)
    local hwid = gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
    local frequest, fsetclipboard = request or http_request or syn_request, setclipboard or toclipboard

    function ValidateKey(key)
        local validationUrl = "https://pandadevelopment.net/v2_validation?key=" .. tostring(key) .. "&service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid())
    
        
        local success, response = pcall(function()
            return frequest({
                Url = validationUrl,
                Method = "GET",
                Headers = { ["User-Agent"] = "Roblox/Exploit" }
            })
        end)

        print(success)
        print(response)
        
        if success and response then
            if response.Success then
                local decodeSuccess, jsonData = pcall(function()
                    return HttpService:JSONDecode(response.Body)
                end)
                
                if decodeSuccess and jsonData then
                    if jsonData.V2_Authentication and jsonData.V2_Authentication == "success" then
                        --print("[Pelinda Ov2.5] Authenticated successfully.")
                        return true, "Authenticated"
                    else
                        local reason = jsonData.Key_Information.Notes or "Unknown reason"
                        --print("[Pelinda Ov2.5] Authentication failed. Reason: " .. reason)
                        return false, "Authentication failed: " .. reason
                    end
                else
                    --warn("[Pelinda Ov2.5] Failed to decode JSON response.")
                    return false, "JSON decode error"
                end
            else
                warn("[Pelinda Ov2.5] HTTP request was not successful. Code: " .. tostring(response.StatusCode) .. " Message: " .. response.StatusMessage)
                return false, "HTTP request failed: " .. response.StatusMessage
            end
        else
            --warn("[Pelinda Ov2.5] pcall failed for HttpService:RequestAsync. Error: " .. tostring(response))
            return false, "Request pcall error"
        end
    end
    
    function GetKeyLink()
        return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(hwid())
    end
    
    function CopyLink()
        return fsetclipboard(GetKeyLink())
    end
    
    return {
        Verify = ValidateKey,
        Copy = CopyLink
    }
end

return PandaDevelopment
