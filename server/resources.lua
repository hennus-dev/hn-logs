if Config.resources then
    AddEventHandler('onResourceStart', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            return
        end
        TriggerEvent('laz:logs:server:log', 'resources','Resources Start' , 'Resource '..resourceName..' STARTED', true, 'olive')
    end)
    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            return
        end
        TriggerEvent('laz:logs:server:log', 'resources','Resources Stop' , 'Resource **'..resourceName..'**: STOPPED', true, 'red')
    end)
end
