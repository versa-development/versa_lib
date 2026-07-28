local bridge = {}

function bridge.GiveItem(inventoryId, item, amount, metadata)
    local xPlayer = ESX.GetPlayerFromId(inventoryId)
    if not xPlayer then return false end
  
    return xPlayer.addInventoryItem(item, amount)
end

function bridge.RemoveItem(inventoryId, item, amount, metadata, slot)
    local xPlayer = ESX.GetPlayerFromId(inventoryId)
    if not xPlayer then return false end
  
    return xPlayer.removeInventoryItem(item, amount)
end

function bridge.HasItem(inventoryId, item, metadata)
    local xPlayer = ESX.GetPlayerFromId(inventoryId)
    if not xPlayer then return false end

    return xPlayer.hasItem(item)
end

function bridge.CreateStash(key, data)
  return false -- no stash system?
end

function bridge.OpenStash(source, key)
  return false -- no stash system?
end

return bridge