local Tag = {}


local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function Tag:New(TagConfig, Parent)
    local TagModule = {
        Title = TagConfig.Title or "Tag",
        Icon = TagConfig.Icon,
        Color = TagConfig.Color or Color3.fromHex("#315dff"),
        Radius = TagConfig.Radius or 999,
        Border = TagConfig.Border or false,
        
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
        TagIcon.ImageLabel.ImageColor3 = typeof(TagModule.Color) == "Color3" and Creator.GetTextColorForHSB(TagModule.Color) or nil
    end
    
    local TagTitle = New("TextLabel", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
        TextSize = TagModule.TextSize,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        Text = TagModule.Title,
        TextColor3 = typeof(TagModule.Color) == "Color3" and Creator.GetTextColorForHSB(TagModule.Color) or nil,
    })
    
    local BackgroundGradient
    
    if typeof(TagModule.Color) == "table" then
        
        BackgroundGradient = New("UIGradient")
        for key, value in next, TagModule.Color do
            BackgroundGradient[key] = value
        end
        
        TagTitle.TextColor3 = Creator.GetTextColorForHSB(Creator.GetAverageColor(BackgroundGradient))
        if TagIcon then
            TagIcon.ImageLabel.ImageColor3 = Creator.GetTextColorForHSB(Creator.GetAverageColor(BackgroundGradient))
        end
    end
    
    
    
    local TagFrame = Creator.NewRoundFrame(TagModule.Radius, "Squircle", {
        AutomaticSize = "X",
        Size = UDim2.new(0,0,0,TagModule.Height),
        Parent = Parent,
        ImageColor3 = typeof(TagModule.Color) == "Color3" and TagModule.Color or Color3.new(1,1,1),
    }, {
        BackgroundGradient,
        Creator.NewRoundFrame(TagModule.Radius, "Glass-1", {
            Size = UDim2.new(1,0,1,0),
            ThemeTag = {
                ImageColor3 = "White",
            },
            ImageTransparency = .75
        }),
        New("Frame", {
            Size = UDim2.new(0,0,1,0),
            AutomaticSize = "X",
            Name = "Content",
            BackgroundTransparency = 1,
        }, {
            TagIcon,
            TagTitle,
            New("UIPadding", {
                PaddingLeft = UDim.new(0,TagModule.Padding),
                PaddingRight = UDim.new(0,TagModule.Padding),
            }),
            New("UIListLayout", {
                FillDirection = "Horizontal",
                VerticalAlignment = "Center",
                Padding = UDim.new(0,TagModule.Padding/1.5)
            })
        }),
    })
    
    
    function TagModule:SetTitle(text)
        TagModule.Title = text
        TagTitle.Text = text
        
        return TagModule
    end
    
    function TagModule:SetColor(color)
        TagModule.Color = color
        if typeof(color) == "table" then
            local avgColor = Creator.GetAverageColor(color)
            Tween(TagTitle, .06, { TextColor3 = Creator.GetTextColorForHSB(avgColor) }):Play()
            local gradient = TagFrame:FindFirstChildOfClass("UIGradient") or New("UIGradient", { Parent = TagFrame })
            for k, v in next, color do gradient[k] = v end
            Tween(TagFrame, .06, { ImageColor3 = Color3.new(1,1,1) }):Play()
        else
            if BackgroundGradient then
                BackgroundGradient:Destroy()
            end
            Tween(TagTitle, .06, { TextColor3 = Creator.GetTextColorForHSB(color) }):Play()
            if TagIcon then
                Tween(TagIcon.ImageLabel, .06, { ImageColor3 = Creator.GetTextColorForHSB(color) }):Play()
            end
            Tween(TagFrame, .06, { ImageColor3 = color }):Play()
        end
        
        return TagModule
    end
    
    function TagModule:SetIcon(icon)
        TagModule.Icon = icon
        
        if icon then
            TagIcon = Creator.Image(
                icon,
                icon,
                0,
                TagConfig.Window,
                "Tag",
                false
            )
            
            TagIcon.Size = UDim2.new(0,TagModule.IconSize,0,TagModule.IconSize)
            TagIcon.Parent = TagFrame
            
            if typeof(TagModule.Color) == "Color3" then
                TagIcon.ImageLabel.ImageColor3 = Creator.GetTextColorForHSB(TagModule.Color)
            elseif typeof(TagModule.Color) == "table" then
                TagIcon.ImageLabel.ImageColor3 = Creator.GetTextColorForHSB(Creator.GetAverageColor(BackgroundGradient))
            end
        else
            if TagIcon then
                TagIcon:Destroy()
                TagIcon = nil
            end
        end
        return TagModule
    end
    
    function TagModule:Destroy()
        TagFrame:Destroy()
        return TagModule
    end
    
    return TagModule
end


return Tag