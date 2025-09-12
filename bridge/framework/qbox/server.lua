local qbx = {}
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

function qbx.getPlayer(source)
  local player = exports.qbx_core:GetPlayer(source)
  if not player then return false end

  return structureResponse(player)
end

function qbx.getPlayerFromIdentifier(identifier)
  local player = exports.qbx_core:GetPlayerByCitizenId(identifier)
  if not player then return false end

  return structureResponse(player)
end

function qbx.getPlayers()
  local data = {}
  local players = exports.qbx_core:GetQBPlayers()
  
  for i = 1, #players do
    data[#data + 1] = structureResponse(players[i])
  end

  return data
end

function qbx.getMetaDataValue(source, key)
  return exports.qbx_core:GetMetadata(source, key)
end

function qbx.setMetaDataValue(source, key, value)
  return exports.qbx_core:SetMetadata(source, key, value)
end

function qbx.addMoney(source, type, amount, reason)
  return exports.qbx_core:AddMoney(source, type, amount, reason)
end

function qbx.removeMoney(source, type, amount, reason)
  return exports.qbx_core:RemoveMoney(source, type, amount, reason)
end

return qbx