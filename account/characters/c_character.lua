--[[/////////////////////////////////(Varbals)////////////////////////////]]--
local isShowing = false
local sW, sH = guiGetScreenSize()
local defaultColor = tocolor(29, 28, 28, 193)
local defaultColorCreate, defaultColorSelect, defaultColorLogout = defaultColor,defaultColor,defaultColor
local changeColor = tocolor(255, 28, 28, 220)


--[[/////////////////////////////////(Useful functions)////////////////////////////]]--
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
        if(sm.moov == 1)then
                sm.moov = 0
        end
end
 
local function camRender()
        if (sm.moov == 1) then
                local x1,y1,z1 = getElementPosition(sm.object1)
                local x2,y2,z2 = getElementPosition(sm.object2)
                setCameraMatrix(x1,y1,z1,x2,y2,z2)
        else
                removeEventHandler("onClientPreRender",root,camRender)
        end
end


 

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
        if(sm.moov == 1)then return false end
        sm.object1 = createObject(1337,x1,y1,z1)
        sm.object2 = createObject(1337,x1t,y1t,z1t)
        setElementCollisionsEnabled (sm.object1,false) 
        setElementCollisionsEnabled (sm.object2,false) 
        setElementAlpha(sm.object1,0)
        setElementAlpha(sm.object2,0)
        setObjectScale(sm.object1,0.01)
        setObjectScale(sm.object2,0.01)
        moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
        moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
        sm.moov = 1
        setTimer(removeCamHandler,time,1)
        setTimer(destroyElement,time,1,sm.object1)
        setTimer(destroyElement,time,1,sm.object2)
        addEventHandler("onClientPreRender",root,camRender)
        return true
end


function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function update ()
    showCursor(true)
    isShowing = true
end
addEventHandler("update",root,update)
update()

--[[/////////////////////////////////(functions)////////////////////////////]]--

addEventHandler("onClientRender",root,
function()
    if isShowing == true then
        local isInCharecterSelect = getElementData(localPlayer,"isInCharecterSelect")
        if isInCharecterSelect == true then
                dxDrawRectangle(517, 345, 382, 6, tocolor(29, 28, 28, 193), false) --titelbar
                dxDrawText("Character Station", 541, 332, 872, 351, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--titelbar text
                dxDrawLine(517, 351, 897, 351, tocolor(255, 255, 255, 255), 1, false)--titelbar line
                dxDrawImage(584, 32, 233, 300, ":account/fils/img/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)--titelbar img

                dxDrawRectangle(517, 355, 124, 40, defaultColorCreate, true) -- Create bnt
                dxDrawText("Create Character", 519, 361, 641, 385, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)-- Create text
                dxDrawLine(516, 395, 639, 395, tocolor(255, 255, 255, 255), 1, false)-- Create line

                dxDrawRectangle(645, 355, 124, 40, defaultColorSelect, true) --Select 
                dxDrawText("Select Character", 645, 361, 767, 385, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false) --Select text
                dxDrawLine(645, 395, 768, 395, tocolor(255, 255, 255, 255), 1, false) --Select  line

                dxDrawRectangle(775, 355, 124, 40, defaultColorLogout, true) -- Logout
                dxDrawText("Log Out", 775, 361, 897, 385, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false) -- Logout text
                dxDrawLine(776, 395, 899, 395, tocolor(255, 255, 255, 255), 1, false) -- Logout line
        end
    end
end)

addEventHandler("onClientClick",root,
function(botton,state)
    if botton == "left" and state == "down" then
        if isShowing == true then
            if isMouseInPosition(517, 355, 124, 40) then--Create
                print("Create")
            elseif isMouseInPosition(645, 355, 124, 40) then--Select 
                print("Select")
            elseif isMouseInPosition(775, 355, 124, 40) then--Logout 
                triggerServerEvent("disconnectPlayer",source)
            end
        end
    end
end)

addEventHandler("onClientRender",root,
function()
    if isShowing == true then
        if isMouseInPosition(517, 355, 124, 40) then--Create
            defaultColorCreate = changeColor
        elseif isMouseInPosition(645, 355, 124, 40) then--Select 
            defaultColorSelect = changeColor
        elseif isMouseInPosition(775, 355, 124, 40) then--Logout 
            defaultColorLogout = changeColor
        else
            defaultColorCreate,defaultColorLogout,defaultColorSelect = defaultColor,defaultColor,defaultColor
        end
    end
end)