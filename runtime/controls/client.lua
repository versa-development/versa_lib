local currentlyShown = false

local types = require 'utils/types'
local log = require 'utils/logger'

local function getControlString(control)
    local buttonControl = types.inputControl(control)
    if not buttonControl then
        log.warn('Invalid control key provided to showControls: ' .. tostring(control))
        log.warn('Set new control keys in versa_sdk/data/controls')
        return false
    end

    return '~' .. buttonControl .. '~'
end

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

    -- we flip the array as scaleforms draw from right to left
    local reversed = {}
    for i = #data, 1, -1 do
        reversed[#reversed + 1] = data[i]
    end

    for i, button in ipairs(reversed) do
        -- if a single control is provided, convert it to a table for easier processing
        if type(button.control) ~= 'table' then button.control = { button.control } end

        -- flip the array again for individual button controls as scaleforms draw them right to left
        local scaleformButtons = {}
        for s = #button.control, 1, -1 do
            scaleformButtons[#scaleformButtons + 1] = button.control[s]
        end

        BeginScaleformMovieMethod(handle, 'SET_DATA_SLOT')
        ScaleformMovieMethodAddParamInt(i - 1)
        
        -- added support for having multiple controls for a single button
        for b = 1, #scaleformButtons do
            local controlString = getControlString(scaleformButtons[b])
            ScaleformMovieMethodAddParamPlayerNameString(controlString)
        end
        
        ScaleformMovieMethodAddParamPlayerNameString(button.text)
        EndScaleformMovieMethod()
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