local physics = require ("physics")
local perspective = require("perspective")

display.setStatusBar (display.HiddenStatusBar)

physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("hybrid")

local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para os objetos que terão interação dentro do jogo, grupo principal. 
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo porém sem interação.

local camera = perspective.createView()
camera:prependLayer () -- Prepara os layers da camera.

pontuacao = 0

local spriteGaroto = graphics.newImageSheet ("imagens/garoto.png", {width = 1136, height = 1630, numFrames = 6})

local spriteGarotoAnimacao = {
{name = "parado", start = 1, count = 1, time = 1000, loopCount = 0},
{name = "correndo", start = 1 , count = 6, time = 1000, loopCount = 0},
}

local bg = display.newImageRect ("imagens/Background.png", 8000*0.11, 4500*0.11)
bg.x = display.contentCenterX
bg.y = display.contentCenterY 
backGroup:insert (bg)
camera:add (bg, 8)


local chao = display.newImageRect ('imagens/chao.png', 4503,613)
chao.x = display.contentCenterX
chao.y = 445
chao.xScale = 0.2
chao.yScale = 0.2

physics.addBody (chao,"static", {friction=1, box={x= -10, y=05, halfWidth=2000, halfHeight=34, angle=0}})


backGroup:insert (chao)
camera:add (chao,1)

local player = display.newSprite (spriteGaroto, spriteGarotoAnimacao)
player.id = "player"
player.x = display.contentCenterX
player.y = 100
player.xScale = 0.10
player.yScale = 0.10
player.speed = 5
player.isFixedRotation = true
player.numeroPulo = 0
mainGroup:insert (player)
camera:add (player, 1)

physics.addBody (player, {friction=0.25, box={x= -10, y=0, halfWidth=45, halfHeight=85, angle=0}})

-- Defini sequencia inicial animação. 
player:setSequence ('parado')

-- Inicia a animação. 
player:play ()
--------------------------
camera:setParallax (5,3,0.5,0.2,0.1,0.6,0.9,1)

camera.damping = 10 -- Controla a fluidez da camera ao seguir o player. 

camera:setFocus (player) -- Define o foco da câmera. 
camera:track() -- inicia a perseguição da camera. 


local function verificarTecla (event)
        -- se a fase de evento for down (tecla pressionada) então
        if event.phase == "down" then
            -- se a tecla pressionada for o d então
            if event.keyName == "d" then
                player.direcao = "direita"
                player:setSequence ("correndo")
                player:play()
                player.xScale = 0.10      
            elseif event.keyName == "a" then
                player.direcao = "esquerda"
                player:setSequence ("correndo")
                player:play()
                player.xScale = -0.10
            elseif event.keyName == "space" then
                player.numeroPulo = player.numeroPulo + 1
                -- se numeroPulo for igual a 1 então
                    if player.numeroPulo == 1 then
                        -- é aplicado impulso linear no player (y)
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    -- se o numeroPulo for igual a 2 então
                    elseif player.numeroPulo == 2 then
                        -- transição para o player gire 360 graus em torno do próprio eixo.
                        transition.to (player, {rotation=player.rotation+360, time=750})
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                        player.numeroPulo = player.numeroPulo - 2
                    end
            end
        -- quando a fase deevento for up (soltarmos a tecla) então
        elseif event.phase == "up" then
            if event.keyName == "d" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            elseif event.keyName == "a" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            end
        end 
    end
    -- "key": teclado
    Runtime:addEventListener ("key", verificarTecla)

    -- função para movimentação
    local function verificarDirecao ()
        -- Retorna os valores de velocidade linear X e Y e armazena nas variáveis velocidadeX, velocidadeY respectivamente.
        local velocidadeX, velocidadeY = player:getLinearVelocity()
      --  print ("Velocidade x: " .. velocidadeX .. ", velocidade Y: " .. velocidadeY)
      -- se a direcao do player for direita e valocidade x for menor ou igual a 200 then 
        if player.direcao == "direita" and velocidadeX <= 200 then
            -- aplicado impulso linear para movimentação x direita.
            player:applyLinearImpulse (0.2, 0, player.x, player.y)
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then
            player:applyLinearImpulse (-0.2, 0, player.x, player.y)
        end 
    end 
-- "enterFrame" - executa a função o numero de fps/s (nesse caso 60x por segundo)
Runtime:addEventListener ("enterFrame",verificarDirecao)

local function criarQuadrado()
    local quadrado = display.newRect(mainGroup, math.random(display.contentWidth), 400, 50, 50)
    quadrado:setFillColor(1, 0, 0) -- Cor do quadrado (vermelho)
    physics.addBody(quadrado, "dynamic", {radius = 25})
    camera:add (quadrado, 1)
    
    local function removerQuadrado(event)
        if event.phase == "began" then
            display.remove(quadrado)
            criarQuadrado() -- Crie um novo quadrado quando o anterior for removido
        end
        return true
    end
    
    quadrado:addEventListener("touch", removerQuadrado)
end

-- Após a criação do chão
criarQuadrado()
