local config = require 'data.config'
local notificationBridge = require ('bridge.notification.' .. config.Notification .. '.client')

return notificationBridge