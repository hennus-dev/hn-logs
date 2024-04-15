colldowntags = 0
colldownlogs = 0

RegisterNetEvent('laz:logs:server:log', function(webhooks,name, message,tags,color,id, otherid )
    local name = name
    local WeebHook = Config.WebHook[webhooks] or Config.WebHook['default']
    local embed = Embed(name, message, Colours[color] or Colours["purple"], name)
    while colldownlogs > 0 do
        Wait(100)
        colldownlogs = colldownlogs - 1
    end
    PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs// '..name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    colldownlogs = colldownlogs + 5
    if tags then
        while  colldowntags  > 0 do
                Wait(100)
                colldowntags = colldowntags - 1
        end
        if WeebHook.tag and WeebHook.tag ~= '' then
            colldowntags = 5
            PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs// '..name, content = WeebHook.tag}), { ['Content-Type'] = 'application/json' })
        else
            LazError('No se ha configurado el tag para el webhook: '..webhooks)
        end
    end
end)

-- register send Embed to discord

RegisterNetEvent('Laze:logs:server:sendEmbed', function(webhooks, embed, tag)
    local WeebHook = Config.WebHook[webhooks] or Config.WebHook['default']
    print (json.encode(embed))
    while colldownlogs > 0 do
        Wait(50)
        colldownlogs = colldownlogs - 1
    end
    colldownlogs = colldownlogs + 5
    PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
    if tag then
        while  colldowntags  > 0 do
                Wait(50)
                colldowntags = colldowntags - 1
        end
        if WeebHook.tag and WeebHook.tag ~= '' then
            colldowntags = 5
            PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs', content = WeebHook.tag}), { ['Content-Type'] = 'application/json' })
        else
            LazError('No se ha configurado el tag para el webhook: '..webhooks)
        end
    end
end)

if Config.startServer then
    CreateThread(function()
        TriggerEvent('laz:logs:server:log', 'server','Logs Start' , 'Server started at ' .. os.date("%c"))
    end)
end

RegisterNetEvent('Laz-Logs:LogFields', function(...) 
    local a = {...}
    local whk = a[1]
    local name = a[2]
    local description = a[3]
    local color = a[4]
    local footer = a[5]
    local fields = a[6]
    local id = a[7]
    local tag = a[8] or false
    local embed = EmbedFields(name, description, Colours[color], footer, fields, tonumber(id))
    
    TriggerEvent('Laze:logs:server:sendEmbed', tostring(whk), embed, tag)
end)

RegisterNetEvent('Laz-Logs:SimplyLog', function(...) 
    local a = {...}
    local whk = a[1]
    local name = a[2]
    local color = a[3]
    local footer = a[4]
    local text = a[5]
    local tag = a[6] or false
    local embed = Embed(name, text, Colours[color] or Colours["purple"], footer)
    TriggerEvent('Laze:logs:server:sendEmbed', tostring(whk), embed, tag)
end)

