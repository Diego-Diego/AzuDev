ESX.RegisterServerCallback('nzr:getNumPlayer', function(src, cb)
    local src = src
    local xPlayers = #ESX.GetExtendedPlayers()

    cb(xPlayers)
end)