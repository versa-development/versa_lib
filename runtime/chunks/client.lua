CreateThread(function()
  Wait(1000)

  local progress = require '@versa_lib.modules.progress.client'

  RegisterCommand('progressbar', function()
    
    local success = progress.init({
      label = 'Processing...',
      duration = 5000,
      prop = { 
        model = 'prop_logpile_06b',
        bone = 28422,
        pos = { x = 0.0, y = 0.0, z = 0.0 },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
      },
      animation = {
        dict = 'amb@world_human_welding@male@base',
        name = 'base',
        flags = 16,
      },
      states = {
        useWhileDead = false,
        canCancel = false,
        disableMovement = false,
        disableDriving = true,
        disableCombat = true,
        disableMouseMovement = false,
        disableSprint = true,
      }
    })
  end)
end)