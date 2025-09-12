local ox = {}

function ox.giveItem(inventoryId, item, amount, metadata)
  return exports.ox_inventory:AddItem(inventoryId, item, amount, metadata)
end

function ox.removeItem(inventoryId, item, amount, metadata, slot)
  return exports.ox_inventory:RemoveItem(inventoryId, item, amount, metadata, slot)
end

function ox.hasItem(inventoryId, item, metadata)
  local item = exports.ox_inventory:GetItem(inventoryId, item, metadata)
  if item and item.count and item.count > 0 then
    return true, item.count
  end

  return false, 0
end

return ox