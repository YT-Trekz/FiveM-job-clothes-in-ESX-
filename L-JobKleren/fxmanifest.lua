fx_version 'adamant'
game 'gta5'

author 'MadeByアンディ | L-Leaks Scripts'
description 'ESX L-JobKleren'
version '1.0.0'

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'client/client.lua'
}

shared_scripts {
	'config.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/en.lua',
  'server/server.lua'
}