--[[
    WindUI Example 2
]]

local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))
local Players = cloneref(game:GetService("Players"))

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

--[[ local function LoadFont()
	local FontUrl = "https://github.com/vercel/geist-font/raw/refs/heads/main/fonts/Geist/otf/Geist-SemiBold.otf"

	if not isfile then
		return
	end

	
	local Response = WindUI.Creator.Request({
		Url = FontUrl,
		Method = "GET",
	})
	
	if Response.Success then
		local FontData = Response.Body
		local FontPath = "WindUI/Geist-SemiBold.ttf"
		
		if writefile then
			writefile(FontPath, FontData)

			local json = {
				name = "Geist",
				faces = {
					{
						weight = 600,
						style = "SemiBold",
						src = getcustomasset(FontPath),
					},
					-- ...
				}
			}

			--writefile("WindUI/Geist.json", game:GetService("HttpService"):JSONEncode(json))

			--return getcustomasset("WindUI/Geist.json")
			return game:GetService("HttpService"):JSONEncode(json)
		end
	end
end 

local Font = LoadFont()
print(Font)
WindUI:SetFont(Font)

print(getcustomasset("rbxasset://fonts/families/GothamSSm.json"))
]]

local Window = WindUI:CreateWindow({
	Title = "Beta",
	NewElements = true,
	Theme = "Dark",
	Size = UDim2.new(0, 840, 0, 500),
	MinSize = Vector2.new(815, 400),
	MaxSize = Vector2.new(1000, 700),
	--Transparent = true,
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

local PlayerParagraph = Tab:Paragraph({
	Title = "...",
	Desc = "...",
	Image = Players:GetUserThumbnailAsync(1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420),
	--Color = Color3.fromHex("#30ff6a"),
})

local PlayersTable = {}

function RefreshPlayersTable()
	PlayersTable = {}
	for _, Player in next, Players:GetChildren() do
		table.insert(PlayersTable, {
			Title = Player.DisplayName,
			_Name = Player.Name,
			_UserId = Player.UserId,
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
		print("Selected Player:", selectedplayer.Title)

		PlayerParagraph:SetTitle(selectedplayer.Title)
		PlayerParagraph:SetDesc(selectedplayer._Name)
		PlayerParagraph:SetImage(selectedplayer.Icon)
	end,
})

Dropdown:Refresh(RefreshPlayersTable())

-- autp update players list when player joins/leaves
Players.ChildAdded:Connect(function()
	Dropdown:Refresh(RefreshPlayersTable())
end)
Players.ChildRemoved:Connect(function()
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

local CoolTab = Window:Tab({
	Title = "Cool Tab",
})

CoolTab:Toggle({
	Title = "Toggle Example",
	Value = true,
	Callback = function(value)
		print("Toggle Value:", value)
	end,
})

CoolTab:Slider({
	Title = "Slider Example",
	Value = {
		Min = 0,
		Max = 100,
		Default = 50,
	},
	Width = 250,
	IsTooltip = true,
	Callback = function(value)
		print("Slider Value:", value)
	end,
})

-- tab 3

local Tab3 = Window:Tab({
	Title = "Tab 3",
})

local HStack = Tab3:HStack({ AutoSpace = true })

local VStackLeft = HStack:VStack() -- left
local VStackRight = HStack:VStack() -- right
local VStackThird = HStack:VStack() -- third

-- left
VStackLeft:Paragraph({
	Title = "[HIDDEN]" or Players.LocalPlayer.DisplayName,
	Desc = "[HIDDEN]" or Players.LocalPlayer.Name,
	Image = Players:GetUserThumbnailAsync(
		Players.LocalPlayer.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size420x420
	),
	ImageSize = 70,
})

VStackLeft:Button({
	Title = "Reset Character",
	Callback = function()
		Players.LocalPlayer.Character:BreakJoints()
	end,
})

VStackLeft:Button({
	Title = "Leave Game",
	Callback = function()
		Players.LocalPlayer:Kick("You left the game.")
	end,
})

-- right

local PlaceInfo = MarketplaceService:GetProductInfoAsync(game.PlaceId)

VStackRight:Paragraph({
	Title = PlaceInfo.Name,
	Desc = PlaceInfo.Description or "Cool Place!!",
	Image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="
		.. game.PlaceId
		.. "&fmt=png&wd=420&ht=420",
	ImageSize = 70,
})

VStackRight:Button({
	Title = "Copy Place ID",
	Callback = function()
		if setclipboard then
			setclipboard(game.PlaceId)
		else
			print("Place ID:", game.PlaceId)
		end
	end,
})

VStackRight:Button({
	Title = "Copy Game ID",
	Callback = function()
		if setclipboard then
			setclipboard(game.GameId)
		else
			print("Game ID:", game.GameId)
		end
	end,
})

VStackRight:Button({
	Title = "Copy Creator ID",
	Callback = function()
		if setclipboard then
			setclipboard(PlaceInfo.Creator.Id)
		else
			print("Creator ID:", PlaceInfo.Creator.Id)
		end
	end,
})

VStackRight:Button({
	Title = "Copy Creator Name",
	Callback = function()
		if setclipboard then
			setclipboard(PlaceInfo.Creator.Name)
		else
			print("Creator Name:", PlaceInfo.Creator.Name)
		end
	end,
})

-- third

-- create some elements pls

VStackThird:Paragraph({
	Title = "Paragraph in Third VStack",
	Desc = "This is a paragraph inside the third VStack.",
})

VStackThird:Space()

VStackThird:Button({
	Title = "Print Window Size",
	Icon = "app-window",
	Callback = function()
		print("UI Size:", Window.Size)
	end,
})

VStackThird:Space()

VStackThird:Toggle({
	Title = "Toggle in Third VStack",
	Value = false,
	Callback = function(value)
		print("Toggle in third VStack value:", value)
	end,
})

local TestTab = Window:Tab({
	Title = "Tab for testing",
})

somevalue = {
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
	"eleven",
	"twelve",
	"thirteen",
	"fourteen",
	"fifteen",
	"sixteen",
	"seventeen",
	"eighteen",
	"nineteen",
	"twenty",
	"twenty-one",
	"twenty-two",
	"twenty-three",
	"twenty-four",
	"twenty-five",
	"twenty-six",
	"twenty-seven",
	"twenty-eight",
	"twenty-nine",
	"thirty",
	"thirty-one",
	"thirty-two",
	"thirty-three",
	"thirty-four",
	"thirty-five",
	"thirty-six",
	"thirty-seven",
	"thirty-eight",
	"thirty-nine",
	"forty",
}
local function one()
	local names = {}
	for name, _ in pairs(somevalue) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

TestTab:Dropdown({
	Title = "Test",
	Values = somevalue,
	Value = "one",
	Callback = function(Value)
		getgenv().im = somevalue[Value]
	end,
})

local ColorpickerTab = Window:Tab({
	Title = "Colorpicker Test",
})

local Colorpicker = ColorpickerTab:Colorpicker({
	Title = "Pick a color",
	Default = Color3.fromRGB(255, 0, 0),
	Transparency = 0,
})
