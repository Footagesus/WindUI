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
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
		end
	end
end

--WindUI.TransparencyValue = .9
local ThemeName = "Dark"

local Window = WindUI:CreateWindow({
	Title = "WindUI Library",
	Author = "by .ftgs",
	Icon = "solar:wind-bold",
	Theme = ThemeName,
	--NewElements = true,
	--Transparent = true,
	ToggleKey = Enum.KeyCode.F,
	--Acrylic = true,

	--[[
	KeySystem = {
		Title = "Key System",
		Description = "Enter the correct key to unlock the window",
		KeyValidator = function(key)
			return key == "HelloWorld"
		end,
	}
	]]
})

Window:Tag({
	Title = "v1.6.64-fix",
	Color = "ElementBackground",
})

Window:Tab({
	Title = "Main",
	Icon = "warehouse",
})

Window:Section({
	Title = "Silent",
})

local Tab1 = Window:Tab({
	Title = "Exploits",
	Icon = "terminal",
})

Window:Tab({
	Title = "Aimbot",
	Icon = "locate-fixed",
})

Window:Tab({
	Title = "ESP",
	Icon = "eye",
})

local InfoTab = Window:Tab({
	Title = "Info",
	Icon = "badge-info",
})

InfoTab:Paragraph({
	Title = "WindUI",
	Desc = "WindUI is a open source UI library for Roblox Script Hubs",
	Buttons = {
		{
			Title = "GitHub",
			Callback = function()
				print("GitHub Button Clicked")
			end,
		},
		{
			Title = "Documentation",
			Variant = "Secondary",
			Callback = function()
				print("Documentation Button Clicked")
			end,
		},
	},
})

local HStack1 = InfoTab:HStack()

local VStackLeft = HStack1:VStack()
local VStackRight = HStack1:VStack()

VStackLeft:Button({
	Title = "Reload UI",
	Justify = "Center",
	Icon = "refresh-ccw",
	IconAlign = "Left",
	Color = Color3.fromHex("#F44732"),
	Callback = function()
		print("Reloading UI...")
	end,
})

VStackRight:Button({
	Title = "Rejoin Place",
	Justify = "Center",
	Icon = "log-out",
	IconAlign = "Left",
	Color = Color3.fromHex("#f4b332"),
	Callback = function()
		print("Rejoining place...")
	end,
})

local Section = Tab1:Section({
	Title = "Hi1",
	Icon = "rbxassetid://77799629590713",
	IconThemed = true,
	Box = true,
	BoxBorder = true,
})

local Viewport = Section:Viewport({
	Object = Instance.new("Part"),
	Interactive = true,
})

Section:Input({
	Title = "Leave at Wave",
	Desc = "Enter a wave number to automatically leave the raid at that wave (0 = never leave)",
	Icon = "log-out",
	Type = "Default",
	Placeholder = "e.g. 50",
	Value = "0",
	Flag = "ninja_raid_leave_wave",
	Callback = function(text)
		--[[local num = tonumber(text)
		if num then
			ninjaRaid_leaveWave = math.floor(num)
		else
			ninjaRaid_leaveWave = 0
		end]]
	end,
})

local EmptyTab = Window:Tab({
	Title = "Custom empty page tab",

	CustomEmptyPage = {
		Icon = "lucide:smile",
		Title = "This is a cool empty tab",
		Desc = "I like it. its so great tab with cool 'custom empty page'",
	},
})
