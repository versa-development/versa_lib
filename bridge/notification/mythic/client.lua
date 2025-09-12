local mythic = {}

function mythic.notify(data)
  local title = data.title
  local message = data.message
  local duration = data.duration
  local notificationType = data.type -- info success or error

  if notificationType == 'info' then
    notificationType = 'inform'
  end

  exports.mythic_notify:DoCustomHudText(notificationType, message, duration)
end

return mythic