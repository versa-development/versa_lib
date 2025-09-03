local progressBar = {}

function progressBar.init(data)
  local label = data.label or ''
  local duration = data.duration or 5000
  local prop = data.prop or nil
  local states = data.states or nil
  
  local animation = data.animation and {
    animDict = data.animation.dict,
    anim = data.animation.name,
    flags = data.animation.flags,
  } or nil

  -- checking if there are multiple props defined
  if data.prop and type(data.prop) == 'table' and next(data.prop) then
    prop = data.prop[1]
    prop2 = data.prop[2]
  elseif data.prop and type(data.prop) == 'table' and not next(data.prop) then
    prop = data.prop
    prop2 = nil
  end
    
  exports['progressbar']:Progress({
    name = 'versa_lib_' .. math.random(1000, 9999),
    duration = duration,
    label = label,
    useWhileDead = states.useWhileDead or false,
    canCancel = states.canCancel or false,
    controlDisables = {
      disableMovement = states.disableMovement or false,
      disableCarMovement = states.disableDriving or false,
      disableMouse = states.disableMouseMovement or false,
      disableCombat = states.disableCombat or false,
    },
    animation = animation,
    prop = prop or nil,
    propTwo = propTwo or nil,
  }, function(cancelled)
    return (not cancelled)
  end)
end

return progressBar