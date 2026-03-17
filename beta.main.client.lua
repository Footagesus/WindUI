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
	ShowTabTitle = true,
})

local Tab2 = Window:Tab({
	Title = "Tab 2",
	ShowTabTitle = true,
	TabTitleAlign = "Center",
})

local Tab3 = Window:Tab({
	Title = "Tab 3",
	ShowTabTitle = true,
	TabTitleAlign = "Right",
})

local Players = cloneref(game:GetService("Players"))

local PlayersTable = {}

function RefreshPlayersTable()
	PlayersTable = {}
	for _, Player in next, Players:GetChildren() do
		table.insert(PlayersTable, {
			Title = Player.Name .. "_Test12312123123123123123123123123",
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

-- tab 2

local Values = {
	"Value 1",
	"Value 2",
	"Value 3",
	"Value 4",
	"Value 5",
}

local Dropdown2
Dropdown2 = Tab2:Dropdown({
	Title = "Select Values",
	Values = Values,
	Value = "Value 1",
	Callback = function(selectedvalue)
		print("Selected Value:", selectedvalue)
	end,
})

local Section1 = Tab3:Section({
	Title = "Section Example",
})

local Group1 = Section1:Group() --HStack

local Button = Group1:Button({
	Title = "Button example 1",
	Callback = function()
		print("clicked")
	end,
})

local Button = Group1:Button({
	Title = "Button example 2",
	Callback = function()
		print("clicked")
	end,
})
