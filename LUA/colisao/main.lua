local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local cima = display.newRect (display.contentCenterX, -20, 500, 50)
physics.addBody (cima, "static")
cima.myName = "Teto"

local baixo = display.newRect (display.contentCenterX, 500, 500, 50)
physics.addBody (baixo, "static")
baixo.myName = "Chao"

local esquerda = display.newRect (-40, 0, 50, 1000)
physics.addBody (esquerda, "static")
esquerda.myName = "GolVermelho"

local direita = display.newRect (360, 10, 50, 1000)
physics.addBody (direita, "static")
direita.myName = "GolAzul"

local bola1 = display.newImageRect ("imagens/bola1.png", 481*0.2, 518*0.2)
bola1.x = display.contentCenterX
bola1.y = display.contentCenterY
physics.addBody (bola1, {bounce = 0.8, radius = 48})
bola1.myName = "Bola um"

local bola2 = display.newImageRect ("imagens/bola2.png", 500*0.2, 500*0.2)
bola2.x = display.contentCenterX
bola2.y = 100
physics.addBody (bola2, {bounce = 0.5, radius = 45})
bola2.myName = "Bola dois"