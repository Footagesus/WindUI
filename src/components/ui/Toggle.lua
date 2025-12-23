local Toggle = {}

local Creator = require("../../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local UserInputService = game:GetService("UserInputService")

function Toggle.New(Value, Icon, IconSize, Parent, Callback, NewElement, Config)
    local Toggle = {}
    
    local Radius = 24/2
    local IconToggleFrame
    if Icon and Icon ~= "" then
        IconToggleFrame = New("ImageLabel", {
            Size = UDim2.new(0,20-7,0,20-7),
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
    
    local ToggleContainer = New("Frame", {
        Size = UDim2.new(0,2,0,26),
        BackgroundTransparency = 1,
        Parent = Parent,
    })
    
    local ToggleFrame = Creator.NewRoundFrame(Radius, "Squircle",{
        ImageTransparency = .85,
        ThemeTag = {
            ImageColor3 = "Text"
        },
        Parent = ToggleContainer,
        Size = UDim2.new(0,NewElement and (24+24+4) or (24*1.7),0,24),
        AnchorPoint = Vector2.new(1,0.5),
        Position = UDim2.new(0,0,0.5,0),
    }, {
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            Name = "Layer",
            ThemeTag = {
                ImageColor3 = "Toggle",
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
            Size = UDim2.new(0,NewElement and 30 or 20,0,20),
            Position = UDim2.new(0,2,0.5,0),
            AnchorPoint = Vector2.new(0,0.5),
            ImageTransparency = 1,
            Name = "Frame",
        }, {
            Creator.NewRoundFrame(Radius, "Squircle", {
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = 0,
                ThemeTag = {
                    ImageColor3 = "ToggleBar",
                },
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
                Name = "Bar"
            }, {
                Creator.NewRoundFrame(Radius, "Glass-1", {
                    Size = UDim2.new(1,0,1,0),
                    ImageColor3 = Color3.new(1,1,1),
                    Name = "Highlight",
                    ImageTransparency = 0.4,
                }, {
                    -- New("UIGradient", {
                    --     Rotation = 60,
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
                IconToggleFrame,
                New("UIScale", {
                    Scale = 1, -- 1.66
                })
            }),
        })
    })
    
    local dragConnection
    local endConnection
    local startX
    local FrameWidth = NewElement and 30 or 20
    local ToggleWidth = ToggleFrame.Size.X.Offset
    
    function Toggle:Set(Toggled, isCallback, isAnim)
        if not isAnim then
            if Toggled then
                Tween(ToggleFrame.Frame, 0.15, {
                    Position = UDim2.new(0, ToggleWidth - FrameWidth - 2, 0.5, 0),
                }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            else
                Tween(ToggleFrame.Frame, 0.15, {
                    Position = UDim2.new(0, 2, 0.5, 0),
                }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            end
        else
            if Toggled then
                ToggleFrame.Frame.Position = UDim2.new(0, ToggleWidth - FrameWidth - 2, 0.5, 0)
            else
                ToggleFrame.Frame.Position = UDim2.new(0, 2, 0.5, 0)
            end
        end
    
        if Toggled then
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 0,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 0,
                }):Play()
            end
        else
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 1,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 1,
                }):Play()
            end
        end
    
        isCallback = isCallback ~= false
        
        task.spawn(function()
            if Callback and isCallback then
                Creator.SafeCallback(Callback, Toggled)
            end
        end)
    end
    
    
    function Toggle:Animate(input, ToggleObj)
        if not Config.Window.IsToggleDragging then
            Config.Window.IsToggleDragging = true
            
            local startMouseX = input.Position.X
            local startMouseY = input.Position.Y
            local startFrameX = ToggleFrame.Frame.Position.X.Offset
            local isScrolling = false
            
            Tween(ToggleFrame.Frame.Bar.UIScale, 0.28, {Scale = 1.5}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            Tween(ToggleFrame.Frame.Bar, 0.28, {ImageTransparency = .85}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            
            if dragConnection then
                dragConnection:Disconnect()
            end
            
            dragConnection = UserInputService.InputChanged:Connect(function(inputChanged)
                if Config.Window.IsToggleDragging and (inputChanged.UserInputType == Enum.UserInputType.MouseMovement or inputChanged.UserInputType == Enum.UserInputType.Touch) then
                    if isScrolling then
                        return
                    end
                    
                    local deltaX = math.abs(inputChanged.Position.X - startMouseX)
                    local deltaY = math.abs(inputChanged.Position.Y - startMouseY)
                    
                    if deltaY > deltaX and deltaY > 10 then
                        isScrolling = true
                        Config.Window.IsToggleDragging = false
                        
                        if dragConnection then
                            dragConnection:Disconnect()
                            dragConnection = nil
                        end
                        if endConnection then
                            endConnection:Disconnect()
                            endConnection = nil
                        end
                        
                        Tween(ToggleFrame.Frame, 0.15, {
                            Position = UDim2.new(0, startFrameX, 0.5, 0)
                        }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
                        
                        Tween(ToggleFrame.Frame.Bar.UIScale, 0.23, {Scale = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
                        Tween(ToggleFrame.Frame.Bar, 0.23, {ImageTransparency = 0}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
                        return
                    end
                    
                    local mouseDelta = inputChanged.Position.X - startMouseX
                    local newX = math.max(2, math.min(startFrameX + mouseDelta, ToggleWidth - FrameWidth - 2))
                    
                    local percent = (ToggleFrame.Frame.Position.X.Offset - 2) / (ToggleWidth - FrameWidth - 4)
                    
                    Tween(ToggleFrame.Frame, 0.05, {
                        Position = UDim2.new(0, newX, 0.5, 0)
                    }, Enum.EasingStyle.Linear, Enum.EasingDirection.Out):Play()
                    
                    -- Tween(ToggleFrame.Layer, 0.05, {
                    --     ImageTransparency = 1 - percent
                    -- }, Enum.EasingStyle.Linear, Enum.EasingDirection.Out):Play()
                    --ToggleFrame.Layer.ImageTransparency = 1 - percent
                end
            end)
            
            if endConnection then
                endConnection:Disconnect()
            end
            
            endConnection = UserInputService.InputEnded:Connect(function(inputEnded)
                if Config.Window.IsToggleDragging and (inputEnded.UserInputType == Enum.UserInputType.MouseButton1 or inputEnded.UserInputType == Enum.UserInputType.Touch) then
                    Config.Window.IsToggleDragging = false
                    
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                    
                    if endConnection then
                        endConnection:Disconnect()
                        endConnection = nil
                    end
                    
                    if isScrolling then
                        return
                    end
                    
                    local currentX = ToggleFrame.Frame.Position.X.Offset
                    local delta = math.abs(inputEnded.Position.X - startMouseX)
                    
                    if delta < 10 then
                        local objValue = not ToggleObj.Value
                        ToggleObj:Set(objValue, true, false)
                    else
                        local barCenter = currentX + FrameWidth / 2
                        local toggleCenter = ToggleWidth / 2
                        local newValue = barCenter > toggleCenter
                        ToggleObj:Set(newValue, true, false)
                    end
                    
                    Tween(ToggleFrame.Frame.Bar.UIScale, 0.23, {Scale = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
                    Tween(ToggleFrame.Frame.Bar, 0.23, {ImageTransparency = 0}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
                end
            end)
        end
    end
    
    return ToggleContainer, Toggle
end

return Toggle