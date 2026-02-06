--[[

    Panda Development API   |   https://pandadevelopment.net/
    
]]

local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)

local HttpService = cloneref(game:GetService("HttpService"))
local PandaDevelopment = {}

function PandaDevelopment.New(serviceId)
	local hwid = gethwid or function()
		return cloneref(game:GetService("Players")).LocalPlayer.UserId
	end
	local frequest, fsetclipboard = request or http_request or syn_request, setclipboard or toclipboard

	function ValidateKey(key)
		local validationUrl = "https://new.pandadevelopment.net/api/v1/keys/validate"

		local payload = {
			ServiceID = serviceId,
			HWID = tostring(hwid()),
			Key = tostring(key),
		}

		local jsonData = HttpService:JSONEncode(payload)
		local success, response = pcall(function()
			return frequest({
				Url = validationUrl,
				Method = "POST",
				Headers = {
					["User-Agent"] = "Roblox/Exploit",
					["Content-Type"] = "application/json",
				},
				Body = jsonData,
			})
		end)

		if success and response then
			if response.Success then
				local decodeSuccess, jsonData = pcall(function()
					return HttpService:JSONDecode(response.Body)
				end)

				if decodeSuccess and jsonData then
					if jsonData.Authenticated_Status and jsonData.Authenticated_Status == "Success" then
						return true, "Authenticated"
					else
						local reason = jsonData.Note or "Unknown reason"
						return false, "Authentication failed: " .. reason
					end
				else
					return false, "JSON decode error"
				end
			else
				warn(
					" HTTP request was not successful. Code: "
						.. tostring(response.StatusCode)
						.. " Message: "
						.. response.StatusMessage
				)
				return false, "HTTP request failed: " .. response.StatusMessage
			end
		else
			return false, "Request pcall error"
		end
	end

	function GetKeyLink()
		return "https://new.pandadevelopment.net/getkey/" .. tostring(serviceId) .. "?hwid=" .. tostring(hwid())
	end

	function CopyLink()
		return fsetclipboard(GetKeyLink())
	end

	return {
		Verify = ValidateKey,
		Copy = CopyLink,
	}
end

return PandaDevelopment
