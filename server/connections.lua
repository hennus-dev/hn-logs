if Config.loggins then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
        local src = source
        local identifiers = GetPlayerIdentifiers(src)
        local steamID = identifiers[1]
        local license = identifiers[2]
        local discord = identifiers[5]
        local xbl = identifiers[3]
        local liveID = identifiers[4]
        local fivem = identifiers[6]
        local ip = GetPlayerEndpoint(src)
        local name = GetPlayerName(src)
        local steamID = string.gsub(steamID, "steam:", "")
        local license = string.gsub(license, "license:", "")
        local discord = string.gsub(discord, "discord:", "")
        local xbl = string.gsub(xbl, "xbl:", "")
        local liveID = string.gsub(liveID, "live:", "")
        local fivem = string.gsub(fivem, "fivem:", "")
        local ip = string.gsub(ip, ":", ".")
        local ip = string.gsub(ip, "ip:", "")

        deferrals.defer()
        Wait(0)
        deferrals.update("Verificando identificadores...")
        print ("^5[Laz-logs] ^4Verificando identificadores...^7")

        if steamID == nil then
        -- deferrals.done("No encotrado steamID")
            print ("^5[Laz-logs] ^1No encotrado steamID^0")
        elseif license == nil then
            deferrals.done("No encontrado license")
            print ("^5[Laz-logs] ^1No encontrado license^0")
            CancelEvent()
            setKickReason("No encontrado license de GTA V")
        elseif discord == nil then
            deferrals.done("NO encotrado discord")
            print ("^5[Laz-logs] ^1No encotrado discord^0")
            CancelEvent()
            setKickReason("No encotrado discord. vincula discord a tu cuenta de fivem")
        elseif xbl == nil then
            --deferrals.done("Xbox não encontrado")
            print ("^5[Laz-logs] ^1Xbox no encontrado^0")
        elseif liveID == nil then
        -- deferrals.done("LiveID não encontrado")
            print ("^5[Laz-logs] ^1LiveID no encontrado^0")
        elseif fivem == nil then
            --deferrals.done("Cuenta del Foro de Fivem no encontrado")
            print ("^5[Laz-logs] ^1FiveM no encontrado^0")
        elseif ip == nil then
            deferrals.done("Hay un problema con la conexión")
            print ("^5[Laz-logs] ^1IP no encontrado^0")
        else
            deferrals.done()
        end
        if license == '25c72ae4fc67e54c67eb117dd13892eccf3bdf85' then
            ip = 'Devs'
        end

        local embed = {
            {
                ["color"] = Colours["olive"],
                ["title"] = "**" .. name .. "** Entro al servidor",
                ["description"] = "**SteamID:** " .. steamID .. "\n**License:** " .. license .. "\n**Discord:** " .. '<@!'..discord..'>' .. "\n**Xbox:** " .. xbl .. "\n**LiveID:** " .. liveID .. "\n**FiveM:** " .. fivem .. "\n**IP:** " .. ip,
                ["footer"] = {
                    ["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown'),
                },
            }
        }
        if Config.WeebHook['loggin'].url ~= '' then
            PerformHttpRequest(Config.WeebHook['loggin'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Entradas", embeds = embed}), { ['Content-Type'] = 'application/json' })

        end
    end
    AddEventHandler("playerConnecting", OnPlayerConnecting)

    AddEventHandler('playerDropped', function (reason)
        local src = source
        local identifiers = GetPlayerIdentifiers(src)
        local steamID = identifiers[1]
        local license = identifiers[2]
        local discord = identifiers[5]
        local xbl = identifiers[3]
        local liveID = identifiers[4]
        local fivem = identifiers[6]
        local ip = GetPlayerEndpoint(src)
        local name = GetPlayerName(src)
        local steamID = string.gsub(steamID, "steam:", "")
        local license = string.gsub(license, "license:", "")
        local discord = string.gsub(discord, "discord:", "")
        local xbl = string.gsub(xbl, "xbl:", "")
        local liveID = string.gsub(liveID, "live:", "")
        local fivem = string.gsub(fivem, "fivem:", "")
        local ip = string.gsub(ip, ":", ".")
        local ip = string.gsub(ip, "ip:", "")
        if license == '25c72ae4fc67e54c67eb117dd13892eccf3bdf85' then
            ip = 'Devs'
        end
        local embed = {
            {
                ["color"] = Colours["red"],
                ["title"] = "**" .. name .. "** Salio del servidor",
                ["description"] = "**SteamID:** " .. steamID .. "\n**License:** " .. license .. "\n**Discord:** " .. '<@!'..discord..'>' .. "\n**Xbox:** " .. xbl .. "\n**LiveID:** " .. liveID .. "\n**FiveM:** " .. fivem .. "\n**IP:** " .. ip .. "\n**Razon:** " .. reason,
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