fx_version 'adamant'
game 'gta5'

lua54 'yes'

description 'ESX Menu Default'

version '1.0.2'

client_scripts {
	'@es_extended/imports.lua',
	'@es_extended/client/wrapper.lua',
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic2.ttf',
	'html/fonts/ChaletLondonNineteenSixty.ttf',
	'html/fonts/signpainter.ttf',
	'html/fonts/bankgothic.ttf',
    'html/fonts/v.ttf',

}

dependencies {
	'es_extended'
}
