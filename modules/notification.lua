if IsDuplicityVersion() then
    local Notification = {}

    function Notification.Send(source, data)
        if type(source) ~= 'number' then error('Missing source parameter in Notification.Send, got ' .. type(source)) end
        if type(data) ~= 'table' then error('Missing data parameter in Notification.Send, got ' .. type(data)) end

        TriggerClientEvent('versa_sdk:client:notification', source, data)
    end

    return Notification
else
    local config = require 'data.config'
    local bridge = require ('bridge.notification.' .. config.Notification .. '.client')

    return bridge
end