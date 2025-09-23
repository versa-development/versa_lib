-- Global created entities cache
CreatedEntities = {}

-- Module imports
local log = require 'utils.logger'

--- Create a chunk entity
-- @param table data The chunk entity data
-- @return boolean True if created successfully, false otherwise
-- @return string|nil Error message if creation failed, nil if successful
local function createChunkEntity(data)
  -- Get the zone ID for the chunk entity
  local chunkId = GetZoneIdFromCoords(data.coords)
  if not chunkId then
    log.error('No zone found for chunk entity at coords:', json.encode(data.coords))
    return false, 'No zone found for the given coordinates'
  end

  -- Check if the model exists before adding it to the cache
  if not lib.requestModel(data.model, 10000) then
    log.error('Failed to load model for chunk entity:', data.model)
    return false, 'Failed to load model'
  end

  -- Ensure the model is not clogging up client memory
  SetModelAsNoLongerNeeded(data.model)
  
  -- Add to the zone cache
  Zones[chunkId].entities[#Zones[chunkId].entities + 1] = data

  -- Check if the entity is in any of the zones the player is in/surrounding
  if chunkId == CurrentZoneId or (CurrentSurroundingZones and lib.table.contains(CurrentSurroundingZones, chunkId)) then
    print('USER IS IN A CHUNK WHICH THE OBJECT SHOULD BE IN')
    --todo: run the create entity function
  end

  return true
end

-- Events
RegisterNetEvent('versa_sdk:chunks:loadChunkEntities', function(zoneId)
  log.debug('Loading chunk entities for zone:', zoneId)
  CreatedEntities[zoneId] = {}
end)

RegisterNetEvent('versa_sdk:chunks:unloadChunkEntities', function(zoneId)
  log.debug('Unloading chunk entities for zone:', zoneId)
  CreatedEntities[zoneId] = nil
end)

RegisterNetEvent('versa_sdk:chunks:createEntities', function(data)
  if type(data[1]) == 'table' then
    for i, entity in ipairs(data) do
      createChunkEntity(entity)
    end
  else
    createChunkEntity(data)
  end
end)