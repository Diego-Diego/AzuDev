-----
ESX.RegisterUsableItem('tablet', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.getJob().name == "mechanic" then
		print("tg")
		TriggerClientEvent("openDiag:open", source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)
-----

-----
ESX.RegisterUsableItem('blowpipe', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.getJob().name == "mechanic" then
		xPlayer.removeInventoryItem('blowpipe', 1)

		TriggerClientEvent('skl_jobs:onHijack', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)
-----

-----
ESX.RegisterUsableItem('fixkit', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.getJob().name == "mechanic" then
		xPlayer.removeInventoryItem('fixkit', 1)

		TriggerClientEvent('skl_jobs:onFixkit', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)
-----

-----
ESX.RegisterUsableItem('carokit', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.getJob().name == "mechanic" then
		xPlayer.removeInventoryItem('carokit', 1)
		TriggerClientEvent('skl_jobs:onCarokit', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)
-----

-----
ESX.RegisterUsableItem('carglass', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.getJob().name == "mechanic" then
		TriggerClientEvent('skl_jobs:onCarGlass', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)

RegisterServerEvent('skl_jobs:carglassUsed')
AddEventHandler('skl_jobs:carglassUsed', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('carglass', 1)
end)
-----

-----
ESX.RegisterUsableItem('tire', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getJob().name == "mechanic" then
		TriggerClientEvent('skl_jobs:Use', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)

RegisterServerEvent('skl_jobs:Used')
AddEventHandler('skl_jobs:Used', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tire', 1)
end)
-----

RegisterNetEvent("skl_jobs:regive")
AddEventHandler("skl_jobs:regive", function(name)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem(name, 1)
end)

-----
ESX.RegisterUsableItem('superoil', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getJob().name == "mechanic" then
		xPlayer.removeInventoryItem('superoil', 1)
		TriggerClientEvent('skl_jobs:onSuperOil', source)
	else
		xPlayer.showNotification("~r~Vous n'avez pas l'expérience")
	end
end)
-----