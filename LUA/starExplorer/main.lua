----------------- fisica -----------
local physics = require ("physics")
physics.start ()
physics.setGravity (0 , 0)
physics.setDrawMode ("hybrid")
------ desabilitar barra de notificação ---------
display.setStatusBar (display.HiddenStatusBar)
---------------------- sprites -----------

local spiteOpcoes = 
{
    frames = {
        {-- 1) asteroide 1
            x=0,
            y=0,
            width = 102,
            height = 85
        },
        {-- 2) asteroide 2
        x=0,
        y=85,
        width = 90,
        height = 83
        },
        {-- 3) asteroide 3
        x=0,
        y=168,
        width = 100,
        height = 97
        },
        {-- 4) nave
        x=0,
        y=265,
        width = 98,
        height = 79
        },
        {-- 5) lazer
        x=98,
        y=265,
        width = 14,
        height = 40
        }
    }
}

local sprite = graphics.newImageSheet ("imagens/sprite.png", spiteOpcoes)

------------------------grupos de exibição ------
local backGroup = display.newGroup ()
local mainGroup = display.newGroup ()
local UIGroup = display.newGroup ()
----------- inclusão das imagens e parametros ------

local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local nave = display.newImageRect (mainGroup, sprite, 4, 98, 79)
nave.x = display.contentCenterX
nave.y = display.contentHeight - 100

-------- isSensor NÃO INTERFERE NA COLISÃO É SÓ SENSOR
------ isBullet funciona como tiro (TEM A DETECÇÃO MELHORADA)
physics.addBody (nave, "dynamic", {radius = 30, isSensor = true})
nave.myName = "nave"

local vidas = 3
local pontos = 0
local asteroidesTable = {}
math.randomseed (os.time ()) -- faz com que o math.random não tenha padrão previsivel
local gameLoopTimer
local morto = false

-- display.screenOriginX = inicio da tela em X,display.screenOriginY = inicio da tela em Y, display.contentHeight = final da tela em Y, display.contentWidth = final da tela em X

local vidasText = display.newText (UIGroup, "Vidas: " .. vidas, display.screenOriginX + 150, display.screenOriginY + 80, native.systemFont, 36)

local pontosText = display.newText (UIGroup, "Pontos: " .. pontos, display.screenOriginX + 350, display.screenOriginY + 80, native.systemFont, 36)

local function criarAsteroide ()
    
    local novoAsteroide = display.newImageRect (mainGroup, sprite, 1, 102, 85)
    table.insert (asteroidesTable, novoAsteroide)
    physics.addBody(novoAsteroide,"dynamic", {radius = 40, bounce =0.8})
    novoAsteroide.myName = "asteroide"

    local localizacao = math.random (3)
    if (localizacao == 1) then
        novoAsteroide.x = -60
        novoAsteroide.y = math.random (500)
        --------- setLinearVelocity (em X, e em Y)
        novoAsteroide:setLinearVelocity (math.random (40, 120), math.random (20,60))
    elseif (localizacao == 2) then
        novoAsteroide.x = math.random (display.contentWidth)
        novoAsteroide.y = -60
        novoAsteroide:setLinearVelocity (math.random (-40, 40), math.random (40, 120))
    elseif (localizacao == 3) then
        novoAsteroide.x = display.contentWidth + 6
        novoAsteroide.y = math.random (500)
        novoAsteroide:setLinearVelocity (math.random(-120, -40), math.random (20,60))
    end
    --- applyTorque = giro no eixo
    novoAsteroide:applyTorque (math.random (-6, 6))
end

local function atirar ()
    local laser = display.newImageRect (mainGroup, sprite, 5, 14, 40)
    physics.addBody (laser, "dynamic", {isSensor = true})
    laser.isBullet = true
    laser.myName = "laser"
    laser.x, laser.y = nave.x, nave.y
    laser:toBack()

    transition.to (laser, {y=-40, time=500, onComplete = function () display.remove (laser)end})
end

nave:addEventListener ("tap", atirar)

local function moverNave (event)
    local nave = event.target
    local phase = event.phase

    if ("began" == phase) then
-- define nava como foco de toque (os outros objs com toque não são afetados)
        display.currentStage:setFocus (nave)
--define a localização inicial
        nave.touchOffsetX = event.x - nave.x
    elseif ("moved" == phase) then
        if (nave.x >= display.contentWidth - 40) then
            display.currentStage:setFocus (nil)
            nave.x = display.contentWidth - 41
        elseif (nave.x <= 40) then
            display.currentStage:setFocus (nil)
            nave.x = 41
        else
            nave.x = event.x - nave.touchOffsetX
        end
    elseif ("ended" == phase or "canceled" == phase) then
        display.currentStage:setFocus (nil)
    end
    return true
end

nave:addEventListener ("touch", moverNave)

local function gameLoop ()
    criarAsteroide ()
--- para i = grupo( ex. #asteroidesTable = 10 e , 1 inicio e -1  menus um ate 1)
    for i = #asteroidesTable, 1, -1 do
        local thisAsteroide = asteroidesTable [i]
        if (thisAsteroide.x < -100 or thisAsteroide.x > display.contentWidth + 100 or thisAsteroide.y < -100 or thisAsteroide.y > display.contentHeight + 100) then
            display.remove (thisAsteroide)
            table.remove(asteroidesTable, i)
        end
    end
end

gameLoopTimer = timer.performWithDelay (700, gameLoop, 0)

local function restauraNave ()

    nave.isBodyActive = false
    nave.x = display.contentCenterX
    nave.y = display.contentHeight -100

    transition.to (nave, {alpha=1, time=4000, onComplete = function () 
        nave.isBodyActive = true
        morto = false
    end})
end


local function onColision (event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "laser" and obj2.myName == "asteroide") or (obj2.myName == "laser" and obj1.myName == "asteroide")) then
            display.remove (obj1)
            display.remove (obj2)

            for i = #asteroidesTable, 1, -1 do 
                if (asteroidesTable [i] == obj1 or asteroidesTable [i] == obj2) then
                    table.remove (asteroidesTable, i)
                    --- para a função após localizar e não remover o outro astreroide
                    break
                end
            end
            pontos = pontos + 100
            pontosText.text = "Pontos: " .. pontos
        elseif ((obj1.myName == "nave" and obj2.myName == "asteroide") or (obj2.myName == "nave" and obj1.myName == "asteroide")) then

            if (morto == false) then
                morto = true

                vidas = vidas - 1
                vidasText.text = "Vidas: " .. vidas
                if (vidas == 0) then
                    display.remove (nave)
                else
                    nave.alpha = 0
                    timer.performWithDelay (1000, restauraNave)
                end
            
            end
        end
    end
end

Runtime:addEventListener ("collision", onColision)