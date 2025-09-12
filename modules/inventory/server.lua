-- Only allow server side import
if not IsDuplicityVersion() then
  error('Cannot import server side module to the client')
  return
end


local config = require 'data.config'
local inventoryBridge = require ('bridge.inventory.' .. config.Inventory .. '.server')

return inventoryBridge