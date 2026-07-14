--[[
    OxigenUI - Refactored Example
    Demonstrates best practices with new architecture
]]

local InitHelper = require(script.Parent:WaitForChild("src"):WaitForChild("utils"):WaitForChild("InitHelper"))
local DesignTokens = require(script.Parent:WaitForChild("src"):WaitForChild("utils"):WaitForChild("DesignTokens"))
local Logger = require(script.Parent:WaitForChild("src"):WaitForChild("core"):WaitForChild("Logger"))
local EventBus = require(script.Parent:WaitForChild("src"):WaitForChild("core"):WaitForChild("EventBus"))
local ErrorHandler = require(script.Parent:WaitForChild("src"):WaitForChild("core"):WaitForChild("ErrorHandler"))

-- Set debug level
Logger:setLevel(Logger.Level.INFO)

Logger:info("=" .. string.rep("=", 78) .. "=")
Logger:info("Starting OxigenUI Enhanced Example")
Logger:info("=" .. string.rep("=", 78) .. "=")

-- Load WindUI with error handling
local WindUI = InitHelper:loadWindUI()
if not WindUI then
    Logger:error("Failed to load WindUI. Aborting.")
    return
end

Logger:info("WindUI loaded successfully. Version: " .. (WindUI.Version or "Unknown"))

-- Create window using centralized helper
local window = InitHelper:createStandardWindow(WindUI, {
    Title = "OxigenUI Enhanced",
    Icon = "sparkles",
    Theme = "Dark",
    Folder = "OxigenUI_Enhanced",
    Author = "Enhanced by NaityHS",
})

if not window then
    Logger:error("Failed to create window. Aborting.")
    return
end

Logger:info("Window created successfully")

-- Setup window with tags and sections
InitHelper:setupWindowElements(window, {
    Tags = {
        { Title = "v1.6.66", Color = DesignTokens.Colors.Primary },
        { Title = "Enhanced", Color = DesignTokens.Colors.Secondary },
    },
    Sections = {
        { Title = "Core", Opened = true },
        { Title = "Examples", Opened = true },
    },
})

-- Add theme switcher
InitHelper:addThemeSwitcher(window, WindUI)

-- Create main tab
local ExamplesTab = window:Tab({
    Title = "Examples",
    Icon = "sparkles",
    Desc = "Showcasing OxigenUI features",
})

-- Setup event listener for window close
EventBus:on("window-closing", function()
    Logger:info("Window is closing")
end)

window:OnClose(function()
    EventBus:emit("window-closing")
    Logger:info("Window closed")
end)

-- Example 1: Using DesignTokens
local TokensSection = ExamplesTab:Section({
    Title = "Design Tokens Example",
    Icon = "palette",
})

TokensSection:Paragraph({
    Title = "Design System",
    Desc = "Centralized colors, spacing, and typography",
    Image = "palette",
    ImageSize = 20,
    Color = DesignTokens.Colors.Primary,
})

TokensSection:Button({
    Title = "Show Design Tokens",
    Icon = "info",
    Color = DesignTokens.Colors.Secondary,
    Callback = function()
        local message = string.format(
            "Primary: %s\nSpacing MD: %d\nTypography H1 Size: %d",
            tostring(DesignTokens.Colors.Primary),
            DesignTokens.Spacing.MD,
            DesignTokens.Typography.H1.Size
        )
        WindUI:Notify({
            Title = "Design Tokens",
            Content = message,
            Duration = 5,
        })
        Logger:info("Design tokens displayed")
    end,
})

-- Example 2: Using ErrorHandler
local ErrorSection = ExamplesTab:Section({
    Title = "Error Handling Example",
    Icon = "shield-alert",
})

ErrorSection:Paragraph({
    Title = "Safe Operations",
    Desc = "Automatic error catching and logging",
    Image = "shield-check",
    ImageSize = 20,
    Color = DesignTokens.Colors.Success,
})

local function riskySomeOperation(shouldFail)
    if shouldFail then
        error("Simulated error!")
    end
    return "Success!"
end

ErrorSection:Button({
    Title = "Safe Operation (Success)",
    Icon = "check",
    Color = DesignTokens.Colors.Success,
    Callback = function()
        local success, result = ErrorHandler:safeCall(
            riskySomeOperation,
            "Safe Operation",
            false
        )
        
        if success then
            Logger:info("Operation succeeded: " .. result)
            WindUI:Notify({
                Title = "Success",
                Content = result,
                Icon = "check",
            })
        end
    end,
})

ErrorSection:Button({
    Title = "Safe Operation (Error)",
    Icon = "x",
    Color = DesignTokens.Colors.Error,
    Callback = function()
        local success, result = ErrorHandler:safeCall(
            riskySomeOperation,
            "Risky Operation",
            true
        )
        
        if not success then
            Logger:warn("Operation failed safely: " .. tostring(result))
            WindUI:Notify({
                Title = "Operation Failed",
                Content = "But we handled it gracefully!",
                Icon = "alert-circle",
                Duration = 3,
            })
        end
    end,
})

-- Example 3: Using EventBus
local EventSection = ExamplesTab:Section({
    Title = "Event System Example",
    Icon = "zap",
})

EventSection:Paragraph({
    Title = "Decoupled Communication",
    Desc = "Emit and listen to events",
    Image = "radio",
    ImageSize = 20,
    Color = DesignTokens.Colors.Info,
})

local eventCount = 0

EventBus:on("custom-event", function(data)
    eventCount = eventCount + 1
    Logger:info("Event received! Count: " .. eventCount .. ", Data: " .. data)
    WindUI:Notify({
        Title = "Event Fired!",
        Content = "Message: " .. data .. " (Count: " .. eventCount .. ")",
        Duration = 2,
    })
end)

EventSection:Button({
    Title = "Emit Event",
    Icon = "send",
    Color = DesignTokens.Colors.Warning,
    Callback = function()
        EventBus:emit("custom-event", "Hello from EventBus!")
        Logger:info("Event emitted")
    end,
})

EventSection:Button({
    Title = "Show Event Count",
    Icon = "hash",
    Callback = function()
        WindUI:Notify({
            Title = "Event Count",
            Content = "Total events received: " .. eventCount,
            Duration = 3,
        })
    end,
})

-- Example 4: Logging Levels
local LoggingSection = ExamplesTab:Section({
    Title = "Logging Example",
    Icon = "book-open",
})

LoggingSection:Paragraph({
    Title = "Logging System",
    Desc = "Debug, Info, Warn, Error levels",
    Image = "terminal",
    ImageSize = 20,
    Color = DesignTokens.Colors.Grey500,
})

LoggingSection:Button({
    Title = "Log Debug",
    Icon = "bug",
    Callback = function()
        Logger:debug("This is a debug message")
        WindUI:Notify({ Title = "Debug logged", Duration = 1 })
    end,
})

LoggingSection:Button({
    Title = "Log Info",
    Icon = "info",
    Callback = function()
        Logger:info("This is an info message")
        WindUI:Notify({ Title = "Info logged", Duration = 1 })
    end,
})

LoggingSection:Button({
    Title = "Log Warning",
    Icon = "alert-triangle",
    Callback = function()
        Logger:warn("This is a warning message")
        WindUI:Notify({ Title = "Warning logged", Duration = 1 })
    end,
})

LoggingSection:Button({
    Title = "Log Error",
    Icon = "x-circle",
    Color = DesignTokens.Colors.Error,
    Callback = function()
        Logger:error("This is an error message")
        WindUI:Notify({ Title = "Error logged", Duration = 1 })
    end,
})

-- Example 5: Theme Colors
local ColorsSection = ExamplesTab:Section({
    Title = "Color Palette",
    Icon = "palette",
})

ColorsSection:Button({
    Title = "Primary Color",
    Icon = "circle",
    Color = DesignTokens.Colors.Primary,
})

ColorsSection:Button({
    Title = "Secondary Color",
    Icon = "circle",
    Color = DesignTokens.Colors.Secondary,
})

ColorsSection:Button({
    Title = "Success Color",
    Icon = "check-circle",
    Color = DesignTokens.Colors.Success,
})

ColorsSection:Button({
    Title = "Error Color",
    Icon = "x-circle",
    Color = DesignTokens.Colors.Error,
})

ColorsSection:Button({
    Title = "Warning Color",
    Icon = "alert-triangle",
    Color = DesignTokens.Colors.Warning,
})

Logger:info("=" .. string.rep("=", 78) .. "=")
Logger:info("OxigenUI Enhanced Example loaded successfully!")
Logger:info("Open the UI to explore all features")
Logger:info("=" .. string.rep("=", 78) .. "=")
