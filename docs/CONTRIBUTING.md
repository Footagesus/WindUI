# Contributing to OxigenUI

Thank you for your interest in contributing to OxigenUI! This guide will help you get started.

## Code of Conduct

- Be respectful and constructive
- Follow the existing code style
- Write clear commit messages
- Test your changes
- Document new features

## Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Run tests: `lua tests/TestSuite.lua`
5. Commit: `git commit -m "feat: Add my feature"`
6. Push: `git push origin feature/my-feature`
7. Create a Pull Request

## Code Style

### Naming Conventions

```lua
-- Functions: camelCase
function Module:myFunction()
end

-- Constants: UPPER_SNAKE_CASE
local MAX_RETRIES = 3

-- Local variables: camelCase
local myVariable = 42

-- Modules: PascalCase
local MyModule = {}
```

### Documentation

All public functions must have JSDoc-style comments:

```lua
--[[
    Brief description of what the function does
    
    Longer description if needed.
    
    @param param1 string - Description of param1
    @param param2 number - Description of param2
    @param param3 boolean - Optional description
    @return string - Description of return value
    @return boolean - Success status
]]
function Module:myFunction(param1, param2, param3)
    -- implementation
end
```

### Error Handling

Always use ErrorHandler for risky operations:

```lua
local success, result = ErrorHandler:safeCall(function()
    -- risky code
end, "Context Name")

if not success then
    Logger:error("Operation failed: %s", result)
    return false
end
```

### Logging

Use Logger with appropriate levels:

```lua
Logger:debug("Detailed debug info")
Logger:info("General information")
Logger:warn("Warning condition")
Logger:error("Error occurred")
```

### Input Validation

Validate all inputs:

```lua
function Module:process(config)
    local valid, err = Validator:validateMultiple({
        {"name", Validator.isString, {config.name, "name"}},
        {"value", Validator.isNumber, {config.value, "value", 0, 100}},
    })
    
    if not valid then
        Logger:error(err)
        return false, err
    end
end
```

## Project Structure

### Adding a New Module

1. Create file in appropriate directory
2. Use core modules (Logger, ErrorHandler, EventBus)
3. Add JSDoc comments
4. Export the module
5. Add tests in `tests/`
6. Update `docs/API.md`

### Example New Module

```lua
-- src/modules/MyModule.lua
local Logger = require(script.Parent.Parent:WaitForChild("core"):WaitForChild("Logger"))
local ErrorHandler = require(script.Parent.Parent:WaitForChild("core"):WaitForChild("ErrorHandler"))
local Validator = require(script.Parent.Parent:WaitForChild("utils"):WaitForChild("Validator"))

local MyModule = {}

--[[
    Does something important
    
    @param config table - Configuration table
    @return boolean - Success status
]]
function MyModule:doSomething(config)
    -- Validate
    local valid, err = Validator:isTable(config, "config")
    if not valid then
        Logger:error(err)
        return false
    end
    
    -- Execute
    local success, result = ErrorHandler:safeCall(function()
        -- implementation
        return true
    end, "MyModule:doSomething")
    
    if success then
        Logger:info("Operation successful")
    else
        Logger:error("Operation failed")
    end
    
    return success
end

return MyModule
```

### Adding Tests

Add test functions to `tests/TestSuite.lua`:

```lua
function tests.testMyModule()
    local MyModule = require("path/to/MyModule")
    
    -- Test case 1
    local result = MyModule:doSomething({value = 42})
    assert(result, "Should return true")
    
    -- Test case 2
    local result2 = MyModule:doSomething({})
    assert(not result2, "Should handle invalid input")
    
    return true
end
```

## Commit Messages

Follow conventional commits format:

```
feat: Add new feature
fix: Fix a bug
docs: Update documentation
test: Add or update tests
refactor: Refactor code
perf: Improve performance
style: Code style changes
chore: Build/dependency updates
```

Examples:

```
feat: Add ObjectPool utility module
fix: Fix ErrorHandler retry logic
docs: Update API documentation
test: Add TestSuite for core modules
refactor: Split monolithic main.lua
perf: Optimize DesignTokens lookup
```

## Testing

Run the full test suite:

```lua
local tests = require("tests/TestSuite")
local results = tests:runAll()
```

Write tests for:
- Happy path scenarios
- Edge cases
- Error conditions
- Performance-critical code

## Performance Considerations

- Use LazyLoader for heavy modules
- Use ObjectPool for frequently created objects
- Profile with Profiler before optimizing
- Avoid nested loops and callbacks
- Cache expensive computations

## Documentation

Update documentation when:
- Adding new modules
- Changing public APIs
- Adding new features
- Fixing bugs

Documentation files:
- `docs/API.md` - API reference
- `docs/ARCHITECTURE.md` - Architecture guide
- `README.md` - Project overview

## Pull Request Process

1. Update documentation
2. Add/update tests
3. Run full test suite
4. Get code review
5. Address feedback
6. Merge when approved

## Release Process

1. Update version in `package.json` and `src/config/DefaultConfig.lua`
2. Update `changelog.md`
3. Create git tag
4. Build dist files: `npm run build`
5. Create GitHub release

## Getting Help

- Check existing issues
- Read documentation
- Ask in discussions
- Join Discord community

## License

All contributions are licensed under MIT License

---

Thank you for contributing! 🚀
