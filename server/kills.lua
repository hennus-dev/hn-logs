if Config.kills then
	local clientfields = false
	RegisterServerEvent('baseevents:onPlayerDied')
	RegisterServerEvent('baseevents:onPlayerKilled')
	RegisterNetEvent('laz:logs:server:KillsSystem', function(data)
		local d = data
		local victim, killerid, playerName, killerName,weapon, pos,killerpos  = d.victim, d.killerid, d.playerName, d.killerName, d.weapon, d.pos, d.killerpos
		local identvictim = GetIdenti(victim)
		local identkiller = GetIdenti(killerid)
		 clientfields = {
			{
				["name"] = "Victima",
				["value"] = "**Nombre** "..playerName..' **Posicion: **'.."vector3("..round(pos[1], 2)..", "..round(pos[1], 2)..", "..round(pos[1], 2)..")",
			},
			{
				["name"] = "Asesino",
				["value"] = "**Nombre** "..killerName..' **Posicion: **'.."vector3("..round(killerpos[1], 2)..", "..round(killerpos[1], 2)..", "..round(killerpos[1], 2)..")",
			},
			{
				["name"] = "Arma",
				["value"] = weapon,
			},
		}

		for k,v in pairs(identvictim)do
			if tostring(k) == 'steam' or tostring(k) == 'license' or tostring(k) == 'discord' then
				table.insert(clientfields, {
					["name"] = 'victima '..k,
					["value"] = v,
				})
			end
		end
		for k,v in pairs(identkiller)do
			if k == 'steam' or k == 'license' or k == 'discord' then
				table.insert(clientfields, {
					["name"] = 'atacante '..k,
					["value"] = v,
				})
			end
		end
		Wait(10)
		Setclientfields(clientfields)
	end)
	AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
		local src = source
		local killer = GetKiller(killedBy)
		local victim = GetVictim(src)
		local identificadores = GetIdenti(src)
		local fields = {

			{
				["name"] = "Victima",
				["value"] = victim,
				["inline"] = true
			},
			{
				-- victim id
				["name"] = "ID",
				["value"] = src,
				["inline"] = true
			},
			{
				["name"] = "Asesino",
				["value"] = killer,
				["inline"] = false
			},
			{
				["name"] = "Posicion",
				["value"] = "vector3("..round(pos[1], 2)..", "..round(pos[1], 2)..", "..round(pos[1], 2)..")",
				["inline"] = true
			}
		}
		for k,v in pairs(identificadores) do
			table.insert(fields, {
				["name"] = tostring(k),
				["value"] = v,
			})
		end
		local embed = {
			{
				["color"] = Colours['darkred'],
				["title"] = '**'..killer.." Mato a "..victim..'**',
				["fields"] = fields,
				["footer"] = {
					["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown') ,
				},
			}
		}
		TriggerEvent('Laze:logs:server:sendEmbed','kills', embed)
	end)

	AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
		local victim = source
		local info = DebugData(data)
		local field = {
			{
				["name"] = "Victima",
				["value"] = victim,
				["inline"] = true
			},
		}
		if info['Asesino en vehiculo'] == 'no' then
			table.removekey(info, 'Nombre del vehiculo')
			table.removekey(info, 'Sentado en el vehiculo')
		end
		Wait(5)
		while not clientfields do 
			clientfields = Getclientfields()
			Wait(10)
		end
		for k,v in pairs(clientfields) do
			table.insert(field, v)
		end
		for k,v in pairs(info) do
			if v == '' or v == nil or v ==' ' or tostring(v) == 'undefined' then
				v = 'N/A'
			else
				table.insert(field, {
					["name"] = tostring(k),
					["value"] = tostring(v),
				})
			end
			
		end
		Wait(10)
		local embed = {
			{
				["color"] = Colours['darkred'],
				["title"] =  '**'..GetKiller(killedBy).." Mato a "..GetVictim(victim)..'**',
				["fields"] = field,
				["footer"] = {
					["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown') ,
				},
			}
		}
		TriggerEvent('Laze:logs:server:sendEmbed','kills', embed)
	end)

	function Getclientfields()
		return clientfields
	end

	function Setclientfields(data)
		clientfields = data
	end

end