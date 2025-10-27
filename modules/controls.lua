if IsDuplicityVersion() then
    local logger = require 'utils.logger'
    logger.warn('The Controls module is client side only. Importing on server will have no effect.')
    
    return
else
    local config = require 'data.config'
    local bridge = require ('bridge.controls.' .. config.Controls .. '.client')

    return bridge
end