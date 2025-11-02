local PopupModule = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function PopupModule.new(PopupConfig)
    local Popup = {
        Title = PopupConfig.Title or "Dialog",
        Content = PopupConfig.Content,
        Icon = PopupConfig.Icon,
        IconThemed = PopupConfig.IconThemed,
        Thumbnail = PopupConfig.Thumbnail,
        Buttons = PopupConfig.Buttons,
        
        IconSize = 22,
    }
    
    local DialogInit = require("../window/Dialog").Init(nil, PopupConfig.WindUI.ScreenGui.Popups)
    local Dialog = DialogInit.Create(true, "Popup")
    
    local ThumbnailSize = 200
    
    local UISize = 430
    if Popup.Thumbnail and Popup.Thumbnail.Image then
        UISize = 430+(ThumbnailSize/2)
    end
    
    Dialog.UIElements.Main.AutomaticSize = "Y"
    Dialog.UIElements.Main.Size = UDim2.new(0,UISize,0,0)
    
    
    
    local IconFrame
    
    if Popup.Icon then
        IconFrame = Creator.Image(
            Popup.Icon,
            Popup.Title .. ":" .. Popup.Icon,
            0,
            PopupConfig.WindUI.Window,
            "Popup",
            true,
            PopupConfig.IconThemed,
            "PopupIcon"
        )
        IconFrame.Size = UDim2.new(0,Popup.IconSize,0,Popup.IconSize)
        IconFrame.LayoutOrder = -1
    end
    
    
    local Title = New("TextLabel", {
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        Text = Popup.Title,
        TextXAlignment = "Left",
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        ThemeTag = {
            TextColor3 = "PopupTitle",
        },
        TextSize = 20,
        TextWrapped = true,
        Size = UDim2.new(1, IconFrame and -Popup.IconSize-14 or 0,0,0)
    })

    local IconAndTitleContainer = New("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,14),
            FillDirection = "Horizontal",
            VerticalAlignment = "Center"
        }),
        IconFrame, Title
    })
    
    local TitleContainer = New("Frame", {
        AutomaticSize = "Y",
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
    }, {
        -- New("UIListLayout", {
        --     Padding = UDim.new(0,9),
        --     FillDirection = "Horizontal",
        --     VerticalAlignment = "Bottom"
        -- }),
        IconAndTitleContainer,
    })
    
    local NoteText
    if Popup.Content and Popup.Content ~= "" then
        NoteText = New("TextLabel", {
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            TextXAlignment = "Left",
            Text = Popup.Content,
            TextSize = 18,
            TextTransparency = .2,
            ThemeTag = {
                TextColor3 = "PopupContent",
            },
            BackgroundTransparency = 1,
            RichText = true,
            TextWrapped = true,
        })
    end

    local ButtonsContainer = New("Frame", {
        Size = UDim2.new(1,0,0,42),
        BackgroundTransparency = 1,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,18/2),
            FillDirection = "Horizontal",
            HorizontalAlignment = "Right"
        })
    })
    
    local ThumbnailFrame
    if Popup.Thumbnail and Popup.Thumbnail.Image then
        local ThumbnailTitle
        if Popup.Thumbnail.Title then
            ThumbnailTitle = New("TextLabel", {
                Text = Popup.Thumbnail.Title,
                ThemeTag = {
                    TextColor3 = "Text",
                },
                TextSize = 18,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                BackgroundTransparency = 1,
                AutomaticSize = "XY",
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
            })
        end
        ThumbnailFrame = New("ImageLabel", {
            Image = Popup.Thumbnail.Image,
            BackgroundTransparency = 1,
            Size = UDim2.new(0,ThumbnailSize,1,0),
            Parent = Dialog.UIElements.Main,
            ScaleType = "Crop"
        }, {
            ThumbnailTitle,
            New("UICorner", {
                CornerRadius = UDim.new(0,0),
            })
        })
    end
    
    local MainFrame = New("Frame", {
        --AutomaticSize = "XY",
        Size = UDim2.new(1, ThumbnailFrame and -ThumbnailSize or 0,1,0),
        Position = UDim2.new(0, ThumbnailFrame and ThumbnailSize or 0,0,0),
        BackgroundTransparency = 1,
        Parent = Dialog.UIElements.Main
    }, {
        New("Frame", {
            --AutomaticSize = "XY",
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,18),
                FillDirection = "Vertical",
            }),
            TitleContainer,
            NoteText,
            ButtonsContainer,
            New("UIPadding", {
                PaddingTop = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
            })
        }),
    })

    local CreateButton = require("../ui/Button").New
    
    for _, values in next, Popup.Buttons do
        CreateButton(values.Title, values.Icon, values.Callback, values.Variant, ButtonsContainer, Dialog)
    end
    
    Dialog:Open()
    
    
    return Popup
end

return PopupModule