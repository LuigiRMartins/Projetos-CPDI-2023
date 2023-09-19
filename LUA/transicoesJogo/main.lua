local bg = display.newImageRect ("imagens/campo.jpg", 900*1.5, 620*1.5) -- BG

bg.x = display.contentCenterX
bg.y = display.contentCenterY

local bolafut = display.newImageRect ("imagens/bola.png", 500/5, 500/5) -- bola

bolafut.x = display.contentCenterX
bolafut.y = display.contentCenterY

-- Retalngulo Esdquerdo

local retangulo1 = display.newRect (50, 0, 50, 200)

local graddient2 = {
    type = "graddient",
    color1 = {1, 0, 0},
    color2 = {0, 1, 0},
    direction = "down"
}

retangulo1:setFillColor (graddient2)
retangulo1.y = display.contentCenterY

-- Retangulo Direito

local retangulo2 = display.newRect (975, 0, 50, 200)

local graddient1 = {
    type = "graddient",
    color1 = {0, 0, 1},
    color2 = {0, 1, 0},
    direction = "down"
}

retangulo2:setFillColor (graddient1)
retangulo2.y = display.contentCenterY

--- Animações

--[[local function chutarBola(event)
        transition.to (bolafut, {time = 2000, y = 600, x = 900, alpha = 1, rotation = 380, onComplete=function() end})
end]]--


transition.to (bolafut, {time = 2000, y =  200, x = 120, transition = easing.linear, rotation = 100,
 onComplete = function() transition.to (bolafut, {time = 2000, y = 600, x = 900, alpha = 1, rotation = 380}) end})
     
transition.to (retangulo1, {time = 2000, y = 200, delta = false, rotation = 180})

transition.to (retangulo2, {time = 4000, y = 200, delta = true, rotation = 380})



