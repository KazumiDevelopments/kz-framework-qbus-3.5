local laserDrawDistancePoint = vector3(265.25,230.31,97.69)
local laserStartPoints = {
    vector3(264.25, 235.052, 100.383),
    vector3(261.913, 235.368, 101.053),
    vector3(264.77, 230.075, 101.084),
    vector3(260.667, 231.566, 101.047),
    vector3(262.524, 230.227, 100.36),
    vector3(261.085, 233.484, 101.34),
    vector3(271.269, 229.828, 101.417),
    vector3(270.478, 227.998, 101.081),
    vector3(266.314, 229.511, 100.986),
    vector3(267.648, 233.283, 101.108),
    vector3(271.874, 231.745, 101.075),
    vector3(269.873, 233.005, 100.391),
}
local laserGridPoints = {
    vector3(261.012, 235.349, 96.683),
    vector3(259.73, 232.177, 96.683),
    vector3(262.421, 230.49, 96.683),
    vector3(264.217, 235.064, 98.187),
    vector3(265.593, 229.976, 96.683),
    vector3(266.833, 233.34, 96.683),
    vector3(268.187, 228.427, 96.683),
    vector3(269.716, 232.852, 96.683),
    vector3(272.094, 231.224, 96.683),
    vector3(271.164, 227.974, 96.683),
    vector3(271.527, 229.697, 96.683),
    vector3(269.417, 230.443, 96.683),
    vector3(266.969, 231.403, 96.683),
    vector3(263.544, 232.629, 96.683),
    vector3(260.519, 233.779, 96.683),
}

local cityPowerState = true

local lasers = {}

local lasersActive = false
local function activateLasers(b)
    for _, laser in pairs(lasers) do
        laser.setActive(b)
    end
end

RegisterNetEvent("sv-heists:cityPowerState")
AddEventHandler("sv-heists:cityPowerState", function(state)
    cityPowerState = state
end)

Citizen.CreateThread(function()
    for k, coords in pairs(laserStartPoints) do
        local cLaser = Laser.new(coords, laserGridPoints, {
            travelTimeBetweenTargets = {1.0, 4.0},
            waitTimeAtTargets = {0.0, 1.0},
            randomTargetSelection = true,
            name = "laser_" .. tostring(k),
            color = {255, 0, 0, 150}
        })
        lasers[#lasers + 1] = cLaser
    end

    -- while true do
    --     local playerCoords = GetEntityCoords(PlayerPedId())
    --     if not lasersActive and cityPowerState and #(laserDrawDistancePoint - playerCoords) < 14 then
    --         lasersActive = true
    --         activateLasers(true)
    --     elseif lasersActive and (#(laserDrawDistancePoint - playerCoords) > 14 or not cityPowerState) then
    --         lasersActive = false
    --         activateLasers(false)
    --     end
    --     Citizen.Wait(1000)
    -- end
end)

local laserBeamsWithSharksOnTheirHeads = {}
Citizen.CreateThread(function()
  laserBeamsWithSharksOnTheirHeads[#laserBeamsWithSharksOnTheirHeads + 1] = Laser.new(
    {vector3(260.731, 230.879, 97.403), vector3(269.909, 227.539, 97.403)},
    {vector3(262.502, 235.688, 97.403), vector3(271.66, 232.355, 97.403)},
    {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.0, 0.0}, name = "ee",color = {255, 0, 0, 255}}
  )
  laserBeamsWithSharksOnTheirHeads[#laserBeamsWithSharksOnTheirHeads + 1] = Laser.new(
    {vector3(260.742, 230.875, 97.906), vector3(269.911, 227.538, 97.906)},
    {vector3(262.5, 235.689, 97.906), vector3(271.671, 232.351, 97.906)},
    {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.0, 0.0}, name = "ee",color = {255, 0, 0, 255}}
  )
  laserBeamsWithSharksOnTheirHeads[#laserBeamsWithSharksOnTheirHeads + 1] = Laser.new(
    {vector3(260.75, 230.872, 98.42), vector3(269.883, 227.548, 98.42)},
    {vector3(262.541, 235.674, 98.42), vector3(271.666, 232.353, 98.42)},
    {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.0, 0.0}, name = "ee",color = {255, 0, 0, 255}}
  )
end)

RegisterCommand("startsharkbeams", function()
  for _, laser in pairs(laserBeamsWithSharksOnTheirHeads) do
    laser.setActive(true)
  end
end, false)
