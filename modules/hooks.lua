local log = require 'utils.logger'

--- Generate a unique Listener ID
-- @param resource string - Invoking Resource Name
-- @return string - Generated Listener id
local function generateListenerId(resource)
    local randomPart = string.format(
        "%08x-%04x-%04x-%04x-%012x",
        math.random(0, 0xffffffff),
        math.random(0, 0xffff),
        math.random(0, 0xffff),
        math.random(0, 0xffff),
        math.random(0, 0xffffffffffff)
    )

    return ("%s-%s"):format(resource, randomPart)
end

if IsDuplicityVersion() then
    local Hooks = Hooks or {}
    local Hook = {}

    --- Register a listener for a hook
    -- @param hookName string - The name of the hook to listen to
    -- @param callback function - The function to run when the hook is triggered
    -- @return string - The unique Listener ID assigned to this callback
    function Hook.Listen(hookName, callback)
        local invokingResource = GetCurrentResourceName()
        Hooks[hookName] = Hooks[hookName] or {}

        local hookId = generateListenerId(invokingResource)
        Hooks[hookName][hookId] = {
            resource = invokingResource,
            func = callback
        }

        log.debug(('Registered hook listener %s on %s'):format(hookId, hookName))
        return hookId
    end

    --- Trigger a hook and run all registered listeners
    -- @param hookName string - The name of the hook to trigger
    -- @param payload any - Data passed to each listener callback (commonly a table)
    -- @return boolean, string|nil - Returns true if all listeners passed,
    function Hook.Trigger(hookName, ...)
        if not Hooks[hookName] then
            Hooks[hookName] = {}
        end

        for hookId, listener in pairs(Hooks[hookName]) do
            local ok, result, err = pcall(listener.func, ...)
                if not ok then
                log.error(('Hook %s from %s errored: %s'):format(hookId, listener.resource, result))
                return false, result
            elseif result == false then
                return false, err
            end
        end

        return true
    end

    --- Delete a registered hook listener by its ID
    -- @param hookId string - The unique Listener ID returned from hook.on
    -- @return boolean - Returns true if the listener was successfully deleted, false otherwise
    function Hook.Delete(hookId)
    for hookName, listeners in pairs(Hooks) do
        if listeners[hookId] then
            listeners[hookId] = nil
            log.debug(('Deleted hook %s from %s'):format(hookId, hookName))
            return true
        end
    end

    return false
    end

    --- Cleanup hooks when a resource stops
    -- Automatically removes all listeners registered by the stopped resource
    AddEventHandler('onResourceStop', function(resourceName)
        for hookName, listeners in pairs(Hooks) do
            for listenerId, data in pairs(listeners) do
                if data.resource == resourceName then
                    log.debug('Deleting Hook', hookName, 'as invoked resource was stopped.')
                    Hooks[hookName] = nil
                end
            end
        end
    end)

    -- Returns functions to calling resource
    return Hook
else
    log.warn('The Hooks module is server side only. Importing on client will have no effect.')
    return
end