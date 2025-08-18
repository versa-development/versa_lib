Inventory = {}

local config = require 'data.config'
local inventoryBridge = require ('bridge.inventory.' .. config.Inventory .. '.server')

Inventory = inventoryBridge