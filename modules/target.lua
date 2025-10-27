if IsDuplicityVersion() then
    local log = require 'utils.logger'
    log.warn('The target module is not available on the server side.')
    
    return
else
    local config = require 'data.config'
    local bridge = require ('bridge.target.' .. config.Target .. '.client')

    return bridge
end