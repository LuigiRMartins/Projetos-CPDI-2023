-- Física
-- Chamar a biblioteca: 

-- Atribui a biblioteca interna de física á variável physics.
local physics = require ("physics")

-- Iniciar a física no projeto: 
physics.start ()
-- Definir a gravidade do projeto: Definimos a gravidade x e y do projeto:
physics.setGravity (0, 9.8)

-- Definir a renderização da vizialização da física (Usado somente durante o desinvolvimente para testes)
-- Modos: Normal: Aparece apenas as imagens, corpos físicos(hitbox) invisíveis (padrão do sistema), hybrid: Mostra as imagens e os corpos fisicos, Debug: Mostra apenas os corpos físicos. 
physics.setDrawMode ("hybrid")

-- Adicionando objetos físicos: 
local retangulo = display.newRect (150, display.contentCenterY, 150, 200)

physics.addBody (retangulo, "dynamic")

-- Podem ser movidos manuelmente em código, colide com todo mundo e é afetado pela gravidade. 

local chao = display.newRect (display.contentCenterX, 400, 450, 30)

physics.addBody (chao, "static")

-- Não se movem sob simulação e se comporta como se tivesse massa infinita, podem ser movidos manualmente mas não aceita aplicação de velocidade (Colide apenas com "dynamic")

local circulo = display.newCircle ( 300, 50, 30)

physics.addBody (circulo, "kinematic", {radius = 30})

-- Corpo cinematico: não interage com a gravidade e colide apenas com dinâmico. 

local quadrado = display.newRect (display.contentCenterX, 0, 50, 50)
physics.addBody (quadrado, "dynamic", {bounce = 1, friction = 0.1, density = 0.3})

quadrado:applyTorque (100)