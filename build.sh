#!/bin/bash

# cd ~/dev/love/
# rm -rf abyss/build
# npx love.js abyss build -m 1280000000 -t abyss
# mv build abyss/build
# cd abyss

rm -rf src
mkdir src
cp -R classes src/classes
cp -R fonts src/fonts
cp -R lib src/lib
cp -R modules src/modules
cp -R sounds src/sounds
cp -R sprites src/sprites
cp config.lua src/
cp constants.lua src/
cp headers.lua src/
cp main.lua src/

rm -rf build
npx love.js src build -m 1280000000 -t abyss -c
cp release/theme/love.css build/theme/love.css