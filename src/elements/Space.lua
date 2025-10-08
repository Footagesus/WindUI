local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

function Element:New(Config)
    local MainSpace = New("Frame", {
        Parent = Config.Parent,
        Size = UDim2.new(1,-7,0,7*(Config.Columns or 1)),
        BackgroundTransparency = 1,
    })
    
    return "Space", { __type = "Space", ElementFrame = MainSpace}
end

return Element