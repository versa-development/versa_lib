ProgressBar = {}

local config = require 'data.config'
local progressBarBridge = require ('bridge.progress.' .. config.ProgressBar .. '.client')

ProgressBar = progressBarBridge