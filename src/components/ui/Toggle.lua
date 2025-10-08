local Toggle = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function Toggle.New(Value, Icon, Parent, Callback)
    local Toggle = {}
    
    
    local Radius = 26/2
    local IconToggleFrame
    if Icon and Icon ~= "" then
        IconToggleFrame = New("ImageLabel", {
            Size = UDim2.new(1,-7,1,-7),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Image = Creator.Icon(Icon)[1],
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageTransparency = 1,
            ImageColor3 = Color3.new(0,0,0),
        })
    end
    
    local ToggleFrame = Creator.NewRoundFrame(Radius, "Squircle",{
        ImageTransparency = .93,
        ThemeTag = {
            ImageColor3 = "Text"
        },
        Parent = Parent,
        Size = UDim2.new(0,26*1.6,0,26),
    }, {
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            Name = "Layer",
            ThemeTag = {
                ImageColor3 = "Button",
            },
            ImageTransparency = 1, -- 0
        }),
        Creator.NewRoundFrame(Radius, "SquircleOutline", {
            Size = UDim2.new(1,0,1,0),
            Name = "Stroke",
            ImageColor3 = Color3.new(1,1,1),
            ImageTransparency = 1, -- .95
        }, {
            New("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                })
            })
        }),
        
        --bar
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(0,18,0,18),
            Position = UDim2.new(0,3,0.5,0),
            AnchorPoint = Vector2.new(0,0.5),
            ImageTransparency = 0,
            ImageColor3 =  Color3.new(1,1,1),
            -- ThemeTag = {
            --     ImageColor3 = "Icon",
            -- },
            Name = "Frame",
        }, {
            IconToggleFrame,
        })
    })
    
    
    function Toggle:Set(Toggled, isCallback)
        if Toggled then
            Tween(ToggleFrame.Frame, 0.15, {
                Position = UDim2.new(1, -18 - 3 - 1, 0.5, 0),
                --Size = UDim2.new(0,20,0,20),
            }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 0,
            }):Play()
            Tween(ToggleFrame.Stroke, 0.1, {
                ImageTransparency = 0.95,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 0,
                }):Play()
            end
        else
            Tween(ToggleFrame.Frame, 0.15, {
                Position = UDim2.new(0, 4, 0.5, 0),
                Size = UDim2.new(0,18,0,18),
            }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 1,
            }):Play()
            Tween(ToggleFrame.Stroke, 0.1, {
                ImageTransparency = 1,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 1,
                }):Play()
            end
        end

        if isCallback ~= false then isCallback = true end
        
        task.spawn(function()
            if Callback and isCallback then
                Creator.SafeCallback(Callback, Toggled)
            end
        end)
        
        --Toggled = not Toggled
    end
    
    return ToggleFrame, Toggle
end


return Toggle