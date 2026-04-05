local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

function Element:New(Config)
    local MainSpace = New("Frame", {
        Parent = Config.Parent,
        Size = not table.find({ "Group", "HStack" }, Config.ParentType) and UDim2.new(1,-7,0,7*(Config.Columns or 1)) or UDim2.new(0,7*(Config.Columns or 1),0,0),
        BackgroundTransparency = 1,
    })
    
    return "Space", { __type = "Space", ElementFrame = MainSpace}
end

return Element