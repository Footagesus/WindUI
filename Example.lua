-- This is just an example.

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Localization = WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["en"] = {
            ["WINDUI_EXAMPLE"] = "WindUI Example",
            ["WELCOME"] = "Welcome to WindUI!",
            ["LIB_DESC"] = "Beautiful UI library for Roblox",
            ["SETTINGS"] = "Settings",
            ["APPEARANCE"] = "Appearance",
            ["FEATURES"] = "Features",
            ["UTILITIES"] = "Utilities",
            ["UI_ELEMENTS"] = "UI Elements",
            ["CONFIGURATION"] = "Configuration",
            ["SAVE_CONFIG"] = "Save Configuration",
            ["LOAD_CONFIG"] = "Load Configuration",
            ["THEME_SELECT"] = "Select Theme",
            ["TRANSPARENCY"] = "Window Transparency",
            ["LOCKED_TAB"] = "Locked Tab"
        }
    }
})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

WindUI:Popup({
    Title = gradient("WindUI Demo", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    Content = "loc:LIB_DESC",
    Buttons = {
        {
            Title = "Get Started",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})


-- Add your service to get key 
--[[
WindUI.Services.mysuperservicetogetkey = {
    Name = "My Super Service",
    Icon = "droplet", -- lucide or rbxassetid or raw link to img
    
    Args = { "ServiceId" }, --       <- \
    --                                   |
    -- important!!!!!!!!!!!!!!!          |
    New = function(ServiceId) -- <------ | Args!!!!!!!!!!!!
        
        function validateKey(key) -- <--- this too important!!!
            -- your function to validate key
            -- see examples at src/utils/
            
            if not key then
                return false, "Key is invalid!" 
                
            end
            
            return true, "Key is valid!" 
        end
        
        function copyLink()
            return setclipboard("link to key system service.")
        end
        
        return { 
        
            Verify = validateKey, -- <-----  THIS TOO IMPORTANT!!!!!
            Copy = copyLink -- <-------- IMPORTANT!1!1!1!1!1!1!11!
        }
    end
}
]]


local Window = WindUI:CreateWindow({
    Title = "loc:WINDUI_EXAMPLE",
    Icon = "geist:window",
    Author = "loc:WELCOME",
    Folder = "WindUI_Example",
    Size = UDim2.fromOffset(580, 490),
    Theme = "Dark",
    
    HidePanelBackground = false,
    NewElements = false,
    -- Background = WindUI:Gradient({
    --     ["0"] = { Color = Color3.fromHex("#0f0c29"), Transparency = 1 },
    --     ["100"] = { Color = Color3.fromHex("#302b63"), Transparency = 0.9 },
    -- }, {
    --     Rotation = 45,
    -- }),
    --Background = "video:https://cdn.discordapp.com/attachments/1337368451865645096/1402703845657673878/VID_20250616_180732_158.webm?ex=68958a01&is=68943881&hm=164c5b04d1076308b38055075f7eb0653c1d73bec9bcee08e918a31321fe3058&",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            WindUI:Notify({
                Title = "User Profile",
                Content = "User profile clicked!",
                Duration = 3
            })
        end
    },
    Acrylic = false,
    HideSearchBar = false,
    SideBarWidth = 200,
    -- KeySystem = { -- 
    --     -- Key = { "1234", "5678" },  
    --     Note = "Example Key System. With platoboost, etc.",
    --     -- URL = "https://github.com/Footagesus/WindUI",
    --     -- Thumbnail = {
    --     --     Image = "rbxassetid://",
    --     --     Title = "Thumbnail",
    --     -- },
    --     API = {
    --         {   
    --             -- Title = "Platoboost", -- optional 
    --             -- Desc = "Click to copy.", -- optional
    --             -- Icon = "rbxassetid://", -- optional
    
    --             Type = "platoboost", -- type: platoboost, ...
    --             ServiceId = 5541, -- service id
    --             Secret = "1eda3b70-aab4-4394-82e4-4e7f507ae198", -- platoboost secret
    --         },
    --         {   
    --             -- Title = "Other service", -- optional 
    --             -- Desc = nil, -- optional
    --             -- Icon = "rbxassetid://", -- optional
    
    --             Type = "pandadevelopment", -- type: platoboost, ...
    --             ServiceId = "windui", -- service id
    --         },
    --         {   
    --             Type = "luarmor",
    --             ScriptId = "...",
    --             Discord = "https://discord.com/invite/...",
    --         },
    --         { -- Custom service 
    --             Type = "mysuperservicetogetkey",
    --             ServiceId = 42,
    --         }
    --     },
    --     SaveKey = true,
    -- },
    -- KeySystem = {
    --     Key = { "pisun" },
    --     Thumbnail = {
    --         Image = "rbxassetid://88271032881974",
    --         Width = 180, -- default 200
    --     }
    -- }
})



-- OPTIONAL   >:(


Window.User:SetAnonymous(true)
--Window.User:Disable()




Window:SetIconSize(48)

Window:Tag({
    Title = "v1.6.4",
    Color = Color3.fromHex("#30ff6a")
})
Window:Tag({
    Title = "Beta",
    Color = Color3.fromHex("#315dff")
})
local TimeTag = Window:Tag({
    Title = "--:--",
    Radius = 0,
    --Color = Color3.fromHex("#000000"),
    Color = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})


local hue = 0

-- Rainbow effect & Time 
task.spawn(function()
	while true do
		local now = os.date("*t")
		local hours = string.format("%02d", now.hour)
		local minutes = string.format("%02d", now.min)
		
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		
		TimeTag:SetTitle(hours .. ":" .. minutes)
		--TimeTag:SetColor(color)

		task.wait(0.06)
	end
end)


Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Sections = {
    Main = Window:Section({ Title = "loc:FEATURES", Opened = true }),
    Settings = Window:Section({ Title = "loc:SETTINGS", Opened = true }),
    Utilities = Window:Section({ Title = "loc:UTILITIES", Opened = true })
}

local Tabs = {
    Elements = Sections.Main:Tab({ Title = "loc:UI_ELEMENTS", Icon = "layout-grid", Desc = "UI Elements Example" }),
    Appearance = Sections.Settings:Tab({ Title = "loc:APPEARANCE", Icon = "brush" }),
    Config = Sections.Utilities:Tab({ Title = "loc:CONFIGURATION", Icon = "settings" }),
    LockedTab1 = Window:Tab({ Title = "loc:LOCKED_TAB", Icon = "bird", Locked = true, }),
    LockedTab2 = Window:Tab({ Title = "loc:LOCKED_TAB", Icon = "bird", Locked = true, }),
    LockedTab3 = Window:Tab({ Title = "loc:LOCKED_TAB", Icon = "bird", Locked = true, }),
    LockedTab4 = Window:Tab({ Title = "loc:LOCKED_TAB", Icon = "bird", Locked = true, }),
    LockedTab5 = Window:Tab({ Title = "loc:LOCKED_TAB", Icon = "bird", Locked = true, }),
}

-- Tabs.Elements:Paragraph({
--     Title = "Interactive Components",
--     Desc = "Explore WindUI's powerful elements",
--     Image = "component",
--     ImageSize = 20,
--     Color = Color3.fromHex("#30ff6a"),
-- })

Tabs.Elements:Section({
    Title = "Interactive Components",
    TextSize = 20,
})

Tabs.Elements:Section({
    Title = "Explore WindUI's powerful elements",
    TextSize = 16,
    TextTransparency = .25,
})

Tabs.Elements:Divider()

local ElementsSection = Tabs.Elements:Section({
    Title = "Section Example",
    Icon = "bird",
})

local toggleState = false
local featureToggle = ElementsSection:Toggle({
    Title = "Enable Features",
    --Desc = "Unlocks additional functionality",
    Value = false,
    Callback = function(state) 
        toggleState = state
        WindUI:Notify({
            Title = "Features",
            Content = state and "Features Enabled" or "Features Disabled",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

local intensitySlider = ElementsSection:Slider({
    Title = "Effect Intensity",
    Desc = "Adjust the effect strength",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(value)
        print("Intensity set to:", value)
    end
})

local values = {}

for i = 1, 40 do
    table.insert(values, "Test " .. i)
end

ElementsSection:Space()


local testDropdown = ElementsSection:Dropdown({
    Title = "Dropdown test",
    Values = values,
    Value = "Test 1",
    Callback = function(option)
        -- WindUI:Notify({
        --     Title = "Dropdown",
        --     Content = "Selected: "..option,
        --     Duration = 2
        -- })
    end
})

testDropdown:Refresh(values)

ElementsSection:Divider()

ElementsSection:Button({
    Title = "Show Notification",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "Hello WindUI!",
            Content = "This is a sample notification",
            Icon = "bell",
            Duration = 3
        })
    end
})

ElementsSection:Colorpicker({
    Title = "Select Color",
    --Desc = "Select coloe",
    Default = Color3.fromHex("#30ff6a"),
    Transparency = 0, -- enable transparency
    Callback = function(color, transparency)
        WindUI:Notify({
            Title = "Color Changed",
            Content = "New color: "..color:ToHex().."\nTransparency: "..transparency,
            Duration = 2
        })
    end
})

ElementsSection:Code({
    Title = "my_code.luau",
    Code = [[print("Hello world!")]],
    OnCopy = function()
        print("Copied to clipboard!")
    end
})

Tabs.Appearance:Paragraph({
    Title = "Customize Interface",
    Desc = "Personalize your experience",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local canchangetheme = true
local canchangedropdown = true



local themeDropdown = Tabs.Appearance:Dropdown({
    Title = "loc:THEME_SELECT",
    Values = themes,
    SearchBarEnabled = true,
    MenuWidth = 280,
    Value = "Dark",
    Callback = function(theme)
        canchangedropdown = false
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "Theme Applied",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
        canchangedropdown = true
    end
})

local transparencySlider = Tabs.Appearance:Slider({
    Title = "loc:TRANSPARENCY",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        WindUI.TransparencyValue = tonumber(value)
        Window:ToggleTransparency(tonumber(value) > 0)
    end
})

local ThemeToggle = Tabs.Appearance:Toggle({
    Title = "Enable Dark Mode",
    Desc = "Use dark color scheme",
    Value = true,
    Callback = function(state)
        if canchangetheme then
            WindUI:SetTheme(state and "Dark" or "Light")
        end
        if canchangedropdown then
            themeDropdown:Select(state and "Dark" or "Light")
        end
    end
})

WindUI:OnThemeChange(function(theme)
    canchangetheme = false
    ThemeToggle:Set(theme == "Dark")
    canchangetheme = true
end)


Tabs.Appearance:Button({
    Title = "Create New Theme",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "Create Theme",
            Content = "This feature is coming soon!",
            Buttons = {
                {
                    Title = "OK",
                    Variant = "Primary"
                }
            }
        })
    end
})

Tabs.Config:Paragraph({
    Title = "Configuration Manager",
    Desc = "Save and load your settings",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

local configName = "default"
local configFile = nil
local MyPlayerData = {
    name = "Player1",
    level = 1,
    inventory = { "sword", "shield", "potion" }
}

Tabs.Config:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value or "default"
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
    Tabs.Config:Button({
        Title = "loc:SAVE_CONFIG",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            
            configFile:Register("featureToggle", featureToggle)
            configFile:Register("intensitySlider", intensitySlider)
            configFile:Register("testDropdown", testDropdown)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)
            
            configFile:Set("playerData", MyPlayerData)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            
            if configFile:Save() then
                WindUI:Notify({ 
                    Title = "loc:SAVE_CONFIG", 
                    Content = "Saved as: "..configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({ 
                    Title = "Error", 
                    Content = "Failed to save config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    Tabs.Config:Button({
        Title = "loc:LOAD_CONFIG",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            
            if loadedData then
                if loadedData.playerData then
                    MyPlayerData = loadedData.playerData
                end
                
                local lastSave = loadedData.lastSave or "Unknown"
                WindUI:Notify({ 
                    Title = "loc:LOAD_CONFIG", 
                    Content = "Loaded: "..configName.."\nLast save: "..lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
                
                Tabs.Config:Paragraph({
                    Title = "Player Data",
                    Desc = string.format("Name: %s\nLevel: %d\nInventory: %s", 
                        MyPlayerData.name, 
                        MyPlayerData.level, 
                        table.concat(MyPlayerData.inventory, ", "))
                })
            else
                WindUI:Notify({ 
                    Title = "Error", 
                    Content = "Failed to load config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
else
    Tabs.Config:Paragraph({
        Title = "Config Manager Not Available",
        Desc = "This feature requires ConfigManager",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end


local footerSection = Window:Section({ Title = "WindUI " .. WindUI.Version })
Tabs.Config:Paragraph({
    Title = "Github Repository",
    Desc = "github.com/Footagesus/WindUI",
    Image = "github",
    ImageSize = 20,
    Color = "Grey",
    Buttons = {
        {
            Title = "Copy Link",
            Icon = "copy",
            Variant = "Tertiary",
            Callback = function()
                setclipboard("https://github.com/Footagesus/WindUI")
                WindUI:Notify({
                    Title = "Copied!",
                    Content = "GitHub link copied to clipboard",
                    Duration = 2
                })
            end
        }
    }
})

Window:OnClose(function()
    print("Window closed")
    
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
        print("Config auto-saved on close")
    end
end)

Window:OnDestroy(function()
    print("Window destroyed")
end)

Window:OnOpen(function()
    print("Window opened")
end)



-- lock all elements
Window:UnlockAll()

-- unlock all elements
--Window:UnlockAll()

-- unlock all elements in tab
task.wait(0.05)
--  no working :( idk why 
-- Tabs.Elements:LockAll()

if Window:GetUnlocked() and #Window:GetUnlocked() > 0 then
    print("Locked Elements in Window: ")
    for _, lockedelement in next, Window:GetUnlocked() do
        local title = lockedelement.Title
        if string.find(title, Localization.Prefix) then
            local translations = Localization.Translations[WindUI.Creator.Language] or Localization.Translations[Localization.DefaultLanguage]
            title = translations[ title:gsub("^" .. Localization.Prefix, "") ]
        end
        print("- " .. (title or "Unknown"))
    end
    
end


