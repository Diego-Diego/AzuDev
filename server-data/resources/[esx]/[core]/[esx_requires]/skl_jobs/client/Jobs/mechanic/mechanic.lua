openDiag = false
vehicleADiagno = nil
vehiclePropsADiagno  = nil
coordVehADiagno = nil
oilLevel = nil
temperature = nil
pressionFrein = nil
vieFrein = nil
vieMoteur = nil
vieReservoir = nil
CurrentRPM = nil
compressionSuspension = nil
IsChecking = false

RMenu.Add('mechanic', 'diagnostic', RageUI.CreateMenu(" ", "Choisissez une action.", nil, nil, "banner", "ban"))
RMenu:Get('mechanic', 'diagnostic').Closable = false
RMenu:Get('mechanic', 'diagnostic').Closed = function()
    RageUI.CloseAll()
    openDiag = false
end

RegisterNetEvent("openDiag:open")
AddEventHandler("openDiag:open", function()
    vehicleADiagno = ESX.Game.GetVehicleInDirection()
    vehiclePropsADiagno  = ESX.Game.GetVehicleProperties(vehicleADiagno)
    coordVehADiagno = GetEntityCoords(vehicleADiagno)

    if vehicleADiagno ~= nil then
        local engineToDiagno = GetEntityBoneIndexByName(vehicleADiagno, 'engine')
        local coords = GetWorldPositionOfEntityBone(vehicleADiagno, engineToDiagno)
        local capotOuvert = GetVehicleDoorAngleRatio(vehicleADiagno, 4) 

        if capotOuvert ~= 0 then
            if #(GetEntityCoords(PlayerPedId()) - coords) <= 1.5 then
                if not IsChecking then
                    GetVehicleCaracteristique(vehicleADiagno)
                    CreateCamVeh(coordVehADiagno)
                    IsChecking = true
                    IsInDiagno()
                else
                    ESX.ShowNotification('~r~Action déjà en cours.\n~o~Merci de patienter et réessayer.') return
                end
            else
                ESX.ShowNotification('~r~Vous devez être face au moteur pour faire les vérifications') return
            end
        else
            ESX.ShowNotification('~r~Le capot doit être ouvert !') return
        end
    else
        ESX.ShowNotification('~r~Aucun véhicule détecté près de vous.\n~o~Veuillez réessayer.') return
    end
    
    if openDiag then
        RageUI.CloseAll()
	    openDiag = false
		return 
	end

    openDiag = true
    
    RageUI.Visible(RMenu:Get('mechanic', 'diagnostic'), not RageUI.Visible(RMenu:Get('mechanic', 'diagnostic')))
    
    Citizen.CreateThread(function()
        while openDiag do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('mechanic', 'diagnostic'), function()
                if oilLevel == nil then
                    RageUI.Separator('')
                    RageUI.Separator('~o~Vérification du niveau d\'huile')
                    RageUI.Separator('')
                elseif oilLevel <= 2.1 then
                    RageUI.Separator('~r~Niveau d\'huile insuffisant : ~s~'..oilLevel..' ml')
                else
                    RageUI.Separator('~g~Niveau d\'huile : ~s~'..oilLevel..' ml')
                end
                    
                if oilLevel ~= nil then
                    if temperature == nil then
                        RageUI.Separator('')
                        RageUI.Separator('~o~Vérification de la température du moteur')
                        RageUI.Separator('')
                    elseif temperature >= 90 then
                        RageUI.Separator('~r~Température trop élevée : ~s~'..temperature..' °C')
                    else
                        RageUI.Separator('~g~Température : ~s~'..temperature..' °C')
                    end
                end

                if temperature ~= nil then
                    if vieFrein == nil then
                        RageUI.Separator('')
                        RageUI.Separator('~o~Vérification de l\'état des freins')
                        RageUI.Separator('')
                    elseif vieFrein <= 30 then
                        RageUI.Separator('~r~Freins endommagés : ~s~'..vieFrein..' %')
                    else
                        RageUI.Separator('~g~Etat des freins : ~s~'..vieFrein..' %')
                    end
                end
                
                if vieFrein ~= nil then
                    if vieMoteur == nil then
                        RageUI.Separator('')
                        RageUI.Separator('~o~Vérification de l\'état du moteur')
                        RageUI.Separator('')
                    elseif vieMoteur <= 30 then
                        RageUI.Separator('~r~Moteur endommagé : ~s~'..vieMoteur..' %')
                    else
                        RageUI.Separator('~g~Etat du moteur : ~s~'..vieMoteur..' %')
                    end
                end

                if vieMoteur ~= nil then
                    if vieReservoir == nil then
                        RageUI.Separator('')
                        RageUI.Separator('~o~Vérification de l\'état du réservoir')
                        RageUI.Separator('')
                    elseif vieReservoir <= 30 then
                        RageUI.Separator('~r~Réservoir endommagé : ~s~'..vieReservoir..' %')
                    else
                        RageUI.Separator('~g~Etat du réservoir : ~s~'..vieReservoir..' %')
                    end
                end


                if vieReservoir ~= nil then 
                    if vieReservoir <= 30 or vieMoteur <= 30 or vieFrein <= 30 or temperature >= 90 or oilLevel <= 3 then
                        if vieReservoir <= 30 and vieMoteur <= 30 and vieFrein <= 30 and temperature >= 90 and oilLevel <= 3 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~La voiture doit être réparée dans l\'immédiat.')
                            RageUI.Separator('~r~Énormément de soucis majeurs ont été identifiés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieReservoir <= 30 and vieMoteur <= 30 and vieFrein <= 30 and temperature >= 90 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~La voiture doit être réparée dans l\'immédiat.')
                            RageUI.Separator('~r~Énormément de soucis majeurs ont été identifiés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieReservoir <= 30 and vieMoteur <= 30 and vieFrein <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~La voiture doit être réparée dans l\'immédiat.')
                            RageUI.Separator('~r~Énormément de soucis majeurs ont été identifiés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieReservoir <= 30 and vieMoteur <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~La voiture doit être réparée dans l\'immédiat.')
                            RageUI.Separator('~r~Deux soucis majeurs ont été identifiés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif temperature >= 90 and vieMoteur <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~La voiture doit être réparée dans l\'immédiat.')
                            RageUI.Separator('~r~Deux soucis majeurs ont été identifiés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieReservoir <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~Le réservoir est endommagé.')
                            RageUI.Separator('~r~Il doit être changé.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieMoteur <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~Le moteur de la voiture est endommagé.')
                            RageUI.Separator('~r~Il doit être changé.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieFrein <= 30 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~Les freins de la voiture sont endommagés.')
                            RageUI.Separator('~r~Ils doivent être changés.')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        elseif vieReservoir <= 30 or vieMoteur <= 30 or vieFrein <= 30 or temperature >= 90 or oilLevel <= 3 then
                            RageUI.Separator('')
                            RageUI.Separator('Bilan de votre diagnostic')
                            RageUI.Separator('~r~Le véhicule doit être réparé au plus vite.')
                            RageUI.Separator('~r~Problème(s) majeur(s) identifié(s)')
                            RMenu:Get('mechanic', 'diagnostic').Closable = true
                        end
                    else
                        RageUI.Separator('')
                        RageUI.Separator('Bilan de votre diagnostic')
                        RageUI.Separator('~g~Aucun problème mécanique découvert.')
                        RageUI.Separator('~o~Essayez de regarder la carrosserie.')
                        RMenu:Get('mechanic', 'diagnostic').Closable = true
                    end
                end
            end)
        end
    end)
end)

--SetVehicleOilLevel(vehicle, 100.0)