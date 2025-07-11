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
Vector = require "lib/brinevector"
Window = require "classes/window"
Queue = require "classes/queue"
Deque = require "classes/deque"
Timer = require "classes/timer"
Time = require "classes/time"
Sprite = require "classes/sprite"
Animation = require "classes/animation"
Mouse = require "classes/mouse"
Object = require "classes/object"
CanvasArea = require "classes/canvasarea"
UIElement = require "classes/uielement"
Button = require "classes/button"

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

-- Classes

UI = require "modules.ui"
Camera = require "classes/camera"
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

-- Tools

Tool = require "classes/tools/tool"
ToolHand = require "classes.tools.hand"
ToolPlank = require "classes.tools.plank"
ToolTile = require "classes.tools.tile"
ToolBuilding = require "classes.tools.building"
ToolHammer = require "classes.tools.hammer"

-- Tiles

TileContainer = require "classes.tiles.container"
TileBlock = require "classes.tiles.block"
TileSoil = require "classes.tiles.soil"
TileSupport = require "classes.tiles.support"
TileWheat = require "classes.tiles.wheat"
TileTree = require "classes.tiles.tree"

-- Buildings

Building = require "classes.buildings.building"
BuildingHouse = require "classes.buildings.house"
BuildingMine = require "classes.buildings.mine"
BuildingWindmill = require "classes.buildings.windmill"
BuildingSawmill = require "classes.buildings.sawmill"
BuildingBlock = require "classes.buildings.block"