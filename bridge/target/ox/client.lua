local ox = {}
local helper = require '@versa_sdk.utils.target'

--- format the target data from the input
-- @param data table
-- @return table
local function formatTargetData(data)
  local targetObject = {}

  -- ensure data is a table of entries
  if not (type(data) == 'table') then
    data = { data }
  end

  for _, v in ipairs(data) do
    if type(v) ~= 'table' then error('Each target data entry must be a table') end
    if not v.title then error('Missing title property in target data') end
    if not v.event then error('Missing event property in target data') end

    targetObject[#targetObject + 1] = {
      name = 'sdk',
      label = v.title,
      icon = v.icon or 'fa-solid fa-circle',
      distance = v.distance or 2.5,
      canInteract = v.canInteract or nil,
      items = v.items or nil,
      anyItem = v.anyItem or false,
      onSelect = function()
        local event = v.event.type == 'client' and TriggerEvent or TriggerServerEvent
        local eventName = v.event.name or error('Missing event name in target data')
        local parameters = v.event.parameters or {}

        event(eventName, table.unpack(parameters))
      end
    }
  end

  return targetObject
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