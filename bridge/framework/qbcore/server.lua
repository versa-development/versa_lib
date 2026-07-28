local bridge = {}

local types = require 'utils/types'
local QBCore = exports['qb-core']:GetCoreObject()

--- Structure the central character object
local function structureResponse(data)
  return types.character({
    identifier = data.PlayerData.citizenid,
    source = data.PlayerData.source,
    firstname = data.PlayerData.charinfo.firstname,
    lastname = data.PlayerData.charinfo.lastname,
    jobName = data.PlayerData.job.name,
    jobLabel = data.PlayerData.job.label,
    jobGrade = data.PlayerData.job.grade,
    metadata = data.PlayerData.metadata
  })
end

bridge.Name = 'qbcore'

function bridge.GetPlayer(source)
  local player = QBCore.Functions.GetPlayer(source)
  if not player then return false end

  return structureResponse(player)
end

function bridge.GetPlayerFromIdentifier(identifier)
  local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
  if not player then return false end

  return structureResponse(player)
end

function bridge.GetPlayers()
  local data = {}
  local players = QBCore.Functions.GetQBPlayers()
  
  for i = 1, #players do
    data[#data + 1] = structureResponse(players[i])
  end

  return data
end

function bridge.GetMetaDataValue(source, key)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    return Player.Functions.GetMetaData(key)
end

function bridge.SetMetaDataValue(source, key, value)
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return end
  
  return Player.Functions.SetMetaData(key, value)
end

function bridge.AddMoney(source, type, amount, reason)
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return end
  
  return Player.Functions.AddMoney(type, amount, reason)
end

function bridge.RemoveMoney(source, type, amount, reason)
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return end
  
  return Player.Functions.RemoveMoney(type, amount, reason)
end

return bridge