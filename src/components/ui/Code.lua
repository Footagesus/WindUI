local Code = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local Highlighter = require("../../modules/Highlighter")

function Code.New(Code, Title, Parent, Callback, UIScale)
    local CodeModule = {
        Radius = 12,
        Padding = 10
    }

    local TextLabel = New("TextLabel", {
        Text = "",
        TextColor3 = Color3.fromHex("#CDD6F4"),
        TextTransparency = 0,
        TextSize = 14,
        TextWrapped = false,
        LineHeight = 1.15,
        RichText = true,
        TextXAlignment = "Left",
        Size = UDim2.new(0,0,0,0),
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,CodeModule.Padding+3),
            PaddingLeft = UDim.new(0,CodeModule.Padding+3),
            PaddingRight = UDim.new(0,CodeModule.Padding+3),
            PaddingBottom = UDim.new(0,CodeModule.Padding+3),
        })
    })
    TextLabel.Font = "Code"
    
    local ScrollingFrame = New("ScrollingFrame", {
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
        AutomaticCanvasSize = "X",
        ScrollingDirection = "X",
        ElasticBehavior = "Never",
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 0,
    }, {
        TextLabel
    })
    
    local CopyButton = New("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0,30,0,30),
        Position = UDim2.new(1,-CodeModule.Padding/2,0,CodeModule.Padding/2),
        AnchorPoint = Vector2.new(1,0),
        Visible = Callback and true or false,
    }, {
        Creator.NewRoundFrame(CodeModule.Radius-4, "Squircle", {
            -- ThemeTag = {
            --     ImageColor3 = "Text",
            -- },
            ImageColor3 = Color3.fromHex("#ffffff"),
            ImageTransparency = 1, -- .95
            Size = UDim2.new(1,0,1,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Name = "Button",
        }, {
            New("UIScale", {
                Scale = 1, -- .9
            }),
            New("ImageLabel", {
                Image = Creator.Icon("copy")[1],
                ImageRectSize = Creator.Icon("copy")[2].ImageRectSize,
                ImageRectOffset = Creator.Icon("copy")[2].ImageRectPosition,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
                Size = UDim2.new(0,12,0,12),
                -- ThemeTag = {
                --     ImageColor3 = "Icon",
                -- }, 
                ImageColor3 = Color3.fromHex("#ffffff"),
                ImageTransparency = .1,
            })
        })
    })
    
    Creator.AddSignal(CopyButton.MouseEnter, function()
        Tween(CopyButton.Button, .05, {ImageTransparency = .95}):Play()
        Tween(CopyButton.Button.UIScale, .05, {Scale = .9}):Play()
    end)
    Creator.AddSignal(CopyButton.InputEnded, function()
        Tween(CopyButton.Button, .08, {ImageTransparency = 1}):Play()
        Tween(CopyButton.Button.UIScale, .08, {Scale = 1}):Play()
    end)
    
    local CodeFrame = Creator.NewRoundFrame(CodeModule.Radius, "Squircle", {
        -- ThemeTag = {
        --     ImageColor3 = "Text"
        -- },
        ImageColor3 = Color3.fromHex("#212121"),
        ImageTransparency = .035,
        Size = UDim2.new(1,0,0,20+(CodeModule.Padding*2)),
        AutomaticSize = "Y",
        Parent = Parent,
    }, {
        Creator.NewRoundFrame(CodeModule.Radius, "SquircleOutline", {
            Size = UDim2.new(1,0,1,0),
            -- ThemeTag = {
            --     ImageColor3 = "Text"
            -- },
            ImageColor3 = Color3.fromHex("#ffffff"),
            ImageTransparency = .955,
        }),
        New("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
        }, {
            Creator.NewRoundFrame(CodeModule.Radius, "Squircle-TL-TR", {
                -- ThemeTag = {
                --     ImageColor3 = "Text"
                -- },
                ImageColor3 = Color3.fromHex("#ffffff"),
                ImageTransparency = .96,
                Size = UDim2.new(1,0,0,20+(CodeModule.Padding*2)),
                Visible = Title and true or false
            }, {
                New("ImageLabel", {
                    Size = UDim2.new(0,18,0,18),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://132464694294269", -- luau logo
                    -- ThemeTag = {
                    --     ImageColor3 = "Icon",
                    -- },
                    ImageColor3 = Color3.fromHex("#ffffff"),
                    ImageTransparency = .2,
                }),
                New("TextLabel", {
                    Text = Title,
                    -- ThemeTag = {
                    --     TextColor3 = "Icon",
                    -- },
                    TextColor3 = Color3.fromHex("#ffffff"),
                    TextTransparency = .2,
                    TextSize = 16,
                    AutomaticSize = "Y",
                    FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                    TextXAlignment = "Left",
                    BackgroundTransparency = 1,
                    TextTruncate = "AtEnd",
                    Size = UDim2.new(1,CopyButton and -20-(CodeModule.Padding*2),0,0)
                }),
                New("UIPadding", {
                    --PaddingTop = UDim.new(0,CodeModule.Padding),
                    PaddingLeft = UDim.new(0,CodeModule.Padding+3),
                    PaddingRight = UDim.new(0,CodeModule.Padding+3),
                    --PaddingBottom = UDim.new(0,CodeModule.Padding),
                }),
                New("UIListLayout", {
                    Padding = UDim.new(0,CodeModule.Padding),
                    FillDirection = "Horizontal",
                    VerticalAlignment = "Center",
                })
            }),
            ScrollingFrame,
            New("UIListLayout", {
                Padding = UDim.new(0,0),
                FillDirection = "Vertical",
            })
        }),
        CopyButton,
    })
    
    CodeModule.CodeFrame = CodeFrame
    
    Creator.AddSignal(TextLabel:GetPropertyChangedSignal("TextBounds"), function()
        ScrollingFrame.Size = UDim2.new(1,0,0,(TextLabel.TextBounds.Y/(UIScale or 1)) + ((CodeModule.Padding+3)*2))
    end)
    
    function CodeModule.Set(code)
        TextLabel.Text = Highlighter.run(code)
    end
    
    function CodeModule.Destroy()
        CodeFrame:Destroy()
        CodeModule = nil
    end
    
    CodeModule.Set(Code)

    Creator.AddSignal(CopyButton.MouseButton1Click, function()
        if Callback then
            Callback()
            local CheckIcon = Creator.Icon("check")
            CopyButton.Button.ImageLabel.Image = CheckIcon[1]
            CopyButton.Button.ImageLabel.ImageRectSize = CheckIcon[2].ImageRectSize
            CopyButton.Button.ImageLabel.ImageRectOffset = CheckIcon[2].ImageRectPosition
            
            task.wait(1)
            local CopyIcon = Creator.Icon("copy")
            CopyButton.Button.ImageLabel.Image = CopyIcon[1]
            CopyButton.Button.ImageLabel.ImageRectSize = CopyIcon[2].ImageRectSize
            CopyButton.Button.ImageLabel.ImageRectOffset = CopyIcon[2].ImageRectPosition
        end
    end)
    return CodeModule
end


return Code