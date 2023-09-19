local physics = require ("physics")
physics.start()
physics.setDrawMode ("hybrid")

-- Reniver a varra de notificação: 
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/background.png", 360, 570)

bg.x = display.contentCenterX
bg.y = display.contentCenterY

local plataforma = display.newImageRect ("imagens/platform.png", 300*1, 50)

plataforma.x = display.contentCenterX
plataforma.y = display.contentHeight - 25
physics.addBody (plataforma, "static")

local ballon = display.newImageRect ("imagens/balloon.png", 112, 112)

ballon.x = display.contentCenterX
ballon.y = display.contentCenterY
ballon.alpha = 0.8
physics.addBody (ballon, "dynamic", {radius = 50, bouce = 0.6})

local numToques = 0

local toquesText = display.newText (numToques, display.contentCenterX, 50, native.systemFont, 40)
toquesText:setFillColor (0, 0, 0)

local function cima ()
    --Parçâmetro: (impulsoX, impulsoY, objeto.x, objeto.y)
    ballon:applyLinearImpulse (0, -0.75, ballon.x, ballon.y)
    numToques = numToques + 1
    toquesText.text = numToques
end

local function zerou ()
    numToques = 0
    toquesText.text = numToques
end

plataforma:addEventListener ("collision", zerou)
ballon:addEventListener ("tap", cima)