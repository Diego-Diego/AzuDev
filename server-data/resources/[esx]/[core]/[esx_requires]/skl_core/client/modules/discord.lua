AddEventHandler('InitClientScript:discord', function()
    Citizen.CreateThread(function()
        while true do
            local PlayerName = GetPlayerName(PlayerId())
            local id = GetPlayerServerId(PlayerId())
            local nbPlayerTotal = NZR.GetCountPlayers()
            
            SetDiscordAppId(1103390178971766917)
            SetRichPresence(PlayerName.." ["..id.."]")
            SetRichPresence("["..id.."]" .. " - ".. nbPlayerTotal .. "/64")
            SetDiscordRichPresenceAsset('logo')
            SetDiscordRichPresenceAssetText('SkyLand')

            SetDiscordRichPresenceAction(0, "🐌 Rejoindre 🐌", "fivem://connect/YourIpHere")
            SetDiscordRichPresenceAction(1, "🔗 Discord 🔗", "https://discord.gg/qPpzS2ydKp")

            Citizen.Wait(10000)
        end
    end)
end)