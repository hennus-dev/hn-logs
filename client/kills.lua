if Config.kills then
    AddEventHandler('gameEventTriggered', function(event, data)
		print('^4gameEventTriggered '..event)
		print ('data '..json.encode(data))
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
                print ("diead "..playerName.." "..killerName.." "..weaponName.." vector3("..pos[1]..", "..pos[2]..", "..pos[3]..")")
                print ('playerid '..playerid..' killerid '..killerid)
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