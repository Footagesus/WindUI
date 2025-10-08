local Input = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function Input.New(Placeholder, Icon, Parent, Type, Callback, OnChange, Radius, ClearTextOnFocus)
    Type = Type or "Input"
    local Radius = Radius or 10
    local IconInputFrame
    if Icon and Icon ~= "" then
        IconInputFrame = New("ImageLabel", {
            Image = Creator.Icon(Icon)[1],
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            Size = UDim2.new(0,24-3,0,24-3),
            BackgroundTransparency = 1,
            ThemeTag = {
                ImageColor3 = "Icon",
            }
        })
    end
    
    local isMulti = Type ~= "Input"
    
    local TextBox = New("TextBox", {
        BackgroundTransparency = 1,
        TextSize = 17,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
        Size = UDim2.new(1,IconInputFrame and -29 or 0,1,0),
        PlaceholderText = Placeholder,
        ClearTextOnFocus = ClearTextOnFocus or false,
        ClipsDescendants = true,
        TextWrapped = isMulti,
        MultiLine = isMulti,
        TextXAlignment = "Left",
        TextYAlignment = Type == "Input" and "Center" or "Top",
        --AutomaticSize = "XY",
        ThemeTag = {
            PlaceholderColor3 = "PlaceholderText",
            TextColor3 = "Text",
        },
    })
    
    local InputFrame = New("Frame", {
        Size = UDim2.new(1,0,0,42),
        Parent = Parent,
        BackgroundTransparency = 1
    }, {
        New("Frame", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            Creator.NewRoundFrame(Radius, "Squircle", {
                ThemeTag = {
                    ImageColor3 = "Accent",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .97,
            }),
            Creator.NewRoundFrame(Radius, "SquircleOutline", {
                ThemeTag = {
                    ImageColor3 = "Outline",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .95,
            }, {
                -- New("UIGradient", {
                --     Rotation = 70,
                --     Color = ColorSequence.new({
                --         ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
                --         ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                --         ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 255, 255)),
                --     }),
                --     Transparency = NumberSequence.new({
                --         NumberSequenceKeypoint.new(0.0, 0.1),
                --         NumberSequenceKeypoint.new(0.5, 1),
                --         NumberSequenceKeypoint.new(1.0, 0.1),
                --     })
                -- })
            }),
            Creator.NewRoundFrame(Radius, "Squircle", {
                Size = UDim2.new(1,0,1,0),
                Name = "Frame",
                ImageColor3 = Color3.new(1,1,1),
                ImageTransparency = .95
            }, {
                New("UIPadding", {
                    PaddingTop = UDim.new(0,Type == "Input" and 0 or 12),
                    PaddingLeft = UDim.new(0,12),
                    PaddingRight = UDim.new(0,12),
                    PaddingBottom = UDim.new(0,Type == "Input" and 0 or 12),
                }),
                New("UIListLayout", {
                    FillDirection = "Horizontal",
                    Padding = UDim.new(0,8),
                    VerticalAlignment = Type == "Input" and "Center" or "Top",
                    HorizontalAlignment = "Left",
                }),
                IconInputFrame,
                TextBox,
            })
        })
    })
    
    -- InputFrame:GetPropertyChangedSignal("AbsoluteSize"), function()
    --     TextBox.Size = UDim2.new(
    --         0,
    --         IconInputFrame and InputFrame.AbsoluteSize.X -29-12 or InputFrame.AbsoluteSize.X-12,
    --         1,
    --         0
    --     )
    -- end)
    
    if OnChange then
        Creator.AddSignal(TextBox:GetPropertyChangedSignal("Text"), function()
            if Callback then
                Creator.SafeCallback(Callback, TextBox.Text)
            end
        end)
    else
        Creator.AddSignal(TextBox.FocusLost, function()
            if Callback then
                Creator.SafeCallback(Callback, TextBox.Text)
            end
        end)
    end
    
    return InputFrame
end


return Input