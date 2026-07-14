# OxigenUI Documentation

## Overview

OxigenUI is an enhanced fork of WindUI - a powerful Roblox UI library with a complete architecture overhaul for 10x better code quality, performance, and maintainability.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Core Modules](#core-modules)
3. [Architecture](#architecture)
4. [API Reference](#api-reference)
5. [Best Practices](#best-practices)
6. [Performance Tips](#performance-tips)
7. [Troubleshooting](#troubleshooting)

---

## Quick Start

### Basic Setup

```lua
local InitHelper = require(script.Parent:WaitForChild("src"):WaitForChild("utils"):WaitForChild("InitHelper"))
local DesignTokens = require(script.Parent:WaitForChild("src"):WaitForChild("utils"):WaitForChild("DesignTokens"))

-- Load WindUI
local WindUI = InitHelper:loadWindUI()

-- Create window
local window = InitHelper:createStandardWindow(WindUI, {
    Title = "My App",
    Theme = "Dark",
})

-- Setup elements
InitHelper:setupWindowElements(window, {
    Tags = {
        { Title = "v1.0", Color = DesignTokens.Colors.Primary },
    },
    Sections = {
        { Title = "Features" },
    },
})

-- Add theme switcher
InitHelper:addThemeSwitcher(window, WindUI)
```

---

## Core Modules

### Logger (`src/core/Logger.lua`)

Centralized logging system with 4 severity levels.

```lua
local Logger = require("src/core/Logger")

Logger:setLevel(Logger.Level.DEBUG)
Logger:debug("Debug message")
Logger:info("Info message")
Logger:warn("Warning message")
Logger:error("Error message")
```

**Features:**
- Severity levels: DEBUG, INFO, WARN, ERROR
- Timestamp support
- Stack trace information
- Format string support

---

### ErrorHandler (`src/core/ErrorHandler.lua`)

Safe function execution with error management and retry logic.

```lua
local ErrorHandler = require("src/core/ErrorHandler")

-- Safe function execution
local success, result = ErrorHandler:safeCall(function()
    return someRiskyOperation()
end, "Operation Name")

-- With retry logic
local success, result = ErrorHandler:tryWithRetry(
    function() return risky() end,
    3,           -- max retries
    1,           -- delay between retries
    "My Operation"
)

-- Wrap functions
local safeFunc = ErrorHandler:wrap(myFunction, "My Function")
local result = safeFunc()

-- Error callbacks
ErrorHandler:onError(function(error, context)
    print("Error in " .. context .. ": " .. error)
end)
```

**Features:**
- Safe function execution with try-catch
- Automatic error logging
- Retry with exponential backoff
- Function wrapping
- Error callbacks

---

### EventBus (`src/core/EventBus.lua`)

Centralized event management system.

```lua
local EventBus = require("src/core/EventBus")

-- Listen to events
local cleanup = EventBus:on("player-joined", function(playerName)
    print("Player joined: " .. playerName)
end, 10)  -- priority

-- One-time listener
EventBus:once("first-time-event", function()
    print("This fires only once")
end)

-- Emit events
EventBus:emit("player-joined", "John")

-- Remove listener
cleanup()  -- or EventBus:off("player-joined", callback)

-- Get listener count
local count = EventBus:listenerCount("player-joined")

-- Get event history
local history = EventBus:getHistory("player-joined")
```

**Features:**
- Priority-based listeners
- One-time listeners
- Event history
- Error handling for listeners
- Event name enumeration

---

### DesignTokens (`src/utils/DesignTokens.lua`)

Centralized design system.

```lua
local DesignTokens = require("src/utils/DesignTokens")

-- Access colors
local primaryColor = DesignTokens.Colors.Primary
local errorColor = DesignTokens:getColor("Error")

-- Access spacing
local padding = DesignTokens.Spacing.MD
local margin = DesignTokens:getSpacing("LG")

-- Access typography
local headingStyle = DesignTokens:getTypography("H1")
local bodyStyle = DesignTokens:getTypography("Body")

-- Animation constants
local duration = DesignTokens.Animation.Normal
local easing = DesignTokens.Easing.Out

-- Create gradients
local gradient = DesignTokens:createGradient(
    DesignTokens.Colors.Primary,
    DesignTokens.Colors.Secondary
)
```

**Available Tokens:**
- Colors (50+ colors with semantic naming)
- Spacing (XS, SM, MD, LG, XL, XXL, XXXL)
- Border Radius (0-999)
- Shadows (SM-XXL)
- Typography (H1-Caption)
- Animation durations
- Opacity levels

---

### LazyLoader (`src/utils/LazyLoader.lua`)

Lazy-load modules on demand.

```lua
local LazyLoader = require("src/utils/LazyLoader")

-- Load module on first access
local Button = LazyLoader:load("src/elements/Button")

-- Preload multiple modules
LazyLoader:preload({
    "src/elements/Button",
    "src/elements/Input",
    "src/elements/Slider",
})

-- Check if loaded
if LazyLoader:isLoaded("src/elements/Button") then
    print("Button module is loaded")
end

-- Get metadata
local metadata = LazyLoader:getMetadata("src/elements/Button")
print("Loaded at:", metadata.loadedAt)
```

---

### Profiler (`src/utils/Profiler.lua`)

Performance profiling and benchmarking.

```lua
local Profiler = require("src/utils/Profiler")

-- Measure function
local duration, result = Profiler:measure("fetch-data", function()
    -- Your code here
    return data
end)

-- Manual timing
Profiler:start("operation")
-- ... do something ...
local ms = Profiler:stop("operation")

-- Get statistics
local stats = Profiler:getStats("fetch-data")
print("Average:", stats.average)
print("Min:", stats.min)
print("Max:", stats.max)

-- Print report
Profiler:printReport(10)  -- Top 10 slowest
```

---

### ObjectPool (`src/utils/ObjectPool.lua`)

Memory-efficient object reuse.

```lua
local ObjectPool = require("src/utils/ObjectPool")

-- Create pool
local buttonPool = ObjectPool:new(10, function()
    return { pressed = false, id = math.random() }
end)

-- Acquire object
local button = buttonPool:acquire()
button.pressed = true

-- Release object
buttonPool:release(button)

-- Get stats
local stats = buttonPool:getStats()
print("In use:", stats.inUse)
print("Available:", stats.available)
```

---

### Validator (`src/utils/Validator.lua`)

Input validation and type checking.

```lua
local Validator = require("src/utils/Validator")

-- Type validation
local valid, err = Validator:isString(value, "Username")
if not valid then error(err) end

valid, err = Validator:isNumber(age, "Age", 0, 120)
if not valid then error(err) end

valid, err = Validator:isFunction(callback, "Callback")

-- String validation
valid, err = Validator:isStringLength(name, "Name", 3, 20)
valid, err = Validator:matches(email, "^[%w%.]+@[%w%.]+$", "Email")

-- Object validation
valid, err = Validator:hasRequiredFields(
    config,
    "Config",
    {"name", "value", "callback"}
)

-- Bulk validation
valid, err = Validator:validateMultiple({
    {"username", Validator.isString, {value, "Username"}},
    {"age", Validator.isNumber, {value, "Age", 18, 99}},
})
```

---

## Architecture

```
src/
├── core/
│   ├── Logger.lua          # Logging system
│   ├── ErrorHandler.lua    # Error management
│   └── EventBus.lua        # Event system
├── utils/
│   ├── DesignTokens.lua    # Design system
│   ├── InitHelper.lua      # Setup utilities
│   ├── LazyLoader.lua      # Lazy loading
│   ├── Profiler.lua        # Performance profiling
│   ├── ObjectPool.lua      # Object pooling
│   └── Validator.lua       # Input validation
├── config/
│   └── DefaultConfig.lua   # Configuration
├── components/             # UI components
├── elements/               # Element implementations
├── modules/                # Business logic
├── themes/                 # Theme definitions
└── Init.lua                # Main entry point

tests/
└── TestSuite.lua           # Comprehensive tests

docs/
├── ARCHITECTURE.md         # Architecture guide
├── API.md                  # API reference
└── CONTRIBUTING.md         # Contributing guide
```

---

## Best Practices

### 1. Use DesignTokens Instead of Magic Values

```lua
-- ❌ Bad
button.Size = UDim2.fromOffset(24, 24)
button.BackgroundColor3 = Color3.fromHex("#30FF6A")

-- ✅ Good
button.Size = DesignTokens.Size.MD
button.BackgroundColor3 = DesignTokens.Colors.Primary
```

### 2. Use ErrorHandler for Safe Operations

```lua
-- ❌ Bad
local result = risky_function()

-- ✅ Good
local success, result = ErrorHandler:safeCall(risky_function, "Operation")
if not success then
    Logger:error("Operation failed")
end
```

### 3. Use Lazy Loading for Heavy Modules

```lua
-- ❌ Bad
local Button = require("src/elements/Button")
local Input = require("src/elements/Input")
local Slider = require("src/elements/Slider")

-- ✅ Good
local Button = LazyLoader:load("src/elements/Button")
local Input = LazyLoader:load("src/elements/Input")
local Slider = LazyLoader:load("src/elements/Slider")
```

### 4. Validate User Input

```lua
function CreateUser(name, email, age)
    local valid, err = Validator:validateMultiple({
        {"name", Validator.isStringLength, {name, "Name", 2, 50}},
        {"email", Validator.matches, {email, "^[%w%.]+@[%w%.]+$", "Email"}},
        {"age", Validator.isNumber, {age, "Age", 13, 120}},
    })
    
    if not valid then
        error(err)
    end
    
    -- Create user
end
```

### 5. Use EventBus for Decoupled Communication

```lua
-- Emitter
local function saveConfig(config)
    -- ... save logic ...
    EventBus:emit("config-saved", configName)
end

-- Listener
EventBus:on("config-saved", function(configName)
    Logger:info("Config saved: " .. configName)
end)
```

---

## Performance Tips

1. **Use ObjectPool** for frequently created/destroyed objects
2. **Use Profiler** to identify bottlenecks
3. **Use LazyLoader** for optional/heavy modules
4. **Use DesignTokens** to avoid repeated calculations
5. **Use ErrorHandler:tryWithRetry** for flaky operations
6. **Monitor Logger levels** in production

---

## Troubleshooting

### Module Not Found

```lua
-- Ensure correct path relative to script location
local Logger = require(script.Parent:WaitForChild("src"):WaitForChild("core"):WaitForChild("Logger"))
```

### Performance Issues

```lua
-- Use Profiler to identify slow code
Profiler:printReport()

-- Use LazyLoader instead of require all at once
local module = LazyLoader:load("path/to/module")
```

### Memory Leaks

```lua
-- Use ObjectPool for frequently created objects
local pool = ObjectPool:new(100, createObject)

-- Always cleanup event listeners
local cleanup = EventBus:on("event", callback)
-- Later:
cleanup()
```

---

## Migration from WindUI

OxigenUI is backward compatible with WindUI while adding:

- Better error handling
- Performance profiling
- Lazy loading
- Input validation
- Centralized logging
- Event system
- Design tokens

Simply update your requires:

```lua
-- Old
local WindUI = require("WindUI/Init")

-- New (with enhancements)
local InitHelper = require("src/utils/InitHelper")
local WindUI = InitHelper:loadWindUI()
```

---

## Support

- GitHub Issues: [OxigenUI Issues](https://github.com/NaityHS/OxigenUI/issues)
- Discord: [Development Hub](https://discord.gg/ftgs-development-hub-1300692552005189632)

---

**Version:** 1.6.66 | **License:** MIT
