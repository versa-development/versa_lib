fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
dependencies {
  '/onesync', -- requires state awareness to be enabled
}

name 'versa_lib'
author 'Versa Development'
version '0.1'
games { 'rdr3', 'gta5' }
description 'A modular utility library for FiveM & RedM'

files {
  'init.lua',
  'bridge/**/*.lua',
  'modules/**/*.lua',
  'config.lua',
}

client_scripts {'
  'runtime/**/client.lua',
}

server_scripts {
  'runtime/**/server.lua',
}