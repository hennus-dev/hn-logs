fx_version 'cerulean'

game 'gta5'

author 'Hakos'
version '0.1.0-alpha'

description 'Sistema de logs basico [Lazarus-dev]'

shared_script {
    'config.lua',
    'configs/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/licenses.lua'
}

lua54 'yes'

