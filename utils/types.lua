local types = {}

local controls = require 'data/controls'

--[[
Character Object (types.character)
{
  identifier = string   -- Unique player identifier (citizenid, identifier, etc.)
  source     = number   -- Server ID of the player
  firstname  = string   -- Character’s first name
  lastname   = string   -- Character’s last name
  fullname   = string   -- firstname + " " + lastname
  metadata   = table    -- Character metadata
}
]]
function types.character(data)
  return {
    identifier = data.identifier,
    source = tonumber(data.source),
    name = {
      first = data.firstname,
      last = data.lastname,
      full = data.firstname .. ' ' .. data.lastname,
    },
    metadata = data.metadata,
  }
end

function types.inputControl(control)
  return controls[control] or false
end

return types