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
    self.contacts = {}
end


function BuildingBlock:clone()

    return self.class(self.position, self.rotation, self.sprite, self.dl)
end


function BuildingBlock:update(dt)
    Building.update(self, dt)

    for key, contact in pairs(self.contacts) do
        if contact.object:is(BuildingBlock) and contact.secondary then
            self:connect(contact.object)
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

--- Connect block to self
--- @param block BuildingBlock block to connect
function BuildingBlock:connect(block)

    if self.connected[block] then return end

    local x = (self.position.x + block.position.x) / 2.0
    local y = (self.position.y + block.position.y) / 2.0
    local joint = love.physics.newWeldJoint(self.body, block.body, x, y)

    table.insert(self.joints, joint)
    table.insert(block.joints, joint)

    self.connected[block] = block
    block.connected[self] = self
end


function BuildingBlock:begincontact(a, b, contact)

    local object = b:getBody():getUserData()
    local xa, ya, xb, yb = contact:getPositions();
    local cache = {
        position = Vector(xa, ya),
        secondary = xb and Vector(xb, yb) or nil, -- might be absent
        normal = Vector(contact:getNormal()),
        object = object
    }

    self.contacts[object] = cache
end


function BuildingBlock:endcontact(a, b, contact)

    local object = b:getBody():getUserData()

    self.contacts[object] = nil
end


-- function BuildingBlock:postsolve(a, b, contact, normalimpulse, tangentimpulse)
    -- Building.postsolve(self, a, b, contact, normalimpulse, tangentimpulse)

    -- audio.play(sound.collide)
    -- if normalimpulse > 1000 then print(normalimpulse) end
    -- print(self.body:getMass())
    -- self.dimpulse = self.dimpulse + normalimpulse + math.abs(tangentimpulse)
-- end


return BuildingBlock
