--- @class BuildingBlock: Building
local BuildingBlock = class("BuildingBlock", Building)

local DIR = {
    [1] = Vector( 1,  0),
    [2] = Vector( 0, -1),
    [3] = Vector(-1,  0),
    [4] = Vector( 0,  1)
}

--- comment
--- @param position Vector|nil
--- @param rotation number|nil
--- @param sprite Sprite
--- @param dl number|nil
function BuildingBlock:init(position, rotation, sprite, dl)

    Building.init(self, position, rotation, sprite or sprites.buildings.block, nil, dl or DL_BUILDING)
    self.cost = COST_BLOCK
    self.durability = DUR_BLOCK
    self.category = {PC_BLOCK}
    self.mask = {PC_BEAM}
    self.connected = {}
    self.nails = {}
    self.joints = {}
    self.sensors = {
        love.physics.newFixture(self.body, love.physics.newRectangleShape(DIR[1].x * TILESIZE, DIR[1].y * TILESIZE, SNS_BLOCK, SNS_BLOCK), DS_SENSOR),
        love.physics.newFixture(self.body, love.physics.newRectangleShape(DIR[2].x * TILESIZE, DIR[2].y * TILESIZE, SNS_BLOCK, SNS_BLOCK), DS_SENSOR),
        love.physics.newFixture(self.body, love.physics.newRectangleShape(DIR[3].x * TILESIZE, DIR[3].y * TILESIZE, SNS_BLOCK, SNS_BLOCK), DS_SENSOR),
        love.physics.newFixture(self.body, love.physics.newRectangleShape(DIR[4].x * TILESIZE, DIR[4].y * TILESIZE, SNS_BLOCK, SNS_BLOCK), DS_SENSOR),
    }
    for i, sensor in ipairs(self.sensors) do
        sensor:setSensor(true)
    end
    self.contacts = {}
end


function BuildingBlock:clone()

    return self.class(self.position, self.rotation, self.sprite, self.dl)
end


function BuildingBlock:update(dt)
    Building.update(self, dt)

    for key, contact in pairs(self.contacts) do
        if contact.sensor:testPoint(contact.block.body:getPosition()) then
            self:connect(contact.block, contact.direction)
            self.contacts[key] = nil
        end
    end
end


function BuildingBlock:destroy(position)
    for key, nail in pairs(self.nails) do
        nail:destroy()
    end

    Building.destroy(self, position)
end

--- Connects block to this block at given side
--- @param block BuildingBlock block to connect
--- @param direction Vector normal from the center pointing to the side
function BuildingBlock:connect(block, direction)

    for i, b in ipairs(self.connected) do
        if b == block then return end
    end

    local rotation = self.body:getAngle()
    local position = self.position + direction:rotated(rotation) * TILESIZE

    block.body:setAngle(rotation)
    block.body:setPosition(position:split())

    local x = (self.position.x + position.x) / 2.0
    local y = (self.position.y + position.y) / 2.0
    local joint = love.physics.newWeldJoint(self.body, block.body, x, y)

    table.insert(self.joints, joint)
    table.insert(block.joints, joint)
    table.insert(self.connected, block)
    table.insert(block.connected, self)
end


function BuildingBlock:begincontact(a, b, contact)

    local body = b:getBody()
    local object = body:getUserData()

    if object:is(BuildingBlock) then
        for i, sensor in ipairs(self.sensors) do
            if a == sensor then self.contacts[object] = {block = object, sensor = a, direction = DIR[i]} end
        end
    end
end


function BuildingBlock:endcontact(a, b, contact)

    local body = b:getBody()
    local object = body:getUserData()

    if object:is(BuildingBlock) then
        self.contacts[object] = nil
    end
end


-- function BuildingBlock:postsolve(a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    -- self.dimpulse = self.dimpulse + normalimpulse + math.abs(tangentimpulse)
-- end


return BuildingBlock
