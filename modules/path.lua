local Grid = require("lib/jumper.grid")
local Pathfinder = require ("lib/jumper.pathfinder")


local path = {}


function path.load()
    
    path.walkable = 0

    path.grid = Grid(game.map.getGrid())

    path.finder = Pathfinder(path.grid, 'ASTAR', path.walkable) 
    path.finder:setMode("ORTHOGONAL")
end

function path.update(grid)

    path.finder:setGrid(Grid(grid))
end

function path.get(startx, starty, destx, desty, walkable)

    path.finder:setWalkable(walkable or path.walkable)
    local path = path.finder:getPath(startx, starty, destx, desty)

    return path
end


return path