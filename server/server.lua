colldowntags = 0
colldownlogs = 0

RegisterNetEvent('laz:logs:server:log', function(webhooks,name, message,tags,color,id, otherid )
    local name = name
    local WeebHook = Config.WeebHook[webhooks] or Config.WeebHook['default']
    local embed = Embed(name, message, Colours[color] or Colours["purple"], name)
    while colldownlogs > 0 do
        Wait(100)
        colldownlogs = colldownlogs - 1
    end
    PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs// '..name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    colldownlogs = 5
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

RegisterNetEvent('Laze:logs:server:sendEmbed', function(webhooks, embed)
    local WeebHook = Config.WeebHook[webhooks] or Config.WeebHook['default']
    print "function embed"
    print (json.encode(embed))
    PerformHttpRequest(WeebHook.url, function(err, text, headers) if LazDebug then LazError(err..' '..tostring(text)..' '..json.encode(headers)) end end, 'POST', json.encode({username = 'Laz-logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end)

CreateThread(function()
    TriggerEvent('laz:logs:server:log', 'server','Logs Start' , 'Server started at ' .. os.date("%c"))
end)



