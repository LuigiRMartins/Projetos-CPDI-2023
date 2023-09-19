-- Variável global. (Deve ser evitado)
vidas = 2
vidas = 8
print (vidas)
print ("O valor de vida: " .. vidas)
----------------
-- Variáveos locais (Só é lida dentro do script)
-- (Local) é utilizado somnente na criação da variável
local pontos = 10
print (pontos)
print ("O valor de pontos: " .. pontos)

---------------- Operações  aritméticas ----------------
-- Soma
--Local (Significa qe a variável é local) laranjas (nome da variável) = (atribuir valor) 10 (valor atribuído a variável)
local laranjas = 10 

laranjas  = laranjas + 5
-- print imprime a informação dentro do console. 
print ("A soma das laranjas deu: " .. laranjas)

local bananas = 5 

-- Soma entre variáveis 
local cesta = 0
cesta = laranjas + bananas + 5 
print ("Na sua cesta possuem " .. cesta .. " frutas" )

-- Subtração 

cesta = laranjas - bananas 
bananas = bananas - 1 

-- Multiplicação

local carro = 8
carro = carro * 2
print("Quantitade de carros: " .. carro)

-- Dividindo pela multiplacação 

carro = carro * 0.5 -- Metade (Processo mais rápido)
print ("Divisáo pela multiplicação: " .. carro)

-- Divisão Sintax

local cauburao = 20
cauburao = cauburao / 2 
print ("Depois de assaltado sobrou apenas " .. cauburao .. " Mil reais no cauburáo")