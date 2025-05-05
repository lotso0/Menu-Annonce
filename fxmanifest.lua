fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'lotso'

shared_script '@es_extended/imports.lua'

client_scripts {
    -- RageUI base
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',

    -- RageUI components
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',

    -- Config & client logic
    'RageUI/configk2r.lua',
    'client.lua',
    'exemple.lua'
}

server_script 'server.lua'
