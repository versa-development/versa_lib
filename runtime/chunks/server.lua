Chunks = {}

local framework = require '@versa_lib.modules.framework.server'
RegisterCommand('data', function(source)
  local player = framework.getPlayer(source)
  print(json.encode(player, { indent = true }))
end)