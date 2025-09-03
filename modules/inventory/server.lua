local config = require 'data.config'
local inventoryBridge = require ('bridge.inventory.' .. config.Inventory .. '.server')

return inventoryBridge