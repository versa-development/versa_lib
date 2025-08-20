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
      move = states.disableMovement,
      car = states.disableDriving,
      combat = states.disableCombat,
      mouse = states.disableMouseMovement,
      sprint = states.disableSprint,
    },
    anim = animation,
    prop = prop,
  })
end

return progressBar