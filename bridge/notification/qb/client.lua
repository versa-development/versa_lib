local bridge = {}

function bridge.Send(data)
  local title = data.title
  local message = data.message
  local duration = data.duration
  local notificationType = data.type -- info success or error
  
  if notificationType == 'info' then
    notificationType = 'primary'
  end

  TriggerEvent('QBCore:Notify', message, notificationType, duration)
end

return bridge