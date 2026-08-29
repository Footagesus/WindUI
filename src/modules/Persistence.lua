local HttpService = game:GetService("HttpService")

local Persistence = {}

local function ensureFolder(path)
	if not isfolder or not makefolder then return false, "Filesystem API is unavailable" end
	if not isfolder(path) then makefolder(path) end
	return true
end

local function encodeValue(value)
	local valueType = typeof(value)
	if valueType == "Color3" then
		return { __winduiType = "Color3", value = value:ToHex() }
	end
	if valueType == "string" or valueType == "number" or valueType == "boolean" then
		return value
	end
	if valueType == "table" then
		local result = {}
		for key, child in next, value do
			if typeof(key) == "string" or typeof(key) == "number" then
				local encoded = encodeValue(child)
				if encoded ~= nil then result[key] = encoded end
			end
		end
		return result
	end
	return nil
end

local function decodeValue(value)
	if typeof(value) ~= "table" then return value end
	if value.__winduiType == "Color3" and typeof(value.value) == "string" then
		return Color3.fromHex(value.value)
	end
	local result = {}
	for key, child in next, value do
		if key ~= "__winduiType" then result[key] = decodeValue(child) end
	end
	return result
end

function Persistence.WriteJson(path, value)
	if not writefile then return false, "Filesystem API is unavailable" end
	local ok, encoded = pcall(function() return HttpService:JSONEncode(encodeValue(value)) end)
	if not ok then return false, tostring(encoded) end
	local wrote, err = pcall(writefile, path, encoded)
	if not wrote then return false, tostring(err) end
	return true
end

function Persistence.ReadJson(path)
	if not isfile or not readfile then return false, "Filesystem API is unavailable" end
	if not isfile(path) then return false, "File does not exist" end
	local ok, decoded = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
	if not ok then return false, tostring(decoded) end
	return true, decodeValue(decoded)
end

function Persistence.ListJson(path)
	if not listfiles then return {} end
	local ok = ensureFolder(path)
	if not ok then return {} end
	local files = {}
	for _, file in next, listfiles(path) do
		if file:sub(-5) == ".json" then table.insert(files, file) end
	end
	table.sort(files)
	return files
end

function Persistence.EnsureFolder(path)
	return ensureFolder(path)
end

return Persistence
