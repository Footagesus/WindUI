local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService= cloneref(game:GetService("RunService"))

local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local cloneref = (cloneref or clonereference or function(instance) return instance end)

local Element = {}

local IsSliderHolding = false

function Element:New(Config)
    local Slider = {
        __type = "Slider",
        Title = Config.Title or nil,
        Desc = Config.Desc or nil,
        Locked = Config.Locked or nil,
        LockedTitle = Config.LockedTitle,
        Value = Config.Value or {},
        Icons = Config.Icons or nil,
        IsTooltip = Config.IsTooltip or false,
        IsTextbox = Config.IsTextbox,
        Step = Config.Step or 1,
        Callback = Config.Callback or function() end,
        UIElements = {},
        IsFocusing = false,
        
        Width = Config.Width or 130,
        TextBoxWidth = Config.Window.NewElements and 40 or 30,
        ThumbSize = 13,
        IconSize = 26,
    }
    if Slider.Icons == {} then
        Slider.Icons = {
            From = "sfsymbols:sunMinFill",
            To = "sfsymbols:sunMaxFill",
        }
    end
    if Slider.IsTextbox == nil and Slider.Title == nil then Slider.IsTextbox = false else Slider.IsTextbox = Slider.IsTextbox ~= false end
    
    local isTouch
    local moveconnection
    local releaseconnection
    local Value = Slider.Value.Default or Slider.Value.Min or 0
    
    local LastValue = Value
    local delta = (Value - (Slider.Value.Min or 0)) / ((Slider.Value.Max or 100) - (Slider.Value.Min or 0))
    
    local CanCallback = true
    local IsFloat = Slider.Step % 1 ~= 0
    
    local function FormatValue(val)
        if IsFloat then
            return tonumber(string.format("%.2f", val))
        end
        return math.floor(val + 0.5)
    end
    
    local function CalculateValue(rawValue)
        if IsFloat then
            return math.floor(rawValue / Slider.Step + 0.5) * Slider.Step
        else
            return math.floor(rawValue / Slider.Step + 0.5) * Slider.Step
        end
    end
    
    local IconFrom, IconTo
    local TotalSliderWidth = 32
    if Slider.Icons then
        if Slider.Icons.From then
            IconFrom = Creator.Image(
                Slider.Icons.From, 
                Slider.Icons.From, 
                0, 
                Config.Window.Folder,
                "SliderIconFrom",
                true,
                true,
                "SliderIconFrom"
            )
            IconFrom.Size = UDim2.new(0,Slider.IconSize,0,Slider.IconSize)
            TotalSliderWidth = TotalSliderWidth + Slider.IconSize - 2
        end
        if Slider.Icons.To then
            IconTo = Creator.Image(
                Slider.Icons.To, 
                Slider.Icons.To, 
                0, 
                Config.Window.Folder,
                "SliderIconTo",
                true,
                true,
                "SliderIconTo"
            )
            IconTo.Size = UDim2.new(0,Slider.IconSize,0,Slider.IconSize)
            TotalSliderWidth = TotalSliderWidth + Slider.IconSize - 2
        end
    end
    Slider.SliderFrame = require("../components/window/Element")({
        Title = Slider.Title,
        Desc = Slider.Desc,
        Parent = Config.Parent,
        TextOffset = Slider.Width,
        Hover = false,
        Tab = Config.Tab,
        Index = Config.Index,
        Window = Config.Window,
        ElementTable = Slider,
        ParentConfig = Config,
    })
    
    
    Slider.UIElements.SliderIcon = Creator.NewRoundFrame(99, "Squircle", {
        ImageTransparency = .95,
        Size = UDim2.new(1, not Slider.IsTextbox and -TotalSliderWidth or (-Slider.TextBoxWidth-8), 0, 4),
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        Name = "Frame",
        ThemeTag = {
            ImageColor3 = "Text",
        },
    }, {
        Creator.NewRoundFrame(99, "Squircle", {
            Name = "Frame",
            Size = UDim2.new(delta, 0, 1, 0),
            ImageTransparency = .1,
            ThemeTag = {
                ImageColor3 = "Slider",
            },
        }, {
            Creator.NewRoundFrame(99, "Squircle", {
                Size = UDim2.new(0, Config.Window.NewElements and (Slider.ThumbSize*2) or (Slider.ThumbSize+2), 0, Config.Window.NewElements and (Slider.ThumbSize+4) or (Slider.ThumbSize+2)),
                Position = UDim2.new(1, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ThemeTag = {
                    ImageColor3 = "SliderThumb",
                },
                Name = "Thumb",
            }, {
                Creator.NewRoundFrame(99, "Glass-1", {
                    Size = UDim2.new(1,0,1,0),
                    ImageColor3 = Color3.new(1,1,1),
                    Name = "Highlight",
                    ImageTransparency = .6,
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
            })
        })
    })
    
    Slider.UIElements.SliderContainer = New("Frame", {
        Size = UDim2.new(Slider.Title == nil and 1 or 0, Slider.Title == nil and 0 or Slider.Width, 0, 0),
        AutomaticSize = "Y",
        Position = UDim2.new(1, Slider.IsTextbox and (Config.Window.NewElements and -12-4 or 0) or 0, 0.5, 0),
        AnchorPoint = Vector2.new(1,0.5),
        BackgroundTransparency = 1,
        Parent = Slider.SliderFrame.UIElements.Main,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0, Slider.Title ~= nil and 8 or 12),
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
            HorizontalAlignment = Slider.Icons and (Slider.Icons.From and ( Slider.Icons.To and "Center" or "Left") or Slider.Icons.To and "Right") or "Center",
        }),
        IconFrom,
        Slider.UIElements.SliderIcon,
        IconTo,
        New("TextBox", {
            Size = UDim2.new(0,Slider.TextBoxWidth,0,0),
            TextXAlignment = "Left",
            Text = FormatValue(Value),
            ThemeTag = {
                TextColor3 = "Text"
            },
            TextTransparency = .4,
            AutomaticSize = "Y",
            TextSize = 15,
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            BackgroundTransparency = 1,
            LayoutOrder = -1,
            Visible = Slider.IsTextbox,
        })
    })
    
    local Tooltip
    if Slider.IsTooltip then
        Tooltip = require("../components/ui/Tooltip").New(Value, Slider.UIElements.SliderIcon.Frame.Thumb, true, "Secondary", "Small", false)
        Tooltip.Container.AnchorPoint = Vector2.new(0.5,1)
        Tooltip.Container.Position = UDim2.new(0.5,0,0,-8)
    end
    
    function Slider:Lock()
        Slider.Locked = true
        CanCallback = false
        return Slider.SliderFrame:Lock(Slider.LockedTitle)
    end
    function Slider:Unlock()
        Slider.Locked = false
        CanCallback = true
        return Slider.SliderFrame:Unlock()
    end
    
    if Slider.Locked then
        Slider:Lock()
    end
    
    --local ScrollingFrameParent = Slider.SliderFrame.Parent:IsA("ScrollingFrame") and Slider.SliderFrame.Parent or Slider.SliderFrame.Parent.Parent.Parent
    local ScrollingFrameParent = Config.Tab.UIElements.ContainerFrame
    
    function Slider:Set(Value, input)
        if CanCallback then
            if not Slider.IsFocusing and not IsSliderHolding and (not input or (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)) then
                if input then
                    isTouch = (input.UserInputType == Enum.UserInputType.Touch)
                    ScrollingFrameParent.ScrollingEnabled = false
                    IsSliderHolding = true
                    
                    local inputPosition = isTouch and input.Position.X or UserInputService:GetMouseLocation().X
                    local delta = math.clamp((inputPosition - Slider.UIElements.SliderIcon.AbsolutePosition.X) / Slider.UIElements.SliderIcon.AbsoluteSize.X, 0, 1)
                    Value = CalculateValue(Slider.Value.Min + delta * (Slider.Value.Max - Slider.Value.Min))
                    Value = math.clamp(Value, Slider.Value.Min or 0, Slider.Value.Max or 100)
                    
                    if Value ~= LastValue then
                        Tween(Slider.UIElements.SliderIcon.Frame, 0.05, {Size = UDim2.new(delta,0,1,0)}):Play()
                        Slider.UIElements.SliderContainer.TextBox.Text = FormatValue(Value)
                        if Tooltip then Tooltip.TitleFrame.Text = FormatValue(Value) end
                        Slider.Value.Default = FormatValue(Value)
                        LastValue = Value
                        Creator.SafeCallback(Slider.Callback, FormatValue(Value))
                    end
                    
                    moveconnection = RunService.RenderStepped:Connect(function()
                        local inputPosition = isTouch and input.Position.X or UserInputService:GetMouseLocation().X
                        local delta = math.clamp((inputPosition - Slider.UIElements.SliderIcon.AbsolutePosition.X) / Slider.UIElements.SliderIcon.AbsoluteSize.X, 0, 1)
                        Value = CalculateValue(Slider.Value.Min + delta * (Slider.Value.Max - Slider.Value.Min))
                        
                        if Value ~= LastValue then
                            Tween(Slider.UIElements.SliderIcon.Frame, 0.05, {Size = UDim2.new(delta,0,1,0)}):Play()
                            Slider.UIElements.SliderContainer.TextBox.Text = FormatValue(Value)
                            if Tooltip then Tooltip.TitleFrame.Text = FormatValue(Value) end
                            Slider.Value.Default = FormatValue(Value)
                            LastValue = Value
                            Creator.SafeCallback(Slider.Callback, FormatValue(Value))
                        end
                    end)
                    
                    -- release slider
                    releaseconnection = UserInputService.InputEnded:Connect(function(endInput)
                        if (endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch) and input == endInput then
                            moveconnection:Disconnect()
                            releaseconnection:Disconnect()
                            IsSliderHolding = false
                            ScrollingFrameParent.ScrollingEnabled = true
                            
                            if Config.Window.NewElements then
                                Tween(Slider.UIElements.SliderIcon.Frame.Thumb, .2, { ImageTransparency = 0, Size = UDim2.new(0,Config.Window.NewElements and (Slider.ThumbSize*2) or (Slider.ThumbSize+2),0,Config.Window.NewElements and (Slider.ThumbSize+4) or (Slider.ThumbSize+2)) }, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut):Play()
                            end
                            if Tooltip then Tooltip:Close(false) end
                        end
                    end)
                else
                    Value = math.clamp(Value, Slider.Value.Min or 0, Slider.Value.Max or 100)
                    
                    local delta = math.clamp((Value - (Slider.Value.Min or 0)) / ((Slider.Value.Max or 100) - (Slider.Value.Min or 0)), 0, 1)
                    Value = CalculateValue(Slider.Value.Min + delta * (Slider.Value.Max - Slider.Value.Min))
                    
                    if Value ~= LastValue then
                        Tween(Slider.UIElements.SliderIcon.Frame, 0.05, {Size = UDim2.new(delta,0,1,0)}):Play()
                        Slider.UIElements.SliderContainer.TextBox.Text = FormatValue(Value)
                        if Tooltip then Tooltip.TitleFrame.Text = FormatValue(Value) end
                        Slider.Value.Default = FormatValue(Value)
                        LastValue = Value
                        Creator.SafeCallback(Slider.Callback, FormatValue(Value))
                    end
                end
            end
        end
    end
    
    function Slider:SetMax(newMax)
        Slider.Value.Max = newMax
        
        local currentValue = tonumber(Slider.Value.Default) or LastValue
        if currentValue > newMax then
            Slider:Set(newMax)
        else
            local newDelta = math.clamp((currentValue - (Slider.Value.Min or 0)) / (newMax - (Slider.Value.Min or 0)), 0, 1)
            Tween(Slider.UIElements.SliderIcon.Frame, 0.1, {Size = UDim2.new(newDelta, 0, 1, 0)}):Play()
        end
    end
    
    function Slider:SetMin(newMin)
        Slider.Value.Min = newMin
        
        local currentValue = tonumber(Slider.Value.Default) or LastValue
        if currentValue < newMin then
            Slider:Set(newMin)
        else
            local newDelta = math.clamp((currentValue - newMin) / ((Slider.Value.Max or 100) - newMin), 0, 1)
            Tween(Slider.UIElements.SliderIcon.Frame, 0.1, {Size = UDim2.new(newDelta, 0, 1, 0)}):Play()
        end
    end
    
    Creator.AddSignal(Slider.UIElements.SliderContainer.TextBox.FocusLost, function(enterPressed)
        if enterPressed then
            local newValue = tonumber(Slider.UIElements.SliderContainer.TextBox.Text)
            if newValue then
                Slider:Set(newValue)
            else
                Slider.UIElements.SliderContainer.TextBox.Text = FormatValue(LastValue)
                if Tooltip then Tooltip.TitleFrame.Text = FormatValue(LastValue) end
            end
        end
    end)
    
    Creator.AddSignal(Slider.UIElements.SliderContainer.InputBegan, function(input)
        if Slider.Locked or IsSliderHolding then
            return
        end
        
        Slider:Set(Value, input)
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            -- drag slider
            if Config.Window.NewElements then 
                Tween(Slider.UIElements.SliderIcon.Frame.Thumb, .24, { ImageTransparency = .85, Size = UDim2.new(0,(Config.Window.NewElements and (Slider.ThumbSize*2) or (Slider.ThumbSize))+8,0,Slider.ThumbSize+8) }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            end
            if Tooltip then Tooltip:Open() end
            --print("piskaa")
        end
    end)
    
    return Slider.__type, Slider
end

return Element