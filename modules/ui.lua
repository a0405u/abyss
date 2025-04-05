local ui = {}


function ui.init()
    ui.mouse = Mouse(sprites.mouse, screen.scale)
end


function ui.draw()
    ui.mouse:draw()
end


function ui.update(dt)
    ui.mouse:update(dt)
end


return ui