-- Criando grupos de exibição 

local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para os objetos que terão interação dentro do jogo, grupo principal. 
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo porém sem interação.

-- Método embutido: 
-- Inclui o objeto no grupo já na sua criação. 
local bg = display.newImageRect (backGroup, "imagens/bg.jpg", 509*2, 339*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5)

chao.x = display.contentCenterX
chao.y = 430

mainGroup:insert (chao)

local sol = display.newImageRect (backGroup, "imagens/sun.png", 256, 257)

sol.x = display.contentCenterX
sol.y = 50

local nuvem = display.newImageRect ("imagens/cloud.png", 2360/5, 984/5)

nuvem.x = display.contentCenterX
nuvem.y = 140

backGroup:insert (nuvem)

local arvore = display.newImageRect (mainGroup, "imagens/tree.png", 1024/6, 1024/6) 
-- arvore já inserida no newgroup

arvore.x = 5
arvore.y = 330

arvore:scale (-1, 1) -- mudar escala da árvore 

local arvore1 = display.newImageRect ("imagens/tree.png", 1024/6, 1024/6)

arvore1.x = 320
arvore1.y = 330

mainGroup:insert (arvore1) -- Inserir a arvore1 no maingroup

chao:toFront (mainGroup) -- Puxa o chão para frente
