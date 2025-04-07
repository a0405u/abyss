DEBUG = true

GRAVITY = 9.8
DRAG = 2

TILESIZE = 4

NAIL_STRENGTH = math.pow(2, 10)
PLANK_STRENGTH = 1000

DS_BUILDING = 80

BASE_WOOD  = 160
BASE_STONE = 80
BASE_FOOD  = 40

       INCOME_MINE = {wood = 0,    stone = 4,      food = 0}
    INCOME_SAWMILL = {wood = 8,    stone = 0,      food = 0}
   INCOME_WINDMILL = {wood = 0,    stone = 0,      food = 2}

        COST_PLANK = {wood = 10,    stone = 0,      food = 0}
        COST_BLOCK = {wood = 10,    stone = 20,     food = 0}
        COST_SOIL  = {wood = 0,     stone = 10,     food = 20}
        COST_HOUSE = {wood = 0,     stone = 10,     food = 10}
     COST_WINDMILL = {wood = 20,    stone = 10,     food = 0}
   COST_LUMBERMILL = {wood = 10,    stone = 10,     food = 0}
     COST_TOWNHALL = {wood = 40,    stone = 20,     food = 40}
         COST_MINE = {wood = 20,    stone = 10,     food = 10}

-- PHYSYCS CO
PC_PLAYER = 2
PC_PLANK = 3
PC_COLUMN = 4
PC_PLATFORM = 5
PC_BUILDING = 6
PC_GIB = 7
PC_PLAYER_AREA = 8
PC_PLAYER_FLOOR_BOX = 9
PC_BLOCK = 10

-- DRAWING LAYERS
DL_BACKGROUND = 2
DL_HILL_BG = 4
DL_COLUMN = 10
DL_TILE = 12
DL_BUILDING = 15
DL_PLATFORM = 20
DL_GIB = 25
DL_HILL = 28
DL_NAIL = 30
DL_PLAYER = 90
DL_GHOST = 95

DL_UI = 100
DL_UI_BUTTON = 180
DL_UI_ICON = 200
DL_UI_TEXT = 220
DL_UI_MOUSE = 300