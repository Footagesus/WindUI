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

	-- KeySystem = {
	-- 	Title = "SUper key Sustem",
	-- 	Note = "fejnighsrbefijdkamejsh",
	-- 	KeyValidator = function(Key)
	-- 		return Key == "HelloWorld"
	-- 	end,
	-- },
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

Window:Tab({
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
