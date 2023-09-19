-- Chamando os scripts criados para o projeto. 
local scriptPlayer = require ("Player")
local scriptInimigo = require ("Inimigo")
local scriptHud = require ("HUD")
local scriptColetavel = require ("Coletavel")

local physics = require ("physics")
physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.png", 800*0.7, 600*0.7)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5)
chao.x = display.contentCenterX
chao.y = display.contentHeight + 30
-- Parâmetro para criar a box {x ref imagem =, y ref a imagem=, metade da largura box=, metade da altura box=, angulo da box= }
physics.addBody (chao, "static", {friction = 1, box = {x = 0, y = 0, halfWidth = 480, halfHeight = 40, angle = 0}})