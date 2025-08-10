local cloneref = cloneref or function(v) return v end

local GetService = {}
local Cache = setmetatable({}, {__mode = "v"})

setmetatable(GetService, {
    __index = function(_, ServiceName)
        if type(ServiceName) ~= "string" then error("GetService expects string key", 2) end
        local cached = Cache[ServiceName]
        if cached then return cached end
        local success, service = pcall(game.GetService, game, ServiceName)
        if not success or not service then error(("Service '%s' not found"):format(ServiceName), 2) end
        local cloned = cloneref(service)
        Cache[ServiceName] = cloned
        return cloned
    end,
    __newindex = function() error("GetService is read-only", 2) end,
    __tostring = function() return "CustomGetService" end,
})

return GetService
