-- Credits: https://devforum.roblox.com/t/realtime-richtext-lua-syntax-highlighting/2500399
-- Modified by me (Footagesus)

local highlighter = {}
local keywords = {
	lua = {
		"and",
		"break",
		"or",
		"else",
		"elseif",
		"if",
		"then",
		"until",
		"repeat",
		"while",
		"do",
		"for",
		"in",
		"end",
		"local",
		"return",
		"function",
		"export",
	},
	rbx = {
		"game",
		"workspace",
		"script",
		"math",
		"string",
		"table",
		"task",
		"wait",
		"select",
		"next",
		"Enum",
		"tick",
		"assert",
		"shared",
		"loadstring",
		"tonumber",
		"tostring",
		"type",
		"typeof",
		"unpack",
		"Instance",
		"CFrame",
		"Vector3",
		"Vector2",
		"Color3",
		"UDim",
		"UDim2",
		"Ray",
		"BrickColor",
		"OverlapParams",
		"RaycastParams",
		"Axes",
		"Random",
		"Region3",
		"Rect",
		"TweenInfo",
		"collectgarbage",
		"not",
		"utf8",
		"pcall",
		"xpcall",
		"_G",
		"setmetatable",
		"getmetatable",
		"os",
		"pairs",
		"ipairs",
	},
	operators = {
		"#",
		"+",
		"-",
		"*",
		"%",
		"/",
		"^",
		"=",
		"~",
		"=",
		"<",
		">",
	},
}

local colors = {
	numbers = Color3.fromHex("#FAB387"),
	boolean = Color3.fromHex("#FAB387"),
	operator = Color3.fromHex("#94E2D5"),
	lua = Color3.fromHex("#CBA6F7"),
	rbx = Color3.fromHex("#F38BA8"), -- def
	str = Color3.fromHex("#A6E3A1"),
	comment = Color3.fromHex("#9399B2"),
	null = Color3.fromHex("#F38BA8"), -- nil
	call = Color3.fromHex("#89B4FA"),
	self_call = Color3.fromHex("#89B4FA"),
	local_property = Color3.fromHex("#CBA6F7"),
}

local function createKeywordSet(keywords)
	local keywordSet = {}
	for _, keyword in ipairs(keywords) do
		keywordSet[keyword] = true
	end
	return keywordSet
end

local luaSet = createKeywordSet(keywords.lua)
local rbxSet = createKeywordSet(keywords.rbx)
local operatorsSet = createKeywordSet(keywords.operators)

local function getHighlight(tokens, index)
	local token = tokens[index]

	if colors[token .. "_color"] then
		return colors[token .. "_color"]
	end

	if tonumber(token) then
		return colors.numbers
	elseif token == "nil" then
		return colors.null
	elseif token:sub(1, 2) == "--" then
		return colors.comment
	elseif operatorsSet[token] then
		return colors.operator
	elseif luaSet[token] then
		return colors.lua
	elseif rbxSet[token] then
		return colors.rbx
	elseif token:sub(1, 1) == '"' or token:sub(1, 1) == "'" then
		return colors.str
	elseif token == "true" or token == "false" then
		return colors.boolean
	end

	if tokens[index + 1] == "(" then
		if tokens[index - 1] == ":" then
			return colors.self_call
		end

		return colors.call
	end

	if tokens[index - 1] == "." then
		if tokens[index - 2] == "Enum" then
			return colors.rbx
		end

		return colors.local_property
	end
end

function highlighter.run(source, newColors)
	if newColors ~= nil then
		for name, color in next, newColors do
			colors[name] = color
		end
	end

	local tokens = {}
	local currentToken = ""

	local inString = false
	local inComment = false
	local commentPersist = false

	for i = 1, #source do
		local character = source:sub(i, i)

		if inComment then
			if character == "\n" and not commentPersist then
				table.insert(tokens, currentToken)
				table.insert(tokens, character)
				currentToken = ""

				inComment = false
			elseif source:sub(i - 1, i) == "]]" and commentPersist then
				currentToken = currentToken .. "]"

				table.insert(tokens, currentToken)
				currentToken = ""

				inComment = false
				commentPersist = false
			else
				currentToken = currentToken .. character
			end
		elseif inString then
			if character == inString and source:sub(i - 1, i - 1) ~= "\\" or character == "\n" then
				currentToken = currentToken .. character
				inString = false
			else
				currentToken = currentToken .. character
			end
		else
			if source:sub(i, i + 1) == "--" then
				table.insert(tokens, currentToken)
				currentToken = "-"
				inComment = true
				commentPersist = source:sub(i + 2, i + 3) == "[["
			elseif character == '"' or character == "'" then
				table.insert(tokens, currentToken)
				currentToken = character
				inString = character
			elseif operatorsSet[character] then
				table.insert(tokens, currentToken)
				table.insert(tokens, character)
				currentToken = ""
			elseif character:match("[%w_]") then
				currentToken = currentToken .. character
			else
				table.insert(tokens, currentToken)
				table.insert(tokens, character)
				currentToken = ""
			end
		end
	end

	table.insert(tokens, currentToken)

	local highlighted = {}

	for i, token in ipairs(tokens) do
		local highlight = getHighlight(tokens, i)

		if highlight then
			local syntax = string.format(
				'<font color = "#%s">%s</font>',
				highlight:ToHex(),
				token:gsub("<", "&lt;"):gsub(">", "&gt;")
			)

			table.insert(highlighted, syntax)
		else
			table.insert(highlighted, token)
		end
	end

	return table.concat(highlighted)
end

return highlighter
