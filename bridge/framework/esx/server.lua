local bridge = {}

local types = require 'utils/types'
local ESX = exports.es_extended:getSharedObject()

--- Structure the central character object
local function structureResponse(data)
  return types.character({
    identifier = data.PlayerData.identifier,
    source = data.PlayerData.source,
    firstname = data.PlayerData.firstName ,
    lastname = data.PlayerData.lastName,
    jobName = data.PlayerData.job.name,
    jobLabel = data.PlayerData.job.label,
    jobGrade = data.PlayerData.job.grade,
    metadata = data.PlayerData.metadata
  })
end

bridge.Name = 'esx'

function bridge.GetPlayer(source)
  local player = ESX.GetPlayerFromId(source)
  if not player then return false end

  return structureResponse(player)
end

function bridge.GetPlayerFromIdentifier(identifier)
  local player = ESX.GetPlayerFromIdentifier(identifier)
  if not player then return false end

  return structureResponse(player)
end

function bridge.GetPlayers()
  local data = {}
  local players = ESX.ExtendedPlayers()
  
  for i = 1, #players do
    data[#data + 1] = structureResponse(players[i])
  end

  return data
end

function bridge.GetMetaDataValue(source, key)
  local player = ESX.GetPlayerFromId(source)
  if not player then return false end

  return player.getMeta(key)
end

function bridge.SetMetaDataValue(source, key, value)
  local player = ESX.GetPlayerFromId(source)
  if not player then return false end

  return player.setMeta(key, value)
end

function bridge.AddMoney(source, type, amount, reason)
  local player = ESX.GetPlayerFromId(source)
  if not player then return false end

  return player.addAccountMoney(type, amount, reason)
end

function bridge.RemoveMoney(source, type, amount, reason)
  local player = ESX.GetPlayerFromId(source)
  if not player then return false end

  return player.removeAccountMoney(type, amount, reason)
end

return bridge