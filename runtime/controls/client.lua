local currentlyShown = false

local types = require 'utils/types'
local log = require 'utils/logger'

RegisterNetEvent('versa_sdk:showControls', function(data)
    if currentlyShown ~= false then
        TriggerEvent('versa_sdk:hideControls')
        Wait(300)
    end

    local handle = RequestScaleformMovie('INSTRUCTIONAL_BUTTONS')
    currentlyShown = handle

    while not HasScaleformMovieLoaded(handle) do
        Wait(0)
    end

    CallScaleformMovieMethod(handle, 'CLEAR_ALL')
    CallScaleformMovieMethodWithNumber(handle, 'TOGGLE_MOUSE_BUTTONS', 0)

    -- flip the array as GTA draws them from right to left
    local reversed = {}
    for i = #data, 1, -1 do
        reversed[#reversed + 1] = data[i]
    end

    for i, button in ipairs(reversed) do
        local buttonControl = types.inputControl(button.control)
        if not buttonControl then
            log.warn('Invalid control key provided to showControls: ' .. tostring(button.control))
            log.warn('Set new control keys in versa_sdk/data/controls')
            goto continue
        end

        BeginScaleformMovieMethod(handle, 'SET_DATA_SLOT')
        ScaleformMovieMethodAddParamInt(i - 1)
        ScaleformMovieMethodAddParamPlayerNameString('~' .. buttonControl .. '~')
        ScaleformMovieMethodAddParamPlayerNameString(button.text)
        EndScaleformMovieMethod()

        ::continue::
    end

    CallScaleformMovieMethod(handle, 'DRAW_INSTRUCTIONAL_BUTTONS')

    while currentlyShown == handle do
        Wait(0)
        DrawScaleformMovieFullscreen(handle, 255, 255, 255, 255, 1)
    end
end)

RegisterNetEvent('versa_sdk:hideControls', function()
    if currentlyShown then
        SetScaleformMovieAsNoLongerNeeded(currentlyShown)
        currentlyShown = false
    end

    return true
end)