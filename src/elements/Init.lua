return {
    Elements = {
        Paragraph   = require("./Paragraph"),
        Button      = require("./Button"),
        Toggle      = require("./Toggle"),
        Slider      = require("./Slider"),
        Keybind     = require("./Keybind"),
        Input       = require("./Input"),
        Dropdown    = require("./Dropdown"),
        Code        = require("./Code"),
        Colorpicker = require("./Colorpicker"),
        Section     = require("./Section"),
        Divider     = require("./Divider"),
        Space       = require("./Space"),
        Image       = require("./Image"),
    },
    Load = function(tbl, Container, Elements, Window, WindUI, OnElementCreateFunction, ElementsModule, UIScale, Tab)
        for name, module in next, Elements do
            tbl[name] = function(self, config)
                config = config or {}
                config.Tab = Tab or tbl
                config.ParentTable = tbl
                config.Index = #tbl.Elements + 1
                config.GlobalIndex = #Window.AllElements + 1
                config.Parent = Container
                config.Window = Window
                config.WindUI = WindUI
                config.UIScale = UIScale
                config.ElementsModule = ElementsModule
        
                local elementInstance, content = module:New(config)
                
                
                local frame
                for key, value in pairs(content) do
                    if typeof(value) == "table" and key:match("Frame$") then
                        frame = value
                        break
                    end
                end
                
                if frame then
                    content.ElementFrame = frame.UIElements.Main
                    function content:SetTitle(title)
                        frame:SetTitle(title)
                    end
                    function content:SetDesc(desc)
                        frame:SetDesc(desc)
                    end
                    function content:Highlight()
                        frame:Highlight()
                    end
                    function content:Destroy()
                        
                        table.remove(Window.AllElements, config.GlobalIndex)
                        table.remove(tbl.Elements, config.Index)
                        table.remove(Tab.Elements, config.Index)
                        tbl:UpdateAllElementShapes(tbl)
                    
                        frame:Destroy()
                    end
                end
                
                
                
                Window.AllElements[config.Index] = content
                tbl.Elements[config.Index] =  content
                if Tab then Tab.Elements[config.Index] =  content end
                
                if Window.NewElements then
                    tbl:UpdateAllElementShapes(tbl)
                end
                
                if OnElementCreateFunction then
                    OnElementCreateFunction()
                end
                return content
            end
        end
        function tbl:UpdateAllElementShapes(bbb)
            for i, element in next, bbb.Elements do
                local frame
                for key, value in pairs(element) do
                    if typeof(value) == "table" and key:match("Frame$") then
                        frame = value
                        break
                    end
                end
                
                if frame then
                    --print("idx changed : " .. i .. " " .. (element.Title or "not found"))
                    frame.Index = i
                    if frame.UpdateShape then
                        --print(" .changed: " .. i)
                        frame.UpdateShape(bbb)
                    end
                end
            end
        end
    end,
    
}