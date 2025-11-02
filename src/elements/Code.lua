local Creator = require("../modules/Creator")
local New = Creator.New

-- local Highlighter = require("../Highlighter")
local CodeComponent = require("../components/ui/Code")

local Element = {}

function Element:New(Config)
    local Code = {
        __type = "Code",
        Title = Config.Title,
        Code = Config.Code,
        OnCopy = Config.OnCopy,
    }
    
    local CanCallback = not Code.Locked
    
    -- Code.CodeFrame = require("../Components/Element")({
    --     Title = Code.Title,
    --     Desc = Code.Code,
    --     Parent = Config.Parent,
    --     TextOffset = 40,
    --     Hover = false,
    -- })
    
    -- Code.CodeFrame.UIElements.Main.Title.Desc:Destroy()
    
    local CodeElement = CodeComponent.New(Code.Code, Code.Title, Config.Parent, function()
        if CanCallback then
            local NewTitle = Code.Title or "code"
            local success, result = pcall(function()
                toclipboard(Code.Code)
                
                if Code.OnCopy then Code.OnCopy() end
            end)
            if not success then
                Config.WindUI:Notify({
                    Title = "Error",
                    Content = "The " .. NewTitle .. " is not copied. Error: " .. result,
                    Icon = "x",
                    Duration = 5,
                })
            end
        end
    end, Config.WindUI.UIScale, Code)
    
    function Code:SetCode(code)
        CodeElement.Set(code)
        Code.Code = code
    end
    
    function Code:Destroy()
        CodeElement.Destroy()
        Code = nil
    end
    
    Code.ElementFrame = CodeElement.CodeFrame
    
    return Code.__type, Code
end

return Element