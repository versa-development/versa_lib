if IsDuplicityVersion() then
    local config = require 'data.config'
    local bridge = require ('bridge.framework.' .. config.Framework .. '.server')

    return bridge
else
    local logger = require 'utils.logger'
    logger.warn('The Framework module is server side only. Importing on client will have no effect.')
    
    return
end