fx_version 'adamant'

game 'gta5'

shared_scripts {
    "@es_extended/imports.lua",
    "@es_extended/locale.lua"
}

client_scripts {
	"vendors/RageUI/RMenu.lua",
	"vendors/RageUI/menu/RageUI.lua",
	"vendors/RageUI/menu/Menu.lua",
	"vendors/RageUI/menu/MenuController.lua",
	"vendors/RageUI/components/*.lua",
	"vendors/RageUI/menu/elements/*.lua",
	"vendors/RageUI/menu/items/*.lua",
	"vendors/RageUI/menu/panels/*.lua",
	"vendors/RageUI/menu/windows/*.lua",

    "client/**/*.lua",
    "config.lua"
}

server_scripts {
	'@es_extended/common/modules/async.lua',
	'@oxmysql/lib/MySQL.lua',
    "server/**/*.lua",
    "config.lua"
}