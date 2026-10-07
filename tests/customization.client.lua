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

WindUI:SetFont("rbxassetid://11702779409")

local Window = WindUI:CreateWindow({
	Title = "PopHub",
	--Icon = "solar:balloon-bold",
	--Author = "by .ftgs",
	Theme = "Indigo",
	ToggleKey = Enum.KeyCode.RightShift,
	--AutoScale = false,
})

Window:DisableTopbarButtons({ "Fullscreen" })

local GeneralTab = Window:Tab({
	Title = "General",
	Icon = "solar:home-angle-2-bold",
})

GeneralTab:Paragraph({
	Title = "Creator",
	Desc = ".ftgs",
	--Image = "",
})

-- idk uhhhhh
