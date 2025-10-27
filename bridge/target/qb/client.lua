local bridge = {}
local helper = require 'utils/target'

--- format the target data from the input
-- @param data table
-- @return table
local function formatTargetData(data)
  if not data.title then error('Missing title property in target data') end
  if not data.event then error('Missing event property in target data') end

  return {
    label = data.title,
    type = 'client',
    icon = data.icon or 'fa-solid fa-circle',
    canInteract = data.canInteract or nil,
    action = function()
      local event = data.event.type == 'client' and TriggerEvent or TriggerServerEvent
      local eventName = data.event.name or error('Missing event name in target data')
      local parameters = data.event.parameters or {}

      event(eventName, table.unpack(parameters))
    end
  }
end

--- add a target to an entity or multiple entities
-- @param data table
-- @return any
function bridge.AddEntity(data)
  local entities = helper.getEntitiesData(data)
  local targetOptions = formatTargetData(data)

  exports['qb-target']:AddTargetEntity(entities, {
    options = targetOptions,
    distance = targetOptions.distance or 2.5
  })
end

--- remove a target from an entity or multiple entities
-- @param data table
-- @return any
function bridge.RemoveEntity(data)
  local entities = helper.getEntitiesData(data)

  return exports['qb-target']:RemoveTargetEntity(entities, { })
end

-- Send the module object
return bridge