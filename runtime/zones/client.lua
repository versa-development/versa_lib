Zones = {}

-- Module imports
local config = require 'data.config'
local log = require 'utils.logger'

-- Zone coordinates and values for the world grid
local ZONE_SIZE <const> = 250
local ZONE_HEIGHT <const> = 500
local MIN_X, MAX_X <const> = -3000, 3000
local MIN_Y, MAX_Y <const> = -3000, 3000

-- Debug RGB Colours
local INSIDE_ZONE_COLOUR <const> = { r = 0, g = 255, b = 0, a = 50 }
local SURROUNDING_ZONE_COLOUR <const> = { r = 255, g = 255, b = 0, a = 25 }
local OUTSIDE_ZONE_COLOUR <const> = { r = 255, g = 0, b = 0, a = 15 }

--- A debug function handling the zone colour changes on enter and exit
-- @param type string 'onEnter' or 'onExit'
-- @param zoneData table The zone object
local function debugZone(isEntering, zoneData)
  local zone = Zones[zoneData.id]

  if isEntering then
    log.debug('Entered zone at', zoneData.id, json.encode(zone.surroundingZones))
    zone.debugColour = INSIDE_ZONE_COLOUR
    
    -- Set the surrounding zones to a different colour
    for i = 1, #zone.surroundingZones do
      local surroundingZoneId = zone.surroundingZones[i]
      local surroundingZone = Zones[surroundingZoneId].zone
      surroundingZone.debugColour = SURROUNDING_ZONE_COLOUR
    end
  elseif not isEntering then
    zone.debugColour = OUTSIDE_ZONE_COLOUR
    
    -- Reset the surrounding zones to the outside colour
    for i = 1, #zone.surroundingZones do
      local surroundingZoneId = zone.surroundingZones[i]
      local surroundingZone = Zones[surroundingZoneId].zone
      surroundingZone.debugColour = OUTSIDE_ZONE_COLOUR
    end
  end
end

--- Get the surrounding zones (N, NE, E, SE, S, SW, W, NW) for a given zone based on its coordinates.
-- @param x number The x coordinate of the zone
-- @param y number The y coordinate of the zone
-- @return table A list of surrounding zone IDs
local function getSurroundingZones(x, y)
  local response = {}

  for dx = -1, 1 do
    for dy = -1, 1 do
      if not (dx == 0 and dy == 0) then
        local gridX = x + (dx * ZONE_SIZE)
        local gridY = y + (dy * ZONE_SIZE)

        for zoneId, data in pairs(Zones) do
          if data.zone.coords.x == gridX and data.zone.coords.y == gridY then
            response[#response + 1] = zoneId
            break
          end
        end
      end
    end
  end

  return response
end

--- Create zones in a grid pattern based on the defined zone size
local function createZones()
  -- Creates zones in a grid pattern based on the defined zone size
  for x = MIN_X, MAX_X, ZONE_SIZE do
    for y = MIN_Y, MAX_Y, ZONE_SIZE do

      -- Create the ox lib box zone for the zone 
      local zone = lib.zones.box({
        coords = vector3(x, y, 0),
        size = vector3(ZONE_SIZE, ZONE_SIZE, ZONE_HEIGHT),
        rotation = 0,
        onEnter = function(self)
          if config.Debug then debugZone(true, self) end
        end,
        onExit = function(self)
          if config.Debug then debugZone(false, self) end
        end,
        debug = config.Debug,
        debugColour = OUTSIDE_ZONE_COLOUR
      })

      Zones[zone.id] = {
        surroundingZones = {},
        entities = {},
        zone = zone 
      }
    end
  end

  -- Once all zones are created, we can set the surrounding zones (we render entities in current zone and surrounding zones)
  -- cache them so then the client doesn't need to loop every time they enter a new zone
  for zoneId, data in pairs(Zones) do
    Zones[zoneId].surroundingZones = getSurroundingZones(data.zone.coords.x, data.zone.coords.y)
  end
end

-- On client load, create the zones
createZones()