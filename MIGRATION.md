# OxigenUI Migration Guide

## From WindUI to OxigenUI Enhanced

This guide helps you migrate from standard WindUI to OxigenUI with the new architecture.

## Table of Contents

1. [Overview](#overview)
2. [Step-by-Step Migration](#step-by-step-migration)
3. [API Changes](#api-changes)
4. [Best Practices](#best-practices)
5. [Troubleshooting](#troubleshooting)

---

## Overview

### What's Compatible

✅ All existing WindUI code works unchanged
✅ All existing components available
✅ All existing themes available
✅ New modules are additive

### What's Enhanced

✨ Better error handling with ErrorHandler
✨ Centralized design system with DesignTokens
✨ Lazy loading with LazyLoader
✨ Event system with EventBus
✨ Input validation with Validator
✨ Performance profiling with Profiler
✨ Object pooling with ObjectPool
✨ Logging with Logger

---

## Step-by-Step Migration

### Step 1: Update Imports

**Before:**
```lua
local WindUI = require("./src/Init")
```

**After:**
```lua
local InitHelper = require("src/utils/InitHelper")
local WindUI = InitHelper:loadWindUI()

-- Optional: Import new utilities
local DesignTokens = require("src/utils/DesignTokens")
local Logger = require("src/core/Logger")
local ErrorHandler = require("src/core/ErrorHandler")
```

### Step 2: Replace Magic Values

**Before:**
```lua
local button = window:Button({
    Title = "Click Me",
    Color = Color3.fromHex("#30FF6A"),
    Size = UDim2.fromOffset(24, 24),
})
```

**After:**
```lua
local button = window:Button({
    Title = "Click Me",
    Color = DesignTokens.Colors.Primary,
    Size = DesignTokens.Size.MD,
})
```

### Step 3: Add Error Handling

**Before:**
```lua
local result = riskySomeOperation()
```

**After:**
```lua
local success, result = ErrorHandler:safeCall(
    riskySomeOperation,
    "My Operation"
)

if not success then
    Logger:error("Operation failed: %s", result)
end
```

### Step 4: Add Logging

**Before:**
```lua
print("Window created")
warn("Something might be wrong")
```

**After:**
```lua
Logger:info("Window created")
Logger:warn("Something might be wrong")
```

### Step 5: Use Event System (Optional)

**Before:**
```lua
local signal = Instance.new("BindableEvent")
local conn = signal:Connect(function(value)
    print(value)
end)
signal:Fire(42)
```

**After:**
```lua
local cleanup = EventBus:on("my-event", function(value)
    print(value)
end)
EventBus:emit("my-event", 42)
cleanup()  -- or EventBus:off("my-event", callback)
```

---

## API Changes

### New APIs

#### Logger
```lua
Logger:setLevel(Logger.Level.DEBUG)
Logger:debug(msg, ...)
Logger:info(msg, ...)
Logger:warn(msg, ...)
Logger:error(msg, ...)
```

#### ErrorHandler
```lua
ErrorHandler:safeCall(fn, context, ...)
ErrorHandler:tryWithRetry(fn, maxRetries, delay, context)
ErrorHandler:wrap(fn, context)
ErrorHandler:onError(callback)
```

#### EventBus
```lua
EventBus:on(name, callback, priority)
EventBus:once(name, callback, priority)
EventBus:off(name, callback)
EventBus:emit(name, ...)
EventBus:listenerCount(name)
```

#### DesignTokens
```lua
DesignTokens:getColor(name)
DesignTokens:getSpacing(name)
DesignTokens:getTypography(name)
DesignTokens:createGradient(color1, color2)
```

#### Validator
```lua
Validator:isString(value, field)
Validator:isNumber(value, field, min, max)
Validator:isBoolean(value, field)
Validator:isTable(value, field)
Validator:isFunction(value, field)
Validator:validateMultiple(conditions)
```

#### LazyLoader
```lua
LazyLoader:load(path)
LazyLoader:preload(paths)
LazyLoader:isLoaded(path)
LazyLoader:unload(path)
```

#### Profiler
```lua
Profiler:measure(name, fn, ...)
Profiler:start(name)
Profiler:stop(name)
Profiler:getStats(name)
Profiler:printReport(limit)
```

#### ObjectPool
```lua
local pool = ObjectPool:new(size, factory)
pool:acquire()
pool:release(obj)
pool:getStats()
```

#### InitHelper
```lua
InitHelper:loadWindUI()
InitHelper:createStandardWindow(windUI, config)
InitHelper:setupWindowElements(window, config)
InitHelper:addThemeSwitcher(window, windUI)
```

### Unchanged APIs

All existing WindUI APIs remain unchanged:

```lua
window:CreateWindow(config)
window:Tab(config)
window:Section(config)
window:Button(config)
window:Toggle(config)
window:Slider(config)
window:Input(config)
window:Dropdown(config)
-- ... and all other existing components
```

---

## Best Practices

### 1. Always Use DesignTokens

```lua
-- ❌ Bad
color = Color3.fromHex("#30FF6A")

-- ✅ Good
color = DesignTokens.Colors.Primary
```

### 2. Always Use ErrorHandler

```lua
-- ❌ Bad
local result = riskyFunction()

-- ✅ Good
local success, result = ErrorHandler:safeCall(riskyFunction, "Operation")
```

### 3. Use Logging Instead of Print

```lua
-- ❌ Bad
print("Done")
warn("Error")

-- ✅ Good
Logger:info("Done")
Logger:warn("Error")
```

### 4. Validate User Input

```lua
-- ❌ Bad
local config = userInput

-- ✅ Good
local valid, err = Validator:isTable(userInput, "config")
if not valid then error(err) end
```

### 5. Use Events Instead of Signals

```lua
-- ❌ Bad
local signal = Instance.new("BindableEvent")
signal:Connect(fn)

-- ✅ Good
EventBus:on("event", fn)
```

---

## Troubleshooting

### Issue: Module Not Found

**Symptom:** "Module not found" error

**Solution:**
```lua
-- Use correct relative path
local Logger = require(script.Parent:WaitForChild("src"):WaitForChild("core"):WaitForChild("Logger"))
```

### Issue: Performance Slow

**Symptom:** Laggy UI

**Solution:**
```lua
-- Profile to identify bottleneck
Profiler:measure("slow-operation", function()
    -- code
end)
Profiler:printReport()

-- Use LazyLoader for heavy modules
local Module = LazyLoader:load("path/to/module")
```

### Issue: Memory Leaks

**Symptom:** Growing memory usage

**Solution:**
```lua
-- Use ObjectPool for frequently created objects
local pool = ObjectPool:new(100, createObject)

-- Clean up event listeners
local cleanup = EventBus:on("event", callback)
cleanup()  -- Don't forget to clean up!
```

### Issue: Crashes

**Symptom:** Script stops working

**Solution:**
```lua
-- Wrap risky code
local success, result = ErrorHandler:safeCall(function()
    -- risky code
end, "Operation Name")

if not success then
    Logger:error("Crashed: %s", result)
end
```

---

## Common Patterns

### Initialize App

```lua
local InitHelper = require("src/utils/InitHelper")
local WindUI = InitHelper:loadWindUI()
local window = InitHelper:createStandardWindow(WindUI, {
    Title = "My App",
})
InitHelper:setupWindowElements(window, {
    Tags = { { Title = "v1.0" } },
})
```

### Handle Configuration

```lua
local function setupConfig(config)
    local valid, err = Validator:validateMultiple({
        {"name", Validator.isString, {config.name, "name"}},
        {"value", Validator.isNumber, {config.value, "value"}},
    })
    
    if not valid then
        Logger:error("Invalid config: %s", err)
        return false
    end
    
    Logger:info("Config loaded: %s", config.name)
    return true
end
```

### Create Reusable Component

```lua
local function createButton(parent, title, callback)
    return parent:Button({
        Title = title,
        Color = DesignTokens.Colors.Primary,
        Icon = "check",
        Callback = function()
            local success, result = ErrorHandler:safeCall(
                callback,
                "Button: " .. title
            )
            if success then
                Logger:info("Button clicked: %s", title)
            end
        end,
    })
end
```

---

## Timeline

### Day 1: Basic Migration
- [ ] Update imports
- [ ] Replace magic values
- [ ] Add error handling

### Day 2: Enhanced Features
- [ ] Add logging
- [ ] Use event system
- [ ] Input validation

### Day 3: Optimization
- [ ] Performance profiling
- [ ] Object pooling
- [ ] Lazy loading

---

## Support

- **Documentation:** `docs/`
- **Examples:** `main_refactored.lua`
- **Tests:** `tests/TestSuite.lua`
- **Issues:** GitHub Issues
- **Chat:** Discord

---

**Estimated Migration Time:** 2-4 hours per project
**Difficulty:** Easy to Medium
**Benefits:** 10x Better code quality!

---

Need help? Check the examples or open an issue!
