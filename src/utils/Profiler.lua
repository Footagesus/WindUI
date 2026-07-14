--[[
    Profiler Module
    Performance profiling and benchmarking utilities
]]

local Profiler = {}
local measurements = {}
local activeTimers = {}

--[[
    Measure execution time of a function
    @param name string - Name of the measurement
    @param fn function - Function to measure
    @param ... any - Arguments to pass to function
    @return number - Execution time in milliseconds
    @return any - Function result
]]
function Profiler:measure(name, fn, ...)
    local startTime = tick()
    local result = fn(...)
    local duration = (tick() - startTime) * 1000
    
    if not measurements[name] then
        measurements[name] = {
            count = 0,
            total = 0,
            min = math.huge,
            max = -math.huge,
            history = {}
        }
    end
    
    local stat = measurements[name]
    stat.count = stat.count + 1
    stat.total = stat.total + duration
    stat.min = math.min(stat.min, duration)
    stat.max = math.max(stat.max, duration)
    table.insert(stat.history, duration)
    
    -- Keep only last 100 measurements
    if #stat.history > 100 then
        table.remove(stat.history, 1)
    end
    
    return duration, result
end

--[[
    Start a manual timer
    @param name string - Name of the timer
]]
function Profiler:start(name)
    activeTimers[name] = tick()
end

--[[
    Stop a manual timer and get duration
    @param name string - Name of the timer
    @return number - Duration in milliseconds
]]
function Profiler:stop(name)
    if not activeTimers[name] then
        return 0
    end
    
    local duration = (tick() - activeTimers[name]) * 1000
    activeTimers[name] = nil
    
    return duration
end

--[[
    Get statistics for a measurement
    @param name string - Name of the measurement
    @return table - Statistics table
]]
function Profiler:getStats(name)
    local stat = measurements[name]
    if not stat then
        return nil
    end
    
    return {
        name = name,
        count = stat.count,
        total = stat.total,
        average = stat.total / stat.count,
        min = stat.min,
        max = stat.max,
        latest = stat.history[#stat.history],
    }
end

--[[
    Get all measurements
    @return table - All measurements
]]
function Profiler:getAllStats()
    local allStats = {}
    for name, stat in pairs(measurements) do
        table.insert(allStats, {
            name = name,
            count = stat.count,
            total = stat.total,
            average = stat.total / stat.count,
            min = stat.min,
            max = stat.max,
        })
    end
    
    -- Sort by total time (descending)
    table.sort(allStats, function(a, b)
        return a.total > b.total
    end)
    
    return allStats
end

--[[
    Print profiling report
    @param limit number - Max entries to print
]]
function Profiler:printReport(limit)
    limit = limit or 10
    local stats = self:getAllStats()
    
    print("\n" .. string.rep("=", 80))
    print("PROFILER REPORT")
    print(string.rep("=", 80))
    print(string.format("%40s | %12s | %12s | %12s | %12s", "Name", "Count", "Total (ms)", "Avg (ms)", "Max (ms)"))
    print(string.rep("-", 80))
    
    for i = 1, math.min(limit, #stats) do
        local stat = stats[i]
        print(string.format("%40s | %12d | %12.2f | %12.2f | %12.2f",
            stat.name:sub(1, 40),
            stat.count,
            stat.total,
            stat.average,
            stat.max
        ))
    end
    
    print(string.rep("=", 80) .. "\n")
end

--[[
    Clear all measurements
]]
function Profiler:clear()
    measurements = {}
    activeTimers = {}
end

return Profiler
