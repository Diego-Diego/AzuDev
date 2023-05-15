local JobAutorized = "Aucun"

Citizen.CreateThread(function ()
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()

    Citizen.Wait(1000)
    LoadBlips()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    Citizen.Wait(250)
    LoadBlips()
end)

RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction)
	Citizen.Wait(250)
    ESX.PlayerData.faction = faction
    Citizen.Wait(250)
    LoadBlips()
end)

RegisterNetEvent("MyCity_Jobs:AutorizedMarker")
AddEventHandler("MyCity_Jobs:AutorizedMarker", function(Autorized)
    JobAutorized = Autorized
    LoadBlips()
end)

BlipsFreeA = {
    {Titre = "Mécano", Couleur = 68, ID = 643, Taille = 0.8, x = -339.16, y = -137.24, z = 39.00, JobNum = "0", Job = "none"},
}

function LoadBlips()
    for _, info in pairs(BlipsFreeA) do
        RemoveBlip(info.Blip)
        Citizen.Wait(50)
        if info.JobNum == "0" then
            info.Blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.Blip, info.ID)
            SetBlipDisplay(info.Blip, 4)
            SetBlipScale(info.Blip, info.Taille)
            SetBlipColour(info.Blip, info.Couleur)
            SetBlipAsShortRange(info.Blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.Titre)
            EndTextCommandSetBlipName(info.Blip)
        elseif info.JobNum == "1" then
            if ESX.PlayerData.job.name == info.Job then
                info.Blip = AddBlipForCoord(info.x, info.y, info.z)
                SetBlipSprite(info.Blip, info.ID)
                SetBlipDisplay(info.Blip, 4)
                SetBlipScale(info.Blip, info.Taille)
                SetBlipColour(info.Blip, info.Couleur)
                SetBlipAsShortRange(info.Blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(info.Titre)
                EndTextCommandSetBlipName(info.Blip)
            end
        elseif info.JobNum == "3" then
            if JobAutorized == info.Job then
                info.Blip = AddBlipForCoord(info.x, info.y, info.z)
                SetBlipSprite(info.Blip, info.ID)
                SetBlipDisplay(info.Blip, 4)
                SetBlipScale(info.Blip, info.Taille)
                SetBlipColour(info.Blip, info.Couleur)
                SetBlipAsShortRange(info.Blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(info.Titre)
                EndTextCommandSetBlipName(info.Blip)
            end
        end
    end
end

RegisterNetEvent("MyCity_Jobs:Tp000")
AddEventHandler("MyCity_Jobs:Tp000", function(Autorized)
    SetEntityCoords(PlayerPedId(), 61.10759, 8.404738, 69.12)
end)