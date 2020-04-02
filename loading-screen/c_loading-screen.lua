local isShowing = false
local sW_, sH_ = guiGetScreenSize()
local sx, sy = sW_/1400, sH_/1050
local rotLoop = 0
local startTick = getTickCount()
local timer = 3000
local stoping = false
local lsatRan = nil
local randomChar = {"girl1","girl2","boy1","boy2"}
local ran = randomChar[math.random ( #randomChar )]

isEventHandlerAdded = function( sEventName, pElementAttachedTo, func )
    if 
        type( sEventName ) == 'string' and 
        isElement( pElementAttachedTo ) and 
        type( func ) == 'function' 
    then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

addEventHandler("onClientResourceStart",root,
function(startedRes)
    if startedRes == getThisResource() then
        if isShowing == false then
            isShowing = true
        end
    end
end)
funcOne = function()
    if isShowing == true then
        rotLoop = rotLoop + 60*sx
        chack = getElementData(localPlayer,"isComplet")
        local iProgress = (getTickCount() - startTick) / timer
        local x, y = interpolateBetween(0, 0, 0, 100*sx, -500*sy, 0, iProgress, "InOutBack")
        dxDrawImage(0, 0, 1400*sx, 1050*sy, "img/loading.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1079*sx, 839*sy, 80*sx, 80*sy, "img/circle.png", rotLoop, 0, 0, tocolor(255, 255, 255, 255), true)
        x, y = interpolateBetween(0, 0, 0, -100*sx, 500*sx, 0, iProgress, "OutBack")
    end
end


local startTick = getTickCount()
local direction = true

functTwo = function()
    local tick        = getTickCount()
    local progress    = (tick - startTick) / 3000
    
    if progress > 1.5 then
        startTick, direction, progress = tick, not direction, 0
    end

    local percentage = interpolateBetween(0, 0, 0, 1*sx, 0, 0, progress, "OutBack")
    if not direction then percentage = 1 - percentage end
    yset = -560*sx * percentage
    xset = 100*sx * percentage
    dxDrawImage( xset-11*sx, 1048*sy+yset, 355*sx, 617*sy, "img/characters/"..ran..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end


renderFunction = function()

    if xset == 0 and yset == 0 then
        ran = randomChar[math.random ( #randomChar )]
        while ran == currentImage do
            ran = randomChar[math.random ( #randomChar )]
        end
        currentImage = ran
        print(ran)
    end
end

setTimer(renderFunction,1000,0)

init = function()
    if isTransferBoxActive() == true then
        if not isEventHandlerAdded("onClientRender", root, funcOne) then
            addEventHandler("onClientRender", root, funcOne)
        end
        if not isEventHandlerAdded("onClientRender", root, functTwo) then
            addEventHandler("onClientRender", root, functTwo)
        end
    else
        if isEventHandlerAdded("onClientRender", root, funcOne) then
            removeEventHandler("onClientRender", root, funcOne)
        end
        if isEventHandlerAdded("onClientRender", root, functTwo) then
            removeEventHandler("onClientRender", root, functTwo)
        end
    end
end
setTimer(init, 2000, 0)