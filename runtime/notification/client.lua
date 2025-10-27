local Notification = require 'modules/notification'

RegisterNetEvent('versa_sdk:client:notification', function(payload)
    Notification.Send(payload)
end)