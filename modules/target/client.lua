local config = require 'data.config'
local targetBridge = require ('bridge.target.' .. config.Target .. '.client')

return targetBridge