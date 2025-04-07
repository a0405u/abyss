local font = {}


function font.bitmap(path, height, glyphs)

    local imagedata = love.image.newImageData(path)

    local sourcewidth = imagedata:getWidth()
    local lines = imagedata:getHeight() / height
    local width = sourcewidth * lines

    local fontdata = love.image.newImageData(width, height)

    for line = 0, lines do
        fontdata:paste(imagedata, sourcewidth * line, 0, 0, line * height, sourcewidth, height)
    end

    return love.graphics.newImageFont(fontdata, glyphs)
end


-- font.default = love.graphics.newFont("Fonts/IBM_BIOS.ttf", 8)
-- font.small = love.graphics.newFont("Fonts/EverexME.ttf", 8)
font.default = font.bitmap("fonts/bold.png", 9, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}~АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
-- font.default:setLineHeight(0.9)
font.small = font.bitmap("fonts/small.png", 8, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
font.smallinverted = font.bitmap("fonts/smallinverted.png", 8, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
-- font.small:setLineHeight(6/9)
font.mono = font.bitmap("fonts/mono.png", 8, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя█▒~")
font.monoinv = font.bitmap("fonts/monoinv.png", 8, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя█▒~")
font.monobold = font.bitmap("fonts/monobold.png", 8, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя█▒~")
love.graphics.setFont(font.default)


return font