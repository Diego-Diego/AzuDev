function NZR.GetCountPlayers()
    local count = 0
    ESX.TriggerServerCallback('nzr:getNumPlayer', function(data)
        count = data
    end)
    Wait(500)
    return count
end