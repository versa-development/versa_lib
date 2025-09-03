local config = require 'data.config'
local frameworkBridge = require ('bridge.framework.' .. config.Framework .. '.server')

return frameworkBridge