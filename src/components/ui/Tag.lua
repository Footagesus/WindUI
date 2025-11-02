local Tag = {}


local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local function Color3ToHSB(color)
	local r, g, b = color.R, color.G, color.B
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local delta = max - min

	local h = 0
	if delta ~= 0 then
		if max == r then
			h = (g - b) / delta % 6
		elseif max == g then
			h = (b - r) / delta + 2
		else
			h = (r - g) / delta + 4
		end
		h = h * 60
	else
		h = 0
	end

	local s = (max == 0) and 0 or (delta / max)
	local v = max

	return {
		h = math.floor(h + 0.5),
		s = s,
		b = v
	}
end

local function GetPerceivedBrightness(color)
	local r = color.R
	local g = color.G
	local b = color.B
	return 0.299 * r + 0.587 * g + 0.114 * b
end

local function GetTextColorForHSB(color)
    local hsb = Color3ToHSB(color)
	local h, s, b = hsb.h, hsb.s, hsb.b
	if GetPerceivedBrightness(color) > 0.5 then
		return Color3.fromHSV(h / 360, 0, 0.05)
	else
		return Color3.fromHSV(h / 360, 0, 0.98)
	end
end

local function GetAverageColor(gradient)
    local r, g, b = 0, 0, 0
    local keypoints = gradient.Color.Keypoints
    for _, k in ipairs(keypoints) do
        -- bruh
        r = r + k.Value.R
        g = g + k.Value.G
        b = b + k.Value.B
    end
    local n = #keypoints
    return Color3.new(r/n, g/n, b/n)
end


function Tag:New(TagConfig, Parent)
    local TagModule = {
        Title = TagConfig.Title or "Tag",
        Icon = TagConfig.Icon,
        Color = TagConfig.Color or Color3.fromHex("#315dff"),
        Radius = TagConfig.Radius or 999,
        
        TagFrame = nil,
        Height = 26,
        Padding = 10,
        TextSize = 14,
        IconSize = 16,
    }
    
    local TagIcon
    if TagModule.Icon then
        TagIcon = Creator.Image(
            TagModule.Icon,
            TagModule.Icon,
            0,
            TagConfig.Window,
            "Tag",
            false
        )
        
        TagIcon.Size = UDim2.new(0,TagModule.IconSize,0,TagModule.IconSize)
        TagIcon.ImageLabel.ImageColor3 = typeof(TagModule.Color) == "Color3" and GetTextColorForHSB(TagModule.Color) or nil
    end
    
    local TagTitle = New("TextLabel", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
        TextSize = TagModule.TextSize,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        Text = TagModule.Title,
        TextColor3 = typeof(TagModule.Color) == "Color3" and GetTextColorForHSB(TagModule.Color) or nil,
    })
    
    local BackgroundGradient
    
    if typeof(TagModule.Color) == "table" then
        
        BackgroundGradient = New("UIGradient")
        for key, value in next, TagModule.Color do
            BackgroundGradient[key] = value
        end
        
        TagTitle.TextColor3 = GetTextColorForHSB(GetAverageColor(BackgroundGradient))
        if TagIcon then
            TagIcon.ImageLabel.ImageColor3 = GetTextColorForHSB(GetAverageColor(BackgroundGradient))
        end
    end
    
    
    
    local TagFrame = Creator.NewRoundFrame(TagModule.Radius, "Squircle", {
        AutomaticSize = "X",
        Size = UDim2.new(0,0,0,TagModule.Height),
        Parent = Parent,
        ImageColor3 = typeof(TagModule.Color) == "Color3" and TagModule.Color or Color3.new(1,1,1),
    }, {
        BackgroundGradient,
        New("UIPadding", {
            PaddingLeft = UDim.new(0,TagModule.Padding),
            PaddingRight = UDim.new(0,TagModule.Padding),
        }),
        TagIcon,
        TagTitle,
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            Padding = UDim.new(0,TagModule.Padding/1.5)
        })
    })
    
    
    function TagModule:SetTitle(text)
        TagModule.Title = text
        TagTitle.Text = text
    end
    
    function TagModule:SetColor(color)
        TagModule.Color = color
        if typeof(color) == "table" then
            local avgColor = GetAverageColor(color)
            Tween(TagTitle, .06, { TextColor3 = GetTextColorForHSB(avgColor) }):Play()
            local gradient = TagFrame:FindFirstChildOfClass("UIGradient") or New("UIGradient", { Parent = TagFrame })
            for k, v in next, color do gradient[k] = v end
            Tween(TagFrame, .06, { ImageColor3 = Color3.new(1,1,1) }):Play()
        else
            if BackgroundGradient then
                BackgroundGradient:Destroy()
            end
            Tween(TagTitle, .06, { TextColor3 = GetTextColorForHSB(color) }):Play()
            if TagIcon then
                Tween(TagIcon.ImageLabel, .06, { ImageColor3 = GetTextColorForHSB(color) }):Play()
            end
            Tween(TagFrame, .06, { ImageColor3 = color }):Play()
        end
    end
    
    
    return TagModule
end


return Tag