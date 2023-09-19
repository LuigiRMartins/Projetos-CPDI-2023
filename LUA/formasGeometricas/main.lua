local retangulo = display.newRect (130, 120, 200, 130)
local gradiente2 = {
    type = "gradient",
    color1 = {0.4, 0.2, 0.6},
    color2 = {0.2, 0.6, 0.4},
    direction = "right"
}

retangulo:setFillColor (gradiente2)

local circulo = display.newCircle (325, 120, 65)
local gradiente1 = {
    type = "graddient", 
    color1 = {0.6,0.5,0.9},
    color2 = {0.9,0.6,0.5},
    direction = "left"
}

circulo:setFillColor (gradiente1)

local quadrado = display.newRect(480, 120, 130, 130)
local composite = {
    type = "composite",
    paint1 = { type = "image", filename = "imagens/chaoterra.png" },
    paint2 = { type = "image", filename = "imagens/granito.png" }
}

quadrado.fill = composite
quadrado.fill.effect = "composite.average"


-- Descontar as bordas do projeto na hora de escolher a distância de X dos objetos.

-- Adicionar retângulo arredondado: 
-- Comandos: display.newRoundedRect (x, y, largura, altura, raio das bordas)

local retanguloarredondado = display.newRoundedRect (670, 120, 200, 130, 30)
local composite1  = {
    type = "composite",
    paint1 = { type = "image", filename = "imagens/flores.png" },
    paint2 = { type = "image", filename = "imagens/arvora.png" }
}

retanguloarredondado.fill = composite1
retanguloarredondado.fill.effect = "composite.average"


-- Adicionar uma linha : 
--Comandos: display.newline (xInicial, yInicial, xFinal, yFinal)

local linha display.newLine (30, 200, 770, 200)

-- Para posicionar a linha é necessário a localização inicial do primeiro objeto ( - sua larguira ) e a posição final ( + largura do objeto )
-- Modificando X e Y da linha é possivel posiciona-la na vertical ou na horizontal! 

-- Criar um polígono: 
-- Comando: display.newPolygon (X, y, vertices)

local localizacaoX = 130
local localizacaoy = 310

local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65 , 90 , 0 ,45, -65, 90, -43, 15, -105, -35, -27, -35}

-- Matemática com ponto cartesiano ( Definido a partir da criação das linhas )

estrela = display.newPolygon (localizacaoX, localizacaoy, vertices)

 -- Criar um novo texto: 
 -- Comandos: display.newText ("Texto que quero inserir", x, y, fonte, fontsize)

 -- Fonte pode ser nativa ou FONTES BAIXADAS ( PROCURAR PACOTES DE FONTES ) (Ideal utilizar imagens do que texto adicionado)

local helloWord = display.newText ("Hello World", 380, 300, native.systemFont, 50)

-- Possivél crias blocosk (Adentação) armazenando paramos para utilizar em outros casos. 

local parametros = {
    text =  "Olá Mundo!",
    x = 400,
    y = 380,
    font = "Ink Free", -- Mudança de Fonte utilizada                    
    fontSize = 60,
    align = "right"
}

local olaMundo = display.newText (parametros)

-- Adicionar um texto em relevo: 
-- Comando: display.newEmbossedText ()

local opcoes = {
    text = "Luigi R. Martins",
    x = 500,
    y = 450,
    font = "Segoe Script",
    fontSize = 60
}

local textoRelevo = display.newEmbossedText ( opcoes )

-- Adicionar cor ao objeto/texto: ( https://www.color-hex.com/ - Sites com cores )
-- Comandos: variavel:setFillColor (cinza, vermelho, verde, azul, alfa)

helloWord:setFillColor (0.9, 0.4, 0.5)
helloWord.alpha = 1

local color = {
    -- destaque
    highlight = { r = 1, g = 0, b = 0},
    -- sombra
    shadow = {r = 1, g = 0, b = 0},
}


textoRelevo:setFillColor (0.51, 0, 0.51) -- setFIllColor vem em primeiro. 

textoRelevo:setEmbossColor (color)


-- Gradiente: 
-- Comandos: variável = { type =, color1 = { , , }, color2 = { , , }, direction = " "}

local gradiente = { 
    type = "gradient",
    color1 = { 1, 0.1, 0.9},
    color2 = {0.8, 0.8, 0.8},
    direction = "down"
}

estrela:setFillColor (gradiente)

-----------------------------------------------------------






