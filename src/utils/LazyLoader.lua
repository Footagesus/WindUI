--[[
    LazyLoader Module
    Lazy-loads modules on-demand to improve startup performance
]]

local LazyLoader = {}
local loadedModules = {}
local loadingModules = {}
local moduleMetadata = {}

--[[
    Load a module with caching
    @param modulePath string - Path to module
    @return any - Loaded module
]]
function LazyLoader:load(modulePath)
    -- Return cached module if already loaded
    if loadedModules[modulePath] then
        return loadedModules[modulePath]
    end
    
    -- Prevent circular dependencies
    if loadingModules[modulePath] then
        error(string.format("Circular dependency detected for module: %s", modulePath))
    end
    
    loadingModules[modulePath] = true
    
    local success, module = pcall(function()
        return require(modulePath)
    end)
    
    loadingModules[modulePath] = nil
    
    if not success then
        error(string.format("Failed to load module %s: %s", modulePath, tostring(module)))
    end
    
    loadedModules[modulePath] = module
    moduleMetadata[modulePath] = {
        loadedAt = tick(),
        size = string.len(tostring(module)),
    }
    
    return module
end

--[[
    Preload multiple modules
    @param modulePaths table - Array of module paths
]]
function LazyLoader:preload(modulePaths)
    for _, path in ipairs(modulePaths) do
        self:load(path)
    end
end

--[[
    Unload a module from cache
    @param modulePath string - Path to module
]]
function LazyLoader:unload(modulePath)
    loadedModules[modulePath] = nil
    moduleMetadata[modulePath] = nil
end

--[[
    Clear all loaded modules
]]
function LazyLoader:clearCache()
    loadedModules = {}
    moduleMetadata = {}
end

--[[
    Get module metadata
    @param modulePath string - Path to module
    @return table - Module metadata
]]
function LazyLoader:getMetadata(modulePath)
    return moduleMetadata[modulePath]
end

--[[
    Get all loaded modules
    @return table - Loaded modules
]]
function LazyLoader:getLoadedModules()
    return loadedModules
end

--[[
    Check if module is loaded
    @param modulePath string - Path to module
    @return boolean - Is module loaded
]]
function LazyLoader:isLoaded(modulePath)
    return loadedModules[modulePath] ~= nil
end

return LazyLoader
