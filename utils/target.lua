local target = {}

--- format the entities data from the input
-- @param data table
-- @return table
function target.getEntitiesData(data)
  local entities = {}
  if data.entity then
    table.insert(entities, data.entity)
  end

  if data.entities then
    for _, entity in ipairs(data.entities) do
      table.insert(entities, entity)
    end
  end

  return entities
end

return target