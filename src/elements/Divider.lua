local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

function Element:New(Config)
    local Divider = New("Frame", {
        Size = UDim2.new(1,0,0,1),
        Position = UDim2.new(0.5,0,0.5,0),
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundTransparency = .9,
        ThemeTag = {
            BackgroundColor3 = "Text"
        }
    })
    local MainDivider = New("Frame", {
        Parent = Config.Parent,
        Size = UDim2.new(1,-7,0,7),
        BackgroundTransparency = 1,
    }, {
        Divider
    })
    
    return "Divider", { __type = "Divider", ElementFrame = MainDivider }
end

return Element