local framework = {}

local function structureResponse(data)
  return {
    playerId = data.PlayerData.citizenid,
    source = data.PlayerData.source,
    firstname = data.PlayerData.charinfo.firstname,
    lastname = data.PlayerData.charinfo.lastname,
    fullname = data.PlayerData.charinfo.firstname .. ' ' .. data.PlayerData.charinfo.lastname,
  }
end

function framework.getPlayer(source)
  local player = exports.qbx_core:GetPlayer(source)
  if not player then return nil end

  return structureResponse(player)
end

function framework.getPlayerFromId(playerId)
  local player =  exports.qbx_core:GetPlayerByCitizenId(playerId)
  if not player then return nil end

  return structureResponse(player)
end

function framework.getPlayers()
  return exports.qbx_core:GetQBPlayers()
end

function framework.getMetaDataValue(source, key)
  return exports.qbx_core:GetMetadata(source, key)
end

function framework.setMetaDataValue(source, key, value)
  return exports.qbx_core:SetMetadata(source, key, value)
end

function framework.addMoney(source, type, amount, reason)
  return exports.qbx_core:AddMoney(source, type, amount, reason)
end

function framework.removeMoney(source, type, amount, reason)
  return exports.qbx_core:RemoveMoney(source, type, amount, reason)
end

return framework