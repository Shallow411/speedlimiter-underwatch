-- CONFIG --
local speedLimit = 169 -- The speed limit in MPH, set this 1 mph lower than the actual limit you desire, so if you want to limit speed to 170 set this to 169
local useSpeedLimiter = true -- Set to true to enable speed limiting, false to show only the warning message
local warningFrequency = 1-- Number of warning messages to show (1 means only once)


-- Do not change ANYTHING below unless you know what your doing! 
local resourceName = GetCurrentResourceName()

TriggerEvent('chatMessage', '^1' .. resourceName .. ': made by underwatch')
TriggerEvent('chatMessage', '^2' .. resourceName .. ': Thank you for using this script, feel free to ask me for support and or modify the code as you wish.')
TriggerEvent('chatMessage', '^2Dont worry, these messages only show to you, im not an advertiser ;)')



Citizen.CreateThread(function()
    local warningsShown = 0

    while true do
        Citizen.Wait(0)

        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if DoesEntityExist(vehicle) and not IsEntityDead(playerPed) then
            local speed = GetEntitySpeed(vehicle) * 2.23694 -- Convert speed to MPH

            if useSpeedLimiter then
                -- Apply the speed limiter
                local newSpeed = speedLimit * 0.44704 -- Convert speed limit to meters per second (m/s)
                SetEntityMaxSpeed(vehicle, newSpeed)
            else
                -- If speed limiter is disabled, reset the speed limit
                SetEntityMaxSpeed(vehicle, 999.99) -- A high value to remove any speed limit applied previously
            end

            -- Show the warning message according to the warningFrequency
            if not useSpeedLimiter and speed > (speedLimit + 1) and warningsShown < warningFrequency then
                -- Show the warning message
                local warningMessage = "^1Speed Limit Exceeded, please do not exceed the speed limit of " .. speedLimit + 1 .. " MPH!"
                TriggerEvent('chatMessage', '', {255, 0, 0}, warningMessage)

                -- Increment the warningsShown counter
                warningsShown = warningsShown + 1
            elseif speed <= speedLimit then
                -- Reset the warningsShown counter when the speed is below or equal to the limit
                warningsShown = 0
            end
        end
    end
end)