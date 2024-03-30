if Config.kills then
    AddEventHandler('gameEventTriggered', function(event, data)
		if event == 'CEventNetworkEntityDamage' then
			--local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
            local victim, attacker, victimDied, weapon = GetDataDamage(data)
			if not IsEntityAPed(victim) then return end
            if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
                local playerid = NetworkGetPlayerIndexFromPed(victim)
                local playerName = GetPlayerName(playerid) .. '** id: **' .. GetPlayerServerId(playerid)
                local killerid = NetworkGetPlayerIndexFromPed(attacker)
                local killerName = GetPlayerName(killerid) .. '** id: **' .. GetPlayerServerId(killerid)
                local weaponName = Weapon[weapon] or weapon
                local pos = GetEntityCoords(PlayerPedId())
                local killerpos = GetEntityCoords(GetPlayerPed(killerid))
                local data = {
                    victim = GetPlayerServerId(playerid),
                    killerid = GetPlayerServerId(killerid),
                    playerName = playerName,
                    killerName = killerName,
                    weapon = weaponName,
                    pos = pos,
                    killerpos = killerpos,
                }
                TriggerServerEvent('laz:logs:server:KillsSystem', data)
            end
		end
	end)
end