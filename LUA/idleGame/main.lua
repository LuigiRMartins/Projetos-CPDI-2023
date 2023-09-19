 --local scriptCamera = require ("camera")
--local scriptGame = require ("game")


-- local physics = require ("physics")
-- physics.start ()
-- physics.setGravity (0, 9.8)
-- physics.setDrawMode ("hybrid")

-------------------------------------------
local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para os objetos que terão interação dentro do jogo, grupo principal. 
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo porém sem interação.

local scriptHud = require("HUD")
local perspective = require("perspective")

local camera = perspective.createView()
camera:prependLayer() -- Prepare camera layers.

local water = display.newRect (2000,2000, 2000,2000)
water.x = display.contentCenterX
water.y = display.contentCenterY
water:setFillColor (0.03, 0.23,0.72)
mainGroup:insert (water)
camera:add(water,2)

local mapScale = 2
local map = display.newImageRect("imagens/map.png", 1536 * mapScale, 2048 * mapScale)
map.y = display.contentCenterY
map.x = display.contentCenterX
mainGroup:insert (map)
camera:add(map, 1)


local player = display.newCircle(20, 20, 20, 20)
player.y = display.contentCenterY
player.x = display.contentCenterX
player.alpha = 0
mainGroup:insert (player)
camera:add(player, 1)


local playerRadius = player.width * 0.5
local mapBounds = { 
    left = map.x - map.width * 0.5 + playerRadius,
    right = map.x + map.width * 0.5 - playerRadius,
    top = map.y - map.height * 0.5 + playerRadius,
    bottom = map.y + map.height * 0.5 - playerRadius 
}

local touchOffsetX, touchOffsetY

local function movePlayer(event)
    local phase = event.phase
    local touchX, touchY = event.x, event.y

    if phase == "began" then
        -- Player movement begins when the touch starts
        transition.cancel(player) -- Cancel any ongoing transitions to avoid conflicts
        player.isMoving = true

        -- Calculate the touch offset from the player's current position
        touchOffsetX = player.x - touchX
        touchOffsetY = player.y - touchY

        -- Start camera tracking when the touch begins
        camera:track()
    elseif phase == "moved" then
        -- Update player's position during the touch movement
        if player.isMoving then
            -- Calculate the new position with touch offset
            local newX = touchX + touchOffsetX
            local newY = touchY + touchOffsetY

            -- Limit the player's position within the map bounds
            newX = math.max(mapBounds.left, math.min(newX, mapBounds.right))
            newY = math.max(mapBounds.top, math.min(newY, mapBounds.bottom))

            player.x, player.y = newX, newY
        end
    elseif phase == "ended" or phase == "cancelled" then
        -- Player movement ends when the touch ends or is cancelled
        player.isMoving = false
    end
end

map:addEventListener("touch", movePlayer)
water:addEventListener("touch", movePlayer)

camera:setParallax(0, 0, 0, 0, 0, 0, 0, 0)
camera.damping = 20
camera:setFocus(player) -- Define the camera focus.
