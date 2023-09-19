-- Call Physics
local physics = require ("physics")
physics.start()
physics.setGravity(0, 0)
physics.setDrawMode("hybrid")

display.setStatusBar(display.HiddenStatusBar)

-- Player TEST
local player = display.newCircle(20, 20, 20, 20)
player.x = display.contentCenterX
player.y = display.contentCenterY

-- Weapon Variables
local weapon1 = "Weapon 1"
local weapon2 = "Weapon 2"
local weapon3 = "Weapon 3"
local weapon4 = "Weapon 4"
local currentWeapon = weapon1

-- Projectile variables
local projectile1 = "Projectile 1"
local projectile2 = "Projectile 2"
local projectile3 = "Projectile 3"
local projectile4 = "Projectile 4"

-- Function to shoot projectiles based on the current weapon
local function shootProjectile(event)
    if currentWeapon == weapon1 then
        print("Shooting", projectile1)

        local bullet = display.newRect(40, 40, 40, 40) -- Replace with the image and dimensions
        bullet.x = player.x -- Set the initial position of the projectile
        bullet.y = player.y
        physics.addBody(bullet, "dynamic") -- Add physics properties to the projectile

        -- Calculate the angle and distance between the player and the touch position
        local touchX = event.x
        local touchY = event.y
        local angle = math.atan2(touchY - player.y, touchX - player.x)
        local distance = math.sqrt((touchX - player.x) ^ 2 + (touchY - player.y) ^ 2)

        -- Set the velocity of the projectile based on the angle and distance
        local speed = 100 -- Adjust the speed as needed
        bullet:setLinearVelocity(math.cos(angle) * speed, math.sin(angle) * speed)
        
    elseif currentWeapon == weapon2 then
        print("Shooting", projectile2)
        
        local bullet = display.newCircle(40, 40, 40, 40) 
        bullet.x = player.x 
        bullet.y = player.y
        physics.addBody(bullet, "dynamic") 

       
        local touchX = event.x
        local touchY = event.y
        local angle = math.atan2(touchY - player.y, touchX - player.x)
        local distance = math.sqrt((touchX - player.x) ^ 2 + (touchY - player.y) ^ 2)

       
        local speed = 120  
        bullet:setLinearVelocity(math.cos(angle) * speed, math.sin(angle) * speed)

    elseif currentWeapon == weapon3 then
        print("Shooting", projectile3)
        -- Create PROJ3
    elseif currentWeapon == weapon4 then
        print("Shooting", projectile4)
        -- Create PROJ4
    end
end

-- Function to switch weapons
local function switchWeapon(weapon)
    currentWeapon = weapon
    print("Switched to", currentWeapon)
end

-- Function to handle key events
local function onKeyEvent(event)
    if event.phase == "down" then
        if event.keyName == "1" then
            switchWeapon(weapon1)
        elseif event.keyName == "2" then
            switchWeapon(weapon2)
        elseif event.keyName == "3" then
            switchWeapon(weapon3)
        elseif event.keyName == "4" then
            switchWeapon(weapon4)
        end
    end
end

-- Function to handle touch events
local function onTouch(event)
    if event.phase == "began" then
        shootProjectile(event)
    end
end

-- Add key and touch event listeners
Runtime:addEventListener("key", onKeyEvent)
Runtime:addEventListener("touch", onTouch)
