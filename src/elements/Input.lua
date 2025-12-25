local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local Element = {
    UICorner = 8,
    UIPadding = 8,
}


local CreateButton = require("../components/ui/Button").New
local CreateInput = require("../components/ui/Input").New

function Element:New(Config)
    local Input = {
        __type = "Input",
        Title = Config.Title or "Input",
        Desc = Config.Desc or nil,
        Type = Config.Type or "Input", -- Input or Textarea
        Locked = Config.Locked or false,
        LockedTitle = Config.LockedTitle,
        InputIcon = Config.InputIcon or false,
        Placeholder = Config.Placeholder or "Enter Text...",
        Value = Config.Value or "",
        Callback = Config.Callback or function() end,
        ClearTextOnFocus = Config.ClearTextOnFocus or false,
        UIElements = {},
        
        Width = 150,
    }
    
    local CanCallback = true

    Input.InputFrame = require("../components/window/Element")({
        Title = Input.Title,
        Desc = Input.Desc,
        Parent = Config.Parent,
        TextOffset = Input.Width,
        Hover = false,
        Tab = Config.Tab,
        Index = Config.Index,
        Window = Config.Window,
        ElementTable = Input,
        ParentConfig = Config,
    })
    
    local InputComponent = CreateInput(
        Input.Placeholder, 
        Input.InputIcon, 
        Input.Type == "Textarea" and Input.InputFrame.UIElements.Container or Input.InputFrame.UIElements.Main, 
        Input.Type, 
        function(v)
            Input:Set(v, true)
        end,
        nil,
        Config.Window.NewElements and 12 or 10,
        Input.ClearTextOnFocus
    )
    
    if Input.Type == "Input" then
        InputComponent.Size = UDim2.new(0,Input.Width,0,36)
        InputComponent.Position = UDim2.new(1,0,Config.Window.NewElements and 0 or 0.5,0)
        InputComponent.AnchorPoint = Vector2.new(1,Config.Window.NewElements and 0 or 0.5)
    else
        InputComponent.Size = UDim2.new(1,0,0,42+56+50)
    end
    
    New("UIScale", {
        Parent = InputComponent,
        Scale = 1,
    })
    
    function Input:Lock()
        Input.Locked = true
        CanCallback = false
        return Input.InputFrame:Lock(Input.LockedTitle)
    end
    function Input:Unlock()
        Input.Locked = false
        CanCallback = true
        return Input.InputFrame:Unlock()
    end
    
    
    function Input:Set(v, IsUserInput)
        if CanCallback then
            Input.Value = v
            Creator.SafeCallback(Input.Callback, v)
            
            if not IsUserInput then
                InputComponent.Frame.Frame.TextBox.Text = v
            end
        end
    end
    
    function Input:SetPlaceholder(v)
        InputComponent.Frame.Frame.TextBox.PlaceholderText = v
        Input.Placeholder = v
    end
    
    Input:Set(Input.Value)
    
    if Input.Locked then
        Input:Lock()
    end

    return Input.__type, Input
end

return Element