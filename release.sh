zip abyss.zip -r classes fonts lib modules sounds sprites config.lua constants.lua headers.lua main.lua
rm -rf release/latest
mkdir release/latest
mv abyss.zip release/latest/abyss.love

cd release

mkdir latest/win
cp bin/win/* latest/win/
cd latest/win
cat love.exe ../abyss.love > abyss.exe
zip abyss_win.zip * -y -r
cd ../..

mkdir latest/mac
cp -r bin/mac/* latest/mac/abyss.app/
cp latest/abyss.love latest/mac/abyss.app/Contents/Resources/abyss.love
cd latest/mac
zip abyss_macos.zip abyss.app -y -r
cd ../..