-- Chamar a biblioteca de física
local physics = require ("physics")
-- Iniciar o motor de física
physics.start ()
-- Definir a gravidade 
physics.setGravity (0, 0)
-- Definir o modo de renderização
physics.setDrawMode ("hybrid")

-- Remover a barra de notificações.
display.setStatusBar (display.HiddenStatusBar)

-- criar os grupos de exibição 
local botao = display.newGroup ()
local grupoBg = display.newGroup ()
local grupoMain = display.newGroup ()
local grupoUI = display.newGroup ()

-- Criar variáveis de pontos e vidas para atribuição de valor.
local pontos = 0
local vidas = 5

-- Adicionar background 
local bg = display.newImageRect (grupoBg, "imagens/bg.png", 1920/2, 1080/2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

--  Adicionar placa na tela. 
local pontosText = display.newText (grupoUI, "Pontos: ".. pontos, 50, 20, native.systemFont, 25)
pontosText:setFillColor (0, 0, 0)

local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 260, 20, native.systemFont, 25)
vidasText:setFillColor (0, 0, 0)

-- Adicionar herói
local corpoPlayer = { -20, -67, 20, -67, 25, 80, -20 , 60, 20, 58} -- HITBOX HERÓINA 

local player = display.newImageRect (grupoMain, "imagens/neutral.png", 510/5.5,1000/5.5)
player.x = 30 
player.y = 420
player.myName = "Susu"
physics.addBody (player, { shape = corpoPlayer } )
player.bodyType = "kinematic"

-- Criar botões

local botaoEsquerda = display.newImageRect (botao, "imagens/botao.png", 475/4, 495/4)
botaoEsquerda.x = 280
botaoEsquerda.y = 460

local botaoDireta = display.newImageRect (botao, "imagens/botao.png", 475/4, 495/4)
botaoDireta.x = 40
botaoDireta.y = 460

-- Adicionar funções de movimentação 
local function esquerda (event)
    if ( event.phase == "began" ) then
        player.x = player.x + 10
        -- Code executed when the button is touched
        print( "object touched = " .. tostring(event.target) )  -- "event.target" is the touched object
    elseif ( event.phase == "moved") then
        player.x = player.x + 10
        -- Code executed when the touch is moved over the object
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        -- Code executed when the touch lifts off the object
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true  -- Prevents tap/touch propagation to underlying objects
end

botaoEsquerda:addEventListener ("touch", esquerda )

local function direita (event)
    if ( event.phase == "began" ) then
        player.x = player.x - 10
        -- Code executed when the button is touched
        print( "object touched = " .. tostring(event.target) )  -- "event.target" is the touched object
    elseif ( event.phase == "moved") then
        player.x = player.x - 10
        -- Code executed when the touch is moved over the object
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        -- Code executed when the touch lifts off the object
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true  -- Prevents tap/touch propagation to underlying objects
end

botaoDireta:addEventListener ("touch", direita )

-- Adicionar botão de tiro: 
local fire = display.newCircle (grupoMain, 40, 40, 40, 40)
fire.x = display.contentCenterX
fire.y = 490

-- Função para atirar: 
local function atirar ()
    local livroSusu = display.newCircle (grupoMain, 10, 10, 10, 10)
    livroSusu.x = player.x + 22 
    livroSusu.y = player.y - 10
    physics.addBody (livroSusu, "dynamic", {isSensor = true})
    transition.to (livroSusu, {y = - 500, time = 2500,
                    onComplete = function () display.remove (livroSusu)
                    end})
livroSusu.myName = "Livrito"
livroSusu:toBack () -- Joga o elemento pra trás dentro do grupo!
end

fire:addEventListener ("tap", atirar)

--- Adicinando inimigo 

local inimigo = display.newImageRect (grupoMain, "imagens/macaco1.png", 1436/16, 1478/16)
inimigo.x = 300
inimigo.y = 200 
inimigo.myName = "Macaquinho"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "cima" 

-- Função de atirar do inimigo: 

local function atirarInimigo ()
    local tiroInimigo = display.newCircle (grupoMain, 20,20,20,20)
    tiroInimigo.y = inimigo.y 
    tiroInimigo.x = inimigo.x 
    tiroInimigo.rotation = 180 
    physics.addBody (tiroInimigo, "dynamic", {isSensor = true})
    transition.to (tiroInimigo, {x = -200, time = 2000, 
                    onComplete = function ()
                        display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName = "Bananinha"
end

-- Cirando timer de disdparo do inimigo : 
-- Comandos timer: (Tempo repetição, função, quantidade de repetições)
inimigo.timer = timer.performWithDelay (math.random (1000, 1500), atirarInimigo, 0)

local function movimentarInimigo ()
    if not (inimigo.x == nil ) then

        if (direcaoInimigo == "cima" ) then 
            inimigo.y = inimigo.y - 1 

            if (inimigo.y <= 50) then 
                direcaoInimigo = "baixo"
            end 
        
        elseif (direcaoInimigo == "baixo") then 
                inimigo.y = inimigo.y + 1

                if (inimigo.y >= 400 ) then 
                    direcaoInimigo = "cima"
                end
        end
    else
        print ("Inimigo morreu!")

        Runtime:removeEventListener ("enterFrame", movimentarInimigo)
    end 
end 

Runtime:addEventListener ("enterFrame", movimentarInimigo)

--Função de colisão: 
local function onCollision (event)
-- Qyabdi a faso do evento for began então
    if (event.phase == "began" ) then
-- Variavei para facilitar a escrita do código.
        local obj1 = event.object1
        local obj2 = event.object2
-- Quando o myName do objeto 1 for ... eo nome do obj2 for ...
        if ((obj1.myName == "" and obj2.myName == "") or (obj1.myName == "" and obj2.myName == ""))
        then
        -- Se o obj1 for ... then
            if (obj1.myName == "") then 
        -- Remove o projétil do jogo.
                display.remove (obj1)
            else 
                display.remove (obj2)
            end
     
            pontos = pontos + 10 
            pontosText.text = "Pontos: " .. pontos

        elseif ((obj1.myname == "" and obj2.myName == "" ) or (obj1.myName == "" and obj2.myName == "")) then 
           
            if (obj1.myName == "") then 
                display.remove (obj1)

            else 
                display.remove (obj2)
            end 
-- Reduz a vida do player a cada colisão 
        vidas = vidas - 1 
        vidas.text = "Vidas: " .. vidas 
        end

    end 
end 

Runtime:addEventListener ("collision", onCollision)

-- Carregando audio de fundo (Stream indicado para audios longos) ("pasta/arquivo.formato")

local bgAudio = audio.loadStream ("Audio/bg.mp3")
-- Reservar um canal de audio para o som de fundo 
audio.reserveChannels (1)
-- Especificar o Volume desse canal 

audio.setVolume (0.6, {channel=1})
-- Reproduzir o audio 
--  (audio a reproduzir, {canal, loopins (-1 infinito)})

audio.play (bgAudio, {channel = 1, loops = -1})

-- loadSound é melhor utilizado com sons curtos. 

local audioTiro = audio.loadSound ("Audio/tiro.wav")

-----------------------------------------------------

-- COLOCAR O SOM NA COLISÃO DOS OBJETOS!! 