local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remote = Instance.new("RemoteFunction")
Remote.Name = "GetPullRequestData"
Remote.Parent = ReplicatedStorage

local BaseUrl = "https://api.github.com/repos/"

local function FetchPullRequestData(RepoOwner, RepoName, PullRequestNumber)
	if type(PullRequestNumber) ~= "number" then return nil end
	local Url = string.format("%s%s/%s/pulls/%d", BaseUrl, RepoOwner, RepoName, PullRequestNumber)
	local Response = HttpService:GetAsync(Url)
	return HttpService:JSONDecode(Response)
end

Remote.OnServerInvoke = function(Player, RepoOwner, RepoName, PullRequestNumber)
	if type(RepoOwner) ~= "string" or type(RepoName) ~= "string" then
		return nil
	end

	local Success, Result = pcall(function()
		return FetchPullRequestData(RepoOwner, RepoName, PullRequestNumber)
	end)

	if not Success then
		return nil
	end

	return Result
end