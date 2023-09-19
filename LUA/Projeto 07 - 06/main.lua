-- Primeiro chamar a Fisica 

local physics = require ("physics")

physics.start ()

physics.setGravity (0,0)

physics.setDrawMode ("normal")

-- Remover barra notificações 

display.setStatusBar (display.HiddenStatusBar)

-- Grupo exibição 

local grupoFun = display.newGroup ()

local grupoBg = display.newGroup ()

local grupoMain = display.newGroup ()

local grupoUI = display.newGroup ()

-- Variáveis para UI 

local dinheiro = 0
local vidas = 10
local round = 0

-- Background do jogo.
local bg = display.newImageRect("imagens/fundo.png", 2047/2, 1534/2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY
grupoBg:insert(bg) -- Inserir back ground no grupo correto!

-- UI DO JOGO 

local menu = display.newRect (grupoUI, 500, -85, 1600, 500)
local composite1 = {
    type = "composite",
    paint1 = {type = "image", filename = "imagens/botao.png"},
    paint2 = {type = "image", filename = "imagens/botao1.png"}
}

menu.fill = composite1
menu.fill.effect = "composite" -- Teste de textura para newRect 

local vida = display.newImageRect(grupoUI, "imagens/Coracao.png", 256/2.8, 256/2.8)
vida.x = 60
vida.y = 55

local vidaText = display.newText (grupoUI, vidas, 59, 50, native.systemFont, 40)
vidaText:setFillColor (0,0,0)

local moeda = display.newImageRect(grupoUI, "imagens/Moedinha.png", 256/2.8, 256/2.8)
moeda.x = 150
moeda.y = 54

local dinheiroText = display.newText (grupoUI, dinheiro, 235, 54, native.systemFont, 40)
dinheiroText:setFillColor (0,0,0)

local balaoMenu = display.newImageRect (grupoUI,"imagens/BalaoMenu.png", 256/3.2, 256/3.2)
balaoMenu.x = 323
balaoMenu.y = 54

local roundText = display.newText (grupoUI, "Round: " .. round, 450, 54, native.systemFont, 40)
roundText:setFillColor (0,0,0)

-- Meu player: 

local player = display.newImageRect (grupoMain, "imagens/macaco.png", 261, 227)
player.x = 900
player.y = 240
player.myName = "dartMonkey"

local imageFile = "imagens/macaco.png"

local imageOutline = graphics.newOutline (2, imageFile)

physics.addBody (player, { outline = imageOutline}) -- Teste para hitbox no tamanho da imagem! 

player.bodyType = "kinematic"


-- Spawner (Inimigo)
local spawn = display.newCircle (grupoMain, 50,50,50,50)
spawn.x = -55
spawn.y = 400
spawn.myName = "Canhao"
physics.addBody (spawn, "kinematic")
local direcaoCanhao = "direita"

-- Função de waves inimiga: 
 
local function disparoBalao ()
    local balao = display.newImageRect (grupoMain, "imagens/ballon.png", 256/1.5,256/1.5)
    balao.y = spawn.y - 10
    balao.x = spawn.x + 20
    physics.addBody (balao, "dynamic", {radius =30, isSensor = true})
    transition.to (balao,  {x = 1200, time = 5000, 
                            onComplete = function ()
                                display.remove (balao)
                            end})
    balao.myName = "balao"
end

spawn.timer = timer.performWithDelay (math.random (100, 200), disparoBalao, 0)

-- Define um local para saber se o player está rotacionando
local isRotating = false

-- Função para touch
local function onTouch(event)
    if event.phase == "began" and not isRotating then
        -- Set the rotating flag to true
        isRotating = true
        
        -- Cria a bala 
        local bullet = display.newImageRect(grupoBg,"imagens/dardo.png", 728/10, 326/10)
        bullet.x = player.x - 30
        bullet.y = player.y 
        physics.addBody (bullet, "dynamic", {isSensor = true})
        bullet.myName = "dardo"
        
        -- Calcular a direção da bala 
        local angle = math.atan2(event.y - player.y, event.x - player.x)
        local bulletSpeed = 10 -- Ajustável 

        -- move a bala na direção calculada 
        bullet.xSpeed = math.cos(angle) * bulletSpeed
        bullet.ySpeed = math.sin(angle) * bulletSpeed

        -- Função movimentar o dardo
        local function moveBullet()
            if bullet and bullet.x then -- Checa se a bala ainda existe 
                bullet.x = bullet.x + bullet.xSpeed
                bullet.y = bullet.y + bullet.ySpeed
            end
        end 

        -- Mover continuamente a bala 
        Runtime:addEventListener("enterFrame", moveBullet)
    
        -- Remover o dardo se ele for para fora da tela
        local function removeBullet() 
            
            if bullet and bullet.x then -- Checa sea bala ainda existe antes de fazer a matemática.
               if bullet.x < 0 or bullet.x > display.contentWidth or 
                  bullet.y < 0 or bullet.y > display.contentHeight then 
                  display.remove(bullet)
                  Runtime:removeEventListener("enterFrame", moveBullet)
                end
            end
        end
        -- Timer para checar e remover a bala 
        timer.performWithDelay(1000, removeBullet)

        -- Rotaciona a bala para o local de clique
        bullet.rotation = math.deg(angle)
    end
    -- Rotaciona o jogador para a posição do toque
    local angle = math.atan2(event.y - player.y, event.x - player.x)
    local rotationAngle = math.deg(angle) + 240 -- Converte o radio em DEG 
    player.rotation = rotationAngle  -- Posiciona o angulo diveretamente
    
    -- Depois de um Delay reseta a func de rotação 
    timer.performWithDelay(200, function()
        isRotating = false
    end)
end

-- Adicionar touch na tela 
Runtime:addEventListener("touch", onTouch)

-- Função de espinhos para colisão

local espinhos = display.newRect (grupoMain, 50, 50, 50 ,50)
espinhos.x = 1080
espinhos.y = 400
physics.addBody (espinhos,"dynamic", { isSensor = true})
espinhos.myName = "espinho"

-- Função colisão bala e Balão 
local function onCollision(event)
    if event.phase == "began" then
        local obj1 = event.object1
        local obj2 = event.object2
        

        if (obj1.myName == "balao" and obj2.myName == "dardo") or (obj1.myName == "dardo" and obj2.myName == "balao") then
            display.remove (obj2)
            display.remove (obj1)
            dinheiro = dinheiro + 1
            dinheiroText.text = dinheiro

        elseif ((obj1.myName == "balao" and obj2.myName == "espinho") or (obj1.myName == "espinho" and obj2.myName == "balao")) then
            display.remove (obj2)
            vidas = vidas - 1 
            vidaText.text = vidas
            if (vidas <= 0) then 
                Runtime:removeEventListener ("collision", onCollision)
                Runtime:removeEventListener ("touch", onTouch)
                timer.cancel (spawn.timer)

                local gameOver = display.newImageRect (grupoUI,"imagens/gameOver.png", 500/2, 499/2)
                gameOver.x = display.contentCenterX
                gameOver.y = display.contentCenterY
                    
            end
        end
    end
end

Runtime:addEventListener ("collision", onCollision)













   