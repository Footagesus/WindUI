--[[

    WindUI Example (wip)
    
]]


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end
end

--[[

WindUI.Creator.AddIcons("solar", {
    ["CheckSquareBold"] = "rbxassetid://132438947521974",
    ["CursorSquareBold"] = "rbxassetid://120306472146156",
    ["FileTextBold"] = "rbxassetid://89294979831077",
    ["FolderWithFilesBold"] = "rbxassetid://74631950400584",
    ["HamburgerMenuBold"] = "rbxassetid://134384554225463",
    ["Home2Bold"] = "rbxassetid://92190299966310",
    ["InfoSquareBold"] = "rbxassetid://119096461016615",
    ["PasswordMinimalisticInputBold"] = "rbxassetid://109919668957167",
    ["SolarSquareTransferHorizontalBold"] = "rbxassetid://125444491429160",
})--]]


function createPopup()
    return WindUI:Popup({
        Title = "Welcome to the WindUI!",
        Icon = "bird",
        Content = "Hello!",
        Buttons = {
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            },
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            },
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            }
        }
    })
end



-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = ".ftgs hub  |  WindUI Example",
    --Author = "by .ftgs • Footagesus",
    Folder = "ftgshub",
    Icon = "solar:folder-2-bold-duotone",
    --IconSize = 22*2,
    NewElements = true,
    --Size = UDim2.fromOffset(700,700),
    
    HideSearchBar = false,
    
    OpenButton = {
        Title = "Open .ftgs hub UI", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac", -- Default or Mac
    },

    --[[
    KeySystem = {
        Title = "Key System Example  |  WindUI Example",
        Note = "Key System. Key: 1234",
        KeyValidator = function(EnteredKey)
            if EnteredKey == "1234" then
                createPopup()
                return true
            end
            return false
            -- return EnteredKey == "1234" -- if key == "1234" then return true else return false end
        end
    }
    ]]
})

--createPopup()

--Window:SetUIScale(.8)

-- */  Tags  /* --
do
    Window:Tag({
        Title = "v" .. WindUI.Version,
        Icon = "github",
        Color = Color3.fromHex("#1c1c1c"),
        Border = true,
    })
end

-- */  Theme (soon)  /* --
do
    --[[WindUI:AddTheme({
        Name = "Stylish",
        
        Accent = Color3.fromHex("#3b82f6"), 
        Dialog = Color3.fromHex("#1a1a1a"), 
        Outline = Color3.fromHex("#3b82f6"),
        Text = Color3.fromHex("#f8fafc"),  
        Placeholder = Color3.fromHex("#94a3b8"),
        Button = Color3.fromHex("#334155"), 
        Icon = Color3.fromHex("#60a5fa"), 
        
        WindowBackground = Color3.fromHex("#0f172a"),
        
        TopbarButtonIcon = Color3.fromHex("#60a5fa"),
        TopbarTitle = Color3.fromHex("#f8fafc"),
        TopbarAuthor = Color3.fromHex("#94a3b8"),
        TopbarIcon = Color3.fromHex("#3b82f6"),
        
        TabBackground = Color3.fromHex("#1e293b"),    
        TabTitle = Color3.fromHex("#f8fafc"),
        TabIcon = Color3.fromHex("#60a5fa"),
        
        ElementBackground = Color3.fromHex("#1e293b"),
        ElementTitle = Color3.fromHex("#f8fafc"),
        ElementDesc = Color3.fromHex("#cbd5e1"),
        ElementIcon = Color3.fromHex("#60a5fa"),
    })--]]
    
    -- WindUI:SetTheme("Stylish")
end


-- */  Colors  /* --
local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")
local Green = Color3.fromHex("#10C550")
local Grey = Color3.fromHex("#83889E")
local Blue = Color3.fromHex("#257AF7")
local Red = Color3.fromHex("#EF4F1D")


-- */ Other Functions /* --
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


-- */  About Tab  /* --
do
    local AboutTab = Window:Tab({
        Title = "About WindUI",
        Desc = "Description Example", 
        Icon = "solar:info-square-bold",
        IconColor = Grey,
        IconShape = "Square",
    })
    
    local AboutSection = AboutTab:Section({
        Title = "About WindUI",
    })
    
    AboutSection:Image({
        Image = "https://repository-images.githubusercontent.com/880118829/22c020eb-d1b1-4b34-ac4d-e33fd88db38d",
        AspectRatio = "16:9",
        Radius = 9,
    })
    
    AboutSection:Space({ Columns = 3 })
    
    AboutSection:Section({
        Title = "What is WindUI?",
        TextSize = 24,
        FontWeight = Enum.FontWeight.SemiBold,
    })

    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[WindUI is a stylish, open-source UI (User Interface) library specifically designed for Roblox Script Hubs.
Developed by Footagesus (.ftgs, Footages).
It aims to provide developers with a modern, customizable, and easy-to-use toolkit for creating visually appealing interfaces within Roblox.
The project is primarily written in Lua (Luau), the scripting language used in Roblox.]],
        TextSize = 18,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 }) 
    
    
    -- Default buttons
    
    AboutTab:Button({
        Title = "Export WindUI JSON (copy)",
        Color = Color3.fromHex("#a2ff30"),
        Justify = "Center",
        IconAlign = "Left",
        Icon = "", -- removing icon
        Callback = function()
            tableToClipboard(WindUI)
            WindUI:Notify({
                Title = "WindUI JSON",
                Content = "Copied to Clipboard!"
            })
        end
    })
    AboutTab:Space({ Columns = 1 }) 
    
    
    AboutTab:Button({
        Title = "Destroy Window",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            Window:Destroy()
        end
    })
end

-- */  Elements Section  /* --
local ElementsSection = Window:Section({
    Title = "Elements",
})
local ConfigUsageSection = Window:Section({
    Title = "Config Usage",
})
local OtherSection = Window:Section({
    Title = "Other",
})




-- */  Overview Tab  /* --
do
    local OverviewTab = ElementsSection:Tab({
        Title = "Overview",
        Icon = "solar:home-2-bold",
        IconColor = Grey,
        IconShape = "Square",
    })
    
    local OverviewSection1 = OverviewTab:Section({
        Title = "Group's Example"
    })
    
    local OverviewGroup1 = OverviewTab:Group({})
    
    OverviewGroup1:Button({ Title = "Button 1", Justify = "Center", Icon = "", Callback = function() print("clicked button 1") end })
    OverviewGroup1:Space()
    OverviewGroup1:Button({ Title = "Button 2", Justify = "Center", Icon = "", Callback = function() print("clicked button 2") end })
    
    OverviewTab:Space()
    
    local OverviewGroup2 = OverviewTab:Group({})
    
    OverviewGroup2:Button({ Title = "Button 1", Justify = "Center", Icon = "", Callback = function() print("clicked button 1") end })
    OverviewGroup2:Space()
    OverviewGroup2:Toggle({ Title = "Toggle 2",  Callback = function(v) print("clicked toggle 2:", v) end })
    OverviewGroup2:Space()
    OverviewGroup2:Colorpicker({ Title = "Colorpicker 3", Default = Color3.fromHex("#30ff6a"), Callback = function(color) print(color) end })
    
    OverviewTab:Space()
    
    local OverviewGroup3 = OverviewTab:Group({})
    
    
    local OverviewSection1 = OverviewGroup3:Section({
        Title = "Section 1",
        Desc = "Section exampleee",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })
    OverviewSection1:Button({ Title = "Button 1", Justify = "Center", Icon = "", Callback = function() print("clicked button 1") end })
    OverviewSection1:Space()
    OverviewSection1:Toggle({ Title = "Toggle 2",  Callback = function(v) print("clicked toggle 2:", v) end })
    
    
    OverviewGroup3:Space()
    
    
    local OverviewSection2 = OverviewGroup3:Section({
        Title = "Section 2",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })
    OverviewSection2:Button({ Title = "Button 1", Justify = "Center", Icon = "", Callback = function() print("clicked button 1") end })
    OverviewSection2:Space()
    OverviewSection2:Button({ Title = "Button 2", Justify = "Center", Icon = "", Callback = function() print("clicked button 2") end })

    --OverviewTab:Space()
    
end


-- */  Toggle Tab  /* --
do
    local ToggleTab = ElementsSection:Tab({
        Title = "Toggle",
        Icon = "solar:check-square-bold",
        IconColor = Green,
        IconShape = "Square",
    })
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example"
    })
    
    ToggleTab:Space()
    
    local ToggleGroup1 = ToggleTab:Group()
    ToggleGroup1:Toggle({})
    ToggleGroup1:Space()
    ToggleGroup1:Toggle({})
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Checkbox",
        Type = "Checkbox",
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Checkbox",
        Desc = "Checkbox example",
        Type = "Checkbox",
    })
    
    ToggleTab:Space()
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Locked = true,
        LockedTitle = "This element is locked",
    })
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example",
        Locked = true,
        LockedTitle = "This element is locked",
    })
end


-- */  Button Tab  /* --
do
    local ButtonTab = ElementsSection:Tab({
        Title = "Button",
        Icon = "solar:cursor-square-bold",
        IconColor = Blue,
        IconShape = "Square",
    })
    
    
    local HighlightButton
    HighlightButton = ButtonTab:Button({
        Title = "Highlight Button",
        Icon = "mouse",
        Callback = function()
            print("clicked highlight")
            HighlightButton:Highlight()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Desc = "With description",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Notify Button",
        --Desc = "Button example",
        Callback = function()
            WindUI:Notify({
                Title = "Hello",
                Content = "Welcome to the WindUI Example!",
                Icon = "solar:bell-bold",
                Duration = 5,
                CanClose = false,
            })
        end
    })
    
    
    ButtonTab:Button({
        Title = "Notify Button 2",
        --Desc = "Button example",
        Callback = function()
            WindUI:Notify({
                Title = "Hello",
                Content = "Welcome to the WindUI Example!",
                --Icon = "solar:bell-bold",
                Duration = 5,
                CanClose = false,
            })
        end
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Button",
        Locked = true,
        LockedTitle = "This element is locked",
    })
    
    
    ButtonTab:Button({
        Title = "Button",
        Desc = "Button example",
        Locked = true,
        LockedTitle = "This element is locked",
    })
end


-- */  Input Tab  /* --
do
    local InputTab = ElementsSection:Tab({
        Title = "Input",
        Icon = "solar:password-minimalistic-input-bold",
        IconColor = Purple,
        IconShape = "Square",
    })
    
    
    InputTab:Input({
        Title = "Input",
        Icon = "mouse"
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        --Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Desc = "Input example",
        Type = "Textarea",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Locked = true,
        LockedTitle = "This element is locked",
    })
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
        Locked = true,
        LockedTitle = "This element is locked",
    })
end


-- */  Slider Tab  /* --
do
    local SliderTab = ElementsSection:Tab({
        Title = "Slider",
        Icon = "solar:square-transfer-horizontal-bold",
        IconColor = Green,
        IconShape = "Square",
    })
    
    SliderTab:Section({
        Title = "Default Slider with Tooltip and without textbox",
        TextSize = 14,
    })
    
    SliderTab:Slider({
        Title = "Slider Example",
        Desc = "Hahahahaha hello",
        IsTooltip = true,
        IsTextbox = false,
        Width = 200,
        Step = 1,
        Value = {
            Min = 0,
            Max = 200,
            Default = 100,
        },
        Callback = function(value)
            print(value)
        end
    })

    SliderTab:Space()
    
    SliderTab:Section({
        Title = "Slider without description",
        TextSize = 14,
    })
    
    SliderTab:Slider({
        Title = "Slider Example",
        Step = 1,
        Width = 200,
        Value = {
            Min = 0,
            Max = 200,
            Default = 100,
        },
        Callback = function(value)
            print(value)
        end
    })

    SliderTab:Space()
    
    SliderTab:Section({
        Title = "Slider without titles",
        TextSize = 14,
    })
    
    SliderTab:Slider({
        IsTooltip = true,
        Step = 1,
        Value = {
            Min = 0,
            Max = 200,
            Default = 100,
        },
        Callback = function(value)
            print(value)
        end
    })

    SliderTab:Space()
    
    SliderTab:Section({
        Title = "Slider with icons ('from' only)",
        TextSize = 14,
    })
    
    SliderTab:Slider({
        IsTooltip = true,
        Step = 1,
        Value = {
            Min = 0,
            Max = 200,
            Default = 100,
        },
        Icons = {
            From = "sfsymbols:sunMinFill",
            --To = "sfsymbols:sunMaxFill",
        },
        Callback = function(value)
            print(value)
        end
    })

    SliderTab:Space()
    
    SliderTab:Section({
        Title = "Slider with icons (from & to)",
        TextSize = 14,
    })
    
    SliderTab:Slider({
        IsTooltip = true,
        Step = 1,
        Value = {
            Min = 0,
            Max = 100,
            Default = 50,
        },
        Icons = {
            From = "sfsymbols:sunMinFill",
            To = "sfsymbols:sunMaxFill",
        },
        Callback = function(value)
            print(value)
        end
    })
end


-- */  Dropdown Tab  /* --
do
    local DropdownTab = ElementsSection:Tab({
        Title = "Dropdown",
        Icon = "solar:hamburger-menu-bold",
        IconColor = Yellow,
        IconShape = "Square",
    })
    
    
    DropdownTab:Dropdown({
        Title = "Advanced Dropdown (example)",
        Values = {
            {
                Title = "New file",
                Desc = "Create a new file",
                Icon = "file-plus",
                Callback = function() 
                    print("Clicked 'New File'")
                end
            },
            {
                Title = "Copy link",
                Desc = "Copy the file link",
                Icon = "copy",
                Callback = function() 
                    print("Clicked 'Copy link'")
                end
            },
            {
                Title = "Edit file",
                Desc = "Allows you to edit the file",
                Icon = "file-pen",
                Callback = function() 
                    print("Clicked 'Edit file'")
                end
            },
            {
                Type = "Divider",
            },
            {
                Title = "Delete file",
                Desc = "Permanently delete the file",
                Icon = "trash",
                Callback = function() 
                    print("Clicked 'Delete file'")
                end
            },
        }
    })
    
    DropdownTab:Space()
    
    DropdownTab:Dropdown({
        Title = "Multi Dropdown",
        Values = {
            "Привет", "Hello", "Сәлем", "Bonjour"
        },
        Value = nil,
        AllowNone = true,
        Multi = true,
        Callback = function(selectedValue)
            print("Selected: " .. selectedValue)
        end
    })
    
    DropdownTab:Space()
    
    DropdownTab:Dropdown({
        Title = "No Multi Dropdown (default",
        Values = {
            "Привет", "Hello", "Сәлем", "Bonjour"
        },
        Value = 1,
        --AllowNone = true,
        Callback = function(selectedValue)
            print("Selected: " .. selectedValue)
        end
    })
    
    DropdownTab:Space()
    
    
end



--[[  idk. VideoFrame is not working with custom video on exploits
      I don't know why
    
-- */  Video Tab  /* --
do
    local VideoTab = ElementsSection:Tab({
        Title = "Video",
        Icon = "video",
    })
    
    VideoTab:Video({
        Title = "My Video Hahahah", -- optional
        Author = ".ftgs", -- optional
        Video = "https://cdn.discordapp.com/attachments/1337368451865645096/1402703845657673878/VID_20250616_180732_158.webm?ex=68fc5f01&is=68fb0d81&hm=f4f0a88dbace2d3cef92535b2e57effae6d4c4fc444338163faafa7f3fdac529&"
    })
end

--]]


-- */  Config Usage  /* --
do -- config elements
    local ConfigElementsTab = ConfigUsageSection:Tab({
        Title = "Config Elements",
        Icon = "solar:file-text-bold",
        IconColor = Blue,
        IconShape = nil,
    })
    
    -- All elements are taken from the official documentation: https://footagesus.github.io/WindUI-Docs/docs
    
    -- Saving elements to the config using `Flag`
    
    ConfigElementsTab:Colorpicker({
        Flag = "ColorpickerTest",
        Title = "Colorpicker",
        Desc = "Colorpicker Description",
        Default = Color3.fromRGB(0, 255, 0),
        Transparency = 0,
        Locked = false,
        Callback = function(color) 
            print("Background color: " .. tostring(color))
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Dropdown({
        Flag = "DropdownTest",
        Title = "Advanced Dropdown",
        Values = {
            {
                Title = "Category A",
                Icon = "bird"
            },
            {
                Title = "Category B",
                Icon = "house"
            },
            {
                Title = "Category C",
                Icon = "droplet"
            },
        },
        Value = "Category A",
        Callback = function(option) 
            print("Category selected: " .. option.Title .. " with icon " .. option.Icon) 
        end
    })
    ConfigElementsTab:Dropdown({
        Flag = "DropdownTest2",
        Title = "Advanced Dropdown 2",
        Values = {
            {
                Title = "Category A",
                Icon = "bird"
            },
            {
                Title = "Category B",
                Icon = "house"
            },
            {
                Title = "Category C",
                Icon = "droplet",
                Locked = true,
            },
        },
        Value = "Category A",
        Multi = true,
        Callback = function(options) 
            local titles = {}
            for _, v in ipairs(options) do
                table.insert(titles, v.Title)
            end
            print("Selected: " .. table.concat(titles, ", "))
        end
    })
    
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Input({
        Flag = "InputTest",
        Title = "Input",
        Desc = "Input Description",
        Value = "Default value",
        InputIcon = "bird",
        Type = "Input", -- or "Textarea"
        Placeholder = "Enter text...",
        Callback = function(input) 
            print("Text entered: " .. input)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Keybind({
        Flag = "KeybindTest",
        Title = "Keybind",
        Desc = "Keybind to open ui",
        Value = "G",
        Callback = function(v)
            Window:SetToggleKey(Enum.KeyCode[v])
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Slider({
        Flag = "SliderTest",
        Title = "Slider",
        Step = 1,
        Value = {
            Min = 20,
            Max = 120,
            Default = 70,
        },
        Callback = function(value)
            print(value)
        end
    })
    ConfigElementsTab:Slider({
        Flag = "SliderTest2",
        --Title = "Slider",
        Icons = {
            From = "sfsymbols:sunMinFill",
            To = "sfsymbols:sunMaxFill",
        },
        Step = 1,
        IsTooltip = true,
        Value = {
            Min = 0,
            Max = 100,
            Default = 50,
        },
        Callback = function(value)
            print(value)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Toggle({
        Flag = "ToggleTest",
        Title = "Toggle Panel Background",
        --Desc = "Toggle Description",
        --Icon = "house",
        --Type = "Checkbox",
        Value = not Window.HidePanelBackground,
        Callback = function(state) 
            Window:SetPanelBackground(state)
        end
    })
    
    ConfigElementsTab:Toggle({
        Flag = "ToggleTest",
        Title = "Toggle",
        Desc = "Toggle Description",
        --Icon = "house",
        --Type = "Checkbox",
        Value = false,
        Callback = function(state) 
            print("Toggle Activated" .. tostring(state))
        end
    })
end

do -- config panel
    local ConfigTab = ConfigUsageSection:Tab({
        Title = "Config Usage",
        Icon = "solar:folder-with-files-bold",
        IconColor = Purple,
        IconShape = nil,
    })

    local ConfigManager = Window.ConfigManager
    local ConfigName = "default"

    local ConfigNameInput = ConfigTab:Input({
        Title = "Config Name",
        Icon = "file-cog",
        Callback = function(value)
            ConfigName = value
        end
    })

    ConfigTab:Space()
    
    -- local AutoLoadToggle = ConfigTab:Toggle({
    --     Title = "Enable Auto Load to Selected Config",
    --     Value = false,
    --     Callback = function(v)
    --         Window.CurrentConfig:SetAutoLoad(v)
    --     end
    -- })

    -- ConfigTab:Space()

    local AllConfigs = ConfigManager:AllConfigs()
    local DefaultValue = table.find(AllConfigs, ConfigName) and ConfigName or nil

    local AllConfigsDropdown = ConfigTab:Dropdown({
        Title = "All Configs",
        Desc = "Select existing configs",
        Values = AllConfigs,
        Value = DefaultValue,
        Callback = function(value)
            ConfigName = value
            ConfigNameInput:Set(value)
            
            AutoLoadToggle:Set(ConfigManager:GetConfig(ConfigName).AutoLoad or false)
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Save Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:Config(ConfigName)
            if Window.CurrentConfig:Save() then
                WindUI:Notify({
                    Title = "Config Saved",
                    Desc = "Config '" .. ConfigName .. "' saved",
                    Icon = "check",
                })
            end
            
            AllConfigsDropdown:Refresh(ConfigManager:AllConfigs())
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Load Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
            if Window.CurrentConfig:Load() then
                WindUI:Notify({
                    Title = "Config Loaded",
                    Desc = "Config '" .. ConfigName .. "' loaded",
                    Icon = "refresh-cw",
                })
            end
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Print AutoLoad Configs",
        Icon = "",
        Justify = "Center",
        Callback = function()
            print(HttpService:JSONDecode(ConfigManager:GetAutoLoadConfigs()))
        end
    })
end




-- */  Other  /* --
do
    local InviteCode = "ftgs-development-hub-1300692552005189632"
    local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

    local Response = WindUI.cloneref(game:GetService("HttpService")):JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "WindUI/Example",
            ["Accept"] = "application/json"
        }
    }).Body)
    
    local DiscordTab = OtherSection:Tab({
        Title = "Discord",
    })
    
    if Response and Response.guild then
        DiscordTab:Section({
            Title = "Join our Discord server!",
            TextSize = 20,
        })
        local DiscordServerParagraph = DiscordTab:Paragraph({
            Title = tostring(Response.guild.name),
            Desc = tostring(Response.guild.description),
            Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
            Thumbnail = "https://cdn.discordapp.com/banners/1300692552005189632/35981388401406a4b7dffd6f447a64c4.png?size=512",
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy link",
                    Icon = "link",
                    Callback = function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                    end
                }
            }
        })
        
    end
end



-- */ Using Nebula Icons /* --
--[[
do
    local NebulaIcons = loadstring(game:HttpGetAsync("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()
    
    -- Adding icons (e.g. Fluency)
    WindUI.Creator.AddIcons("fluency",    NebulaIcons.Fluency)
    --               ^ Icon name          ^ Table of Icons
    
    -- You can also add nebula icons
    WindUI.Creator.AddIcons("nebula",    NebulaIcons.nebulaIcons)
    
    -- Usage ↑ ↓
    
    local TestSection = Window:Section({
        Title = "Custom icons usage test (nebula)",
        Icon = "nebula:nebula",
    })
end
]]
--[[

local EndButStartTab = Window:Tab({
    Title = "EndButStartTab",
    -- u can use `Before` or `After`
    Before = AboutTab, -- put this tab Before AboutTab
    
})
--]]