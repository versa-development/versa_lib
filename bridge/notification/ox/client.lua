local bridge = {}

function bridge.Send(data)
  local title = data.title
  local message = data.message
  local duration = data.duration
  local notificationType = data.type -- info success or error
  
  if notificationType == 'info' then
    notificationType = 'inform'
  end

  lib.notify({
    title = title,
    description = message,
    duration = duration,
    showDuration = true,
    type = notificationType,
  })
end

return bridge