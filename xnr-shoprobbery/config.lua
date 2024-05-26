Config = {}

Config.Cooldown = 500 -- 500 seconds

Config.RequiredPolice = 1

Config.Progress = {
    duration = 10000,
    label = 'Zbieranie pieniędzy...',
    anim = {
        dict = 'oddjobs@shop_robbery@rob_till',
        clip = 'loop'
    }
}

Config.Dispatch = function()
    local coords = GetEntityCoords(playerPed)
    local street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street = GetStreetNameFromHashKey(street2)
    TriggerServerEvent('xnr_dispatch:AddDispatchData', 'Rabunek kasy fiskalnej', '10-90', coords, street, 7, 3, false, false, "default")
end

Config.cashRegisters = {
    {
        id = 1, 
        coords = vector4(24.95, -1344.99, 29.5, 0),
        reward = math.random(500, 600)
    },
    {
        id = 2, 
        coords = vector4(24.95, -1346.26, 29.5, 0),
        reward = math.random(100, 200)
    }
}