ESX.RegisterUsableItem('tablet', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerClientEvent("openDiag:open", source)
end)