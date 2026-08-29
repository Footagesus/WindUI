local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

local function getAspectRatio(value)
	if type(value) == "number" then return value end
	local width, height = tostring(value or "16:9"):match("(%d+):(%d+)")
	return width and tonumber(width) / tonumber(height) or (16 / 9)
end

local function resolveVideo(source, folder, callback, forceExtension)
	if not source:find("^https?://") then callback(source) return end
	task.spawn(function()
		local extension = forceExtension or source:lower():match("%.([a-z0-9]+)[%?&]?") or "webm"
		local fileName = "WindUI/" .. (folder or "Temp") .. "/assets/.Video-" .. Creator.SanitizeFilename(source) .. "." .. extension
		if not (isfile and isfile(fileName)) then
			local success, response = pcall(function()
				return Creator.Request and Creator.Request({ Url = source, Method = "GET" }).Body or game:HttpGet(source)
			end)
			if not success or not response then warn("[ WindUI.Video ] Failed to download video: " .. tostring(response)) return end
			if writefile then writefile(fileName, response) end
		end
		local success, asset = pcall(getcustomasset, fileName)
		if success then callback(asset) else warn("[ WindUI.Video ] Failed to load custom asset: " .. tostring(asset)) end
	end)
end

function Element:New(config)
	local video = { __type = "Video", Source = config.Video or config.Source or "", ElementFrame = nil }
	local isGif = video.Source:lower():match("%.gif[%?&]?") ~= nil
	local radius = config.Radius or config.Window.ElementConfig.UICorner
	local cardTransparency = config.Window.Background and math.max(config.Window.BackgroundElementTransparency or 0, 0.9) or 0.965
	local card = Creator.NewRoundFrame(radius, "Squircle", {
		Parent = config.Parent, Size = UDim2.new(1, 0, 0, config.Height or 220), ImageTransparency = cardTransparency,
		ThemeTag = { ImageColor3 = "Text" },
	})
	local frame = New(isGif and "ImageLabel" or "VideoFrame", {
		Parent = card, Size = UDim2.new(1, -10, 1, -10), Position = UDim2.new(0, 5, 0, 5), BackgroundTransparency = 1,
		Looped = not isGif and config.Loop == true or nil, Volume = not isGif and (config.Muted ~= false and 0 or (config.Volume or 1)) or nil,
		ScaleType = isGif and "Crop" or nil,
	})
	New("UICorner", { Parent = frame, CornerRadius = UDim.new(0, math.max(radius - 4, 0)) })
	video.ElementFrame = card
	video.UIElements = { Main = card, Video = frame }
	local assetSource = video.Source
	if isGif and assetSource:find("discordapp%.net") then
		assetSource = assetSource .. (assetSource:find("?", 1, true) and "&" or "?") .. "format=png"
	end
	resolveVideo(assetSource, config.Window.Folder, function(asset)
		if not frame.Parent then return end
		if isGif then
			frame.Image = asset
		else
			frame.Video = asset
			if config.Autoplay ~= false then frame:Play() end
		end
	end, isGif and "png" or nil)
	function video:Play() if not isGif then frame:Play() end end
	function video:Pause() if not isGif then frame:Pause() end end
	function video:Destroy() card:Destroy() end
	return video.__type, video
end

return Element
