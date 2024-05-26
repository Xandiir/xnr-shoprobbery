ESX = exports.es_extended:getSharedObject()

playerPed = PlayerPedId()
lib.onCache('ped', function(value) playerPed = value end)

lib.locale()

Citizen.CreateThread(function()
    for k,v in pairs(Config.cashRegisters) do 
        exports['ox_target']:addBoxZone({
            coords = vec3(v.coords[1], v.coords[2], v.coords[3]),
            size = vec3(0.6, 0.6, 1),
            rotation = v.coords[4],
            debug = true,
            drawSprite = true,
            options = {
                {
                    name = 'RobTill',
                    label = 'Okradnij',
                    icon = 'fas fa-cash-register',
                    onSelect = function(data)
                        local canRob = true

                        for key, value in pairs(GlobalState.canRobbery) do 
                            if key == v.id then 
                                if not value then 
                                    canRob = false 
                                    break
                                end
                            end
                        end

                        if canRob then 
                            ESX.TriggerServerCallback('xnr-shoprobbery:CheckRobbery', function(started)
                                if started then
                                    TriggerServerEvent('xnr-shoprobbery:setState', v.id, false)

                                    Citizen.SetTimeout(Config.Cooldown * 1000, function()
                                        TriggerServerEvent('xnr-shoprobbery:setState', v.id, true)
                                    end)

                                    local success = lib.skillCheck({'easy', 'medium', 'hard', 'easy'}, {'1', '2', '3', '4'})

                                    if success then 
                                        Config.Dispatch()

                                        if lib.progressBar({
                                            duration = Config.Progress.duration,
                                            label = Config.Progress.label,
                                            useWhileDead = false,
                                            canCancel = true,
                                            disable = {
                                                car = true,
                                                move = true,
                                                combat = true
                                            },
                                            anim = Config.Progress.anim
                                        }) then
                                            ESX.TriggerServerCallback('xnr-shoprobbery:Reward', function(hasReward)
                                                if hasReward then
                                                    lib.notify({description = locale('robbed'), type = 'success'})
                                                end
                                            end, v.reward)
                                        end
                                    end
                                end
                            end)
                        else 
                            lib.notify({description = locale('cant_rob'), type = 'error'})
                        end
                    end,
                }
            }
        })
    end
end)



