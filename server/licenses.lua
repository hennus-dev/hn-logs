local Debug = exports['hn-libs']:Debug()

---@class Licenses
---@field steam string
---@field license string
---@field xbl string
---@field live string
---@field discord string
---@field fivem string
---@field playerip string
---@field name string
local Licenses = setmetatable({
    __class = 'Licenses',
    SteamID = nil,
    License = nil,
    Xbl = nil,
    LiveID = nil,
    Discord = nil,
    Fivem = nil,
    PlayerIp = nil,
}, {} )

Licenses.New = function(self)
    local licenses = {
        SteamID = nil,
        License = nil,
        Xbl = nil,
        LiveID = nil,
        Discord = nil,
        Fivem = nil,
    }

    return licenses
end

---@param playerId integer The player server id
---@return Licenses
function GetIdentifiers (playerId)
    local identifier = GetPlayerIdentifiers(playerId)
    local licenses = Licenses.New()

    for _, id in ipairs(identifier) do
        for type, cfg in pairs(Config.licenses) do
            if string.sub(id, 1, string.len(cfg.prefix..":")) == cfg.prefix..":" then
                licenses[type] = string.gsub(id, cfg.prefix..":", "")
            end
        end
    end

    for _,v in pairs(Config.devLicenses) do
        if v == licenses.License then
            for id, _ in pairs(licenses) do
                licenses[id] = 'Developer'
            end
        end
    end

    return licenses
end

if Config.ValidateLicense then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
        local src = source
        local identifiers = GetIdentifiers(src)
        local field = {}
        --TODO Refactor this
        local loginError = false
        local msg = ''

        for identifier, idConfig in pairs(Config.licenses) do
            if idConfig.active then
                if idConfig.mandatory then
                    if identifiers[identifier] == nil then
                        msg = "No se ha encontrado "..identifier
                        deferrals.done(msg)
                        setKickReason('No tienes '..identifier..' abierto')
                        CancelEvent()
                        Debug:print("^5[hn-logs] ^1"..msg.."^0")
                        loginError = true or loginError
                    else
                        Debug:print("^5[hn-logs] ^1"..identifier..": "..identifiers[identifier].."^0")
                        table.insert(field, {
                            ['name'] = identifier,
                            ['value'] = '```'..identifiers[identifier]..'```',
                            ['inline'] = true,
                        })
                        
                    end
                else
                    identifiers[identifier] = 'No activado'
                end
            end
        end

        Wait(100)
        
        if Config.WebHook['login'].url ~= '' then
            Debug:print('playerId: '..src)
            local ip = GetPlayerEndpoint(src) or ' '
            Debug:print('IP: '..ip)

            --TODO: Refactor ip and name append to the field table            
            table.insert(field, {
                ['name'] = 'IP',
                ['value'] = '```'..ip..'```',
                ['inline'] = true,
            })

            if loginError == true then
                table.insert(field, {
                    ['name'] = 'Kick_Reason',
                    ['value'] = '```'..msg..'```',
                    ['inline'] = false,
                })

            end
        
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

            PerformHttpRequest(Config.WebHook['login'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Entradas", embeds = embed}), { ['Content-Type'] = 'application/json' })
        else
            print ("^5[hn-logs] ^1No tienes configurado el webhook de login^0")
        end
    end

    AddEventHandler("playerConnecting", OnPlayerConnecting)

    -- AddEventHandler('playerDropped', function (reason)
    --     if reason == 'Exiting' then
    --         reason = 'Se desconecto /quit'
    --     end
    --     local src = source
    --     local identifiers = GetIdentifier(src)
    --     local steamID = identifiers.steam
    --     local license = identifiers.license
    --     local discord = identifiers.discord
    --     local xbl = identifiers.xbl
    --     local liveID = identifiers.liveid
    --     local fivem = identifiers.fivem
    --     local ip = identifiers.playerip
    --     local name = identifiers.name
    --     local field = {
    --         {
    --             ['name'] = 'Razon',
    --             ['value'] = '```'..reason..'```',
    --         },
    --     }
    --     if Config.licenses.active.steam then 
    --         if steamID == nil then
    --             steamID = 'No encontrado'
    --             print ("^5[Laz-logs] ^1No encontrado steamID^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'SteamID',
    --                 ['value'] = '```'..steamID..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.license then
    --         if license == nil then
    --             license = 'No encontrado'
    --             print ("^5[Laz-logs] ^1No encontrado license^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'License',
    --                 ['value'] = '```'..license..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.discord then
    --         if discord == nil then
    --             discord = 'No encontrado'
    --             print ("^5[Laz-logs] ^1No encontrado discord^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'Discord',
    --                 ['value'] = discord,
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.xbl then
    --         if xbl == nil then
    --             xbl = 'No encontrado'
    --             print ("^5[Laz-logs] ^1Xbox no encontrado^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'Xbox',
    --                 ['value'] = '```'..xbl..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.live then
    --         if liveID == nil then
    --             liveID = 'No encontrado'
    --             print ("^5[Laz-logs] ^1LiveID no encontrado^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'LiveID',
    --                 ['value'] = '```'..liveID..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.fivem then
    --         if fivem == nil then
    --             fivem = 'No encontrado'
    --             print ("^5[Laz-logs] ^1FiveM no encontrado^0")
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'FiveM',
    --                 ['value'] = '```'..fivem..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end
    --     if Config.licenses.active.ip then
    --         if ip == nil then
    --             ip = 'No encontrado'
    --         else
    --             table.insert(field, {
    --                 ['name'] = 'IP',
    --                 ['value'] = '```'..ip..'```',
    --                 ['inline'] = true
    --             })
    --         end
    --     end

    --     Wait(100)
    --     print ("fields "..json.encode(field))
    --     local embed = {
    --         {
    --             ["color"] = Colours["red"],
    --             ["title"] = "**" .. name .. "** Salio del servidor",
    --             ['fields'] = field,
    --             ["footer"] = {
    --                 ["text"] = os.date("%c")..' | '..GetConvar('sv_hostname', 'Unknown'),
    --             },
    --         }
    --     }
    --     if Config.WeebHook['logout'].url ~= '' then
    --         PerformHttpRequest(Config.WeebHook['logout'].url, function(err, text, headers) end, 'POST', json.encode({username = GetCurrentResourceName().."-Logs- Salidas", embeds = embed}), { ['Content-Type'] = 'application/json' })
    --     end

    -- end)
end