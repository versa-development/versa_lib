local controls = {}

function controls.show(data)
    TriggerEvent('versa_sdk:showControls', data)
end

function controls.hide()
    TriggerEvent('versa_sdk:hideControls')
end

return controls