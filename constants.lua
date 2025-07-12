VERSION = "1.1"
DATE = "26.04.2025"
AUTHORS = "a0405u and onhore for Ludum Dare 57"
DEBUG = false

GRAVITY = 9.8
DRAG = 2
JUMP = (DEBUG and 16) or 8

SAND_FORCE = 100

RNG_PLANK_TOOL = 8

HAND_PULL_FORCE = 2048
MOUSE_PULL_FORCE = 2048
MOUSE_DAMPING = 2
MOUSE_FREQUENCY = 1
MOUSE_SUPPORT_STRENGTH = math.pow(2, 100)

TILESIZE = 4

NAIL_STRENGTH = math.pow(2, 10)
PLANK_STRENGTH = 1000
BUILDING_STRENGTH = 10000
GIB_STRENGTH = 1200

LN_PLANK_MIN = 2
LN_PLANK_MAX = 8

GIB_SPEED = 20

RST_GROUND = -1

DS_BUILDING = 80
DS_PLANK = 28

BASE_WOOD  = 160
BASE_STONE = 80
BASE_FOOD  = 40

INCOME_HOUSE = {wood = 0.1, stone = 0.1, food = 0.1}
INCOME_MINE = {wood = 0, stone = 0.6, food = 0}
INCOME_SAWMILL = {wood = 0.6, stone = 0, food = 0}
INCOME_WINDMILL = {wood = 0, stone = 0, food = 0.6}

COST_NONE = {wood = 0, stone = 0, food = 0}
COST_PLANK = {wood = 10, stone = 0, food = 0}
COST_BLOCK = {wood = 10, stone = 20, food = 0}
COST_SOIL = {wood = 0, stone = 10, food = 20}
COST_SUPPORT = {wood = 20, stone = 20, food = 0}
COST_WHEAT = {wood = 0, stone = 0, food = 30}
COST_TREE = {wood = 30, stone = 0, food = 0}
COST_HOUSE = {wood = 0, stone = 10, food = 10}
COST_WINDMILL = {wood = 20, stone = 10, food = 10}
COST_SAWMILL = {wood = 10, stone = 10, food = 20}
COST_MINE = {wood = 20, stone = 10, food = 30}
COST_TOWNHALL = {wood = 40, stone = 20, food = 40}

MLT_TREE = 0.5
MLT_WHEAT = 0.5

-- PHYSYCS CO
PC_PLAYER = 2
PC_PLANK = 3
PC_BEAM = 4
PC_PLATFORM = 5
PC_BUILDING = 6
PC_GIB = 7
PC_PLAYER_AREA = 8
PC_PLAYER_FLOOR_BOX = 9
PC_BLOCK = 10
PC_GROUND = 11
PC_GHOST = 12
PC_WALL = 13
PC_BGBLOCK = 14

-- DRAWING LAYERS
DL_BACKGROUND = 2
DL_SUPPORT = 3
DL_HILL_BG = 4
DL_TREE = 8
DL_BEAM = 10
DL_BUILDING = 15
DL_WALL = 18
DL_PLATFORM = 20
DL_GIB = 25
DL_NAIL = 26
DL_TILE = 27
DL_HILL = 28
DL_PLAYER = 90
DL_GROUND = 92
DL_WHEAT = 94
DL_GHOST = 95

DL_UI = 100
DL_UI_BUTTON = 180
DL_UI_ICON = 200
DL_UI_TEXT = 220
DL_UI_MOUSE = 300