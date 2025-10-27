if IsDuplicityVersion() then
    local config = require 'config'
    local bridge = require ('bridge.inventory.' .. config.Inventory .. '.server')

    return bridge
else
    local log = require 'utils/logger'
    log.warn('The Inventory module is server side only. Importing on client will have no effect.')
    return
end