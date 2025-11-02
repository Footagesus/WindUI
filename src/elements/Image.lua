local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

local function ParseAspectRatio(aspectRatio)
    if type(aspectRatio) == "string" then
        local width, height = aspectRatio:match("(%d+):(%d+)")
        if width and height then
            return tonumber(width) / tonumber(height)
        end
    elseif type(aspectRatio) == "number" then
        return aspectRatio
    end
    return nil
end

function Element:New(Config)
    local ImageModule = {
        __type = "Image",
        Image = Config.Image or "",
        AspectRatio = Config.AspectRatio or "16:9",
        Radius = Config.Radius or Config.Window.ElementConfig.UICorner,
    }
    local MainImage = Creator.Image(
        ImageModule.Image,
        ImageModule.Image,
        ImageModule.Radius,
        Config.Window.Folder,
        "Image",
        false
    )
    MainImage.Parent = Config.Parent
    MainImage.Size = UDim2.new(1,0,0,0)
    MainImage.BackgroundTransparency = 1
    
    -- local MainImage = New("ImageLabel", {
    --     Parent = Config.Parent,
    --     Size = UDim2.new(1, 0, 0, 0),
    --     Image = ,
    --     BackgroundTransparency = 1,
    -- }, {
    --     New("UICorner", {
    --         CornerRadius = UDim.new(0,ImageModule.Radius)
    --     })
    -- })
    
    local aspectRatio = ParseAspectRatio(ImageModule.AspectRatio)
    local aspectRatioConstraint = nil
    
    if aspectRatio then
        aspectRatioConstraint = New("UIAspectRatioConstraint", {
            Parent = MainImage,
            AspectRatio = aspectRatio,
            AspectType = "ScaleWithParentSize",
            DominantAxis = "Width"
        })
    end
    
    function ImageModule:Destroy()
        MainImage:Destroy()
    end
    
    return ImageModule.__type, ImageModule
end

return Element