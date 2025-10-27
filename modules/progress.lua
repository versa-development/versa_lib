if IsDuplicityVersion() then
    local log = require 'utils.logger'
    log.warn('The Inventory module is server side only. Importing on client will have no effect.')
    
    return
else
    local config = require 'data.config'
    local bridge = require ('bridge.progress.' .. config.ProgressBar .. '.client')

    return bridge
end