Config = {}
Config.ValidateLicense = true -- Activar o desactivar el loggin de los jugadores

Config.loggins = false -- Activar o desactivar el loggin de los jugadores
Config.resources = true -- Activar o desactivar para ver si se reinicia algun recursos
Config.kills = true -- Activar o desactivar para ver las meurtes de los jugadores
Config.startServer = false -- Activar o desactivar para ver cuando se inicia el servidor
Config.connect = 'your https: connect'

Config.devLicenses = {
    'db30949fe3bbb1d5a7ab5a05806d814f753cf6a3' -- tanque_tm license
}

Config.licenses = {
    License = {
        prefix = "license",
        active = true,
        mandatory = false,
    },
    Discord = {
        prefix = "discord",
        active = true,
        mandatory = false,
    },
    Xbl = {
        prefix = "xbl",
        active = true,
        mandatory = false,
    },
    LiveID = {
        prefix = "live",
        active = true,
        mandatory = false,
    },
    Fivem = {
        prefix = "fivem",
        active = true,
        mandatory = true,
    },
    SteamID = {
        prefix = "steam",
        active = true,
        mandatory = false,
    },
}
