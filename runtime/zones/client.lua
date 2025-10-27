-- Global zones cache
Zones = {}

-- Module imports
local config = require 'config'
local log = require 'utils/logger'

-- Zone coordinates and values for the world grid
local ZONE_SIZE <const> = 450
local ZONE_HEIGHT <const> = 2000
local MIN_X, MAX_X <const> = -6000, 8000
local MIN_Y, MAX_Y <const> = -6000, 8000

-- Debug RGB Colours
local INSIDE_ZONE_COLOUR <const> = { r = 0, g = 255, b = 0, a = 10 }
local SURROUNDING_ZONE_COLOUR <const> = { r = 255, g = 255, b = 0, a = 10 }
local OUTSIDE_ZONE_COLOUR <const> = { r = 255, g = 0, b = 0, a = 5 }

-- Runtime variables
CurrentZoneId = nil
CurrentSurroundingZones = {}

--- A debug function handling the zone colour changes on enter and exit
-- @param boolean isEntering True if entering the zone, false if exiting
-- @param zoneData table The zone object
local function debugZone(isEntering, zoneData)
  local zone = Zones[zoneData.id]

  if isEntering then
    zone.zone.debugColour = INSIDE_ZONE_COLOUR
    
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

--- A function that returns the zone ID for given coordinates
-- @coords vector2 The coordinates to check
-- @return string|nil The zone ID if found, nil otherwise
function GetZoneIdFromCoords(coords)
  for zoneId, data in pairs(Zones) do
    if data.zone:contains(vec3(coords.x, coords.y, 0)) then
      return zoneId
    end
  end
  return nil
end

--- Get the surrounding zones (N, NE, E, SE, S, SW, W, NW) for a given zone based on its coordinates.
-- @param x number The x coordinate of the zone
-- @param y number The y coordinate of the zone
-- @return table A list of surrounding zone IDs
local function getSurroundingZones(x, y)
  local surroundingZones = {}

  for dx = -1, 1 do
    for dy = -1, 1 do
      if not (dx == 0 and dy == 0) then
        local gridX = x + (dx * ZONE_SIZE)
        local gridY = y + (dy * ZONE_SIZE)

        for zoneId, data in pairs(Zones) do
          if data.zone.coords.x == gridX and data.zone.coords.y == gridY then
            surroundingZones[#surroundingZones + 1] = zoneId
            break
          end
        end
      end
    end
  end

  return surroundingZones
end

--- Create zones in a grid pattern based on the defined zone size
local function createZones()
  for x = MIN_X, MAX_X, ZONE_SIZE do
    for y = MIN_Y, MAX_Y, ZONE_SIZE do

      -- Create the ox lib box zone for the zone 
      local zone = lib.zones.box({
        coords = vector3(x, y, 0),
        size = vector3(ZONE_SIZE, ZONE_SIZE, ZONE_HEIGHT),
        rotation = 0,
        onEnter = function(self)
          if config.Debug then debugZone(true, self) end

          TriggerEvent('versa_sdk:zones:enteredZone', self.id)
        end,
        onExit = function(self)
          if config.Debug then debugZone(false, self) end
          Zones[CurrentZoneId].zone.debugColour = OUTSIDE_ZONE_COLOUR
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

  TriggerEvent('versa_sdk:zones:created')
end

-- On client load, create the zones
createZones()