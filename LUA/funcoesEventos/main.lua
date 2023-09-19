--[[ Incluindo funções: 
-- Comando para iniciar a função: local function, nome da função seguido de parênteses.
local function detectarTap (event) -- determina que a função é de evento (Acontecimento)
   
    print ("Objeto tocado: " .. tostring (event.target) )
    -- Código que é executado quando o botão for tocado
    -- tostring: para sequenciar 
    -- event.target: nomear o objeto do evento, ou objeto tocado.
    
    return true -- "Zera" todos os dados depois da função executada. 

end   -- Fecha a function 

local botaoTap = display.newRect (200, 200, 200, 50) -- Adição de botão (Retângulo)
botaoTap:addEventListener ("tap", detectarTap) -- Adiciona um ouvinte "tap" ao objeto. 

local function tapDuplo (event)
    -- Se (número de taps do event for igual a 2) então
    if (event.numTaps == 2) then
        print ("Objeto tocado duas vezes: " .. tostring (event.target) )

    else -- Se não 
        return true
    end -- Fecha o if/else
end -- Fecha a função (Funtion)

local botaoDuplo = display.newRect (100, 300, 200, 50)
botaoDuplo:setFillColor (0.7, 0, 0.5)
botaoDuplo:addEventListener ("tap", tapDuplo)

-- Evento de toque (touch)
-- Fases de toque:
   -- began = Primeira fase de toque, quando o usuário encosta na tela.
   -- moved = Quando o usuário mantém o toque e move pela tela. 
   -- ended = Quando o usuário retira retira o dedo da tela. 
   -- cancelled = Quando o toque for interrompido por algo.

local function fasesToque (event)

    -- Se a fase de toque for igual a began então:
    if (event.phase == "began" ) then
        print ("Objeto tocado: " .. tostring (event.targer) )
    
    -- Porem se a fase de toque for igual a moved então:
    elseif (event.phase == "moved" ) then
        print ("Localização de toque nas seguintes cordenadas: x= " .. event.x .. ", y= " .. event.y)

    -- Entretanto se a fase de toque for igual a Eded ou Cancelled então:
    elseif (event.phase  == "ended" or "cancelled" ) then
        print ("Touch terminado no objeto: " .. tostring (event.target) )
    end -- Fecha os ifs

    return true 
end -- Fecha a Function 

local botaoTouch = display.newRect ( 200, 400, 200, 50)
botaoTouch:setFillColor (0.9, 0.2, 0)
botaoTouch:addEventListener ("touch", fasesToque) ]]--
---------------------------------------------------------------------------------------------------------------
-- Multitoque: 
-- Para utilizar o multitouch precisamos habilitar (ativar) priemiro. 
system.activate ("multitouch")

local retangulo = display.newRect ( display.contentCenterX, display.contentCenterY, 280, 400 )
retangulo:setFillColor (1, 0, 0.3)

local function eventoTouch (event)
    print ("Fase de toque: " .. event.phase )
    print ("Localização x: " .. tostring(event.x) .. "localização y: " .. tostring(event.y) )
    print ("ID de toque exclusivo" .. tostring(event.id) )
    print ("-----------")
    return true 
end

retangulo:addEventListener ("touch", eventoTouch)

