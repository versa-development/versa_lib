local ox = {}
local helper = require '@versa_sdk.utils.target'

--- format the target data from the input
-- @param data table
-- @return table
local function formatTargetData(data)
  if not data.title then error('Missing title property in target data') end
  if not data.event then error('Missing event property in target data') end

  return {
    name = 'sdk',
    label = data.title,
    icon = data.icon or 'fa-solid fa-circle',
    distance = data.distance or 2.5,
    canInteract = data.canInteract or nil,
    items = data.items or nil,
    anyItem = data.anyItem or false,
    onSelect = function()
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
function ox.addEntity(data)
  local entities = helper.getEntitiesData(data)
  local targetOptions = formatTargetData(data)

  return exports.ox_target:addLocalEntity(entities, targetOptions)
end

--- remove a target from an entity or multiple entities
-- @param data table
-- @return any
function ox.removeEntity(data)
  local entities = helper.getEntitiesData(data)

  return exports.ox_target:removeLocalEntity(entities, 'sdk')
end

-- Send the module object
return ox