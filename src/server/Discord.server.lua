local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remote = Instance.new("RemoteFunction")
Remote.Name = "GetDiscordInviteData"
Remote.Parent = ReplicatedStorage

local BaseUrl = "https://discord.com/api/v10/invites/"

local function FetchInviteData(InviteCode)
	local Url = BaseUrl .. InviteCode .. "?with_counts=true&with_expiration=true"
	local Response = HttpService:GetAsync(Url)
	return HttpService:JSONDecode(Response)
end

Remote.OnServerInvoke = function(Player, InviteCode)
	if type(InviteCode) ~= "string" then
		return nil
	end

	local Success, Result = pcall(function()
		return FetchInviteData(InviteCode)
	end)

	if not Success then
		return nil
	end

	return Result
end