local framework = {}
local types = require 'utils.types'

--[[ 
  CUSTOM FRAMEWORK BRIDGE FOR THE VERSA SDK
  IF YOU NEED HELP SETTING THIS UP, FEEL FREE TO JOIN OUR DISCORD
  DISCORD: https://discord.com/invite/FsrujTDbvg
]]

--- Structure the central character object
local function structureResponse(data)
  return types.character({
    identifier = data.identifier,
    source = data.source,
    firstname = data.firstname,
    lastname = data.lastname,
    metadata = data.metadata
  })
end

function framework.getPlayer(source)
  local player = -- Function to get the character data from the source passed by the function
  if not player then return false end

  return structureResponse(player)
end

function framework.getPlayerFromIdentifier(identifier)
  local player = -- Function to get the character data from the identifier passed by the function
  if not player then return false end

  return structureResponse(player)
end

function framework.getPlayers()
  local data = {}
  local players = -- Function to get all the characters data
  
  for i = 1, #players do
    data[#data + 1] = structureResponse(players[i])
  end

  return data
end

function framework.getMetaDataValue(source, key)
  return -- Function to get metadata value from the source and key
end

function framework.setMetaDataValue(source, key, value)
  return -- Function to set metadata value from the source, key and value
end

function framework.addMoney(source, type, amount, reason)
  return -- Function to add money from the source, type, amount and reason
end

function framework.removeMoney(source, type, amount, reason)
  return -- Function to remove money from the source, type, amount and reason
end

return framework