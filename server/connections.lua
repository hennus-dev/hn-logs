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
        if Config.licenses.SteamID.active then
            if steamID == nil then
                if Config.licenses.SteamID.need then
                    deferrals.done("No se ha encontrado ningún steamID")
                    setKickReason('No tienes steam abierto')
                    CancelEvent()
                    print('No se ha encontrado ningún steamID')
                else
                    steamID = 'No activado'
                end
                steamID = 'No se ha encontrado ningún steamID'
            else
                print ('steamID: '..steamID)
                table.insert(field, {
                    ['name'] = 'SteamID',
                    ['value'] = '```'..steamID..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.License.active then
            if license == nil then
                if Config.licenses.License.need then
                    deferrals.done("No se ha encontrado ninguna licencia de Rockstar válida")
                    setKickReason('No se ha encontrado ninguna licencia de Rockstar válida')
                    CancelEvent()
                    print('No se ha encontrado ninguna licencia de Rockstar válida')
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
        if Config.licenses.Discord.active then
            if discord == nil then
                if Config.licenses.Discord.need then
                    deferrals.done("No se ha encontrado tu ID de Discord")
                    setKickReason('No tienes Discord abierto')
                    CancelEvent()
                    print('No se ha encontrado tu ID de Discord')
                else
                    discord = 'No activado'
                end
                print ("^5[Laz-logs] ^1No se ha encontrado discord^0")
            else
                print ('discord: '..discord)
                table.insert(field, {
                    ['name'] = 'Discord',
                    ['value'] = discord,
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.Xbl.active then
            if xbl == nil then
                if Config.licenses.Xbl.need then
                    deferrals.done("No encontrado xbl")
                    setKickReason('No tienes XboxLive abierto')
                    CancelEvent()
                    print('No encontrado xbl')
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
        if Config.licenses.LiveID.active then
            if liveID == nil then
                if Config.licenses.LiveID.need then
                    deferrals.done("No encontrado liveID")
                    setKickReason('No tienes tu cuenta liveID abierta')
                    CancelEvent()
                    print('No encontrado liveID')
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
        if Config.licenses.Fivem.active then
            if fivem == nil then
                if Config.licenses.Fivem.need then
                    deferrals.done("No encontrado foro fivem")
                    setKickReason('No tienes vinculado tu foro fivem')
                    CancelEvent()
                    print('No encontrado foro fivem')
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

        if Config.licenses.Ip.active then
            if ip == nil then
                if Config.licenses.Ip.need then
                    deferrals.done("No encontrado ip")
                    setKickReason('Parece que tienes un problema con tu ip')
                    CancelEvent()
                    print('No encontrado ip')
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
        if Config.WebHook['loggin'].url ~= '' then
            PerformHttpRequest(Config.WebHook['loggin'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Entradas", embeds = embed}), { ['Content-Type'] = 'application/json' })
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
        if Config.licenses.SteamID.active then 
            if steamID == nil then
                steamID = 'No encontrado'
                print ("^5[Laz-logs] ^1No encontrado steamID^0")
            else
                table.insert(field, {
                    ['name'] = 'SteamID',
                    ['value'] = '```'..steamID..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.License.active then
            if license == nil then
                license = 'No encontrado'
                print ("^5[Laz-logs] ^1No encontrado license^0")
            else
                table.insert(field, {
                    ['name'] = 'License',
                    ['value'] = '```'..license..'```',
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.Discord.active then
            if discord == nil then
                discord = 'No encontrado'
                print ("^5[Laz-logs] ^1No encontrado discord^0")
            else
                table.insert(field, {
                    ['name'] = 'Discord',
                    ['value'] = discord,
                    ['inline'] = true
                })
            end
        end
        if Config.licenses.Xbl.active then
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
        if Config.licenses.LiveID.active then
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
        if Config.licenses.Fivem.active then
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
        if Config.licenses.Ip.active then
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
        if Config.WebHook['logout'].url ~= '' then
            PerformHttpRequest(Config.WebHook['logout'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Salidas", embeds = embed}), { ['Content-Type'] = 'application/json' })
        end

    end)
end