ESX = exports.es_extended:getSharedObject()
lib.locale()

robberyEntity = {}
GlobalState.canRobbery = robberyEntity

ESX.RegisterServerCallback('xnr-shoprobbery:CheckRobbery', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local police = ESX.GetExtendedPlayers('job', 'police')
    if #police >= Config.RequiredPolice then
        cb(true)
    else
        TriggerClientEvent('ox_lib:notify', source, {description = locale('required_police'), type = 'error'})
        cb(false)
    end
end)

ESX.RegisterServerCallback('xnr-shoprobbery:Reward', function(source, cb, count)
    exports.ox_inventory:AddItem(source, 'money', count)
end)

RegisterServerEvent('xnr-shoprobbery:setState', function(id, bool)
    robberyEntity[id] = bool
    GlobalState.canRobbery = robberyEntity
end)

