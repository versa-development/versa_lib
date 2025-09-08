local config = require 'data.config'
local log = require 'utils.logger'

-- Duplicity checks if the code ran is the server or client. returns true if server
if IsDuplicityVersion() then
  math.randomseed()

  local resourceVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)   -- TODO: VERSION CHECK!
  log.info('Versa SDK v' .. resourceVersion)
end