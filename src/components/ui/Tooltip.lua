local Tooltip = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function Tooltip.New(Title, Parent, IsArrow, ColorType, Size, IsTextWrap)
    local TooltipModule = {
        Container = nil,
        TooltipSize = 16,
        
        TooltipArrowSizeX = Size == "Small" and 16 or 16*1.5,
        TooltipArrowSizeY = Size == "Small" and 6 or 6*1.5,
        
        PaddingX = Size == "Small" and 12 or 14,
        PaddingY = Size == "Small" and 7 or 9,
        
        Radius = 999,
        
        TitleFrame = nil,
    }
    
    ColorType = ColorType or ""
    IsTextWrap = IsTextWrap ~= false
    
    local TooltipTitle = New("TextLabel", {
        AutomaticSize = "XY",
        TextWrapped = IsTextWrap,
        BackgroundTransparency = 1,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
        Text = Title,
        TextSize = Size == "Small" and 15 or 17,
        TextTransparency = 1,
        ThemeTag = {
            TextColor3 = "Tooltip" .. ColorType .. "Text",
        }
    })
    
    TooltipModule.TitleFrame = TooltipTitle
    
    local UIScale = New("UIScale", {
        Scale = .9 -- 1
    })
    
    local Container = New("Frame", {
        AnchorPoint = Vector2.new(0.5,0),
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        Parent = Parent,
        --GroupTransparency = 1, -- 0
        Visible = false -- true
    }, {
        New("UISizeConstraint", {
            MaxSize = Vector2.new(400, math.huge)
        }),
        New("Frame", {
            AutomaticSize = "XY",
            BackgroundTransparency = 1,
            LayoutOrder = 99,
            Visible = IsArrow,
            Name = "Arrow",
        }, {
            New("ImageLabel", {
                Size = UDim2.new(0,TooltipModule.TooltipArrowSizeX,0,TooltipModule.TooltipArrowSizeY),
                BackgroundTransparency = 1,
                --Rotation = 180,
                Image = "rbxassetid://105854070513330",
                ThemeTag = {
                    ImageColor3 = "Tooltip" .. ColorType,
                },
            }, {
                --[[New("ImageLabel", {
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 99,
                    ImageTransparency = .9,
                    Image = "rbxassetid://105854070513330",
                    ThemeTag = {
                        ImageColor3 = "Text",
                    },
                }), ]]
            }),
        }),
        Creator.NewRoundFrame(TooltipModule.Radius, "Squircle", {
            AutomaticSize = "XY",
            ThemeTag = {
                ImageColor3 = "Tooltip" .. ColorType,
            },
            ImageTransparency = 1,
            Name = "Background",
        }, {
            -- New("UICorner", {
            --     CornerRadius = UDim.new(0,16),
            -- }),
            New("Frame", {
                --[[ThemeTag = {
                    BackgroundColor3 = "Text",
                }, ]]
                AutomaticSize = "XY",
                BackgroundTransparency = 1, -- not needed
            }, {
                New("UICorner", {
                    CornerRadius = UDim.new(0,16),
                }),
                New("UIListLayout", {
                    Padding = UDim.new(0,12),
                    FillDirection = "Horizontal",
                    VerticalAlignment = "Center"
                }),
                --TooltipIcon, 
                TooltipTitle,
                New("UIPadding", {
                    PaddingTop = UDim.new(0,TooltipModule.PaddingY),
                    PaddingLeft = UDim.new(0,TooltipModule.PaddingX),
                    PaddingRight = UDim.new(0,TooltipModule.PaddingX),
                    PaddingBottom = UDim.new(0,TooltipModule.PaddingY),
                }),
            })
        }),
        UIScale,
        New("UIListLayout", {
            Padding = UDim.new(0,0),
            FillDirection = "Vertical",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
        }),
    })
    TooltipModule.Container = Container
    
    function TooltipModule:Open() 
        Container.Visible = true
        
        --Tween(Container, .16, { GroupTransparency = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(Container.Background, .2, { ImageTransparency = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(Container.Arrow.ImageLabel, .2, { ImageTransparency = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(TooltipTitle, .2, { TextTransparency = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(UIScale, .22, { Scale = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
    end
    
    function TooltipModule:Close(IsDestroy) 
        --Tween(Container, .2, { GroupTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(Container.Background, .3, { ImageTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(Container.Arrow.ImageLabel, .2, { ImageTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(TooltipTitle, .3, { TextTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(UIScale, .35, { Scale = .9 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In):Play()
        
        IsDestroy = IsDestroy ~= false
        if IsDestroy then 
            task.wait(.35)
            
            Container.Visible = false
            Container:Destroy() 
        end
    end
    
    return TooltipModule
end



return Tooltip