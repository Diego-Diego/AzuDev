-- Define the variable used to open/close the tab
local tabEnabled = false
local tabLoaded = true --false
ESX = exports['es_extended']:getSharedObject()
local PlayerHasProp = false
local PlayerProps = {}

function REQUEST_NUI_FOCUS(bool)
    SetNuiFocus(bool, bool) -- focus, cursor
    if bool == true then
        SendNUIMessage({showtab = true})
    else
        SendNUIMessage({hidetab = true})
    end
    return bool
end

RegisterCommand("CloseUI", function(source, args, rawCommand)
   SetNuiFocus(false,false)
   DestroyAllProps()
end, true)

function CloseTablette()
    SetNuiFocus(false,false)
    DestroyAllProps()
end
function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
end

RegisterNUICallback("tablet-bus", function(data)
    if data.load then
        tabLoaded = true
        --print("Affiche")
    elseif data.hide then
        --print("Caché")
        SetNuiFocus(false, false) 
        tabEnabled = false
        local ped = GetPlayerPed(-1)
        CloseTablette()
        RequestAnimDict("amb")
        RequestAnimDict("amb@code_human_in_bus_passenger_idles")
        RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
        ClearPedTasks(GetPlayerPed(-1))
        DestroyAllProps()
    elseif data.click then
    end
end
)

RegisterCommand("Tablette", function(source, args, rawCommand)
    local ped = GetPlayerPed(-1)            
    local ChosenDict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a"
    local ChosenAnimation = "idle_a"
    local PropName = "prop_cs_tablet"
    local PropBone = 28422
    local PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = -0.05, 0, 0, 0, 0, 0, 0
    if not tabEnabled then
         tabEnabled = true
         REQUEST_NUI_FOCUS(tabEnabled)
         SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
         TaskPlayAnim(ped, ChosenDict, ChosenAnimation, 2.0, 2.0, -1, 51, 0, false, false, false)
         AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
         --tabEnabled = false
        Citizen.CreateThread(function() 
            while tabEnabled do
                Citizen.Wait(5)
                local playerPed = PlayerPedId()
                if not IsEntityPlayingAnim(playerPed, ChosenDict, ChosenAnimation, 3) then
                    TaskPlayAnim(playerPed, ChosenDict, ChosenAnimation, 2.0, 2.0, -1, 51, 0, false, false, false)
                end
            end
            ClearPedTasks(GetPlayerPed(-1))
            DestroyAllProps()
        end)
    else
        tabEnabled = false
        REQUEST_NUI_FOCUS(tabEnabled)
        CloseTablette()
        Citizen.Wait(0)
        tabEnabled = true
    end
 end, true) 
 
 RegisterKeyMapping('Tablette', 'Ouvrir la Tablette', 'keyboard', 'F1')
 
 
 