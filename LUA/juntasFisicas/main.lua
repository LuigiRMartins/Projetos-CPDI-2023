-- Adicionar fisica 

local physics = require ("physics")

physics.start ()

physics.setGravity ()

physics.setDrawMode ("hybrid")

-- Remover barra status 

display.setStatusBar (display.HiddenStatusBar)

-- local joint 

-- local Circle = display.newCircle (50, 50, 50, 50)
-- Circle:setFillColor (0.2, 0.2, 1)
-- physics.addBody (Circle,"static", {isSensor = true})
-- Circle.x, Circle.y = display.contentCenterX, 80 

-- local Box = display.newRect (0,0, 40,100)
-- Box:setFillColor (1, 0.2, 0.4)
-- physics.addBody (Box, "dynamic")
-- Box.x, Box.y, Box.rotation = 100, Circle.y - 40, 0 

-- -- Criação da junta de pivô ("Tipo de Junta", objA, objB, AncoraX, AncoraY)
-- local jointPivot = physics.newJoint ("pivot", Circle, Box, Circle.x, Circle.y)
-- jointPivot.isMotorEnabled = true -- Ativa o motor da junta de pivô.
-- jointPivot.motorSpeed = 40 -- Define a velocidade do torque do motor.
-- jointPivot.maxMotorTorque = 1000 -- Define o valor máximo da velocidade do torque do motor, utilizado para mlehor visualização do efeito.
-- jointPivot.isLimitEnabled = true -- Determina como ativado os limites de rotação.
-- jointPivot:setRotationLimits (-60, 125)
----------------------------------------------
-- Junta de distância 

-- local Circle = display.newRect ( 0, 0, 60, 60)
-- Circle:setFillColor (0.2, 0.2, 1)
-- physics.addBody (Circle, "static", {isSensor = true})
-- Circle.x, Circle.y = 200, 180 

-- local Box = display.newRect ( 0, 0, 40, 100)
-- Box:setFillColor (1, 0.2, 0.4)
-- physics.addBody (Box, "dynamic", {bounce = 1})
-- Box.x, Box.y = 200, 80 

-- -- (Tipo de junta, objA, objB. ancoraObjA.x, ancoraObjA.y, ancoraObjB.x, ancoraObjB.y)
-- local jointDistance = physics.newJoint ("distance", Circle, Box, Circle.x, Circle.y - 10, Box.x, Box.y)
-- jointDistance.frequency = 0.8  -- Define a frequência de amortecimento em Hz, quanto maior o valor mais macio. 
-- jointDistance.dampingRatio = 0.8 -- Nivel de amortecimento, onde 1 é amortecimento crítico.

-- --JointDistance.Length = StaticBox.y - shape.y -- Define a distância entre os pontos de ancoragem.
-- Box:applyLinearImpulse (0.3, 0, Box.x, Box.y-5)

-----------------------------------------------------------------

--Junta pistão

-- local Circle = display.newRect ( 0, 0, 60, 60)
-- Circle:setFillColor (0.2, 0.2, 1)
-- physics.addBody (Circle, "static", {isSensor = true})
-- Circle.x, Circle.y = display.contentCenterX, 360 

-- local Box = display.newRect ( 0, 0, 130, 20)
-- Box:setFillColor (1, 0.2, 0.4)
-- physics.addBody (Box, "dynamic", {bounce = 1})
-- Box.x, Box.y = display.contentCenterX, 310

-- -- Criação da junta de pistão ("tipo de junta", objA, objB, ancoraX, ancoraY, limite de movimentaçãoX, limite de movimentaçãoY)
-- local jointPiston = physics.newJoint ("piston", Circle, Box, Box.x, Box.y, 0, 1)

-- jointPiston.isMotorEnabled = true 
-- jointPiston.motorSpeed = - 30 
-- jointPiston.maxMotorForce = 10
-- jointPiston.isLimitEnabled = true
-- jointPiston:setLimits (-140, 0)

-------------------------------------------
-- Junta de fricção 

local bodies = {}
local bodiesGroup = display.newGroup ()
local joints = {}

bodiesGroup.alpha = 0 
transition.to (bodiesGroup, {time = 600, alpha = 1, transition = easing.outrQuad})

local shape1 = display.newRect (bodiesGroup, 0, 0, 40, 40)
shape1:setFillColor (1,0.2,0.4)
physics.addBody (shape1, "dinamic")
shape1.x, shape1.y, shape1.rotation = display.contentCenterX-60, 170, 0
shape1.angularVelocity = 200 
bodies [#bodies+1] = shape1 

local shape2 = display.newRect (bodiesGroup, 0, 0, 40, 40)
shape2:setFillColor (1,0.2,0.4)
physics.addBody (shape2, "dinamic")
shape2.x, shape2.y, shape2.rotation = display.contentCenterX + 60, 170, 0
shape2.angularVelocity = 200 
bodies [#bodies+1] = shape2 

local dirtField = display.newRect (bodiesGroup, 0, 0, 120, 190)
dirtField.type = "dirt"
dirtField:setFillColor (0.4, 0.25, 0.2)
physics.addBody (dirtField, "static", {isSensor = true})
dirtField.x, dirtField.y = display.contentCenterX - 60, 335 
bodies [#bodies + 1] = dirtField

local grassField = display.newRect (bodiesGroup, 0, 0, 120, 190)
grassField.type = "grass"
grassField:setFillColor (0.1, 0.4, 0.3)
physics.addBody (grassField, "static", {isSensor = true})
grassField.x, grassField.y = display.contentCenterX + 60, 335
bodies [#bodies + 1] = grassField

local function handleCollision (self, event)
    if (event.phase == "began") then 

        local forceLimit = 0
        local torqueLimit = 0

        if (event.other.type == "dirt") then 
            forceLimit = 0.22
            torqueLimit = 0.022
        else 
            forceLimit = 0.28
            torqueLimit = 0.028
        end 

            timer.performWithDelay (10,
                function ()
                    
                    joints[#joints+1] = physics.newJoint ("friction", event.other, self, self.x, self.y)
                
                    joints[#joints].maxForce = forceLimit
                    joints[#joints].maxTorque = torqueLimit
                end
                )
    end
end

shape1.collision = handleCollision
shape1:addEventListener ("collision", shape1)

shape2.collision = handleCollision
shape2:addEventListener ("collision", shape2)