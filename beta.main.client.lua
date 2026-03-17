local CacheableContentProvider = game:GetService("CacheableContentProvider")
--[[
    WindUI Example 2
]]

local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))

local WindUI

do
	local ok, result = pcall(function()
		return require("./src/Init")
	end)

	if ok then
		WindUI = result
	else
		if RunService:IsStudio() or not writefile then
			WindUI = require(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init"))
		else
			WindUI =
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/beta/dist/main.lua"))()
		end
	end
end

local Window = WindUI:CreateWindow({
	Title = "Beta",
})

local Tab = Window:Tab({
	Title = "Tab 1",
})

local Players = cloneref(game:GetService("Players"))

local PlayersTable = {}

function RefreshPlayersTable()
	PlayersTable = {}
	for _, Player in next, Players:GetChildren() do
		table.insert(PlayersTable, {
			Title = Player.Name,
			Icon = Players:GetUserThumbnailAsync(
				Player.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size420x420
			),
		})
	end

	return PlayersTable
end

local Dropdown = Tab:Dropdown({
	Title = "Select Player",
	Values = {},
	Value = nil,
	Callback = function(selectedplayer)
		print("Selected Player:", selectedplayer)
	end,
})

Dropdown:Refresh(RefreshPlayersTable())

Players.ChildAdded:Connect(function()
	Dropdown:Refresh(RefreshPlayersTable())
end)
