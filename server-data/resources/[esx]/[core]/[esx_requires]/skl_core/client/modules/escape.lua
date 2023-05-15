AddEventHandler('InitClientScript:escape', function()
    Citizen.CreateThread(function()
        while true do
            local nbPlayerTotal = NZR.GetCountPlayers()
            AddTextEntry('PM_SCR_MAP', '~p~Carte de Los Santos')
            AddTextEntry('PM_SCR_GAM', '~r~Prendre l\'avion')
            AddTextEntry('PM_SCR_INF', '~g~Logs')
            AddTextEntry('PM_SCR_SET', '~b~Configuration')
            AddTextEntry('PM_SCR_STA', '~p~Statistiques')
            AddTextEntry('PM_SCR_GAL', '~y~Galerie')
            AddTextEntry('PM_SCR_RPL', '~y~Éditeur ∑')
            AddTextEntry('PM_PANE_CFX', '~y~SkyLand')
            AddTextEntry('FE_THDR_GTAO', "~b~SkyLand ~m~| ~b~discord.gg/~w~qPpzS2ydKp ~m~| ~b~ID : ~w~".. GetPlayerServerId(PlayerId()) .." ~m~| ~b~".. nbPlayerTotal .. "~w~/~b~128 ~w~joueurs ~b~en ligne")
            AddTextEntry('PM_PANE_LEAVE', 'Se déconnecter de ~b~SkyLand');
            AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
            Citizen.Wait(5000)
        end
    end)
end)