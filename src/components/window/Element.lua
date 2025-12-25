local Creator = require("../../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame
local Tween = Creator.Tween

local cloneref = (cloneref or clonereference or function(instance) return instance end)


local UserInputService = cloneref(game:GetService("UserInputService"))


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


local function getElementPosition(elements, targetIndex)
    if type(targetIndex) ~= "number" or targetIndex ~= math.floor(targetIndex) then
        return nil, 1
    end

    -- local maxIndex = 0
    -- for k,_ in next, elements do
    --     if type(k) == "number" and k > maxIndex then maxIndex = k end
    -- end
    
    local maxIndex = #elements
    --print(maxIndex)
    
    if maxIndex == 0 or targetIndex < 1 or targetIndex > maxIndex then
        return nil, 2
    end

    local function isDelimiter(el)
        if el == nil then return true end
        local t = el.__type
        return t == "Divider" or t == "Space" or t == "Section" or t == "Code"
    end

    if isDelimiter(elements[targetIndex]) then
        return nil, 3
    end

    local function calculate(pos, size)
        if size == 1 then return "Squircle" end
        if pos == 1 then return "Squircle-TL-TR" end
        if pos == size then return "Squircle-BL-BR" end
        return "Square"
    end

    local groupStart = 1
    local groupCount = 0

    for i = 1, maxIndex do
        local el = elements[i]
        if isDelimiter(el) then
            if targetIndex >= groupStart and targetIndex <= i - 1 then
                local pos = targetIndex - groupStart + 1
                return calculate(pos, groupCount)
            end
            groupStart = i + 1
            groupCount = 0
        else
            groupCount = groupCount + 1
        end
    end


    if targetIndex >= groupStart and targetIndex <= maxIndex then
        local pos = targetIndex - groupStart + 1
        return calculate(pos, groupCount)
    end

    return nil, 4
end


return function(Config)
    local Element = {
        Title = Config.Title,
        Desc = Config.Desc or nil,
        Hover = Config.Hover,
        Thumbnail = Config.Thumbnail,
        ThumbnailSize = Config.ThumbnailSize or 80,
        Image = Config.Image,
        IconThemed = Config.IconThemed or false,
        ImageSize = Config.ImageSize or 30,
        Color = Config.Color,
        Scalable = Config.Scalable,
        Parent = Config.Parent,
        Justify = Config.Justify or "Between", -- Center or Between
        UIPadding = Config.Window.ElementConfig.UIPadding,
        UICorner = Config.Window.ElementConfig.UICorner,
        UIElements = {},
        
        Index = Config.Index
    }
    
    local ImageSize = Element.ImageSize
    local ThumbnailSize = Element.ThumbnailSize
    local CanHover = true
    local Hovering = false
    
    local IconOffset = 0
    
    local ThumbnailFrame
    local ImageFrame
    if Element.Thumbnail then
        ThumbnailFrame = Creator.Image(
            Element.Thumbnail, 
            Element.Title, 
            Config.Window.NewElements and Element.UICorner-11 or (Element.UICorner-4), 
            Config.Window.Folder,
            "Thumbnail",
            false,
            Element.IconThemed
        )
        ThumbnailFrame.Size = UDim2.new(1,0,0,ThumbnailSize)
    end
    if Element.Image then
        ImageFrame = Creator.Image(
            Element.Image, 
            Element.Title, 
            Config.Window.NewElements and Element.UICorner-11 or (Element.UICorner-4), 
            Config.Window.Folder,
            "Image",
            Element.IconThemed,
            not Element.Color and true or false,
            "ElementIcon"
        )
        if typeof(Element.Color) == "string" then 
            ImageFrame.ImageLabel.ImageColor3 = GetTextColorForHSB(Color3.fromHex(Creator.Colors[Element.Color]))
        elseif typeof(Element.Color) == "Color3" then
            ImageFrame.ImageLabel.ImageColor3 = GetTextColorForHSB(Element.Color)
        end
        
        ImageFrame.Size = UDim2.new(0,ImageSize,0,ImageSize)
        
        IconOffset = ImageSize
    end
    
    local function CreateText(Title, Type)
        local TextColor = typeof(Element.Color) == "string" 
            and GetTextColorForHSB(Color3.fromHex(Creator.Colors[Element.Color]))
            or typeof(Element.Color) == "Color3" 
            and GetTextColorForHSB(Element.Color)
        
        return New("TextLabel", {
            BackgroundTransparency = 1,
            Text = Title or "",
            TextSize = Type == "Desc" and 15 or 17,
            TextXAlignment = "Left",
            ThemeTag = {
                TextColor3 = not Element.Color and ("Element" .. Type) or nil,
            },
            TextColor3 = Element.Color and TextColor or nil,
            TextTransparency = Type == "Desc" and .3 or 0,
            TextWrapped = true,
            Size = UDim2.new(Element.Justify == "Between" and 1 or 0,0,0,0),
            AutomaticSize = Element.Justify == "Between" and "Y" or "XY",
            FontFace = Font.new(Creator.Font, Type == "Desc" and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold)
        })
    end
    
    local Title = CreateText(Element.Title, "Title")
    local Desc = CreateText(Element.Desc, "Desc")
    if not Element.Title or Element.Title == "" then
        Desc.Visible = false
    end
    if not Element.Desc or Element.Desc == "" then
        Desc.Visible = false
    end
    
    Element.UIElements.Title = Title
    Element.UIElements.Desc = Desc
    
    Element.UIElements.Container = New("Frame", {
        Size = UDim2.new(1,0,1,0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,Element.UIPadding),
            FillDirection = "Vertical",
            VerticalAlignment = "Center",
            HorizontalAlignment = Element.Justify == "Between" and "Left" or "Center",
        }),
        ThumbnailFrame,
        New("Frame", {
            Size = UDim2.new(
                Element.Justify == "Between" and 1 or 0,
                Element.Justify == "Between" and -Config.TextOffset or 0,
                0,
                0
            ),
            AutomaticSize = Element.Justify == "Between" and "Y" or "XY",
            BackgroundTransparency = 1,
            Name = "TitleFrame",
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,Element.UIPadding),
                FillDirection = "Horizontal",
                VerticalAlignment = Config.Window.NewElements and ( Element.Justify == "Between" and "Top" or "Center" ) or "Center",
                HorizontalAlignment = Element.Justify ~= "Between" and Element.Justify or "Center",
            }),
            ImageFrame,
            New("Frame", {
                BackgroundTransparency = 1,
                AutomaticSize = Element.Justify == "Between" and "Y" or "XY",
                Size = UDim2.new(
                    Element.Justify == "Between" and 1 or 0,
                    Element.Justify == "Between" and ( ImageFrame and -IconOffset-Element.UIPadding or -IconOffset ) or 0,
                    1,
                    0
                ),
                Name = "TitleFrame",
            }, {
                New("UIPadding", {
                    PaddingTop = UDim.new(0,Config.Window.NewElements and Element.UIPadding/2 or 0),
                    PaddingLeft = UDim.new(0,Config.Window.NewElements and Element.UIPadding/2 or 0),
                    PaddingRight = UDim.new(0,Config.Window.NewElements and Element.UIPadding/2 or 0),
                    PaddingBottom = UDim.new(0,Config.Window.NewElements and Element.UIPadding/2 or 0),
                }),
                New("UIListLayout", {
                    Padding = UDim.new(0,6),
                    FillDirection = "Vertical",
                    VerticalAlignment = "Center",
                    HorizontalAlignment = "Left",
                }),
                Title,
                Desc
            }),
        })
    })
    
    
    -- print(Config.Tab.Elements)
    -- print(Config.Index)
    -- print("Squircle")
    
    local LockedIcon = Creator.Image(
        "lock", 
        "lock", 
        0, 
        Config.Window.Folder,
        "Lock",
        false
    )
    LockedIcon.Size = UDim2.new(0,20,0,20)
    LockedIcon.ImageLabel.ImageColor3 = Color3.new(1,1,1)
    LockedIcon.ImageLabel.ImageTransparency = .4
    
    local LockedTitle = New("TextLabel", {
        Text = "Locked",
        TextSize = 18,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1,1,1),
        TextTransparency = .05,
    })
    
    local ElementFullFrame = New("Frame", {
        Size = UDim2.new(1,Element.UIPadding*2,1,Element.UIPadding*2),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        ZIndex = 9999999,
    })
    
    local Locked, LockedTable = NewRoundFrame(Element.UICorner, "Squircle", {
        Size = UDim2.new(1,0,1,0),
        ImageTransparency = .25,
        ImageColor3 = Color3.new(0,0,0),
        Visible = false,
        Active = false,
        Parent = ElementFullFrame,
    }, {
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
            Padding = UDim.new(0,8)
        }),
        LockedIcon, LockedTitle
    }, nil, true)
    
    local HighlightOutline, HighlightOutlineTable = NewRoundFrame(Element.UICorner, "Squircle-Outline", {
        Size = UDim2.new(1,0,1,0),
        ImageTransparency = 1, -- 0.25
        Active = false,
        ThemeTag = {
            ImageColor3 = "Text",
        },
        Parent = ElementFullFrame,
    }, {
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
            Padding = UDim.new(0,8)
        }),
    }, nil, true)
    
    local Highlight, HighlightTable = NewRoundFrame(Element.UICorner, "Squircle", {
        Size = UDim2.new(1,0,1,0),
        ImageTransparency = 1, -- 0.88
        Active = false,
        ThemeTag = {
            ImageColor3 = "Text",
        },
        Parent = ElementFullFrame,
    }, {
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
            Padding = UDim.new(0,8)
        }),
    }, nil, true)
    
    
    local HoverOutline, HoverOutlineTable = NewRoundFrame(Element.UICorner, "Squircle-Outline", {
        Size = UDim2.new(1,0,1,0),
        ImageTransparency = 1, -- 0.25
        Active = false,
        ThemeTag = {
            ImageColor3 = "Text",
        },
        Parent = ElementFullFrame,
    }, {
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
            Padding = UDim.new(0,8)
        }),
        New("UIGradient", {
            Name = "HoverGradient",
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),     
                NumberSequenceKeypoint.new(0.25, 0.9),
                NumberSequenceKeypoint.new(0.5, 0.3), 
                NumberSequenceKeypoint.new(0.75, 0.9), 
                NumberSequenceKeypoint.new(1, 1)      
            }),
        }),
    }, nil, true)
    
    local Hover, HoverTable = NewRoundFrame(Element.UICorner, "Squircle", {
        Size = UDim2.new(1,0,1,0),
        ImageTransparency = 1, -- 0.88
        Active = false,
        ThemeTag = {
            ImageColor3 = "Text",
        },
        Parent = ElementFullFrame,
    }, {
        New("UIGradient", {
            Name = "HoverGradient",
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),     
                NumberSequenceKeypoint.new(0.25, 0.9),
                NumberSequenceKeypoint.new(0.5, 0.3), 
                NumberSequenceKeypoint.new(0.75, 0.9), 
                NumberSequenceKeypoint.new(1, 1)      
            }),
        }),
        New("UIListLayout", {
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
            Padding = UDim.new(0,8)
        }),
    }, nil, true)
    
    local Main, MainTable = NewRoundFrame(Element.UICorner, "Squircle", {
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = "Y",
        ImageTransparency = Element.Color and .05 or .93,
        --Text = "",
        --TextTransparency = 1,
        --AutoButtonColor = false,
        Parent = Config.Parent,
        ThemeTag = {
            ImageColor3 = not Element.Color and "ElementBackground" or nil
        },
        ImageColor3 = Element.Color and 
            ( 
                typeof(Element.Color) == "string" 
                    and Color3.fromHex(Creator.Colors[Element.Color]) 
                    or typeof(Element.Color) == "Color3" 
                    and Element.Color
            ) or nil
    }, {
        Element.UIElements.Container,
        ElementFullFrame,
        New("UIPadding", {
            PaddingTop = UDim.new(0,Element.UIPadding),
            PaddingLeft = UDim.new(0,Element.UIPadding),
            PaddingRight = UDim.new(0,Element.UIPadding),
            PaddingBottom = UDim.new(0,Element.UIPadding),
        }),
    }, true, true)
    
    Element.UIElements.Main = Main
    Element.UIElements.Locked = Locked
    
    if Element.Hover then
        Creator.AddSignal(Main.MouseEnter, function()
            if CanHover then
                Tween(Main, .12, {ImageTransparency = Element.Color and .15 or .9}):Play()
                Tween(Hover, .12, {ImageTransparency = .9}):Play()
                Tween(HoverOutline, .12, {ImageTransparency = .8}):Play()
                Creator.AddSignal(Main.MouseMoved, function(x,y)
                    Hover.HoverGradient.Offset = Vector2.new(((x - Main.AbsolutePosition.X) / Main.AbsoluteSize.X) - 0.5, 0)
                    HoverOutline.HoverGradient.Offset = Vector2.new(((x - Main.AbsolutePosition.X) / Main.AbsoluteSize.X) - 0.5, 0)
                end)
            end
        end)
        Creator.AddSignal(Main.InputEnded, function()
            if CanHover then
                Tween(Main, .12, {ImageTransparency = Element.Color and .05 or .93}):Play()
                Tween(Hover, .12, {ImageTransparency = 1}):Play()
                Tween(HoverOutline, .12, {ImageTransparency = 1}):Play()
            end
        end)
    end
    
    function Element:SetTitle(text)
        Element.Title = text
        Title.Text = text
    end
    
    function Element:SetDesc(text)
        Element.Desc = text
        Desc.Text = text or ""
        if not text then
            Desc.Visible = false
        elseif not Desc.Visible then
            Desc.Visible = true
        end
    end
    
    
    function Element:Colorize(obj, prop)
        if Element.Color then
            obj[prop] = typeof(Element.Color) == "string" 
                and GetTextColorForHSB(Color3.fromHex(Creator.Colors[Element.Color]))
                or typeof(Element.Color) == "Color3" 
                and GetTextColorForHSB(Element.Color)
                or nil 
        end
    end
    
    if Config.ElementTable then
        Creator.AddSignal(Title:GetPropertyChangedSignal("Text"), function()
            if Element.Title ~= Title.Text then
                Element:SetTitle(Title.Text)
                Config.ElementTable.Title = Title.Text
            end
        end)
        Creator.AddSignal(Desc:GetPropertyChangedSignal("Text"), function()
            if Element.Desc ~= Desc.Text then
                Element:SetDesc(Desc.Text)
                Config.ElementTable.Desc = Desc.Text
            end
        end)
    end
    
    -- function Element:Show()
        
    -- end
    
    function Element:SetThumbnail(newThumbnail, newSize)
        Element.Thumbnail = newThumbnail
        if newSize then
            Element.ThumbnailSize = newSize
            ThumbnailSize = newSize
        end
        
        if ThumbnailFrame then
            if newThumbnail then
                ThumbnailFrame:Destroy()
                ThumbnailFrame = Creator.Image(
                    newThumbnail, 
                    Element.Title, 
                    Element.UICorner-3, 
                    Config.Window.Folder,
                    "Thumbnail",
                    false,
                    Element.IconThemed
                )
                ThumbnailFrame.Size = UDim2.new(1,0,0,ThumbnailSize)
                ThumbnailFrame.Parent = Element.UIElements.Container
                local layout = Element.UIElements.Container:FindFirstChild("UIListLayout")
                if layout then
                    ThumbnailFrame.LayoutOrder = -1
                end
            else
                ThumbnailFrame.Visible = false
            end
        else
            if newThumbnail then
                ThumbnailFrame = Creator.Image(
                    newThumbnail, 
                    Element.Title, 
                    Element.UICorner-3, 
                    Config.Window.Folder,
                    "Thumbnail",
                    false,
                    Element.IconThemed
                )
                ThumbnailFrame.Size = UDim2.new(1,0,0,ThumbnailSize)
                ThumbnailFrame.Parent = Element.UIElements.Container
                local layout = Element.UIElements.Container:FindFirstChild("UIListLayout")
                if layout then
                    ThumbnailFrame.LayoutOrder = -1
                end
            end
        end
    end
    
    function Element:SetImage(newImage, newSize)
        Element.Image = newImage
        if newSize then
            Element.ImageSize = newSize
            ImageSize = newSize
        end
        
        if newImage then
            ImageFrame = Creator.Image(
                newImage, 
                Element.Title, 
                Element.UICorner-3, 
                Config.Window.Folder,
                "Image",
                not Element.Color and true or false
            )
            
            if typeof(Element.Color) == "string" then 
                ImageFrame.ImageLabel.ImageColor3 = GetTextColorForHSB(Color3.fromHex(Creator.Colors[Element.Color]))
            elseif typeof(Element.Color) == "Color3" then
                ImageFrame.ImageLabel.ImageColor3 = GetTextColorForHSB(Element.Color)
            end
            
            ImageFrame.Visible = true

            ImageFrame.Size = UDim2.new(0,ImageSize,0,ImageSize)
            IconOffset = ImageSize
            
        else
            if ImageFrame then
                ImageFrame.Visible = true
            end
            IconOffset = 0
        end
        
        Element.UIElements.Container.TitleFrame.TitleFrame.Size = UDim2.new(1,-IconOffset,1,0)
    end
    
    function Element:Destroy()
        Main:Destroy()
    end
    
    
    function Element:Lock(newtitle)
        CanHover = false
        Locked.Active = true
        Locked.Visible = true
        LockedTitle.Text = newtitle
    end
    
    function Element:Unlock()
        CanHover = true
        Locked.Active = false
        Locked.Visible = false
    end
    
    function Element:Highlight()
        local OutlineGradient = New("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),     
                NumberSequenceKeypoint.new(0.1, 0.9),
                NumberSequenceKeypoint.new(0.5, 0.3), 
                NumberSequenceKeypoint.new(0.9, 0.9), 
                NumberSequenceKeypoint.new(1, 1)      
            }),
            Rotation = 0,
            Offset = Vector2.new(-1, 0),
            Parent = HighlightOutline
        })
        
        local HighlightGradient = New("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),     
                NumberSequenceKeypoint.new(0.15, 0.8),
                NumberSequenceKeypoint.new(0.5, 0.1), 
                NumberSequenceKeypoint.new(0.85, 0.8), 
                NumberSequenceKeypoint.new(1, 1)      
            }),
            Rotation = 0,
            Offset = Vector2.new(-1, 0),
            Parent = Highlight
        })
        
        HighlightOutline.ImageTransparency = 0.65
        Highlight.ImageTransparency = 0.88
        
        Tween(OutlineGradient, 0.75, {
            Offset = Vector2.new(1, 0)
        }):Play()
        
        Tween(HighlightGradient, 0.75, {
            Offset = Vector2.new(1, 0)
        }):Play()
        
        
        task.spawn(function()
            task.wait(.75)
            HighlightOutline.ImageTransparency = 1
            Highlight.ImageTransparency = 1
            OutlineGradient:Destroy()
            HighlightGradient:Destroy()
        end)
    end
    

    function Element.UpdateShape(Tab)
        if Config.Window.NewElements then
            local newShape
            if Config.ParentConfig.ParentType == "Group" then
                newShape = "Squircle"
            else
                newShape = getElementPosition(Tab.Elements, Element.Index)
            end
            
            if newShape and Main then
                MainTable:SetType(newShape)
                LockedTable:SetType(newShape)
                HighlightTable:SetType(newShape)
                HighlightOutlineTable:SetType(newShape .. "-Outline")
                HoverTable:SetType(newShape)
                HoverOutlineTable:SetType(newShape .. "-Outline")
            end
        end
    end
    
    --task.wait(.015)
    
    --Element:Show()
    
    return Element
end