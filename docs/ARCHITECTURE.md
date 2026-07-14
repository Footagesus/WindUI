# OxigenUI Architecture Guide

## Overview

OxigenUI is built with a **modular, layered architecture** designed for:

- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features
- **Performance**: Lazy loading and efficient resource use
- **Reliability**: Comprehensive error handling
- **Testability**: Independent, mockable modules

---

## Layer Architecture

```
┌─────────────────────────────────────────┐
│   Application Layer                     │
│   (main.lua, main.client.lua, etc)     │
├─────────────────────────────────────────┤
│   Component Layer                       │
│   (UI Components, Elements)             │
├─────────────────────────────────────────┤
│   Service Layer                         │
│   (Business Logic, State Management)   │
├─────────────────────────────────────────┤
│   Utility Layer                         │
│   (Validators, Profilers, Loaders)    │
├─────────────────────────────────────────┤
│   Core Layer                            │
│   (Logger, ErrorHandler, EventBus)     │
├─────────────────────────────────────────┤
│   Configuration Layer                   │
│   (Design Tokens, Default Config)      │
└─────────────────────────────────────────┘
```

---

## Core Layer (`src/core/`)

Provides fundamental infrastructure.

### Logger

**Responsibility**: Unified logging with severity levels

```lua
Logger:debug("Detailed info for debugging")
Logger:info("General informational message")
Logger:warn("Warning that something might be wrong")
Logger:error("Error that needs attention")
```

### ErrorHandler

**Responsibility**: Safe execution, retry logic, error management

```lua
local success, result = ErrorHandler:safeCall(fn, context, ...)
local success, result = ErrorHandler:tryWithRetry(fn, maxRetries, delay, context)
ErrorHandler:onError(callback)
```

### EventBus

**Responsibility**: Decoupled event communication

```lua
EventBus:on("event", callback, priority)
EventBus:emit("event", args)
EventBus:once("event", callback)
```

---

## Configuration Layer (`src/config/`)

Provides design system and configuration.

### DesignTokens

**Responsibility**: Centralized design system

- **Colors**: 50+ semantic colors
- **Spacing**: Consistent spacing scale
- **Typography**: Font sizes and weights
- **Animation**: Duration and easing values
- **Shadows**: Shadow opacity levels

### DefaultConfig

**Responsibility**: Application defaults

- Feature flags
- Performance limits
- Storage settings
- API configuration

---

## Utility Layer (`src/utils/`)

Provides reusable tools and helpers.

### LazyLoader

**Responsibility**: On-demand module loading

**Benefits**:
- Reduced startup time
- Circular dependency prevention
- Automatic caching

### Profiler

**Responsibility**: Performance measurement and analysis

**Features**:
- Function timing
- Statistics collection
- Performance reports

### ObjectPool

**Responsibility**: Memory-efficient object reuse

**Benefits**:
- Reduced garbage collection
- Consistent performance
- Lower memory usage

### Validator

**Responsibility**: Input validation and type checking

**Capabilities**:
- Type validation
- Range checking
- Pattern matching
- Required field checking

### InitHelper

**Responsibility**: Simplified initialization

**Functions**:
- LoadWindUI with fallbacks
- Standard window creation
- Element setup
- Common components

---

## Service Layer (`src/modules/`)

Contains business logic and state management.

### Example Structure

```lua
-- src/modules/ConfigManager.lua
local ConfigManager = {}

function ConfigManager:save(name, data)
    ErrorHandler:safeCall(function()
        -- Save logic
    end, "Save Config")
end

function ConfigManager:load(name)
    return ErrorHandler:safeCall(function()
        -- Load logic
    end, "Load Config")
end

return ConfigManager
```

---

## Component Layer (`src/components/`, `src/elements/`)

UI components built on base infrastructure.

### Design Pattern

```lua
local Button = {}

function Button:new(config)
    ErrorHandler:assert(type(config) == "table", "Config must be table")
    
    local self = setmetatable({}, {__index = Button})
    
    -- Validate input
    Validator:validateMultiple({
        {"Title", Validator.isString, {config.Title, "Title"}},
        {"Callback", Validator.isFunction, {config.Callback, "Callback"}},
    })
    
    self.Title = config.Title
    self.Callback = config.Callback
    self.Color = config.Color or DesignTokens.Colors.Primary
    
    -- Emit event
    EventBus:emit("button-created", self)
    
    return self
end

function Button:click()
    ErrorHandler:safeCall(self.Callback, "Button Click")
end

return Button
```

---

## Data Flow

```
User Input
    ↓
[Event Emitted]
    ↓ EventBus
[Component Receives]
    ↓
[Validate Input] ← Validator
    ↓
[Execute Logic] ← ErrorHandler
    ↓
[Update State]
    ↓
[Emit Event]
    ↓
UI Update
```

---

## Error Handling Strategy

### Hierarchy

1. **Prevent Errors**: Use Validator
2. **Handle Gracefully**: Use ErrorHandler
3. **Log Issues**: Use Logger
4. **Notify User**: Use Notifications

### Example

```lua
function CreateUser(config)
    -- 1. Validate
    local valid, err = Validator:validateMultiple({...})
    if not valid then
        Logger:warn("Invalid user config: " .. err)
        return false, err
    end
    
    -- 2. Handle
    local success, result = ErrorHandler:safeCall(function()
        return createUserInDatabase(config)
    end, "Create User")
    
    -- 3. Log
    if success then
        Logger:info("User created: " .. result.id)
    else
        Logger:error("Failed to create user")
    end
    
    return success, result
end
```

---

## Performance Optimizations

### 1. Lazy Loading

```lua
-- Load only when needed
local Button = LazyLoader:load("src/elements/Button")
```

### 2. Object Pooling

```lua
-- Reuse objects
local obj = pool:acquire()
-- ... use object ...
pool:release(obj)
```

### 3. Event Aggregation

```lua
-- Combine multiple events
EventBus:on("update", function() render() end)
```

### 4. Profiling

```lua
-- Identify bottlenecks
Profiler:measure("expensive-op", function()
    -- code
end)
```

---

## Extension Points

### Add New Module

1. Create in appropriate layer
2. Use core modules
3. Export interface
4. Add tests

### Add New Component

1. Extend from base pattern
2. Use DesignTokens
3. Validate inputs
4. Handle errors
5. Emit events

### Add New Theme

1. Extend DesignTokens
2. Add color palette
3. Export configuration
4. Test with components

---

## Testing Strategy

### Unit Tests

```lua
-- tests/TestSuite.lua
function tests.testLogger()
    Logger:setLevel(Logger.Level.DEBUG)
    assert(Logger.currentLevel == Logger.Level.DEBUG)
end
```

### Integration Tests

```lua
function tests.testWindowCreation()
    local window = InitHelper:createStandardWindow(WindUI, {})
    assert(window, "Window should be created")
end
```

### Performance Tests

```lua
function tests.testPerformance()
    local duration = Profiler:measure("operation", function()
        -- test code
    end)
    assert(duration < 100, "Should complete in <100ms")
end
```

---

## Best Practices

### 1. Use Dependency Injection

```lua
-- Good
function Component:new(windUI, config)
    self.windUI = windUI
end

-- Avoid globals
```

### 2. Single Responsibility

```lua
-- Logger only logs
-- ErrorHandler only handles errors
-- Validator only validates
```

### 3. Composition Over Inheritance

```lua
-- Create components from modules
local button = createButton(InitHelper, DesignTokens, config)
```

### 4. Immutable Configuration

```lua
-- Clone config to prevent mutations
local config = table.clone(defaultConfig)
config.customValue = value
```

---

## Future Enhancements

- [ ] Redux-style state management
- [ ] Component composition system
- [ ] Server-side components
- [ ] Animation system
- [ ] Accessibility features
- [ ] i18n support
- [ ] Plugin system

---

**Version:** 1.6.66 | **License:** MIT
