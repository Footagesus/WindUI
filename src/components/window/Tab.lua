local cloneref = (cloneref or clonereference or function(instance) return instance end)

local UserInputService = cloneref(game:GetService("UserInputService"))
local Mouse = game.Players.LocalPlayer:GetMouse()

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local CreateToolTip = require("../ui/Tooltip").New
local CreateScrollSlider = require("../ui/ScrollSlider").New



local Window, WindUI, UIScale

local TabModule = {
    --Window = nil,
    --WindUI = nil,
    Tabs = {}, 
    Containers = {},
    SelectedTab = nil,
    TabCount = 0,
    ToolTipParent = nil,
    TabHighlight = nil,
    
    OnChangeFunc = function(v) end
}

function TabModule.Init(WindowTable, WindUITable, ToolTipParent, TabHighlight)
    Window = WindowTable
    WindUI = WindUITable
    TabModule.ToolTipParent = ToolTipParent
    TabModule.TabHighlight = TabHighlight
    return TabModule
end

function TabModule.New(Config, UIScale)
    local Tab = {
        __type = "Tab",
        Title = Config.Title or "Tab",
        Desc = Config.Desc,
        Icon = Config.Icon,
        IconColor = Config.IconColor,
        IconShape = Config.IconShape,
        IconThemed = Config.IconThemed,
        Locked = Config.Locked,
        ShowTabTitle = Config.ShowTabTitle,
        Selected = false,
        Index = nil,
        Parent = Config.Parent,
        UIElements = {},
        Elements = {},
        ContainerFrame = nil,
        UICorner = Window.UICorner-(Window.UIPadding/2),
        
        Gap = Window.NewElements and 1 or 6,
        
        TabPaddingX = 4+(Window.UIPadding/2),
        TabPaddingY = 3+(Window.UIPadding/2),
        TitlePaddingY = 0,
    }
    
    if Tab.IconShape then
        Tab.TabPaddingX = 2+(Window.UIPadding/4)
        Tab.TabPaddingY = 2+(Window.UIPadding/4)
        Tab.TitlePaddingY = 2+(Window.UIPadding/4)
    end
    
    TabModule.TabCount = TabModule.TabCount + 1
    
	local TabIndex = TabModule.TabCount
	Tab.Index = TabIndex
	
    Tab.UIElements.Main = Creator.NewRoundFrame(Tab.UICorner, "Squircle", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,-7,0,0),
        AutomaticSize = "Y",
        Parent = Config.Parent,
        ThemeTag = {
            ImageColor3 = "TabBackground",
        },
        ImageTransparency = 1,
    }, {
        Creator.NewRoundFrame(Tab.UICorner, "Glass-1", { 
            Size = UDim2.new(1,0,1,0),
            ThemeTag = {
                ImageColor3 = "Text",
            },
            ImageTransparency = 1, -- .85  
            Name = "Outline"
        }, {
            -- New("UIGradient", {
            --     Rotation = 80,
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
            -- }),
        }),
        Creator.NewRoundFrame(Tab.UICorner, "Squircle", {
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
            ThemeTag = {
                ImageColor3 = "Text",
            },
            ImageTransparency = 1, -- .95
            Name = "Frame",
    }, {
            New("UIListLayout", {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0,2+(Window.UIPadding/2)),
                FillDirection = "Horizontal",
                VerticalAlignment = "Center",
            }),
            New("TextLabel", {
                Text = Tab.Title,
                ThemeTag = {
                    TextColor3 = "TabTitle"
                },
                TextTransparency = not Tab.Locked and 0.4 or .7,
                TextSize = 15,
                Size = UDim2.new(1,0,0,0),
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                TextWrapped = true,
                RichText = true,
                AutomaticSize = "Y",
                LayoutOrder = 2,
                TextXAlignment = "Left",
                BackgroundTransparency = 1,
            }, {
                New("UIPadding", {
                    PaddingTop = UDim.new(0,Tab.TitlePaddingY),
                    --PaddingLeft = UDim.new(0,2+(Window.UIPadding/2)),
                    --PaddingRight = UDim.new(0,2+(Window.UIPadding/2)),
                    PaddingBottom = UDim.new(0,Tab.TitlePaddingY)
                })
            }),
            New("UIPadding", {
                PaddingTop = UDim.new(0,Tab.TabPaddingY),
                PaddingLeft = UDim.new(0,Tab.TabPaddingX),
                PaddingRight = UDim.new(0,Tab.TabPaddingX),
                PaddingBottom = UDim.new(0,Tab.TabPaddingY),
            })
        }),
    }, true)
	
	local TextOffset = 0
	local Icon
	local Icon2

	if Tab.Icon then
        Icon = Creator.Image(
            Tab.Icon,
            Tab.Icon .. ":" .. Tab.Title,
            0,
            Window.Folder,
            Tab.__type,
            Tab.IconColor and false or true,
            Tab.IconThemed,
            "TabIcon"
        )
        Icon.Size = UDim2.new(0,16,0,16)
        if Tab.IconColor then
            Icon.ImageLabel.ImageColor3 = Tab.IconColor
        end
        if not Tab.IconShape then
            Icon.Parent = Tab.UIElements.Main.Frame
            Tab.UIElements.Icon = Icon
            Icon.ImageLabel.ImageTransparency = not Tab.Locked and 0 or .7
            TextOffset = -16-2-(Window.UIPadding/2)
            Tab.UIElements.Main.Frame.TextLabel.Size = UDim2.new(1,TextOffset,0,0)
        elseif Tab.IconColor then
            local IconBG = Creator.NewRoundFrame(Tab.IconShape ~= "Circle" and (Tab.UICorner + 5 - (2+(Window.UIPadding/4))) or 9999, "Squircle", {
                Size = UDim2.new(0,26,0,26),
                ImageColor3 = Tab.IconColor,
                Parent = Tab.UIElements.Main.Frame
            }, {
                Icon,
                Creator.NewRoundFrame(Tab.IconShape ~= "Circle" and (Tab.UICorner + 5 - (2+(Window.UIPadding/4))) or 9999, "Glass-1.4", {
                    Size = UDim2.new(1,0,1,0),
                    ThemeTag = {
                        ImageColor3 = "White",
                    },
                    ImageTransparency = 0,
                    Name = "Outline"
                }, {
                    -- New("UIGradient", {
                    --     Rotation = 45,
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
                    -- }),
                }),
            })
            Icon.AnchorPoint = Vector2.new(0.5,0.5)
            Icon.Position = UDim2.new(0.5,0,0.5,0)
            Icon.ImageLabel.ImageTransparency = 0
            Icon.ImageLabel.ImageColor3 = Creator.GetTextColorForHSB(Tab.IconColor, 0.68)
            TextOffset = -26-2-(Window.UIPadding/2)
            Tab.UIElements.Main.Frame.TextLabel.Size = UDim2.new(1,TextOffset,0,0)
        end
        
        
        
        
        
        Icon2 = Creator.Image(
            Tab.Icon,
            Tab.Icon .. ":" .. Tab.Title,
            0,
            Window.Folder,
            Tab.__type,
            true,
            Tab.IconThemed
        )
        Icon2.Size = UDim2.new(0,16,0,16)
        Icon2.ImageLabel.ImageTransparency = not Tab.Locked and 0 or .7
        TextOffset = -30
        
        --Icon2.Parent = Tab.UIElements.Main.Frame
        --Tab.UIElements.Main.Frame.TextLabel.Size = UDim2.new(1,-30,0,0)
        --Tab.UIElements.Icon = Icon
	end
	
	Tab.UIElements.ContainerFrame = New("ScrollingFrame", {
        Size = UDim2.new(1,0,1,Tab.ShowTabTitle and -((Window.UIPadding*2.4)+12) or 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        ElasticBehavior = "Never",
        CanvasSize = UDim2.new(0,0,0,0),
        AnchorPoint = Vector2.new(0,1),
        Position = UDim2.new(0,0,1,0),
        AutomaticCanvasSize = "Y",
        --Visible = false,
        ScrollingDirection = "Y",
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,not Window.HidePanelBackground and 20 or 10),
            PaddingLeft = UDim.new(0,not Window.HidePanelBackground and 20 or 10),
            PaddingRight = UDim.new(0,not Window.HidePanelBackground and 20 or 10),
            PaddingBottom = UDim.new(0,not Window.HidePanelBackground and 20 or 10),
        }),
        New("UIListLayout", {
            SortOrder = "LayoutOrder",
            Padding = UDim.new(0,Tab.Gap),
            HorizontalAlignment = "Center",
        })
    })

    -- Tab.UIElements.ContainerFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    --     Tab.UIElements.ContainerFrame.CanvasSize = UDim2.new(0,0,0,Tab.UIElements.ContainerFrame.UIListLayout.AbsoluteContentSize.Y+Window.UIPadding*2)
    -- end)
    
    Tab.UIElements.ContainerFrameCanvas = New("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = Window.UIElements.MainBar,
        ZIndex = 5,
    }, {
        Tab.UIElements.ContainerFrame,
        New("Frame", {
            Size = UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
            BackgroundTransparency = 1,
            Visible = Tab.ShowTabTitle or false,
            Name = "TabTitle"
        }, {
            Icon2,
            New("TextLabel", {
                Text = Tab.Title,
                ThemeTag = {
                    TextColor3 = "Text"
                },
                TextSize = 20,
                TextTransparency = .1,
                Size = UDim2.new(1,-TextOffset,1,0),
                FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
                TextTruncate = "AtEnd",
                RichText = true,
                LayoutOrder = 2,
                TextXAlignment = "Left",
                BackgroundTransparency = 1,
            }),
            New("UIPadding", {
                PaddingTop = UDim.new(0,20),
                PaddingLeft = UDim.new(0,20),
                PaddingRight = UDim.new(0,20),
                PaddingBottom = UDim.new(0,20),
            }),
            New("UIListLayout", {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0,10),
                FillDirection = "Horizontal",
                VerticalAlignment = "Center",
            })
        }),
        New("Frame", {
            Size = UDim2.new(1,0,0,1),
            BackgroundTransparency = .9,
            ThemeTag = {
                BackgroundColor3 = "Text"
            },
            Position = UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
            Visible = Tab.ShowTabTitle or false,
        })
    })
    
    TabModule.Containers[TabIndex] = Tab.UIElements.ContainerFrameCanvas
	TabModule.Tabs[TabIndex] = Tab
	
	Tab.ContainerFrame = ContainerFrameCanvas
	
    Creator.AddSignal(Tab.UIElements.Main.MouseButton1Click, function()
        if not Tab.Locked then
            TabModule:SelectTab(TabIndex)       
        end
    end)
	
	if Window.ScrollBarEnabled then
        CreateScrollSlider(Tab.UIElements.ContainerFrame, Tab.UIElements.ContainerFrameCanvas, Window, 3)
	end

	local ToolTip
    local hoverTimer
    local MouseConn
    local IsHovering = false
    
        
	-- ToolTip
    if Tab.Desc then
        
        
        Creator.AddSignal(Tab.UIElements.Main.InputBegan, function()
            IsHovering = true
            hoverTimer = task.spawn(function()
                task.wait(0.35)
                if IsHovering and not ToolTip then
                    ToolTip = CreateToolTip(Tab.Desc, TabModule.ToolTipParent, true)
                    ToolTip.Container.AnchorPoint = Vector2.new(0.5,0.5)
        
                    local function updatePosition()
                        if ToolTip then
                            ToolTip.Container.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y - 4)
                        end
                    end
        
                    updatePosition()
                    MouseConn = Mouse.Move:Connect(updatePosition)
                    ToolTip:Open()
                end
            end)
        end)
        
    end
    
    Creator.AddSignal(Tab.UIElements.Main.MouseEnter, function()
        if not Tab.Locked then
            Tween(Tab.UIElements.Main.Frame, 0.08, {ImageTransparency = .97}):Play()
        end
    end)
    Creator.AddSignal(Tab.UIElements.Main.InputEnded, function()
        if Tab.Desc then
            IsHovering = false
            if hoverTimer then
                task.cancel(hoverTimer)
                hoverTimer = nil
            end
            if MouseConn then
                MouseConn:Disconnect()
                MouseConn = nil
            end
            if ToolTip then
                ToolTip:Close()
                ToolTip = nil
            end
        end
        
        if not Tab.Locked then
            Tween(Tab.UIElements.Main.Frame, 0.08, {ImageTransparency = 1}):Play()
        end
    end)
    
    
    
    function Tab:ScrollToTheElement(elemindex)
        Tab.UIElements.ContainerFrame.ScrollingEnabled = false
        Tween(Tab.UIElements.ContainerFrame, .45, 
            { 
                CanvasPosition = Vector2.new(
                    0, -- X
                    
                    Tab.Elements[elemindex].ElementFrame.AbsolutePosition.Y 
                    - Tab.UIElements.ContainerFrame.AbsolutePosition.Y  
                    - Tab.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset -- Y
                ) 
            }, 
            Enum.EasingStyle.Quint, Enum.EasingDirection.Out
        ):Play()
        
        task.spawn(function()
            task.wait(.48)
            
            if Tab.Elements[elemindex].Highlight then
                Tab.Elements[elemindex]:Highlight()
                Tab.UIElements.ContainerFrame.ScrollingEnabled = true
            end
        end)
        
        return Tab
    end
	
    
    
	-- yo
	
    local ElementsModule = require("../../elements/Init")
    
    ElementsModule.Load(Tab, Tab.UIElements.ContainerFrame, ElementsModule.Elements, Window, WindUI, nil, ElementsModule, UIScale)
    
    
    
    function Tab:LockAll()
        --print("LockAll called, number of elements: " .. #self.Elements)
        for _, element in next, Window.AllElements do
            if element.Tab and element.Tab.Index and element.Tab.Index == Tab.Index and element.Lock then 
                element:Lock()
            end
        end
    end
    function Tab:UnlockAll()
        for _, element in next, Window.AllElements do
            if element.Tab and element.Tab.Index and element.Tab.Index == Tab.Index and element.Unlock then
                element:Unlock()
            end
        end
    end
    function Tab:GetLocked()
        local LockedElements = {}
        
        for _, element in next, Window.AllElements do
            if element.Tab and element.Tab.Index and element.Tab.Index == Tab.Index and element.Locked == true then 
                table.insert(LockedElements, element)
            end
        end
        
        return LockedElements
    end
    function Tab:GetUnlocked()
        local UnlockedElements = {}
        
        for _, element in next, Window.AllElements do
            if element.Tab and element.Tab.Index and element.Tab.Index == Tab.Index and element.Locked == false then 
                table.insert(UnlockedElements, element)
            end
        end
        
        return UnlockedElements
    end
    
    function Tab:Select()
        return TabModule:SelectTab(Tab.Index)
    end
    
	task.spawn(function()
        local Empty = New("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
            Parent = Tab.UIElements.ContainerFrame
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,8),
                SortOrder = "LayoutOrder",
                VerticalAlignment = "Center",
                HorizontalAlignment = "Center",
                FillDirection = "Vertical",
            }), 
            New("ImageLabel", {
                Size = UDim2.new(0,48,0,48),
                Image = Creator.Icon("frown")[1],
                ImageRectOffset = Creator.Icon("frown")[2].ImageRectPosition,
                ImageRectSize = Creator.Icon("frown")[2].ImageRectSize,
                ThemeTag = {
                    ImageColor3 = "Icon"
                },
                BackgroundTransparency = 1,
                ImageTransparency = .6,
            }),
            New("TextLabel", {
                AutomaticSize = "XY",
                Text = "This tab is empty",
                ThemeTag = {
                    TextColor3 = "Text"
                },
                TextSize = 18,
                TextTransparency = .5,
                BackgroundTransparency = 1,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            })
        })
        
        -- Empty.TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
        --     Empty.TextLabel.Size = UDim2.new(0,Empty.TextLabel.TextBounds.X,0,Empty.TextLabel.TextBounds.Y)
        -- end)
        
        local CreationConn
        CreationConn = Creator.AddSignal(Tab.UIElements.ContainerFrame.ChildAdded, function()
            Empty.Visible = false
            CreationConn:Disconnect()
        end)
	end)
	
	return Tab
end

function TabModule:OnChange(func)
    TabModule.OnChangeFunc = func
end

function TabModule:SelectTab(TabIndex)
    if not TabModule.Tabs[TabIndex].Locked then
        TabModule.SelectedTab = TabIndex
        
        for _, TabObject in next, TabModule.Tabs do
            if not TabObject.Locked then
                Tween(TabObject.UIElements.Main, 0.15, {ImageTransparency = 1}):Play()
                --Tween(TabObject.UIElements.Main.Outline, 0.15, {ImageTransparency = 1}):Play()
                Tween(TabObject.UIElements.Main.Frame.TextLabel, 0.15, {TextTransparency = 0.3}):Play()
                if TabObject.UIElements.Icon and not TabObject.IconColor then
                    Tween(TabObject.UIElements.Icon.ImageLabel, 0.15, {ImageTransparency = 0.4}):Play()
                end
                TabObject.Selected = false
            end
        end
        Tween(TabModule.Tabs[TabIndex].UIElements.Main, 0.15, {ImageTransparency = 0.93}):Play()
        --Tween(TabModule.Tabs[TabIndex].UIElements.Main.Outline, 0.15, {ImageTransparency = 0}):Play()
        Tween(TabModule.Tabs[TabIndex].UIElements.Main.Frame.TextLabel, 0.15, {TextTransparency = 0}):Play()
        if TabModule.Tabs[TabIndex].UIElements.Icon and not TabModule.Tabs[TabIndex].IconColor then
            Tween(TabModule.Tabs[TabIndex].UIElements.Icon.ImageLabel, 0.15, {ImageTransparency = 0.1}):Play()
        end
        TabModule.Tabs[TabIndex].Selected = true
        
        
        task.spawn(function()
            for _, ContainerObject in next, TabModule.Containers do
                ContainerObject.AnchorPoint = Vector2.new(0,0.05)
                ContainerObject.Visible = false
            end
            TabModule.Containers[TabIndex].Visible = true
            Tween(TabModule.Containers[TabIndex], 0.15, {AnchorPoint = Vector2.new(0,0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()
        end)
        
        TabModule.OnChangeFunc(TabIndex)
    end
end

return TabModule