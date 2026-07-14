--[[
    Validator Module
    Input validation and type checking utilities
]]

local Validator = {}

--[[
    Validate that a value is a string
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isString(value, fieldName)
    if type(value) ~= "string" then
        return false, string.format("%s must be a string, got %s", fieldName, type(value))
    end
    return true
end

--[[
    Validate that a value is a number
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @param min number - Minimum value (optional)
    @param max number - Maximum value (optional)
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isNumber(value, fieldName, min, max)
    if type(value) ~= "number" then
        return false, string.format("%s must be a number, got %s", fieldName, type(value))
    end
    
    if min and value < min then
        return false, string.format("%s must be >= %d", fieldName, min)
    end
    
    if max and value > max then
        return false, string.format("%s must be <= %d", fieldName, max)
    end
    
    return true
end

--[[
    Validate that a value is a boolean
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isBoolean(value, fieldName)
    if type(value) ~= "boolean" then
        return false, string.format("%s must be a boolean, got %s", fieldName, type(value))
    end
    return true
end

--[[
    Validate that a value is a function
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isFunction(value, fieldName)
    if type(value) ~= "function" then
        return false, string.format("%s must be a function, got %s", fieldName, type(value))
    end
    return true
end

--[[
    Validate that a value is a table
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isTable(value, fieldName)
    if type(value) ~= "table" then
        return false, string.format("%s must be a table, got %s", fieldName, type(value))
    end
    return true
end

--[[
    Validate that a value is not nil
    @param value any - Value to validate
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isNotNil(value, fieldName)
    if value == nil then
        return false, string.format("%s is required", fieldName)
    end
    return true
end

--[[
    Validate string length
    @param value string - Value to validate
    @param fieldName string - Field name for error message
    @param minLength number - Minimum length
    @param maxLength number - Maximum length
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isStringLength(value, fieldName, minLength, maxLength)
    local valid, err = self:isString(value, fieldName)
    if not valid then
        return false, err
    end
    
    local len = string.len(value)
    
    if minLength and len < minLength then
        return false, string.format("%s must be at least %d characters", fieldName, minLength)
    end
    
    if maxLength and len > maxLength then
        return false, string.format("%s must be at most %d characters", fieldName, maxLength)
    end
    
    return true
end

--[[
    Validate array length
    @param value table - Array to validate
    @param fieldName string - Field name for error message
    @param minLength number - Minimum length
    @param maxLength number - Maximum length
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:isArrayLength(value, fieldName, minLength, maxLength)
    local valid, err = self:isTable(value, fieldName)
    if not valid then
        return false, err
    end
    
    local len = #value
    
    if minLength and len < minLength then
        return false, string.format("%s must have at least %d items", fieldName, minLength)
    end
    
    if maxLength and len > maxLength then
        return false, string.format("%s must have at most %d items", fieldName, maxLength)
    end
    
    return true
end

--[[
    Validate an object has required fields
    @param value table - Object to validate
    @param fieldName string - Field name for error message
    @param requiredFields table - Array of required field names
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:hasRequiredFields(value, fieldName, requiredFields)
    local valid, err = self:isTable(value, fieldName)
    if not valid then
        return false, err
    end
    
    for _, field in ipairs(requiredFields) do
        if value[field] == nil then
            return false, string.format("%s missing required field: %s", fieldName, field)
        end
    end
    
    return true
end

--[[
    Validate that a string matches a pattern
    @param value string - Value to validate
    @param pattern string - Pattern to match
    @param fieldName string - Field name for error message
    @return boolean - Is valid
    @return string - Error message if invalid
]]
function Validator:matches(value, pattern, fieldName)
    local valid, err = self:isString(value, fieldName)
    if not valid then
        return false, err
    end
    
    if not string.match(value, pattern) then
        return false, string.format("%s does not match required pattern", fieldName)
    end
    
    return true
end

--[[
    Validate multiple conditions
    @param conditions table - Array of {field, validator, args}
    @return boolean - All valid
    @return string - First error message
]]
function Validator:validateMultiple(conditions)
    for _, condition in ipairs(conditions) do
        local field = condition[1]
        local validator = condition[2]
        local args = condition[3]
        
        local valid, err = validator(self, args[1], field, unpack(args, 2))
        if not valid then
            return false, err
        end
    end
    
    return true
end

return Validator
