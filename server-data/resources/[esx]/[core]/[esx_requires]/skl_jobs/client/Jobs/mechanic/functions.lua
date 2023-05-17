function Arrondis(num, dec)
    local aprdecimal = 10^(dec or 0)
    return math.floor(num * aprdecimal + 0.5) / aprdecimal
end

function GetVehicleCaracteristique(vehiculePrisEnCharge)
    oilLevel = nil
    temperature = nil
    pressionFrein = nil
    vieFrein = nil
    vieMoteur = nil
    vieReservoir = nil
    CurrentRPM = nil
    compressionSuspension = nil

    Citizen.SetTimeout(2500, function()
        oilLevel = Arrondis(GetVehicleOilLevel(vehiculePrisEnCharge), 2)
    end)
    
    Citizen.SetTimeout(5000, function()
        temperature = Arrondis(GetVehicleEngineTemperature(vehiculePrisEnCharge), 2)
    end)
    
    Citizen.SetTimeout(7500, function()
        vieFrein = Arrondis(((GetVehicleWheelHealth(vehiculePrisEnCharge, 1))/10), 2)
    end)

    Citizen.SetTimeout(10000, function()
        vieMoteur = Arrondis(((GetVehicleEngineHealth(vehiculePrisEnCharge))/10), 2)
    end)

    Citizen.SetTimeout(12500, function()
        vieReservoir = Arrondis(((GetVehiclePetrolTankHealth(vehiculePrisEnCharge))/10), 2)
    end)

end

function IsInDiagno()
    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
    Citizen.CreateThread(function()
        Wait(12500)
        ClearPedTasksImmediately(PlayerPedId())
        ESX.ShowNotification('~g~Vérifications terminées')
        EndVehCam()
        IsChecking = false
    end)
end

function CreateCamVeh(coords)
    Citizen.CreateThread(function()
        ClearFocus()

        local playerPed = PlayerPedId()

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 7, 0, 0, 0, GetGameplayCamFov())
        SetCamRot(cam, 270.0, 0.0, 0)
        ShakeCam(cam, "DRUNK_SHAKE", 0.2)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1500, true, false)
    end)
end 

function EndVehCam()
    Citizen.CreateThread(function()
        ClearFocus()
		SetTimecycleModifier('')
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam, false)
        cam = nil
    end)
end

local onCaroKit = false
RegisterNetEvent('skl_jobs:onCarokit')
AddEventHandler('skl_jobs:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    
    if vehicle ~= nil then
        local engineToDiagno = GetEntityBoneIndexByName(vehicle, 'engine')
        local coords = GetWorldPositionOfEntityBone(vehicle, engineToDiagno)
        local capotOuvert = GetVehicleDoorAngleRatio(vehicle, 4) 

        if capotOuvert ~= 0 then
            if #(GetEntityCoords(PlayerPedId()) - coords) <= 1.5 then
                if not onCaroKit then
                    onCaroKit = true
                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                    CreateThread(function()
                        if lib.progressCircle({
                            duration = 10000,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                            },
                        }) then 
                            SetVehicleDeformationFixed(vehicle)
                            ClearPedTasksImmediately(playerPed)
                            ESX.ShowNotification("~g~Le véhicule a été reformer !~s~")
                            onCaroKit = false
                        else 
                            ClearPedTasksImmediately(playerPed) 
                            ESX.ShowNotification("~r~Vous avez annuler votre action !") return 
                        end
                    end)
                else
                    TriggerServerEvent("skl_jobs:regive", "carokit") ESX.ShowNotification('~r~Action déjà en cours.\n~o~Merci de patienter et réessayer.') return
                end
            else
                TriggerServerEvent("skl_jobs:regive", "carokit") ESX.ShowNotification('~r~Vous devez être face au moteur pour faire les vérifications') return
            end
        else
            TriggerServerEvent("skl_jobs:regive", "carokit") ESX.ShowNotification('~r~Le capot doit être ouvert !') return
        end
    else
        TriggerServerEvent("skl_jobs:regive", "carokit") ESX.ShowNotification('~r~Aucun véhicule détecté près de vous.\n~o~Veuillez réessayer.') return
    end
end)

--Tire
local propModel = nil
local propSpawned = nil

RegisterNetEvent('skl_jobs:Use')
AddEventHandler('skl_jobs:Use', function()
	loadAnimDict("anim@heists@box_carry@")
	TaskPlayAnim( PlayerPedId(), "anim@heists@box_carry@", "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	propModel = 'prop_wheel_tyre'
	propSpawned = CreateObject(GetHashKey(propModel), x, y, z + 0.2, true, true, true)
	AttachEntityToEntity(propSpawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.10, 0.26, 0.32, 90.0, 110.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(10000)
end)

CreateThread(function()
	while true do
        local interval = 500
		if propSpawned then
            interval = 1
			if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
				local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
				Draw3DText(x, y, z, "~r~[G] ~w~Annuler")
				local vehicle = ESX.Game.GetClosestVehicle()
				if vehicle ~= nil then
					local tire = GetClosestVehicleTire(vehicle)
					if tire ~= nil then
						Draw3DText(tire.bonePos.x, tire.bonePos.y, tire.bonePos.z, "~g~[E] ~w~Poser le pneu")

						if IsControlJustPressed(1, 38) then
							ClearPedSecondaryTask(PlayerPedId())
							TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
							FreezeEntityPosition(PlayerPedId(), true)

                            if lib.progressCircle({
                                duration = 5000,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                },
                            }) then
                                SetVehicleTyreFixed(vehicle, tire.tireIndex, 0, 1)
                                TriggerServerEvent('skl_jobs:Used')
                                deleteProp()
                                ESX.ShowNotification("~g~Le pneu a été réparer !~s~")
                            else
                                ESX.ShowNotification("~r~Vous avez annuler votre action !") return 
                            end
						end
					end
				end
				
				if IsControlJustPressed(1, 47) then
					deleteProp()
				end
			end
		end
        Wait(interval)
	end
end)

function deleteProp()
	DetachEntity(propSpawned, 1, 1)
	DeleteObject(propSpawned)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	propSpawned = nil
end

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.75*scale)
        SetTextFont(4)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--Windows
local propModel2, propSpawned2 = nil, nil

RegisterNetEvent('skl_jobs:onCarGlass')
AddEventHandler('skl_jobs:onCarGlass', function()
	loadAnimDict("anim@heists@box_carry@")
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	propModel2 = 'hei_prop_yah_glass_04'
	propSpawned2 = CreateObject(GetHashKey(propModel2), x, y, z + 0.2, true, true, true)
	AttachEntityToEntity(propSpawned2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.10, 0.26, 0.32, 90.0, 110.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(10000)
end)

CreateThread(function()
	while true do
        local interval = 500
		if propSpawned2 then
            interval = 1
			if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
				local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
				Draw3DText(x, y, z, "~r~[G] ~w~Annuler")
				local vehicle = ESX.Game.GetClosestVehicle()
				if vehicle ~= nil then
					local win = GetClosestVehicleWindows(vehicle)
					if win ~= nil then
						Draw3DText(win.bonePos.x, win.bonePos.y, win.bonePos.z, "~g~[E] ~w~Poser la fenêtre")
                        print(win.bone)
						if IsControlJustPressed(1, 38) then
							ClearPedSecondaryTask(PlayerPedId())
                            loadAnimDict("mp_arresting")
                            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, -1, 2, 0.0, false, false, false)
							FreezeEntityPosition(PlayerPedId(), true)

                            if lib.progressCircle({
                                duration = 5000,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                },
                            }) then
                                FixVehicleWindow(vehicle, win.winIndex)
                                TriggerServerEvent('skl_jobs:carglassUsed')
                                deleteProp2()
                                ESX.ShowNotification("~g~La fenêtre a été réparer !~s~")
                            else
                                ESX.ShowNotification("~r~Vous avez annuler votre action !") return 
                            end
						end
					end
				end
				
				if IsControlJustPressed(1, 47) then
					deleteProp2()
				end
			end
		end
        Wait(interval)
	end
end)

function deleteProp2()
	DetachEntity(propSpawned2, 1, 1)
	DeleteObject(propSpawned2)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	propSpawned2 = nil
end

function GetClosestVehicleWindows(vehicle)
	local winBones = {
        "windscreen",
        "windscreen_r",
        "window_lf",
        "window_rf",
        "window_lr",
        "window_rr",
        "window_lm",
        "window_rm",
    }

	local winIndex = {
        ["windscreen"] = 6,
		["windscreen_r"] = 7,
		["window_lf"] = 0, --Window left, front
		["window_rf"] = 1, -- Window right, front
		["window_lr"] = 2, -- Window left, back
		["window_rr"] = 3, -- Window right, back  
		["window_lm"] = 4,
		["window_rm"] = 5,
	}

	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestWindow = nil
	
	for a = 1, #winBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, winBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestWindow == nil then
			if distance <= minDistance then
				closestWindow = {bone = winBones[a], boneDist = distance, bonePos = bonePos, winIndex = winIndex[winBones[a]]}
			end
		else
			if distance < closestWindow.boneDist then
				closestWindow = {bone = winBones[a], boneDist = distance, bonePos = bonePos, winIndex = winIndex[winBones[a]]}
			end
		end
	end

	return closestWindow
end

--Hijacked
RegisterNetEvent('skl_jobs:onHijack')
AddEventHandler('skl_jobs:onHijack', function()
	local playerPed = PlayerPedId()

    vehicleADiagno = ESX.Game.GetVehicleInDirection()

    if vehicleADiagno ~= nil then
        local doorToDiagno = GetEntityBoneIndexByName(vehicleADiagno, 'door_dside_f')
        local coords = GetWorldPositionOfEntityBone(vehicleADiagno, doorToDiagno)

        if #(GetEntityCoords(PlayerPedId()) - coords) <= 1.5 then
            local chance = math.random(100)
            local alarm  = math.random(100)

            if alarm <= 33 then
                SetVehicleAlarm(vehicleADiagno, true)
                StartVehicleAlarm(vehicleADiagno)
            end

            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

            CreateThread(function()
                Wait(10000)
                if chance <= 66 then
                    SetVehicleDoorsLocked(vehicleADiagno, 1)
                    SetVehicleDoorsLockedForAllPlayers(vehicleADiagno, false)
                    ClearPedTasksImmediately(playerPed)
                    ESX.ShowNotification("~g~Véhicule déverrouiller")
                else
                    ESX.ShowNotification("~r~Vous avez loupez l'ouverture !")
                    ClearPedTasksImmediately(playerPed)
                end
            end)
        else
            TriggerServerEvent("skl_jobs:regive", "blowpipe")
            ESX.ShowNotification('~r~Vous devez être face a la porte pour faire les vérifications') return
        end
    else
        TriggerServerEvent("skl_jobs:regive", "blowpipe")
        ESX.ShowNotification('~r~Aucun véhicule détecté près de vous.\n~o~Veuillez réessayer.') return
    end
end)

RegisterNetEvent('skl_jobs:onFixkit')
AddEventHandler('skl_jobs:onFixkit', function()
    local playerPed = PlayerPedId()
    vehicleADiagno = ESX.Game.GetVehicleInDirection()

    if vehicleADiagno ~= nil then
        local engineToDiagno = GetEntityBoneIndexByName(vehicleADiagno, 'engine')
        local coords = GetWorldPositionOfEntityBone(vehicleADiagno, engineToDiagno)
        local capotOuvert = GetVehicleDoorAngleRatio(vehicleADiagno, 4) 

        if capotOuvert ~= 0 then
            if #(GetEntityCoords(PlayerPedId()) - coords) <= 1.5 then
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                if lib.progressCircle({
                    duration = 20000,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                }) then
                    SetVehicleEngineHealth(vehicleADiagno, 1000.0)
                    SetVehicleUndriveable(vehicleADiagno, false)
                    ClearPedTasksImmediately(playerPed)
                    ESX.ShowNotification("~g~Moteur réparer !~s~")
                else
                    ESX.ShowNotification("~r~Vous avez annuler votre action !") return 
                end
            else
                TriggerServerEvent("skl_jobs:regive", "fixkit")
                ESX.ShowNotification('~r~Vous devez être face au moteur pour faire les vérifications') return
            end
        else
            TriggerServerEvent("skl_jobs:regive", "fixkit") ESX.ShowNotification('~r~Le capot doit être ouvert !') return
        end
    else
        TriggerServerEvent("skl_jobs:regive", "fixkit")
        ESX.ShowNotification('~r~Aucun véhicule détecté près de vous.\n~o~Veuillez réessayer.') return
    end
end)

RegisterNetEvent('skl_jobs:onSuperOil')
AddEventHandler('skl_jobs:onSuperOil', function()
    local playerPed = PlayerPedId()
    vehicleADiagno = ESX.Game.GetVehicleInDirection()

    if vehicleADiagno ~= nil then
        local engineToDiagno = GetEntityBoneIndexByName(vehicleADiagno, 'engine')
        local coords = GetWorldPositionOfEntityBone(vehicleADiagno, engineToDiagno)
        local capotOuvert = GetVehicleDoorAngleRatio(vehicleADiagno, 4) 

        if capotOuvert ~= 0 then
            if #(GetEntityCoords(PlayerPedId()) - coords) <= 1.5 then
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                if lib.progressCircle({
                    duration = 20000,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                }) then
                    SetVehicleOilLevel(vehicleADiagno, 100.0)
                    SetVehicleUndriveable(vehicleADiagno, false)
                    ClearPedTasksImmediately(playerPed)
                    ESX.ShowNotification("~g~Huile ajouter !~s~")
                else
                    ESX.ShowNotification("~r~Vous avez annuler votre action !") return 
                end
            else
                TriggerServerEvent("skl_jobs:regive", "superoil")
                ESX.ShowNotification('~r~Vous devez être face au moteur pour faire les vérifications') return
            end
        else
            TriggerServerEvent("skl_jobs:regive", "superoil") ESX.ShowNotification('~r~Le capot doit être ouvert !') return
        end
    else
        TriggerServerEvent("skl_jobs:regive", "superoil")
        ESX.ShowNotification('~r~Aucun véhicule détecté près de vous.\n~o~Veuillez réessayer.') return
    end
end)