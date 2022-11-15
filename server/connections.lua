if Config.loggins then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
        local src = source
        local identifiers = GetIdenti(src)
        local steamID = identifiers.steam
        local license = identifiers.license
        local discord = identifiers.discord
        local xbl = identifiers.xbl
        local liveID = identifiers.liveid
        local fivem = identifiers.fivem
        local ip = identifiers.playerip
        local name = identifiers.name
        local field = {}
        if Config.licenses.active.steam then
            if steamID == nil then
                if Config.licenses.need.steam then
                    deferrals.done("No encotrado steamID")
                    setKickReason('No tienes steam abierto')
                    CancelEvent()
                    print('No encotrado steamID')
                else
                    steamID = 'No activado'
                end
                steamID = 'No encotrado steamID'
            else
                print ('steamID: '..steamID)
                table.insert(field, {
                    ['name'] = 'SteamID',
                    ['value'] = '```'..steamID..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.license then
            if license == nil then
                if Config.licenses.need.license then
                    deferrals.done("No encotrado license")
                    setKickReason('No tienes steam abierto')
                    CancelEvent()
                    print('No encotrado license')
                else
                    license = 'No activado'
                end
            else
                print ('license: '..license)
                table.insert(field, {
                    ['name'] = 'License',
                    ['value'] = '```'..license..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.discord then
            if discord == nil then
                if Config.licenses.need.discord then
                    deferrals.done("No encotrado discord")
                    setKickReason('No tienes steam abierto')
                    CancelEvent()
                    print('No encotrado discord')
                else
                    discord = 'No activado'
                end
                print ("^5[Laz-logs] ^1No encotrado discord^0")
            else
                print ('discord: '..discord)
                table.insert(field, {
                    ['name'] = 'Discord',
                    ['value'] = discord,
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.xbl then
            if xbl == nil then
                if Config.licenses.need.xbl then
                    deferrals.done("No encotrado xbl")
                    setKickReason('No tienes XboxLive abierto')
                    CancelEvent()
                    print('No encotrado xbl')
                else
                    xbl = 'No activado'
                end
                print ("^5[Laz-logs] ^1Xbox no encontrado^0")
                xbl = 'No encontrado'
            else
                print ('xbl: '..xbl)
                table.insert(field, {
                    ['name'] = 'Xbox',
                    ['value'] = '```'..xbl..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.live then
            if liveID == nil then
                if Config.licenses.need.liveid then
                    deferrals.done("No encotrado liveID")
                    setKickReason('No tienes tu cuenta liveID abierta')
                    CancelEvent()
                    print('No encotrado liveID')
                else
                    liveID = 'No activado'
                end
                --deferals.done("LiveID não encontrado")
                print ("^5[Laz-logs] ^1LiveID no encontrado^0")
                liveID = 'No encontrado'
            else
                print ('liveID: '..liveID)
                table.insert(field, {
                    ['name'] = 'LiveID',
                    ['value'] = liveID,
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.fivem then
            if fivem == nil then
                if Config.licenses.need.fivem then
                    deferrals.done("No encotrado foro fivem")
                    setKickReason('No tienes vinculado tu foro fivem')
                    CancelEvent()
                    print('No encotrado foro fivem')
                else
                    fivem = 'No activado'
                end
                --deferals.done("Cuenta del Foro de Fivem no encontrado")
                print ("^5[Laz-logs] ^1FiveM no encontrado^0")
                fivem = 'No encontrado'
            else
                print ('fivem: '..fivem)
                table.insert(field, {
                    ['name'] = 'FiveM',
                    ['value'] = '```'..fivem..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.ip then
            if ip == nil then
                if Config.licenses.need.ip then
                    deferrals.done("No encotrado ip")
                    setKickReason('Parece que tienes un problema con tu ip')
                    CancelEvent()
                    print('No encotrado ip')
                else
                    ip = 'No activado'
                end
            else
                table.insert(field, {
                    ['name'] = 'IP',
                    ['value'] = '```'..ip..'```',
                    ['inline'] = true
                })
            end
        end
        Wait(100)
        print ("fields "..json.encode(field))
 
       
        local embed = {
            {
                ["color"] = Colours["olive"],
                ["title"] = "**" .. name .. "** Entro al servidor",
                ['fields'] = field,
                ["footer"] = {
                    ["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown'),
                },
            }
        }
        if Config.WeebHook['loggin'].url ~= '' then
            PerformHttpRequest(Config.WeebHook['loggin'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Entradas", embeds = embed}), { ['Content-Type'] = 'application/json' })
        else
            print ("^5[Laz-logs] ^1No tienes configurado el webhook de loggin^0")
        end
    end
    AddEventHandler("playerConnecting", OnPlayerConnecting)

    AddEventHandler('playerDropped', function (reason)
        if reason == 'Exiting' then
            reason = 'Se desconecto /quit'
        end
        local src = source
        local identifiers = GetIdenti(src)
        local steamID = identifiers.steam
        local license = identifiers.license
        local discord = identifiers.discord
        local xbl = identifiers.xbl
        local liveID = identifiers.liveid
        local fivem = identifiers.fivem
        local ip = identifiers.playerip
        local name = identifiers.name
        local field = {
            {
                ['name'] = 'Razon',
                ['value'] = '```'..reason..'```',
            },
        }
        if Config.licenses.active.steam then 
            if steamID == nil then
                steamID = 'No encontrado'
                print ("^5[Laz-logs] ^1No encotrado steamID^0")
            else
                table.insert(field, {
                    ['name'] = 'SteamID',
                    ['value'] = '```'..steamID..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.license then
            if license == nil then
                license = 'No encontrado'
                print ("^5[Laz-logs] ^1No encotrado license^0")
            else
                table.insert(field, {
                    ['name'] = 'License',
                    ['value'] = '```'..license..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.discord then
            if discord == nil then
                discord = 'No encontrado'
                print ("^5[Laz-logs] ^1No encotrado discord^0")
            else
                table.insert(field, {
                    ['name'] = 'Discord',
                    ['value'] = discord,
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.xbl then
            if xbl == nil then
                xbl = 'No encontrado'
                print ("^5[Laz-logs] ^1Xbox no encontrado^0")
            else
                table.insert(field, {
                    ['name'] = 'Xbox',
                    ['value'] = '```'..xbl..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.live then
            if liveID == nil then
                liveID = 'No encontrado'
                print ("^5[Laz-logs] ^1LiveID no encontrado^0")
            else
                table.insert(field, {
                    ['name'] = 'LiveID',
                    ['value'] = '```'..liveID..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.fivem then
            if fivem == nil then
                fivem = 'No encontrado'
                print ("^5[Laz-logs] ^1FiveM no encontrado^0")
            else
                table.insert(field, {
                    ['name'] = 'FiveM',
                    ['value'] = '```'..fivem..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.active.ip then
            if ip == nil then
                ip = 'No encontrado'
            else
                table.insert(field, {
                    ['name'] = 'IP',
                    ['value'] = '```'..ip..'```',
                    ['inline'] = true
                })
            end
        end

        Wait(100)
        print ("fields "..json.encode(field))
        local embed = {
            {
                ["color"] = Colours["red"],
                ["title"] = "**" .. name .. "** Salio del servidor",
                ['fields'] = field,
                ["footer"] = {
                    ["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown'),
                },
            }
        }
        if Config.WeebHook['logout'].url ~= '' then
            PerformHttpRequest(Config.WeebHook['logout'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Salidas", embeds = embed}), { ['Content-Type'] = 'application/json' })
        end

    end)
end