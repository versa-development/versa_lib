local config = require 'config'

local Logger = {}

--- Concatenates arguments into a single string, converting each argument to a string.
local function formatLogMessage(...)
  local args = {...}
  for i = 1, #args do
    args[i] = tostring(args[i])
  end
  return '^7' .. table.concat(args, ' ')
end

function Logger.info(...)
  print('^5[INFO] ' .. formatLogMessage(...))
end

function Logger.warn(...)
  print('^3[WARNING] ' .. formatLogMessage(...))
end

function Logger.error(...)
  print('^1[ERROR] ' .. formatLogMessage(...))
end

function Logger.debug(...)
  if config.Debug then
    print('^2[DEBUG] ' .. formatLogMessage(...))
  end
end

return Logger