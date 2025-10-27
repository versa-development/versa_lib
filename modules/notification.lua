if IsDuplicityVersion() then
    local Notification = {}

    function Notification.Send(source, data)
        TriggerClientEvent('versa_sdk:client:notification', source, data)
    end

    return Notification
else
    local config = require 'data.config'
    local bridge = require ('bridge.notification.' .. config.Notification .. '.client')

    return bridge
end