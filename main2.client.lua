--[[
    WindUI Example 2
]]


local cloneref = (cloneref or clonereference or function(instance) return instance end)
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))

local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        if RunService:IsStudio() or not writefile then
            WindUI = require(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init"))
        else
            WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
        end
    end
end

local ThemeName = "Crimson"


local Window = WindUI:CreateWindow({
    Title = "Theme '" .. ThemeName .. "'",
    Author = "by .ftgs",
    Icon = "solar:compass-big-bold",
    Theme = ThemeName,
    NewElements = true,
})

local Tab1 = Window:Tab({
    Title = "Main",
    Icon = "solar:home-bold",
})

Tab1:Select()


Tab1:Section({
    Title = "Interactive Elements",
    Desc = "Demonstration of new UI components",
})

Tab1:Space({ Columns = 2 })

local Group1 = Tab1:Group()

Group1:Toggle({
    Title = "Autism",
    Value = true,
    Callback = function()end,
})

Group1:Space({ Columns = 0.5 })

Group1:Button({
    Title = "Unload",
    Justify = "Center",
    Icon = "solar:logout-3-bold",
    IconAlign = "Left",
    Size = "Small",
    Callback = function()
        Window:Destroy()
    end,
})


Tab1:Space({ Columns = 1 })

Tab1:Section({
    Title = "Brightness Control",
    TextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold,
})


Tab1:Slider({
    IsTooltip = true,
    Step = 1,
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Icons = {
        From = "solar:moon-stars-bold",
        To = "solar:sun-2-bold",
    },
    Callback = function(value)
        print("Brightness set to: " .. value .. "%")
    end
})

Tab1:Space({ Columns = 1 })


Tab1:Section({
    Title = "Volume Settings",
    TextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold,
})

Tab1:Slider({
    IsTooltip = true,
    Step = 5,
    Value = {
        Min = 0,
        Max = 100,
        Default = 75,
    },
    Icons = {
        From = "solar:volume-cross-bold",
        To = "solar:volume-loud-bold",
    },
    Callback = function(value)
        print("Volume set to: " .. value .. "%")
    end
})

Tab1:Space({ Columns = 0.5 })

local Group2 = Tab1:Group()

Group2:Button({
    Title = "Save",
    Justify = "Center",
    Icon = "solar:check-circle-bold",
    IconAlign = "Left",
    Size = "Small",
    Callback = function()
        WindUI:Notify({
            Title = "Success",
            Content = "Settings saved!"
        })
    end,
})

Group2:Space({ Columns = 0.5 })

Group2:Button({
    Title = "Reset",
    Justify = "Center",
    Icon = "solar:restart-circle-bold",
    IconAlign = "Left",
    Size = "Small",
    Callback = function()
        WindUI:Notify({
            Title = "Reset",
            Content = "All parameters restored to default"
        })
    end,
})








local TabSettings = Window:Tab({
    Title = "Settings",
    Icon = "solar:settings-bold",
})

-- Get all available themes
local Themes = {}
local ThemesModule = WindUI.Themes
for _ThemeName, ThemeData in pairs(ThemesModule) do
    table.insert(Themes, _ThemeName)
end

TabSettings:Section({
    Title = "Theme Settings",
    Desc = "Customize your UI theme",
})

TabSettings:Space({ Columns = 2 })


local CachedPRData = {}
local Remote = ReplicatedStorage:WaitForChild("GetPullRequestData")

TabSettings:Dropdown({
    Title = "Select Theme",
    Value = ThemeName,
    Values = Themes,
    Callback = function(value)
        ThemeName = value
        Window:SetTitle("Theme '" .. ThemeName .. "'")
        WindUI:SetTheme(ThemeName)
        WindUI:Notify({
            Title = "Theme Changed",
            Content = "Now using " .. ThemeName .. " theme"
        })

        local PRNumber = WindUI.Themes[ThemeName] and WindUI.Themes[ThemeName].Metadata and WindUI.Themes[ThemeName].Metadata.PullRequest
        print(PRNumber)
        if PRNumber then
            Window:SetAuthor("Loading...")
            if not CachedPRData[PRNumber] then
                local Success, Data = pcall(function()
                    return Remote:InvokeServer("Footagesus", "WindUI", PRNumber)
                end)
                
                if Success and Data and Data.html_url then
                    CachedPRData[PRNumber] = Data
                    Window:SetAuthor("by " .. Data.user.login .. " | https://github.com/Footagesus/WindUI/pull/" .. PRNumber)
                end
                print(Data)
            else
                local Data = CachedPRData[PRNumber]
                Window:SetAuthor("by " .. Data.user.login .. " | https://github.com/Footagesus/WindUI/pull/" .. PRNumber)
                print(Data)
            end
        else
            Window:SetAuthor("by .ftgs")
        end
    end,
})