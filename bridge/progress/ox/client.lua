local progressBar = {}

function progressBar.init(data)
  local label = data.label or ''
  local duration = data.duration or 5000
  local prop = data.prop or nil
  local animation = data.animation or nil
  local states = data.states or nil
    
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