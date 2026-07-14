--[[
    InitHelper Module
    Centralized initialization utilities for OxigenUI
    Handles WindUI loading and window setup
]]

local InitHelper = {}

local Logger = require(script.Parent.Parent:WaitForChild("core"):WaitForChild("Logger"))
local ErrorHandler = require(script.Parent.Parent:WaitForChild("core"):WaitForChild("ErrorHandler"))

--[[
    Load WindUI with fallback mechanisms
    @return any - WindUI module or nil if loading failed
]]
function InitHelper:loadWindUI()
    Logger:info("Loading WindUI...")
    
    -- Try to load from local src
    local success, result = ErrorHandler:safeCall(function()
        return require("./src/Init")
    end, "Load from local src")
    
    if success then
        Logger:info("✓ Successfully loaded WindUI from local src")
        return result
    end
    
    Logger:warn("Failed to load from local src, trying alternatives...")
    
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Try to load from ReplicatedStorage in Studio
    if RunService:IsStudio() then
        Logger:debug("Attempting to load from ReplicatedStorage (Studio mode)")
        success, result = ErrorHandler:safeCall(function()
            return require(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init"))
        end, "Load from ReplicatedStorage")
        
        if success then
            Logger:info("✓ Successfully loaded WindUI from ReplicatedStorage")
            return result
        end
    end
    
    -- Try to load from GitHub CDN
    Logger:debug("Attempting to load from GitHub CDN")
    success, result = ErrorHandler:tryWithRetry(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end, 3, 1, "Load from GitHub CDN")
    
    if success then
        Logger:info("✓ Successfully loaded WindUI from GitHub CDN")
        return result
    end
    
    Logger:error("Failed to load WindUI from all sources")
    return nil
end

--[[
    Create a standard configured window
    @param windUI any - WindUI module
    @param config table - Window configuration
    @return any - Created window or nil
]]
function InitHelper:createStandardWindow(windUI, config)
    if not windUI then
        Logger:error("WindUI module is required to create window")
        return nil
    end
    
    config = config or {}
    
    local windowConfig = {
        Title = config.Title or "OxigenUI",
        Icon = config.Icon or "sparkles",
        Author = config.Author or "OxigenUI",
        Theme = config.Theme or "Dark",
        Folder = config.Folder or "OxigenUI",
        Size = config.Size or UDim2.fromOffset(580, 490),
        HideSearchBar = config.HideSearchBar ~= nil and config.HideSearchBar or false,
        NewElements = config.NewElements ~= nil and config.NewElements or true,
        SideBarWidth = config.SideBarWidth or 200,
        
        OpenButton = {
            Title = config.OpenButtonTitle or "Open OxigenUI",
            CornerRadius = config.CornerRadius or UDim.new(1, 0),
            StrokeThickness = config.StrokeThickness or 3,
            Enabled = config.OpenButtonEnabled ~= nil and config.OpenButtonEnabled or true,
            OnlyMobile = config.OnlyMobile or false,
            Draggable = config.Draggable ~= nil and config.Draggable or true,
            Color = config.ButtonColor or ColorSequence.new(
                Color3.fromHex("#30FF6A"),
                Color3.fromHex("#e7ff2f")
            ),
        },
    }
    
    local success, window = ErrorHandler:safeCall(function()
        return windUI:CreateWindow(windowConfig)
    end, "Create Window")
    
    if success and window then
        Logger:info("✓ Window created successfully")
        return window
    end
    
    Logger:error("Failed to create window")
    return nil
end

--[[
    Setup common window elements (tags, sections, etc)
    @param window any - Window object
    @param config table - Setup configuration
]]
function InitHelper:setupWindowElements(window, config)
    if not window then
        Logger:error("Window is required")
        return false
    end
    
    config = config or {}
    
    local success = true
    
    -- Add tags
    if config.Tags then
        for _, tagConfig in ipairs(config.Tags) do
            local ok = ErrorHandler:safeCall(function()
                window:Tag({
                    Title = tagConfig.Title or "Tag",
                    Color = tagConfig.Color or Color3.fromHex("#30FF6A"),
                })
            end, "Add Tag: " .. tagConfig.Title)
            success = success and ok
        end
    end
    
    -- Add sections
    if config.Sections then
        for _, sectionConfig in ipairs(config.Sections) do
            local ok = ErrorHandler:safeCall(function()
                window:Section({
                    Title = sectionConfig.Title or "Section",
                    Opened = sectionConfig.Opened ~= nil and sectionConfig.Opened or true,
                })
            end, "Add Section: " .. sectionConfig.Title)
            success = success and ok
        end
    end
    
    if success then
        Logger:info("✓ Window elements setup complete")
    else
        Logger:warn("Some window elements failed to setup")
    end
    
    return success
end

--[[
    Add theme switcher button
    @param window any - Window object
    @param windUI any - WindUI module
    @return boolean - Success status
]]
function InitHelper:addThemeSwitcher(window, windUI)
    if not window or not windUI then
        return false
    end
    
    local success = ErrorHandler:safeCall(function()
        window:CreateTopbarButton("theme-switcher", "moon", function()
            local currentTheme = windUI:GetCurrentTheme()
            local newTheme = currentTheme == "Dark" and "Light" or "Dark"
            windUI:SetTheme(newTheme)
            windUI:Notify({
                Title = "Theme Changed",
                Content = "Current theme: " .. newTheme,
                Duration = 2,
            })
        end, 990)
    end, "Add Theme Switcher")
    
    return success
end

--[[
    Add common notification examples
    @param window any - Window object
    @param windUI any - WindUI module
    @return boolean - Success status
]]
function InitHelper:addNotificationExamples(window, windUI)
    if not window or not windUI then
        return false
    end
    
    local exampleTab = ErrorHandler:safeCall(function()
        return window:Tab({
            Title = "Notifications",
            Icon = "bell",
        })
    end, "Create Notifications Tab")
    
    if not exampleTab then
        return false
    end
    
    local success = true
    
    -- Success notification
    success = success and ErrorHandler:safeCall(function()
        exampleTab:Button({
            Title = "Show Success Notification",
            Icon = "check",
            Callback = function()
                windUI:Notify({
                    Title = "Success!",
                    Content = "Operation completed successfully",
                    Icon = "check",
                    Duration = 3,
                })
            end,
        })
    end, "Add Success Notification Button")
    
    -- Error notification
    success = success and ErrorHandler:safeCall(function()
        exampleTab:Button({
            Title = "Show Error Notification",
            Icon = "x",
            Callback = function()
                windUI:Notify({
                    Title = "Error!",
                    Content = "Something went wrong",
                    Icon = "x",
                    Duration = 3,
                })
            end,
        })
    end, "Add Error Notification Button")
    
    -- Info notification
    success = success and ErrorHandler:safeCall(function()
        exampleTab:Button({
            Title = "Show Info Notification",
            Icon = "info",
            Callback = function()
                windUI:Notify({
                    Title = "Information",
                    Content = "This is an informational message",
                    Icon = "info",
                    Duration = 3,
                })
            end,
        })
    end, "Add Info Notification Button")
    
    return success
end

return InitHelper
