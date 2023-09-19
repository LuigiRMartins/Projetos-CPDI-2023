local circulo = display.newCircle (80, 50, 30)

local function voltarAoInicio()
    transition.to(circulo, {time=3000, y=50, alpha=1, onComplete=function()
        circulo:setFillColor(1, 0, 1) -- Define a cor azul
    end})
end
-- Transições 
-- Comandos: transition.to (Variável, {parâmetros})

transition.to (circulo, {time = 3000, y = 400, alpha = 0.5, onComplete = voltarAoInicio} )

local circulo1 = display.newCircle (150, 50, 30)

transition.to (circulo1, {time = 3000, y = 400, delta = true} )

local circulo2 = display.newCircle (220, 50, 30)
transition.to (circulo2, {time = 3000, y= 400, iterations= 4, transition=easing.outElastic} )

local retangulo = display.newRect ( 200, 250, 50, 70)

transition.to (retangulo, {time = 3000, rotation = 480, yScale= 2, alpha = 0.5, iterations = -2})