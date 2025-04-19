-- if pcall(require, "lldebugger") then require("lldebugger").start() end
-- if pcall(require, "mobdebug") then require("mobdebug").start() end

class = require "lib/middleclass"
peachy = require "lib/peachy"
deep = require "lib/deep"
time = require "lib/cron"
utf8 = require "lib/utf8"
file = require "lib/file"
json = require "lib/json"

Signal = require "lib/signal"
Vector2 = require "classes/vector2"
Vector3 = require "classes/vector3"
Queue = require "classes/queue"
Deque = require "classes/deque"
Timer = require "classes/timer"
Sprite = require "classes/sprite"
Animation = require "classes/animation"
Button = require "classes/button"
Mouse = require "classes/mouse"

require "lib/support"
require "constants"

config = require "config"

-- Modules

debug = require "modules/debug"
font = require "modules/font"
audio = require "modules/audio"
sound = require "modules/sound"
input = require "modules/input"
path = require "modules/path"
screen = require "modules/screen"
canvas = require "modules/canvas"
color = require "modules/color"
game = require "modules/game"
sprites = require "modules/sprites"
ui = require "modules/ui"

-- Classes

Camera = require "classes/camera"
Object = require "classes/object"
Drawable = require "classes/drawable"
Tile = require "classes.tiles.tile"
Tilemap = require "classes/tilemap"
Map = require "classes/map"
Resource = require "classes/resource"
Economy = require "classes/economy"
Actor = require "classes/actor"
Plank = require "classes/plank"
Nail = require "classes/nail"
Gib = require "classes/gib"

Tool = require "classes/tools/tool"
ToolPlank = require "classes.tools.toolplank"
ToolTile = require "classes.tools.tooltile"
ToolBuilding = require "classes.tools.toolbuilding"

Block = require "classes.tiles.block"
Soil = require "classes.tiles.soil"

Building = require "classes.buildings.building"
Mine = require "classes.buildings.mine"
Windmill = require "classes.buildings.windmill"
Sawmill = require "classes.buildings.sawmill"