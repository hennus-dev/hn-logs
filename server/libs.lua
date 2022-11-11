function Embed(title, description, color, footer, fields)
    local embed = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = description,
            ["footer"] = {
                ["text"] = os.date("%c")..'Laz-logs: '..footer,
            },
        }
    }
    if fields then
        embed[1]["fields"] = fields
    end
    return embed
end

function GetKiller(killer)
    local id = killer
    if killer == -1 then
        return 'El sistema'
    elseif killer == 0 then
        return 'Michael'
    elseif killer == 1 then
        return 'Franklin'
    elseif killer == 2 then
        return 'Trevor'
    elseif killer == 3 then
        return 'No Registrado 3'
    elseif killer == 4 then
        return 'Hombre'
    elseif killer == 5 then
        return 'Mujer'
    elseif killer == 6 then
        return 'Npc Policia'
    elseif killer >= 7 and killer <=19 then
        return 'No Registrado'..killer
    elseif killer == 20 then
        return 'Npc Paramedico'
    elseif killer == 21 then
        return 'Npc Bombero(LSFD)'
    elseif killer >= 22 and killer <= 25 then
        return 'No Registrado'..killer
    elseif killer == 26 then
        return 'Npc Humano'
    elseif killer == 27 then
        return 'Npc Policia(SWAT)'
    elseif killer == 28 then
        return 'Animal'
    elseif killer == 29 then
        return 'Por un Arma'
    elseif killer >= 30 then
        return 'No Registrado'..killer
    end
end

function GetVictim(victim)
    local id = victim
    if victim <= 0 then
        return 'No hai victima'
    end
    if victim >= 1 then
        return GetPlayerName(victim)
    end
end

function LazError(message)
    print ('^1[Laz-logs]:Error: ^0'..message)
    if not LazDebug then
        TriggerEvent('laz:logs:server:log', 'error','Error' , message, true, 'purple')
    end
end

function GetIdenti (id)
    local identifier = GetPlayerIdentifiers((tonumber(id)))
    local steam = identifier[1]
    local license = identifier[2]
    local xbl = identifier[3]
    local live = identifier[4]
    local discord = identifier[5]
    local fivem = identifier[6]
    local playerip = GetPlayerEndpoint(id)
    local name = GetPlayerName(id)
    if steam == nil then
        steam = 'No hay steam'
    else
       steam = string.gsub(steam, "steam:", "")
    end
    if license == nil then
        license = 'No hay license'
    else
        license = string.gsub(license, "license:", "")
    end
    if xbl == nil then
        xbl = 'No hay xbl'
    else
        xbl = string.gsub(xbl, "xbl:", "")
    end
    if live == nil then
        live = 'No hay live'
    else
        live = string.gsub(live, "live:", "")
    end
    if discord == nil then
        discord = 'No hay discord'
    else
        discord = string.gsub(discord, "discord:", "")
    end
    if fivem == nil then
        fivem = 'No hay fivem'
    else
        fivem = string.gsub(fivem, "fivem:", "")
    end
    if playerip == nil then
        playerip = 'No hay ip'
    else
        playerip = string.gsub(playerip, ":", "")
    end
    for k,v in pairs(Devs) do
        if v == license then
            steam = 'Developer'
            license = 'Developer'
            xbl = 'Developer'
            live = 'Developer'
           -- discord = 'Developer'
            fivem = 'Developer'
            playerip = 'Developer'
        end
    end
    local data = {
        steam = steam,
        license = license,
        xbl = xbl,
        live = live,
        discord = '<@!'..discord..'>',
        fivem = fivem,
        playerip = playerip,
        name = name
    }

    return data
end

function DebugData(data)
    local d = data
    local r = {}
    for k,v in pairs(d) do
        if k == 'killerinveh' then
            k = "Asesino en vehiculo"
            if v == true then
                v = "si"
            else
                v = "no"
            end
        end
        if k == 'killervehseat' then
            k = "Sentado en el vehiculo"
            if v == -1 then
                v = 'conductor'
            elseif v == 0 then
                v = 'acompañante'
            else
                v = 'pasejero detras'
            end
        end
        if k == 'killervehname' then
            k = "Nombre del vehiculo"
            if v ~= ''then 
                v = tostring(v)
            end
        end
        if k == 'weaponhash' then
            k = "Arma"
            v = GetWeaponLabel(v) or tostring(v)
        end
        if k == 'killerpos' then
            k = "Posicion del asesino"
            -- string vector3
            v = 'vector3('..round(v[1], 2)..', '..round(v[2], 2)..', '..round(v[3], 2)..')'
        end
        if k == 'killertype' then
            k = "Tipo de asesino"
            if v == 0 then
                v = 'Normal'
            elseif v == 1 then
                v = 'Por definir 1'
            elseif v == 2 then
                v = 'Jugador'
            elseif v >= 3 then
                v = 'Por definir'..tostring(v)
            end


        end
        r[k] = v
        if r['Asesino en vehiculo'] == 'no' then
            r['Sentado en el vehiculo'] = nil
            r['Nombre del vehiculo'] = nil
        end
    end
    print(json.encode(r))
    return r
end
  

function GetWeaponLabel(v)
 return Weapon[v]
end



Devs = {
    '25c72ae4fc67e54c67eb117dd13892eccf3bdf85',
    'ea6fdacb38b060c46ee82a79bea6cafec0996a5e',
}