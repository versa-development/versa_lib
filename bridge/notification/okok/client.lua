local okok = {}

function okok.notify(data)
  local title = data.title
  local message = data.message
  local duration = data.duration
  local notificationType = data.type -- info success or error

  exports.okokNotify:Alert(title, message, duration, notificationType, false)
end

return okok