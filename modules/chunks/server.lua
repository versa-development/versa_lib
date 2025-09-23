-- Only allow server side import
if not IsDuplicityVersion() then
  error('Cannot import server side module to the client')
  return
end

-- Module table
local chunk = {}

--- Validate chunk data before creating/editing
-- @param string type The type of chunk entity ('ped' or 'object')
-- @param table data The chunk entity data
-- @return boolean True if valid, false otherwise
-- @return string|nil Error message if invalid, nil if valid
local function validateChunkData(type, data)
  if type == 'ped' then
    if not data.model or not data.coords then
      return false, 'Invalid ped data, model, coords(vector4) are required'
    end
  elseif type == 'object' then
    if not data.model or not data.coords then
      return false, 'Invalid object data, model, coords(vector4) are required'
    end
  else
    return false, 'Invalid chunk entity type'
  end

  return true
end

--- Create a new chunk entity
-- @param string entityType The type of chunk entity ('ped' or 'object')
-- @param string key The unique key for the chunk entity
-- @param table data The chunk entity data
-- @return boolean True if created successfully, false otherwise
-- @return string|nil Error message if creation failed, nil if successful
function chunk.create(entityType, key, data)
  local isValid, errorMsg = validateChunkData(entityType, data)
  if not isValid then 
    return false, errorMsg 
  end
  
  -- Get the resource calling the function so we can delete on resource stop
  local invokingResource = GetCurrentResourceName()
  data.resource = invokingResource

  local createdChunk, errorMsg = exports.versa_sdk:CreateChunkEntity(entityType, key, data)
  return createdChunk, errorMsg
end

--- Edit an existing chunk entity
-- @param string key The unique key for the chunk entity
-- @param table data The chunk entity data to update
-- @return boolean True if edited successfully, false otherwise
-- @return string|nil Error message if edit failed, nil if successful
function chunk.edit(key, data)
  local editedChunk, errorMsg = exports.versa_sdk:EditChunkEntity(key, data)
  return editedChunk, errorMsg
end

--- Delete an existing chunk entity
-- @param string key The unique key for the chunk entity to delete
-- @return boolean True if deleted successfully, false otherwise
function chunk.delete(key)
  local deletedChunk, errorMsg = exports.versa_sdk:DeleteChunkEntity(key)
  return deletedChunk, errorMsg
end

return chunk