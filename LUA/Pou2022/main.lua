local scriptPlayer = require ("Player")
local perspective = require ("perspective")
local physics = require ("physics")

physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("hybrid")


local camera = perspective.createView ()
camera:prependLayer () -- Prepara os layers da camera.

display.setStatusBar (display.HiddenStatusBar)

-- BG 

for i = 0, 4 do 
    local plataforma = display.newRect (50, 50, 50, 50)
    plataforma.x = 100*i 
    plataforma.y = math.random (-30, 450)
    physics.addBody (plataforma, "static", {friction = 1})
    camera:add (plataforma, 1)
end

local chao = display.newRect (200, 200, 400, 200)
chao.x = display.contentCenterX
chao.y = 550
physics.addBody (chao, "static", {friction = 1})
camera:add (chao, 1)

local player = scriptPlayer.novo (240,0)
camera:add (player, 1)

camera:setParallax (0,0,0,0,0,0,0,0)

camera.damping = 10

camera:setFocus (player) -- Define o foco da câmera. 
camera:track() -- inicia a perseguição da camera. 