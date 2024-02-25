--[[
    tag user => <@!user_id>
    tag role => <@&role_id>
    tag everyone => @everyone
]]

Config.WebHook  = {
    ['default'] = {
        url = '',
        tag = '@everyone'
    },
    ['login'] = {
        url = 'https://discord.com/api/webhooks/1091151120442871918/G2qCRnCtuRhKpSY2mNir7kXvVmyDd7rxUfv7_q605kOewCFL4YpPZg35owxQwmIhXHsU'
    },
    ['logout'] = {
        url = ''
    },
    ['server'] = {
        url = '',
        tag = ''--'@everyone'
    },
    ['resources'] = {
        url = '',
        tag = ''
    },
    ['error'] = {
        url = '',
        tag = ''
    },
    ['kills'] = {
        url = '',
        tag = ''
    }

}