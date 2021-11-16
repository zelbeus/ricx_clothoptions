fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"
lua54 'yes'

dependencies {
    'redemrp_clothing',--https://github.com/RedEM-RP/redemrp_clothing
    'redemrp_menu_base'--https://github.com/RedEM-RP/redemrp_clothing
}



client_scripts {
    'client.lua',
    '@redemrp_clothing/client/cloth_hash_names.lua'
}
server_scripts {
    'server.lua'
}
