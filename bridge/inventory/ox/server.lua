local inventory = {}

function inventory.giveItem(inventoryId, item, amount, metadata)
  return exports.ox_inventory:AddItem(inventoryId, item, amount, metadata)
end

function inventory.removeItem(inventoryId, item, amount, metadata, slot)
  return exports.ox_inventory:RemoveItem(inventoryId, item, amount, metadata, slot)
end

function inventory.hasItem(inventoryId, item, metdata)
  return exports.ox_inventory:GetItem(inventoryId, item, metadata)
end

return inventory