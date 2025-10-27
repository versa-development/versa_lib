local bridge = {}

function bridge.Init(data)
  local label = data.label or ''
  local duration = data.duration or 5000
  local prop = data.prop or nil
  local states = data.states or nil
  
  -- Convert animation to QB structure
  local animation = data.animation and {
    animDict = data.animation.dict,
    anim = data.animation.name,
    flags = data.animation.flags,
  } or nil

  -- checking if there are multiple props defined
  local propOne, propTwo = nil, nil
  if prop ~= nil then
    if type(data.prop[1]) == "table" then
      propOne = data.prop[1]
      propTwo = data.prop[2]
    else
      propOne = data.prop
    end
  end
    
  exports['progressbar']:Progress({
    name = 'versa_sdk_' .. math.random(1000, 9999),
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
    prop = propOne or nil,
    propTwo = propTwo or nil,
  }, function(cancelled)
    return (not cancelled)
  end)
end

return bridge