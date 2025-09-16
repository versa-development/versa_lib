local esx = {}
local types = require 'utils.types'

--- Structure the central character object
local function structureResponse(data)
  return types.character({
    identifier = data.PlayerData.citizenid,
    source = data.PlayerData.source,
    firstname = data.PlayerData.charinfo.firstname,
    lastname = data.PlayerData.charinfo.lastname,
    metadata = data.PlayerData.metadata
  })
end

function esx.getPlayer(source)
  local player = exports.esx_core:GetPlayer(source)
  if not player then return false end

  return structureResponse(player)
end

function esx.getPlayerFromIdentifier(identifier)
  local player = exports.esx_core:GetPlayerByCitizenId(identifier)
  if not player then return false end

  return structureResponse(player)
end

function esx.getPlayers()
  local data = {}
  local players = exports.esx_core:GetQBPlayers()
  
  for i = 1, #players do
    data[#data + 1] = structureResponse(players[i])
  end

  return data
end

function esx.getMetaDataValue(source, key)
  return exports.esx_core:GetMetadata(source, key)
end

function esx.setMetaDataValue(source, key, value)
  return exports.esx_core:SetMetadata(source, key, value)
end

function esx.addMoney(source, type, amount, reason)
  return exports.esx_core:AddMoney(source, type, amount, reason)
end

function esx.removeMoney(source, type, amount, reason)
  return exports.esx_core:RemoveMoney(source, type, amount, reason)
end

return esx