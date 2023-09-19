-- Adicionar imagem na tela:
-- Comandos: diplay.newImageRect ("pasta/arquivvo.formato", largura, altura)

local bg = display.newImageRect ("imagens/bg.jpg", 1280*1.20, 720*1.20)

-- Definir localização do objeto.

-- comando: variavel.linha que vou definir - localização na linha.
-- X = Horizontal, Y = Linha vertical. 

bg.x = display.contentCenterX 
-- Comando que centraliza a variável em qualquer resolução
bg.y = display.contentCenterY

local picachu = display.newImageRect ("imagens/pikachu.png", 1191/3, 1254/3)

picachu.x = display.contentCenterX
picachu.y = 690

local charmander = display.newImageRect("imagens/charmander.png", 507/2.3, 492/2.3)

charmander:scale (-1, 1) -- Comando object:scale() (Muda a escala do objeto sem modificar local da imagem na tela podendo ser usado para dar FLIP na imagem!) 

charmander.x = 340
charmander.y = 380


-----------------------------------------------------------------------------------

-- Criar um retängulo: 
-- Comandos: display.newRect (localizações x, localização y, largura, altura)
local retangulo = display.newRect (750, 380, 100, 70)

-- Criando um círculo:
-- Comandos: display.newCircle (x, y, radius (Raio(Metade do circulo)))

local circulo = display.newCircle (150, 80, 50)

local mystery = display.newImageRect("imagens/mystery.png", 493*0.45, 560*0.45)

mystery.x = 775
mystery.y = 370

mystery:scale (-1, 1) -- Comando que modifica a escala da imagem e realiza um FLIP quando negativo! 


-----------------------------------------------------------------------------------
--Pokebola adicional por que gostei da ídeia 

local pokebola = display.newImageRect("imagens/master ball.png", 479/4, 489/4)

pokebola.x = 150
pokebola.y = 85

pokebola:rotate (-20) -- Rota a imagem em sentido horário (Quando positivo) ou anti-horáirio! (Quando negativo)

pokebola:scale (-1, 1)

