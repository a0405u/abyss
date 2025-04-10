zip abyss.zip -r -q classes fonts lib modules sounds sprites config.lua constants.lua headers.lua main.lua
rm -rf release/latest
mkdir release/latest
mv abyss.zip release/latest/abyss.love

mkdir release/latest/web
zip build/abyss_web.zip build/* -y -r -q
cp -r build/* release/latest/web/

cd release

mkdir latest/win
cp bin/win/* latest/win/
cd latest/win
cat love.exe ../abyss.love > abyss.exe
zip abyss_win.zip * -y -r -q
cd ../..

mkdir latest/mac
mkdir latest/mac/abyss.app
cp -r bin/mac/Contents latest/mac/abyss.app/Contents
cp latest/abyss.love latest/mac/abyss.app/Contents/Resources/abyss.love
cd latest/mac
zip abyss_macos.zip abyss.app -y -r -q
cd ../..