local bridge = {}

function bridge.Show(data)
    TriggerEvent('versa_sdk:showControls', data)
end

function bridge.Hide()
    TriggerEvent('versa_sdk:hideControls')
end

return bridge