local config = require 'data.config'
local controlsBridge = require ('bridge.controls.' .. config.Controls .. '.client')

return controlsBridge