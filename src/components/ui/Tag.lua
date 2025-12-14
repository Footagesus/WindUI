-- modules/Tag.lua (or wherever your Tag module is)

local Tag = {}

local Creator = require("../../modules/Creator")  -- Adjust path if needed
local New = Creator.New
local Tween = Creator.Tween

-- Toggle debug prints
local DEBUG = false

local function dprint(...)
    if DEBUG then
        print("[Tag Debug]", ...)
    end
end

-- Convert Color3 to HSB (Hue, Saturation, Brightness)
local function Color3ToHSB(color)
    local r, g, b = color.R, color.G, color.B
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local delta = max - min

    local h = 0
    if delta ~= 0 then
        if max == r then
            h = ((g - b) / delta) % 6
        elseif max == g then
            h = (b - r) / delta + 2
        else
            h = (r - g) / delta + 4
        end
        h = h * 60
    end

    local s = max == 0 and 0 or delta / max
    local v = max

    return { h = math.floor(h + 0.5), s = s, b = v }
end

-- Perceived brightness (luminance formula)
local function GetPerceivedBrightness(color)
    return 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
end

-- Get high-contrast text color (dark on light bg, light on dark bg)
local function GetContrastTextColor(baseColor)
    local brightness = GetPerceivedBrightness(baseColor)
    dprint("Base brightness:", brightness, "→ Using", brightness > 0.5 and "dark" or "light", "text")
    
    local hsb = Color3ToHSB(baseColor)
    if brightness > 0.5 then
        return Color3.fromHSV(hsb.h / 360, 0, 0.05)  -- Almost black
    else
        return Color3.fromHSV(hsb.h / 360, 0, 0.98)  -- Almost white
    end
end

-- Average color from UIGradient
local function GetAverageColor(gradient)
    local r, g, b = 0, 0, 0
    local keypoints = gradient.Color.Keypoints
    local count = #keypoints
    
    for _, kp in ipairs(keypoints) do
        r += kp.Value.R
        g += kp.Value.G
        b += kp.Value.B
    end
    
    local avg = Color3.new(r / count, g / count, b / count)
    dprint("Gradient average:", avg:ToHex())
    return avg
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

    -- Create Icon if provided
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
        TagIcon.Size = UDim2.new(0, TagModule.IconSize, 0, TagModule.IconSize)
    end

    -- Title label
    local TagTitle = New("TextLabel", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
        TextSize = TagModule.TextSize,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        Text = TagModule.Title,
        TextColor3 = Color3.new(1, 1, 1),  -- Temporary
    })

    -- Gradient holder
    local BackgroundGradient

    -- Apply contrast based on current color
    local function ApplyContrast()
        local baseColor
        if typeof(TagModule.Color) == "table" and BackgroundGradient then
            baseColor = GetAverageColor(BackgroundGradient)
        else
            baseColor = TagModule.Color
        end

        local textColor = GetContrastTextColor(baseColor)
        TagTitle.TextColor3 = textColor
        
        if TagIcon then
            TagIcon.ImageLabel.ImageColor3 = textColor
        end
        
        dprint("Applied text color:", textColor:ToHex(), "for base:", baseColor:ToHex())
    end

    -- Setup gradient if needed
    if typeof(TagModule.Color) == "table" then
        BackgroundGradient = New("UIGradient")
        for k, v in next, TagModule.Color do
            BackgroundGradient[k] = v
        end
    end

    -- Create the tag frame
    local TagFrame = Creator.NewRoundFrame(TagModule.Radius, "Squircle", {
        AutomaticSize = "X",
        Size = UDim2.new(0, 0, 0, TagModule.Height),
        Parent = Parent,
        ImageColor3 = typeof(TagModule.Color) == "Color3" and TagModule.Color or Color3.new(1, 1, 1),
    }, {
        BackgroundGradient,
        New("UIPadding", {
            PaddingLeft = UDim.new(0, TagModule.Padding),
            PaddingRight = UDim.new(0, TagModule.Padding),
        }),
        TagIcon,
        TagTitle,
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            Padding = UDim.new(0, TagModule.Padding / 1.5)
        })
    })

    TagModule.TagFrame = TagFrame

    -- Initial apply
    ApplyContrast()

    -- Protect text color from theme overrides
    TagTitle:GetPropertyChangedSignal("TextColor3"):Connect(function()
        if TagModule.Color then
            task.defer(ApplyContrast)
        end
    end)

    if TagIcon then
        TagIcon.ImageLabel:GetPropertyChangedSignal("ImageColor3"):Connect(function()
            if TagModule.Color then
                task.defer(ApplyContrast)
            end
        end)
    end

    -- Handle theme change (WindUI uses function callback, not event)
    if WindUI and typeof(WindUI.OnThemeChange) == "function" then
        WindUI.OnThemeChange(function()
            if TagModule.Color then
                dprint("Theme changed → reapplying tag contrast")
                ApplyContrast()
            end
        end)
    end

    -- Public methods
    function TagModule:SetTitle(text)
        TagModule.Title = text
        TagTitle.Text = text
    end

    function TagModule:SetColor(color)
        TagModule.Color = color
        dprint("SetColor →", typeof(color) == "table" and "gradient" or color:ToHex())

        if typeof(color) == "table" then
            -- Gradient
            if not BackgroundGradient then
                BackgroundGradient = New("UIGradient", { Parent = TagFrame })
            end
            for k, v in next, color do
                BackgroundGradient[k] = v
            end
            Tween(TagFrame, 0.1, { ImageColor3 = Color3.new(1, 1, 1) }):Play()
        else
            -- Solid color
            if BackgroundGradient then
                BackgroundGradient:Destroy()
                BackgroundGradient = nil
            end
            Tween(TagFrame, 0.1, { ImageColor3 = color }):Play()
        end

        ApplyContrast()
    end

    return TagModule
end

return Tag
