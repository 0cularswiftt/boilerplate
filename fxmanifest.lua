fx_version "cerulean"
game "gta5"
lua54 "yes"

author "0cular"
description "React boilerplate for FiveM"
version "1.0.0"

client_scripts {
    "bridge/client/**/*.*",
    "client/*.lua",
    "client/modules/*.lua"
}

server_scripts {
    "bridge/server/**/*.*",
    "server/*.lua",
    "server/modules/*.lua"
}

shared_scripts {
    "@ox_lib/init.lua",
    "shared/*.lua"
}

escrow_ignore {
    "shared/*.lua"
}

ui_page "web/build/index.html"

files {
    "web/build/index.html",
    "web/build/assets/**/*.*"
}