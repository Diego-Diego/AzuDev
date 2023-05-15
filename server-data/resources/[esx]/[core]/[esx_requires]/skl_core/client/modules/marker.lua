AddEventHandler('InitClientScript:marker', function()
    local CurrentActionData = {}
    local JobAutorized = "Aucun"
    local hasAlreadyEnteredMarker
    OpenMenuGlobal = false
    local lastZone, hasMemberCard
    local lastCheckTime = -600000

    Citizen.CreateThread(function ()
        while ESX.GetPlayerData() == nil do
            Citizen.Wait(10)
        end
        ESX.PlayerData = ESX.GetPlayerData()

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        LoadMarkers()
    end) 

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)

    RegisterNetEvent('esx:setFaction')
    AddEventHandler('esx:setFaction', function(faction)
        Citizen.Wait(250)
        ESX.PlayerData.faction = faction
    end)

    RegisterNetEvent("MyCity_Jobs:AutorizedMarker")
    AddEventHandler("MyCity_Jobs:AutorizedMarker", function(Autorized)
        JobAutorized = Autorized
    end)

    function LoadMarkers()
        local checkMemberCardTime = 0
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerPed = PlayerPedId()
                local plyCoords = GetEntityCoords(playerPed)
                local letSleep, isInMarker, currentMarker = true

                if ConfigJobs[ESX.PlayerData.job.name] then
                    for location, v in pairs(ConfigJobs[ESX.PlayerData.job.name]) do
                        if ESX.PlayerData.job.grade >= v.MinimumGrade then
                            local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, v.Pos['x'], v.Pos['y'], v.Pos['z'], true)
                            if dstCheckEnter <= v.DistanceView then
                                if v.Type == 'Boss' then
                                    if ESX.PlayerData.job.grade_name == "boss" then
                                        letSleep = false
                                        DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                        if dstCheckEnter <= v.DistancePressed then
                                            isInMarker, currentMarker = true, v
                                        end
                                    end
                                elseif v.Type == 'Garage' then
                                    letSleep = false
                                    DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                    if dstCheckEnter <= v.DistancePressed then
                                        if v.Message then
                                            if ConfigMarker.D3Text then
                                                NZR.Draw3DText(v.Pos['x'], v.Pos['y'], v.Pos['z'], v.Message)
                                            end
                                        end
                                        if IsControlJustPressed(0, 38) then
                                            TriggerEvent(v.Trigger) 
                                        end
                                    end
                                elseif v.Type == "JobNeed" then
                                    if JobAutorized == v.JobNeed then
                                        letSleep = false
                                        DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                        if dstCheckEnter <= v.DistancePressed then
                                            isInMarker, currentMarker = true, v
                                        end
                                    end
                                else
                                    letSleep = false
                                    DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                    if dstCheckEnter <= v.DistancePressed then
                                        isInMarker, currentMarker = true, v
                                    end
                                end                              
                            end
                        end
                    end
                end

                for location, v in pairs(ConfigMarker.Marqueurs) do
                    local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, v.Pos['x'], v.Pos['y'], v.Pos['z'], true)
                    if dstCheckEnter <= v.DistanceView then
                        if v.Type == 'Flightschool' or v.Type == 'MCEvent' then
                            --if location ~= lastZone then
                                lastZone = location
                                if GetGameTimer() - checkMemberCardTime > 20000 then
                                    checkMemberCardTime = GetGameTimer()
                                    Citizen.CreateThread(function() 
                                        hasMemberCard = HasMemberCard(v.Type)
                                    end)
                                end
                            --end
                            
                            if ESX.PlayerData.job.name == v.JobNeed or hasMemberCard then
                                letSleep = false
                                DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                if dstCheckEnter <= v.DistancePressed then
                                    isInMarker, currentMarker = true, v
                                end
                            end
                        elseif v.Type == "JobNeed" then
                            if JobAutorized == v.JobNeed then
                                letSleep = false
                                DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                if dstCheckEnter <= v.DistancePressed then
                                    isInMarker, currentMarker = true, v
                                end
                            end
                        elseif v.Type == "Weapon" then
                            if IsPedArmed(playerPed, 4) then
                                letSleep = false
                                DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                                if dstCheckEnter <= v.DistancePressed then
                                    isInMarker, currentMarker = true, v
                                end
                            end
                        else
                            letSleep = false
                            if v.Marker ~= -1 then
                                DrawMarker(v.Marker, v.Pos['x'], v.Pos['y'], v.Pos['z']-0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.55, 0.55, 0.55, 255, 0, 102, 255, false, false, 2, false, false, false, false)
                            end

                            if dstCheckEnter <= v.DistancePressed then
                                isInMarker, currentMarker = true, v
                            end
                        end
                    end
                end

                if isInMarker then
                    DisableControlAction(0, 38)
                    if currentMarker.Message then
                        if ConfigMarker.D3Text then
                            NZR.Draw3DText(currentMarker.Pos['x'], currentMarker.Pos['y'], currentMarker.Pos['z'], currentMarker.Message)
                        end
                    end
                    if IsDisabledControlJustPressed(0, 38) then
                        TriggerEvent(currentMarker.Trigger)
                    end
                end

                if isInMarker and not hasAlreadyEnteredMarker then
                    hasAlreadyEnteredMarker = true
                end

                if not isInMarker and hasAlreadyEnteredMarker then
                    if OpenMenuGlobal then
                        RageUI.CloseAll()
                        OpenMenuGlobal = false
                        IsLsCustomMenuOpen = false
                    end

                    if OpenShopMenu then
                        RageUI.CloseAll()
                        OpenShopMenu = false
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end
                    
                    TriggerEvent('MyCity_CoreV2:CloseAll')
                    hasAlreadyEnteredMarker = false
                    lastZone = nil
                end

                if letSleep then
                    Citizen.Wait(500)
                end
            end
        end)
    end

    local bool = false
    function HasMemberCard(type)
        ESX.TriggerServerCallback("MyCity_Jobs:hasMemberCard", function(boolean)
            bool = boolean
        end, type)
        Citizen.Wait(500)
        return bool
    end
end)