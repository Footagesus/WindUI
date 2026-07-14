--[[
    ObjectPool Module
    Object pooling for memory-efficient reuse of objects
]]

local ObjectPool = {}

--[[
    Create a new object pool
    @param initialSize number - Initial size of the pool
    @param factory function - Factory function to create objects
    @return table - Object pool instance
]]
function ObjectPool:new(initialSize, factory)
    local pool = {
        available = {},
        inUse = {},
        factory = factory,
        created = 0,
        acquiredCount = 0,
        releasedCount = 0,
    }
    
    setmetatable(pool, self)
    self.__index = self
    
    -- Pre-allocate objects
    for _ = 1, initialSize or 10 do
        table.insert(pool.available, factory())
        pool.created = pool.created + 1
    end
    
    return pool
end

--[[
    Acquire an object from the pool
    @return any - Object from pool or newly created
]]
function ObjectPool:acquire()
    local obj
    
    if #self.available > 0 then
        obj = table.remove(self.available)
    else
        obj = self.factory()
        self.created = self.created + 1
    end
    
    table.insert(self.inUse, obj)
    self.acquiredCount = self.acquiredCount + 1
    
    return obj
end

--[[
    Release an object back to the pool
    @param obj any - Object to release
]]
function ObjectPool:release(obj)
    local idx = table.find(self.inUse, obj)
    
    if idx then
        table.remove(self.inUse, idx)
        table.insert(self.available, obj)
        self.releasedCount = self.releasedCount + 1
        
        -- Reset object if it has a reset method
        if obj.reset and type(obj.reset) == "function" then
            obj:reset()
        end
    end
end

--[[
    Get pool statistics
    @return table - Statistics
]]
function ObjectPool:getStats()
    return {
        available = #self.available,
        inUse = #self.inUse,
        total = self.created,
        acquired = self.acquiredCount,
        released = self.releasedCount,
    }
end

--[[
    Clear the pool
]]
function ObjectPool:clear()
    self.available = {}
    self.inUse = {}
end

--[[
    Get all available objects
    @return table - Available objects
]]
function ObjectPool:getAvailable()
    return self.available
end

--[[
    Get all in-use objects
    @return table - In-use objects
]]
function ObjectPool:getInUse()
    return self.inUse
end

return ObjectPool
