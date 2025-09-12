local qb = {}

-- qb inventory stash ref: https://github.com/qbcore-framework/qb-inventory/pull/397/files

function qb.giveItem(inventoryId, item, amount, metadata)
  -- QB Inventory has different functions for adding items to players and stashes...
  if type(inventoryId) == 'number' then
    exports['qb-inventory']:AddItem(inventoryId, item, amount, false, metadata, 'versa_sdk:giveItem')
  else
    -- todo: sql query for stashes
  end
end

function qb.removeItem(inventoryId, item, amount, metadata, slot)
  if type(inventoryId) == 'number' then
    exports['qb-inventory']:RemoveItem(inventoryId, item, amount, slot, 'versa_sdk:removeItem') --todo: metadata support
  else
    -- todo: sql query for stashes
  end
end

function qb.hasItem(inventoryId, item, metdata)
  if type(inventoryId) == 'number' then
    return exports['qb-inventory']:HasItem(inventoryId, item, 1) -- todo: metadata support
  else
    -- todo: sql query for stashes
  end
end


return qb