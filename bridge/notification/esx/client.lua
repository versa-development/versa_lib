local bridge = {}

function bridge.Send(data)
  local title = data.title
  local message = data.message
  local duration = data.duration
  local notificationType = data.type -- info success or error

  exports.esx_notify:Notify(message, notificationType, duration, title)
end

return bridge