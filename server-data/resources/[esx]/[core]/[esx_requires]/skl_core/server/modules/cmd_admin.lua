ESX.RegisterCommand('coord', 'superadmin', function(xPlayer, args, showError)
    local player = xPlayer.source
    local playerCoords = GetEntityCoords(GetPlayerPed(player)) .. " **| H:** "..GetEntityHeading(GetPlayerPed(player))
    ESX.DiscordLog(
        "default", -- Name Of Webhook
        "Coordonée",
        "blue",
        playerCoords
    )
end, false, {help = "Webhook coords", validate = true, arguments = {}})

ESX.RegisterCommand('coordxyz', 'superadmin', function(xPlayer, args, showError)
    local player = xPlayer.source
    local playerCoords = GetEntityCoords(GetPlayerPed(player))
	local coord = "x = " .. string.format("%.2f", playerCoords.x) ..", y = " .. string.format("%.2f", playerCoords.y) .. ", z = " .. string.format("%.2f", playerCoords.z)
    ESX.DiscordLog(
        "default", -- Name Of Webhook
        "Coordonée x y z",
        "blue",
        coord
    )
end, false, {help = "Webhook coords", validate = true, arguments = {}})

ESX.RegisterCommand('coordjson', 'superadmin', function(xPlayer, args, showError)
    local player = xPlayer.source
	local playerCoords = GetEntityCoords(GetPlayerPed(player))
	local coord = "\"x\":" .. string.format("%.2f", playerCoords.x) ..",\n \"y\":" .. string.format("%.2f", playerCoords.y) .. ",\n \"z\":" .. string.format("%.2f", playerCoords.z - 1)
	ESX.DiscordLog(
        "default", -- Name Of Webhook
        "Coordonée json",
        "blue",
        coord
    )
end, false, {help = "Webhook coords", validate = true, arguments = {}})