local progressBar = {}

function progressBar.init(data)
  local label = data.label or ''
  local duration = data.duration or 5000
  local prop = data.prop or nil
  local animation = data.animation or nil
  local states = data.states or nil

  -- Versa lib uses "position"/"rotation"; Ox uses "pos"/"rot"
  if prop ~= nil then
    if type(prop[1]) == "table" then
      for i = 1, #prop do
        prop[i].pos = data.prop[i].position
        prop[i].rot = data.prop[i].rotation
      end
    else
      prop.pos = data.prop.position
      prop.rot = data.prop.rotation
    end
  end
    
  return lib.progressBar({
    label = label,
    duration = duration,
    useWhileDead = states.useWhileDead or false,
    canCancel = states.canCancel or false,
    disable = {
      move = states.disableMovement or false,
      car = states.disableDriving or false,
      combat = states.disableCombat or false,
      mouse = states.disableMouseMovement or false,
      sprint = states.disableSprint or false
    },
    anim = animation,
    prop = prop,
  })
end

return progressBar