local sceneGroup = display.newGroup()

local waterBackground = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
waterBackground:setFillColor(0, 0, 1) -- Blue color
sceneGroup:insert(waterBackground)

local map = display.newImage("imagens/map.png", 1536, 2048)
map.x = display.contentCenterX
map.y = display.contentCenterY
sceneGroup:insert(map)

local mapHalfWidth = map.width * 0.5
local mapHalfHeight = map.height * 0.5

local camera = {
    x = display.contentCenterX,
    y = display.contentCenterY,
    speed = 5,
    minX = display.contentCenterX - mapHalfWidth,  -- Minimum X within map bounds
    maxX = display.contentCenterX + mapHalfWidth,  -- Maximum X within map bounds
    minY = display.contentCenterY - mapHalfHeight, -- Minimum Y within map bounds
    maxY = display.contentCenterY + mapHalfHeight   -- Maximum Y within map bounds
}


local function onTouch(event)
    local phase = event.phase
    local x, y = event.x, event.y

    if phase == "began" then
        startX = x
        startY = y
        isDragging = true
    elseif phase == "moved" then
        if isDragging then
            local deltaX = startX - x
            local deltaY = startY - y

            -- Update camera position based on swipe
            camera.x = camera.x + deltaX
            camera.y = camera.y + deltaY

            -- Limit camera position within bounds
            camera.x = math.max(camera.minX, math.min(camera.maxX, camera.x))
            camera.y = math.max(camera.minY, math.min(camera.maxY, camera.y))

            -- Update starting position for next frame
            startX = x
            startY = y

            -- Apply camera transformation to the map
            applyCameraTransform(map)
        end
    elseif phase == "ended" or phase == "cancelled" then
        isDragging = false
    end
end

map:addEventListener("touch", onTouch)
waterBackground:addEventListener("touch", onTouch)


function applyCameraTransform(group)
    group.x = -camera.x
    group.y = -camera.y
end
