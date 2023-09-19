local bg = display.newImageRect ("imagens/sky.png", 960*3, 240*3)

bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/ground.png", 1028, 256)

chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ("imagens/player.png", 534/3.5, 469/3.5)

player.x = 30
player.y = 300 

local E = 0

-- Andar para a direita
local function direita ()
    if (E == 1) then
        player:scale (-1, 1)
        E = 0 
    else 
        print ("direita")
    end
    player.x = player.x + 10
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoDireita.x = 305
botaoDireita.y = 445
botaoDireita:addEventListener ("tap", direita)

--andar para esquerda 
local function esquerda ()
    if (E == 0) then
         player:scale (-1, 1)
        E = 1
    
    else
        print("esquerda")
    end 
    player.x = player.x - 10  
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoEsquerda.x = 235
botaoEsquerda.y = 445
botaoEsquerda:scale (-1, 1)

botaoEsquerda:addEventListener ("tap", esquerda)

--Pular para Cima

local function pulo ()
    player.y = player.y - 30 
end

local botaoCima = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoCima.x = 15
botaoCima.y = 445
botaoCima:rotate (270)

botaoCima:addEventListener ("tap", pulo)

--Pular para Baixo

local function descer ()
    player.y = player.y + 30
end

local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoBaixo.x = 85
botaoBaixo.y = 445
botaoBaixo:rotate (90)

botaoBaixo:addEventListener ("tap", descer)

--Diagonal Direita Cima

local function diagonalDireitaCima ()
    player.y = player.y - 30
    player.x = player.x + 30 
end

local botaoDiagonalCm = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoDiagonalCm.y = 390
botaoDiagonalCm.x = 270
botaoDiagonalCm:rotate (-50)

botaoDiagonalCm:addEventListener ("tap", diagonalDireitaCima)

--Diagonal direita Baixo 

local function diagonalDireitaBaixo ()
    player.y = player.y + 30
    player.x = player.x + 30 
end

local botaoDiagonalBx = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoDiagonalBx.y = 390
botaoDiagonalBx.x = 205
botaoDiagonalBx:rotate (50)

botaoDiagonalBx:addEventListener ("tap", diagonalDireitaBaixo)

--Diagonal Esquerda Cima 

local function diagonalEsquerdaCima ()
    player.y = player.y - 30
    player.x = player.x - 30 
end

local botaoDiagonalEc = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoDiagonalEc.y = 390
botaoDiagonalEc.x = 50
botaoDiagonalEc:rotate (-120)

botaoDiagonalEc:addEventListener ("tap", diagonalEsquerdaCima)

--Diagona Esquerda Baixo 

local function diagonalEsquerdaBaixo ()
    player.y = player.y + 30
    player.x = player.x - 30 
end

local botaoDiagonalEb = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)

botaoDiagonalEb.y = 390
botaoDiagonalEb.x = 115
botaoDiagonalEb:rotate (120)

botaoDiagonalEb:addEventListener ("tap", diagonalEsquerdaBaixo)