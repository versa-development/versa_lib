-- Chunks Global Cache
Chunks = {}

--- Create a new chunk entity
-- @param string type The type of chunk entity ('ped' or 'object')
-- @param string key The unique key for the chunk entity
-- @param table data The chunk entity data
-- @return boolean True if created successfully, false otherwise
-- @return string|nil Error message if creation failed, nil if successful
local function createChunkEntity(type, key, data)
  if Chunks[key] then
    return false, 'Chunk with this key already exists'
  end

  -- Assign additional properties
  data.key = key
  data.type = type

  -- Add to global cache
  Chunks[key] = data

  -- Broadcast creation event to clients
  TriggerClientEvent('versa_sdk:chunks:createEntities', -1, data)

  return true
end

--- Edit an existing chunk entity
-- @param string type The type of chunk entity ('ped' or 'object')
-- @param string key The unique key for the chunk entity
-- @param table data The chunk entity data to update
-- @return boolean True if edited successfully, false otherwise
-- @return string|nil Error message if edit failed, nil if successful
local function editChunkEntity(key, data)
  if not Chunks[key] then
    return false, 'Chunk with this key does not exist'
  end

  local oldChunkData = Chunks[key]

  Chunks[key] = data
  Chunks[key].resource = oldChunkData.resource -- Preserve the resource property

  -- todo: broadcast update event to clients

  return true
end

--- Delete an existing chunk entity
-- @param string key The unique key for the chunk entity to delete
-- @return boolean True if deleted successfully, false otherwise
-- @return string|nil Error message if deletion failed, nil if successful
local function deleteChunkEntity(key)
  if not Chunks[key] then
    return false, 'Chunk with this key does not exist'
  end

  Chunks[key] = nil
  -- todo: broadcast deletion event to clients

  return true
end

-- Event Handlers
AddEventHandler('onResourceStop', function(resourceName)
  for key, chunkData in pairs(Chunks) do
    if chunkData.resource == resourceName then
      Chunks[key] = nil
      print('Deleted chunk entity due to resource stop:', key)
      -- todo: broadcast deletion event to clients
    end
  end
end)

-- Exports
exports('CreateChunkEntity', createChunkEntity)
exports('EditChunkEntity', editChunkEntity)
exports('DeleteChunkEntity', deleteChunkEntity)