local UserInputService = game:GetService("UserInputService")

local SearchBar = {
    Margin = 8,
    Padding = 9,
}


local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween


function SearchBar.new(TabModule, Parent, OnClose)
    local SearchBarModule = {
        IconSize = 18,
        Padding = 14,
        Radius = 22,
        Width = 400,
        MaxHeight = 380,
        
        Icons = require("./Icons")
    }
    
    
    local TextBox = New("TextBox", {
        Text = "",
        PlaceholderText = "Search...",
        ThemeTag = {
            PlaceholderColor3 = "Placeholder",
            TextColor3 = "Text",
        },
        Size = UDim2.new(
            1,
            -((SearchBarModule.IconSize*2)+(SearchBarModule.Padding*2)),
            0,
            0
        ),
        AutomaticSize = "Y",
        ClipsDescendants = true,
        ClearTextOnFocus = false,
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
        TextSize = 18,
    })
    
    local CloseButton = New("ImageLabel", {
        Image = Creator.Icon("x")[1],
        ImageRectSize = Creator.Icon("x")[2].ImageRectSize,
        ImageRectOffset = Creator.Icon("x")[2].ImageRectPosition,
        BackgroundTransparency = 1,
        ThemeTag = {
            ImageColor3 = "Icon",
        },
        ImageTransparency = .1,
        Size = UDim2.new(0,SearchBarModule.IconSize,0,SearchBarModule.IconSize)
    }, {
        New("TextButton", {
            Size = UDim2.new(1,8,1,8),
            BackgroundTransparency = 1,
            Active = true,
            ZIndex = 999999999,
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Text = "",
        })
    })
    
    local ScrollingFrame = New("ScrollingFrame", { -- list
        Size = UDim2.new(1,0,0,0),
        AutomaticCanvasSize = "Y",
        ScrollingDirection = "Y",
        ElasticBehavior = "Never",
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0,0,0,0),
        BackgroundTransparency = 1,
        Visible = false
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,0),
            FillDirection = "Vertical",
        }),
        New("UIPadding", {
            PaddingTop = UDim.new(0,SearchBarModule.Padding),
            PaddingLeft = UDim.new(0,SearchBarModule.Padding),
            PaddingRight = UDim.new(0,SearchBarModule.Padding),
            PaddingBottom = UDim.new(0,SearchBarModule.Padding),
        })
    })
    
    local SearchFrame = Creator.NewRoundFrame(SearchBarModule.Radius, "Squircle", {
        Size = UDim2.new(1,0,1,0),
        ThemeTag = {
            ImageColor3 = "Background",
        },
        ImageTransparency = 0,
    }, {
        Creator.NewRoundFrame(SearchBarModule.Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            --AutomaticSize = "Y",
            Visible = false,
            ImageColor3 = Color3.new(1,1,1),
            ImageTransparency = .98,
            Name = "Frame",
        }, {
            New("Frame", { -- topbar search
                Size = UDim2.new(1,0,0,46),
                BackgroundTransparency = 1,
            }, {
                -- Creator.NewRoundFrame(SearchBarModule.Radius, "Squircle-TL-TR", {
                --     Size = UDim2.new(1,0,1,0),
                --     BackgroundTransparency = 1,
                --     ThemeTag = {
                --         ImageColor3 = "Text",
                --     },
                --     ImageTransparency = .95
                -- }),
                New("Frame", {
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                }, {
                    New("ImageLabel", {
                        Image = Creator.Icon("search")[1],
                        ImageRectSize = Creator.Icon("search")[2].ImageRectSize,
                        ImageRectOffset = Creator.Icon("search")[2].ImageRectPosition,
                        BackgroundTransparency = 1,
                        ThemeTag = {
                            ImageColor3 = "Icon",
                        },
                        ImageTransparency = .1,
                        Size = UDim2.new(0,SearchBarModule.IconSize,0,SearchBarModule.IconSize)
                    }),
                    TextBox,
                    CloseButton,
                    New("UIListLayout", {
                        Padding = UDim.new(0,SearchBarModule.Padding),
                        FillDirection = "Horizontal",
                        VerticalAlignment = "Center",
                    }),  
                    New("UIPadding", {
                        PaddingLeft = UDim.new(0,SearchBarModule.Padding),
                        PaddingRight = UDim.new(0,SearchBarModule.Padding),
                    })
                })
            }),
            New("Frame", { -- results
                BackgroundTransparency = 1,
                AutomaticSize = "Y",
                Size = UDim2.new(1,0,0,0),
                Name = "Results",
            }, {
                New("Frame", {
                    Size = UDim2.new(1,0,0,1),
                    ThemeTag = {
                        BackgroundColor3 = "Outline",
                    },
                    BackgroundTransparency = .9,
                    Visible = false,
                }),
                ScrollingFrame,
                New("UISizeConstraint", {
                    MaxSize = Vector2.new(SearchBarModule.Width, SearchBarModule.MaxHeight),
                }),
            }),
            New("UIListLayout", {
                Padding = UDim.new(0,0),
                FillDirection = "Vertical",
            }),
        })
    })

    local SearchFrameContainer = New("Frame", {
        Size = UDim2.new(0,SearchBarModule.Width,0,0),
        AutomaticSize = "Y",
        Parent = Parent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5,0,0.5,0),
        AnchorPoint = Vector2.new(0.5,0.5),
        Visible = false, -- true
        --GroupTransparency = 1, -- 0
        ZIndex = 99999999,
    }, {
        New("UIScale", {
            Scale = .9, -- 1
        }),
        SearchFrame,
        Creator.NewRoundFrame(SearchBarModule.Radius, "SquircleOutline2", {
            Size = UDim2.new(1,0,1,0),
            ThemeTag = {
                ImageColor3 = "Outline",
            },
            ImageTransparency = 1, -- .7
        }, {
            New("UIGradient", {
                Rotation = 45,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.55),
                    NumberSequenceKeypoint.new(0.5, 0.8),
                    NumberSequenceKeypoint.new(1, 0.6)
                })
            })
        })
    })
    
    local function CreateSearchTab(Title, Desc, Icon, Parent, IsParent, Callback)
        local Tab = New("TextButton", {
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Parent = Parent or nil
        }, {
            Creator.NewRoundFrame(SearchBarModule.Radius-11, "Squircle", {
                Size = UDim2.new(1,0,0,0),
                Position = UDim2.new(0.5,0,0.5,0),
                AnchorPoint = Vector2.new(0.5,0.5),
                -- AutomaticSize = "Y",
                ThemeTag = {
                    ImageColor3 = "Text",
                },
                ImageTransparency = 1, -- .95
                Name = "Main"
            }, {
                Creator.NewRoundFrame(SearchBarModule.Radius-11, "SquircleOutline2", {
                    Size = UDim2.new(1,0,1,0),
                    Position = UDim2.new(0.5,0,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    ThemeTag = {
                        ImageColor3 = "Outline",
                    },
                    ImageTransparency = 1, -- .7
                    Name = "Outline",
                }, {
                    New("UIGradient", {
                        Rotation = 65,
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0.55),
                            NumberSequenceKeypoint.new(0.5, 0.8),
                            NumberSequenceKeypoint.new(1, 0.6)
                        })
                    }),
                    New("UIPadding", {
                        PaddingTop = UDim.new(0,SearchBarModule.Padding-2),
                        PaddingLeft = UDim.new(0,SearchBarModule.Padding),
                        PaddingRight = UDim.new(0,SearchBarModule.Padding),
                        PaddingBottom = UDim.new(0,SearchBarModule.Padding-2),
                    }),
                    New("ImageLabel", {
                        Image = Creator.Icon(Icon)[1],
                        ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
                        ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
                        BackgroundTransparency = 1,
                        ThemeTag = {
                            ImageColor3 = "Icon",
                        },
                        ImageTransparency = .1,
                        Size = UDim2.new(0,SearchBarModule.IconSize,0,SearchBarModule.IconSize)
                    }),
                    New("Frame", {
                        Size = UDim2.new(1,-SearchBarModule.IconSize-SearchBarModule.Padding,0,0),
                        BackgroundTransparency = 1,
                    }, {
                        New("TextLabel", {
                            Text = Title,
                            ThemeTag = {
                                TextColor3 = "Text",
                            },
                            TextSize = 17,
                            BackgroundTransparency = 1,
                            TextXAlignment = "Left",
                            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                            Size = UDim2.new(1,0,0,0),
                            TextTruncate = "AtEnd",
                            AutomaticSize = "Y",
                            Name = "Title"
                        }),
                        New("TextLabel", {
                            Text = Desc or "",
                            Visible = Desc and true or false,
                            ThemeTag = {
                                TextColor3 = "Text",
                            },
                            TextSize = 15,
                            TextTransparency = .3,
                            BackgroundTransparency = 1,
                            TextXAlignment = "Left",
                            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                            Size = UDim2.new(1,0,0,0),
                            TextTruncate = "AtEnd",
                            AutomaticSize = "Y",
                            Name = "Desc"
                        }) or nil,
                        New("UIListLayout", {
                            Padding = UDim.new(0,6),
                            FillDirection = "Vertical",
                        })
                    }),
                    New("UIListLayout", {
                        Padding = UDim.new(0,SearchBarModule.Padding),
                        FillDirection = "Horizontal",
                    })
                }),
            }, true),
            New("Frame", {
                Name = "ParentContainer",
                Size = UDim2.new(1,-SearchBarModule.Padding,0,0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
                Visible = IsParent,
                --Position = UDim2.new(0,SearchBarModule.Padding*2,1,0),
            }, {
                Creator.NewRoundFrame(99, "Squircle", { -- line
                    Size = UDim2.new(0,2,1,0),
                    BackgroundTransparency = 1,
                    ThemeTag = {
                        ImageColor3 = "Text"
                    },
                    ImageTransparency = .9,
                }),
                New("Frame", {
                    Size = UDim2.new(1,-SearchBarModule.Padding-2,0,0),
                    Position = UDim2.new(0,SearchBarModule.Padding+2,0,0),
                    BackgroundTransparency = 1,
                }, {
                    New("UIListLayout", {
                        Padding = UDim.new(0,0),
                        FillDirection = "Vertical",
                    }),
                }),
            }),
            New("UIListLayout", {
                Padding = UDim.new(0,0),
                FillDirection = "Vertical",
                HorizontalAlignment = "Right"
            })
        })
        
        --
        
        Tab.Main.Size = UDim2.new(
            1,
            0,
            0,
            Tab.Main.Outline.Frame.Desc.Visible and (((SearchBarModule.Padding-2)*2) + Tab.Main.Outline.Frame.Title.TextBounds.Y + 6 + Tab.Main.Outline.Frame.Desc.TextBounds.Y)
            or (((SearchBarModule.Padding-2)*2) + Tab.Main.Outline.Frame.Title.TextBounds.Y)
        )

        Creator.AddSignal(Tab.Main.MouseEnter, function()
            Tween(Tab.Main, .04, {ImageTransparency = .95}):Play()
            Tween(Tab.Main.Outline, .04, {ImageTransparency = .7}):Play()
        end)
        Creator.AddSignal(Tab.Main.InputEnded, function()
            Tween(Tab.Main, .08, {ImageTransparency = 1}):Play()
            Tween(Tab.Main.Outline, .08, {ImageTransparency = 1}):Play()
        end)
        Creator.AddSignal(Tab.Main.MouseButton1Click, function()
            if Callback then
                Callback()
            end
        end)
        
        return Tab
    end
    
    local function ContainsText(str, query)
        if not query or query == "" then
            return false
        end
        
        if not str or str == "" then
            return false
        end
        
        local lowerStr = string.lower(str)
        local lowerQuery = string.lower(query)
        
        return string.find(lowerStr, lowerQuery, 1, true) ~= nil
    end
    
    local function Search(query)
        if not query or query == "" then
            return {}
        end
        
        local results = {}
        for tabindex, tab in next, TabModule.Tabs do
            local tabMatches = ContainsText(tab.Title or "", query)
            local elementResults = {}
            
            for elemindex, elem in next, tab.Elements do
                if elem.__type ~= "Section" then
                    local titleMatches = ContainsText(elem.Title or "", query)
                    local descMatches = ContainsText(elem.Desc or "", query)
                    
                    if titleMatches or descMatches then
                        elementResults[elemindex] = {
                            Title = elem.Title,
                            Desc = elem.Desc,
                            Original = elem,
                            __type = elem.__type,
                            Index = elemindex,
                        }
                    end
                end
            end
            
            if tabMatches or next(elementResults) ~= nil then
                results[tabindex] = { 
                    Tab = tab,
                    Title = tab.Title,
                    Icon = tab.Icon,
                    Elements = elementResults,
                }
            end
        end
        return results
    end
    
    function SearchBarModule:Search(query)
        query = query or ""
        
        local result = Search(query)
        
        ScrollingFrame.Visible = true
        SearchFrame.Frame.Results.Frame.Visible = true
        for _, item in next, ScrollingFrame:GetChildren() do
            if item.ClassName ~= "UIListLayout" and item.ClassName ~= "UIPadding" then
                item:Destroy()
            end
        end

        if result and next(result) ~= nil then
            for tabindex, i in next, result do
                local TabIcon = SearchBarModule.Icons["Tab"]
                local TabMainElement = CreateSearchTab(i.Title, nil, TabIcon, ScrollingFrame, true, function()
                    SearchBarModule:Close()
                    TabModule:SelectTab(tabindex) 
                end)
                if i.Elements and next(i.Elements) ~= nil then
                    for elemindex, e in next, i.Elements do
                        local ElementIcon = SearchBarModule.Icons[e.__type]
                        CreateSearchTab(e.Title, e.Desc, ElementIcon, TabMainElement:FindFirstChild("ParentContainer") and TabMainElement.ParentContainer.Frame or nil, false, function()
                            SearchBarModule:Close()
                            TabModule:SelectTab(tabindex) 
                            if i.Tab.ScrollToTheElement then
                                --print("uooo")
                                i.Tab:ScrollToTheElement(e.Index)
                            end
                            --
                        end)
                        --task.wait(0)
                    end
                end
            end
        elseif query ~= "" then
            New("TextLabel", {
                Size = UDim2.new(1,0,0,70),
                BackgroundTransparency = 1,
                Text = "No results found",
                TextSize = 16,
                ThemeTag = {
                    TextColor3 = "Text",
                },
                TextTransparency = .2,
                BackgroundTransparency = 1,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                Parent = ScrollingFrame,
                Name = "NotFound",
            })
        else
            ScrollingFrame.Visible = false
            SearchFrame.Frame.Results.Frame.Visible = false
        end
    end
    
    Creator.AddSignal(TextBox:GetPropertyChangedSignal("Text"), function()
        SearchBarModule:Search(TextBox.Text)
    end)
    
    Creator.AddSignal(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        --task.wait()
        Tween(ScrollingFrame, .06, {Size = UDim2.new(
            1,
            0,
            0,
            math.clamp(ScrollingFrame.UIListLayout.AbsoluteContentSize.Y+(SearchBarModule.Padding*2), 0, SearchBarModule.MaxHeight)
        )}, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut):Play()
        -- ScrollingFrame.Size = UDim2.new(
        --     1,
        --     0,
        --     0,
        --     math.clamp(ScrollingFrame.UIListLayout.AbsoluteContentSize.Y+(SearchBarModule.Padding*2), 0, SearchBarModule.MaxHeight)
        -- )
    end)
    
    function SearchBarModule:Open()
        task.spawn(function()
            SearchFrame.Frame.Visible = true
            SearchFrameContainer.Visible = true
            Tween(SearchFrameContainer.UIScale, .12, {Scale = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        end)
    end
    
    function SearchBarModule:Close()
        task.spawn(function()
            OnClose()
            SearchFrame.Frame.Visible = false
            Tween(SearchFrameContainer.UIScale, .12, {Scale = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            
            task.wait(.12)
            SearchFrameContainer.Visible = false
        end)
    end
    
    Creator.AddSignal(CloseButton.TextButton.MouseButton1Click, function()
        SearchBarModule:Close()
    end)
    
    SearchBarModule:Open()
    
    return SearchBarModule
end

return SearchBar