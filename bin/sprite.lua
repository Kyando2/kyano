local Sprite = require("bin.class")("Sprite")

Sprite.sprites = {}
Sprite.init = false
Sprite.lytable = {}

function Sprite:__init(sprite, sx, sy, visible, x, y, r, ly)
    -- Add attributes
    self.sprite = sprite
    self.x = x or 0
    self.y = y or 0
    self.scale_x = sx or 1
    self.scale_y = sy or 1
    self.rotation = r or 0
    self.visible = ( visible == nil and true) or visible
    self.layer = 1 or ly
    table.insert(Sprite.sprites, self)
    return self
end

function Sprite:draw()
    if self.visible then
        love.graphics.draw(self.sprite, self.x, self.y, self.rotation, self.scale_x, self.scale_y)
    end
end

function Sprite:draw_all()
    if self.init == false then error("Tried drawing without initializing sprites") end
    for _, layer in ipairs(self.lytable) do
        for _, sprite in ipairs(layer) do
            sprite:draw()
        end
    end
end

function Sprite:start()
    for _, sprite in ipairs(self.sprites) do
        if self.lytable[sprite.layer] == nil then self.lytable[sprite.layer] = {sprite} else
        table.insert(self.lytable[sprite.layer], sprite) end
    end
    self.init = true
end

local Tile, _ = require("bin.class")("Tile", Sprite)


return {tile = Tile, sprite = Sprite}