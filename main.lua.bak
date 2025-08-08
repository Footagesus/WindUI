local WindUI = require("./src/init")

-- Test



-- Set theme:
--WindUI:SetTheme("Light")

--- EXAMPLE !!!

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end

local Confirmed = false

WindUI:Popup({
    Title = "Welcome! Popup Example",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "This is an Example UI for the " .. gradient("WindUI", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. " Lib",
    Buttons = {
        {
            Title = "Cancel",
            --Icon = "",
            Callback = function() end,
            Variant = "Secondary", -- Primary, Secondary, Tertiary
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary", -- Primary, Secondary, Tertiary
        }
    }
})


repeat wait() until Confirmed

--

local Window = WindUI:CreateWindow({
    Title = "WindUI Library",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "Example UI",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Resizable = false,
    Theme = "Dark",
    User = {
        Enabled = true, -- <- or false
        Callback = function() print("clicked") end, -- <- optional
        Anonymous = true -- <- or true
    },
    SideBarWidth = 200,
    -- HideSearchBar = true, -- hides searchbar
    ScrollBarEnabled = true, -- enables scrollbar
    -- Background = "rbxassetid://13511292247", -- rbxassetid only

    -- remove it below if you don't want to use the key system in your script.
    KeySystem = { -- <- keysystem enabled
        Key = { "1234", "5678" },
        Note = "Example Key System. \n\nThe Key is '1234' or '5678",
        -- Thumbnail = {
        --     Image = "rbxassetid://18220445082", -- rbxassetid only
        --     Title = "Thumbnail"
        -- },
        URL = "link-to-linkvertise-or-discord-or-idk", -- remove this if the key is not obtained from the link.
        SaveKey = true, -- saves key : optional
    },
})


-- Window:SetBackgroundImage("rbxassetid://13511292247")
-- Window:SetBackgroundImageTransparency(0.9)


-- TopBar Edit

-- Disable Topbar Buttons
-- Window:DisableTopbarButtons({
--     "Close", 
--     "Minimize", 
--     "Fullscreen",
-- })

-- Create Custom Topbar Buttons
--                        ↓ Name             ↓ Icon          ↓ Callback                           ↓ LayoutOrder
Window:CreateTopbarButton("MyCustomButton1", "bird",         function() print("clicked 1!") end,  990)
Window:CreateTopbarButton("MyCustomButton2", "droplet-off",  function() print("clicked 2!") end,  989)
Window:CreateTopbarButton("MyCustomButton3", "battery-plus", function() Window:ToggleFullscreen() end, 988)


Window:EditOpenButton({
    Title = "Open Example UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = true,
})


local Tabs = {}

do
    Tabs.ElementsSection = Window:Section({
        Title = "Elements",
        Opened = true,
    })
    
    Tabs.WindowSection = Window:Section({
        Title = "Window Management",
        Icon = "app-window-mac",
        Opened = true,
    })
    
    Tabs.OtherSection = Window:Section({
        Title = "Other",
        Opened = true,
    })

    
    Tabs.ParagraphTab = Tabs.ElementsSection:Tab({ Title = "Paragraph", Icon = "type" })
    Tabs.ButtonTab = Tabs.ElementsSection:Tab({ Title = "Button", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." })
    Tabs.CodeTab = Tabs.ElementsSection:Tab({ Title = "Code", Icon = "code", Desc = "Displays and manages code snippets." })
    Tabs.ColorPickerTab = Tabs.ElementsSection:Tab({ Title = "ColorPicker", Icon = "paintbrush", Desc = "Choose and customize colors easily." })
    Tabs.DialogTab = Tabs.ElementsSection:Tab({ Title = "Dialog", Icon = "message-square", Desc = "Dialog lol" })
    Tabs.NotificationTab = Tabs.ElementsSection:Tab({ Title = "Notification", Icon = "bell", Desc = "Configure and view notifications." })
    Tabs.ToggleTab = Tabs.ElementsSection:Tab({ Title = "Toggle", Icon = "toggle-left", Desc = "Switch settings on and off." })
    Tabs.SliderTab = Tabs.ElementsSection:Tab({ Title = "Slider", Icon = "sliders-horizontal", Desc = "Adjust values smoothly with sliders." })
    Tabs.InputTab = Tabs.ElementsSection:Tab({ Title = "Input", Icon = "keyboard", Desc = "Accept text and numerical input." })
    Tabs.KeybindTab = Tabs.ElementsSection:Tab({ Title = "Keybind", Icon = "keyboard-off" })
    Tabs.DropdownTab = Tabs.ElementsSection:Tab({ Title = "Dropdown", Icon = "chevrons-up-down", Desc = "Select from multiple options." })
    
    Tabs.WindowTab = Tabs.WindowSection:Tab({ 
        Title = "Window and File Configuration", 
        Icon = "settings", 
        Desc = "Manage window settings and file configurations.", 
        ShowTabTitle = true 
    })
    Tabs.CreateThemeTab = Tabs.WindowSection:Tab({ Title = "Create Theme", Icon = "palette", Desc = "Design and apply custom themes." })
    
    Tabs.LongTab = Tabs.OtherSection:Tab({ 
        Title = "Long and empty tab. with custom icon", 
        Icon = "rbxassetid://129260712070622", 
        IconThemed = true, 
        Desc = "Long Description" 
    })
    Tabs.LockedTab = Tabs.OtherSection:Tab({ Title = "Locked Tab", Icon = "lock", Desc = "This tab is locked", Locked = true })
    Tabs.TabWithoutIcon = Tabs.OtherSection:Tab({ Title = "Tab Without icon", ShowTabTitle = true })
    Tabs.Tests = Tabs.OtherSection:Tab({ Title = "Tests", Icon = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/ui.png", ShowTabTitle = true })
    
    
    Tabs.LastSection = Window:Section({
        Title = "Section without tabs",
        --Opened = true,
    })
    
    Tabs.ConfigTab = Window:Tab({ Title = "Config", Icon = "file-cog" })
end



Window:SelectTab(1)

Tabs.ParagraphTab:Paragraph({
    Title = "Paragraph with Image & Thumbnail",
    Desc = "Test Paragraph",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42, -- default 30
    Thumbnail = "https://tr.rbxcdn.com/180DAY-59af3523ad8898216dbe1043788837bf/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120 -- Thumbnail height
})
Tabs.ParagraphTab:Paragraph({
    Title = "Paragraph with Image & Thumbnail & Buttons",
    Desc = "Test Paragraph",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42, -- default 30
    Thumbnail = "https://tr.rbxcdn.com/180DAY-59af3523ad8898216dbe1043788837bf/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120, -- Thumbnail height
    Buttons = {
        {
            Title = "Button 1",
            Variant = "Primary",
            Callback = function() print("1 Button") end,
            Icon = "bird",
        },
        {
            Title = "Button 2",
            Variant = "Primary",
            Callback = function() print("2 Button") end,
            Icon = "bird",
        },
        {
            Title = "Button 3",
            Variant = "Primary",
            Callback = function() print("3 Button") end,
            Icon = "bird",
        },
    }
})

Tabs.ParagraphTab:Divider()

for _,i in next, { "Default", "Red", "Orange", "Green", "Blue", "Grey", "White" } do
    Tabs.ParagraphTab:Paragraph({
        Title = i,
        Desc = "Paragraph with color",
        Image = "bird",
        Color = i ~= "Default" and i or nil,
        Buttons = {
            {
                Title = "Button 1",
                Variant = "Primary",
                Callback = function() print("1 Button") end,
                Icon = "bird",
            },
            {
                Title = "Button 2",
                Variant = "Primary",
                Callback = function() print("2 Button") end,
                Icon = "bird",
            },
            {
                Title = "Button 3",
                Variant = "Primary",
                Callback = function() print("3 Button") end,
                Icon = "bird",
            },
        }
    })
end



Tabs.ButtonTab:Button({
    Title = "Click Me",
    Desc = "This is a simple button",
    Callback = function() print("Button Clicked!") end
})


local destroybtn
destroybtn = Tabs.ButtonTab:Button({
    Title = "Click to destroy me!",
    Callback = function() destroybtn:Destroy() end,
})

Tabs.ButtonTab:Button({
    Title = "Submit",
    Desc = "Click to submit",
    Callback = function() print("Submitted!") end,
})

Tabs.ButtonTab:Button({
    Title = "Set ToggleKey to 'F'",
    Callback = function() Window:SetToggleKey(Enum.KeyCode.F) end,
})

Tabs.ButtonTab:Divider()


Tabs.ButtonTab:Button({
    Title = "Locked Button",
    Desc = "This button is locked",
    Locked = true,
})


Tabs.CodeTab:Code({
    Title = "example-code.luau",
    Code = [[-- Example Luau code to test syntax highlighting
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

local result = factorial(5)
print("Factorial of 5 is:", result)

local playerName = "Player"
local score = 100

if score >= 100 then
    print(playerName .. " earned an achievement!")
else
    warn("Need more points.")
end

-- Table with nested values
local playerStats = {
    name = "Player",
    health = 100,
    inventory = {"sword", "shield", "potion"}
}

for i, item in ipairs(playerStats.inventory) do
    print("Item in inventory:", item)
end]],
})

Tabs.CodeTab:Code({
    Code = [[print("WindUI on top!")]],
})



Tabs.ColorPickerTab:Colorpicker({
    Title = "Pick a Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color) print("Selected color: " .. tostring(color)) end
})

Tabs.ColorPickerTab:Colorpicker({
    Title = "Transparency Color",
    Default = Color3.fromRGB(0, 0, 255),
    Transparency = 0,
    Callback = function(color) print("Background color: " .. tostring(color)) end
})


Tabs.DialogTab:Button({
    Title = "Create Example Dialog",
    Callback = function()
        Window:Dialog({
            Title = "Example Dialog",
            Content = "Example Content. lalala",
            Icon = "bird",
            Buttons = {
                {
                    Title = "LOL!",
                    Icon = "bird",
                    Variant = "Tertiary",
                    Callback = function()
                        print("lol")
                    end,
                },
                {
                    Title = "Cool!",
                    Icon = "bird",
                    Variant = "Tertiary",
                    Callback = function()
                        print("Cool")
                    end,
                },
                {
                    Title = "Ok!",
                    Icon = "bird",
                    Variant = "Secondary",
                    Callback = function()
                        print("Ok")
                    end,
                },
                {
                    Title = "Awesome!",
                    Icon = "bird",
                    Variant = "Primary",
                    Callback = function() 
                        print("Awesome")
                    end,
                }
            }
        })
    end,
})

Tabs.DialogTab:Button({
    Title = "Create Example Dialog 2",
    Callback = function()
        Window:Dialog({
            Title = "Example Dialog 2",
            Content = "Example Content. lalala",
            Icon = "rbxassetid://129260712070622",
            Buttons = {
                {
                    Title = "Ok!",
                    Variant = "Primary",
                    Callback = function()
                        print("ok")
                    end,
                },
            }
        })
    end,
})


Tabs.NotificationTab:Button({
    Title = "Click to get Notified",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 1",
            Content = "Content",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with icon",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 2",
            Content = "Content",
            Icon = "droplet-off",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with custom icon",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 2",
            Content = "Content",
            Icon = "rbxassetid://129260712070622",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with BackgroundImage",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 3",
            Content = "with BackgroundImage",
            Icon = "image",
            Duration = 5,
            Background = "rbxassetid://13511292247"
        })
    end
})


Tabs.ToggleTab:Toggle({
    Title = "Enable Feature",
    --Image = "bird",
    Value = true,
    Callback = function(state) print("Feature enabled: " .. tostring(state)) end
})

Tabs.ToggleTab:Toggle({
    Title = "Activate Mode",
    Value = false,
    Callback = function(state) print("Mode activated: " .. tostring(state)) end
})
Tabs.ToggleTab:Toggle({
    Title = "Toggle with icon",
    Icon = "check",
    Value = false,
    Callback = function(state) print("Toggle with icon activated: " .. tostring(state)) end
})

Tabs.ToggleTab:Toggle({
    Title = "New Toggle Type 'Checkbox'",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) print("'Checkbox' Toggle activated: " .. tostring(state)) end
})
Tabs.ToggleTab:Toggle({
    Title = "New Toggle Type 'Checkbox' with custom icon",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) print("'Checkbox' Toggle with icon activated: " .. tostring(state)) end
})


Tabs.SliderTab:Slider({
    Title = "Volume Slider",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value) print("Volume set to: " .. value) end
})

Tabs.SliderTab:Slider({
    Title = "Brightness Slider",
    Value = {
        Min = 1,
        Max = 100,
        Default = 75,
    },
    Callback = function(value) print("Brightness set to: " .. value) end
})

Tabs.SliderTab:Slider({
    Title = "Float Slider",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 2.5,
        Default = 1.5,
    },
    Callback = function(value) print("Brightness set to: " .. value) end
})


Tabs.InputTab:Input({
    Title = "Username",
    Value = "Guest",
    Placeholder = "Enter your username",
    Callback = function(input) print("Username: " .. input) end
})

Tabs.InputTab:Input({
    Title = "Password",
    Value = "",
    Placeholder = "Enter your password",
    Callback = function(input) print("Password entered.") end
})


Tabs.InputTab:Input({
    Title = "Input with icon",
    Value = "pisun",
    InputIcon = "bird",
    Placeholder = "Enter pisun",
    Callback = function(input) print("pisun entered.") end
})


Tabs.InputTab:Input({
    Title = "Comment",
    Value = "",
    Type = "Textarea", -- or Input
    Placeholder = "Leave a comment",
    Callback = function(input) 
        print("Comment entered: " .. input)
    end
})

Tabs.InputTab:Input({
    Title = "Comment with icon",
    Desc = "hmmmm",
    Value = "pisun",
    InputIcon = "bird",
    Type = "Textarea", -- or Input
    Placeholder = "Leave a pisun",
    Callback = function(input) 
        print("Pisun entered: " .. input)
    end
})


Tabs.KeybindTab:Keybind({
    Title = "Keybind Example",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})


Tabs.DropdownTab:Dropdown({
    Title = "Select an Option",
    Values = { "Option 1", "Option 2", "Option 3" },
    Value = "Option 1",
    Callback = function(option) print("Selected: " .. option) end
})

local superdropdown

superdropdown = Tabs.DropdownTab:Dropdown({
    Title = "You cant select.",
    Values = { "Option 1", "Option 2", "Option 3" },
    Value = nil,
    AllowNone = true,
    Callback = function(option)
        superdropdown:Select()
    end
})

Tabs.DropdownTab:Dropdown({
    Title = "Choose a Category (Multi)",
    Values = { "Category A", "Category B", "Category C" },
    Value = { "Category A" },
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        print("Categories selected: " .. game:GetService("HttpService"):JSONEncode(option)) 
    end
})
Tabs.DropdownTab:Dropdown({
    Title = "Big Dropdown",
    Values = { "Lllllllloooooooonnnnnggggggggg Tab", 
               "Hi",
             },
    --Value = { "" },
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        print("Pisun selected: " .. game:GetService("HttpService"):JSONEncode(option)) 
    end
})



-- Configuration
-- Optional


local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "Window", Icon = "app-window-mac" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.WindowTab:Button({
    Title = "Save File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.WindowTab:Button({
    Title = "Load File",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "File Loaded",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Overwrite File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Refresh List",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].Placeholder

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        Placeholder = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local CreateInput = Tabs.CreateThemeTab:Input({
    Title = "Theme Name",
    Value = currentThemeName,
    Callback = function(name)
        currentThemeName = name
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Background Color",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Outline Color",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Text Color",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Placeholder Text Color",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        ThemePlaceholderText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Button({
    Title = "Update Theme",
    Callback = function()
        updateTheme()
    end
})

local InviteCode = "ApbHXtAwU2"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

local Response = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
    Url = DiscordAPI,
    Method = "GET",
    Headers = {
        ["User-Agent"] = "RobloxBot/1.0",
        ["Accept"] = "application/json"
    }
}).Body)

if Response and Response.guild then
    local DiscordInfo = Tabs.Tests:Paragraph({
        Title = Response.guild.name,
        Desc = 
            ' <font color="#52525b">•</font> Member Count : ' .. tostring(Response.approximate_member_count) .. 
            '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(Response.approximate_presence_count)
        ,
        Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
        ImageSize = 42,
    })

    Tabs.Tests:Button({
        Title = "Update Info",
        --Image = "refresh-ccw",
        Callback = function()
            local UpdatedResponse = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
                Url = DiscordAPI,
                Method = "GET",
            }).Body)
            
            if UpdatedResponse and UpdatedResponse and UpdatedResponse.guild then
                DiscordInfo:SetDesc(
                    ' <font color="#52525b">•</font> Member Count : ' .. tostring(UpdatedResponse.approximate_member_count) .. 
                    '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(UpdatedResponse.approximate_presence_count)
                )
            end
        end
    })
else
    Tabs.Tests:Paragraph({
        Title = "Error when receiving information about the Discord server",
        Desc = game:GetService("HttpService"):JSONEncode(Response),
        Image = "triangle-alert",
        ImageSize = 26,
        Color = "Red",
    })
end



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

Tabs.Tests:Section({
    Title = "Get WindUI JSON"
})

Tabs.Tests:Button({
    Title = "Get WindUI JSON",
    Callback = function()
        tableToClipboard(WindUI)
    end
})




-- Configs


local ToggleElement = Tabs.ConfigTab:Toggle({
    Title = "Toggle",
    Desc = "Config Test Toggle",
    Callback = function(v) print("Toggle Changed: " .. tostring(v)) end
})

local SliderElement = Tabs.ConfigTab:Slider({
    Title = "Slider",
    Desc = "Config Test Slider",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(v) print("Slider Changed: " .. v) end
})

local KeybindElement = Tabs.ConfigTab:Keybind({
    Title = "Keybind",
    Desc = "Config Test Keybind",
    Value = "F",
    Callback = function(v) print("Keybind Changed/Clicked: " .. v) end
})

local DropdownElement = Tabs.ConfigTab:Dropdown({
    Title = "Dropdown",
    Desc = "Config Test Dropdown",
    Values = { "Test 1", "Test 2" },
    Value = "Test 1",
    Callback = function(v) print("Dropdown Changed: " .. HttpService:JSONEncode(v)) end
})

local InputElement = Tabs.ConfigTab:Input({
    Title = "Input",
    Desc = "Config Test Input",
    Value = "Test",
    Placeholder = "Enter text.......",
    Callback = function(v) print("Input Changed: " .. v) end
})

local ColorpickerElement = Tabs.ConfigTab:Colorpicker({
    Title = "Colorpicker",
    Desc = "Config Test Colorpicker",
    Default = Color3.fromHex("#315dff"),
    Transparency = 0, -- Transparency enabled
    Callback = function(c,t) print("Colorpicker Changed: " .. c:ToHex() .. "\nTransparency: " .. t) end
})

-- Configs


-- 1. Load ConfigManager
local ConfigManager = Window.ConfigManager

if ConfigManager then
    -- 2. Create Config File                    ↓ Config File name
    local myConfig = ConfigManager:CreateConfig("myConfig")
    
    
    -- 3. Register elements
    
    --               | ↓ Element name (no spaces)  | ↓ Element          |
    myConfig:Register( "toggleNameExample",          ToggleElement      )
    myConfig:Register( "sliderNameExample",          SliderElement      ) 
    myConfig:Register( "keybindNameExample",         KeybindElement     )
    myConfig:Register( "dropdownNameExample",        DropdownElement    )
    myConfig:Register( "inputNameExample",           InputElement       )
    myConfig:Register( "ColorpickerNameExample",     ColorpickerElement )
    
    
    -- Save
    
    --[[ Saving at 
        {yourExecutor}
            /Workspace
                /WindUI
                    /{Window.Folder}
                        /config
                            /myConfig.json
                            
                                           ]]
                                       
    -- myConfig:Save()
    
    
    -- Load   
    
    -- myConfig:Load()
    
    
    
    -- Usage:
    
    Tabs.ConfigTab:Button({
        Title = "Save",
        Desc = "Saves elements to config",
        Callback = function()
            myConfig:Save()
        end
    })
    
    Tabs.ConfigTab:Button({
        Title = "Load",
        Desc = "Loads elements from config",
        Callback = function()
            myConfig:Load()
        end
    })
    
    Tabs.ConfigTab:Button({
        Title = "Print all configs",
        --Desc = "Prints configs",
        Callback = function()
            print(game:GetService("HttpService"):JSONEncode(ConfigManager:AllConfigs()))
        end
    })
    
end
    
    
-- function :OnClose()

Window:OnClose(function()
    print("UI Closed.")
end)



-- function :OnDestroy()

Window:OnDestroy(function()
    print("UI Destroyed.")
end)