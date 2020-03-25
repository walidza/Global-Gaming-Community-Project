
--var


loadstring(exports.dgs:dgsImportFunction())()
local loginHighLightText = {"Exit","Succeeded","Register","Show Password","Hide Password","Username","Password"}
local registerHighLightText = {"Exit","Succeeded","Back","Show Password","Hide Password","Username","Password", "Re Password","Email"}
local sW,sH = dgsGetScreenSize()

local isLogin = false
local isRegister = false

local defaultColor = tocolor(249,5,213)
local changeColor = tocolor(0,0,0)
local OswaldBold = dgsCreateFont( "fils/fonts/OswaldBold.ttf", 13 )
local segoepr = dgsCreateFont( "fils/fonts/segoepr.ttf",13)
local fontText = dgsCreateFont("fils/fonts/openSans.ttf", 11.65)
local errorFont = dgsCreateFont("fils/fonts/openSans.ttf", 8)
local TextGUI = dgsCreateFont("fils/fonts/openSans.ttf", 8)
local fontTextLabel = dgsCreateFont("fils/fonts/openSans.ttf", 10)
local fontTab = dgsCreateFont("fils/fonts/openSans.ttf", 11)
local titleFont = dgsCreateFont("fils/fonts/Kalam.ttf", 25)
local OpenSans = dgsCreateFont("fils/fonts/openSans.ttf")


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

--guiTable
login = {}
register = {}
--login gui

        login.panel = dgsCreateLabel(sW*(0.4221428571428571),sH*(0.1152380952380952), sW*(0.2007142857142857), sH*(0.5923809523809524), "", false)
        login.registerIcon = dgsCreateImage(sW*(0.0071428571428571), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/register.png", false, login.panel)
        login.succeededIcon = dgsCreateImage(sW*(0.0828571428571429), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/succeeded.png", false, login.panel)
        login.exitIcon = dgsCreateImage(sW*(0.155), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/exit.png", false, login.panel)
        login.logo = dgsCreateImage(sW*(0), sH*(0), sW*(0.25), sH*(0.2142857142857143), "fils/img/logo.png", false, login.panel)
        rndRect = dgsCreateRoundRect(1.5,tocolor(0,0,0,150))
        login.blurEditUser = dgsCreateImage(sW*(0.0071428571428571), sH*(0.2095238095238095), sW*(0.1857142857142857), sH*(0.0428571428571429), rndRect, false, login.panel)
        login.blurEditPass = dgsCreateImage(sW*(0.0071428571428571), sH*(0.2571428571428571), sW*(0.1857142857142857), sH*(0.0428571428571429), rndRect, false, login.panel)
        login.userEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0057142857142857), sW*(0.1378571428571429), sH*(0.0314285714285714), "", false, login.blurEditUser)
        login.passEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0066666666666667), sW*(0.1378571428571429), sH*(0.0314285714285714), "", false, login.blurEditPass)
        login.userImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0314285714285714), sH*(0.0447619047619048), "fils/icons/user.png", false, login.blurEditUser)
        login.passImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0307142857142857), sH*(0.0428571428571429), "fils/icons/pass.png", false, login.blurEditPass)
        login.passShowIcon = dgsCreateImage(sW*(0.1642857142857143), sH*(0.2952380952380952), sW*(0.025), sH*(0.0333333333333333), "fils/icons/eye.png", false, login.panel)
        login.blurIcon = dgsCreateImage(sW*(0.0042857142857143), sH*(0.5380952380952381), sW*(0.1857142857142857), sH*(0.0428571428571429), rndRect, false, login.panel)
        
        login.infoMsg = dgsCreateLabel(sW*(0),sH*(0.4285714285714286),sW*(0.2),sH*(0.0095238095238095), "Your account Name is take damege!", false, login.panel,tocolor(250,20,20))
        dgsLabelSetHorizontalAlign(login.infoMsg,"center")
        dgsSetFont(login.infoMsg,"aril-bold")
        dgsLabelSetVerticalAlign(login.infoMsg,"center")
        dgsMoveToBack (login.blurIcon)
        dgsMoveToBack (login.blurEditUser)

        blurbox = dgsCreateBlurBox()
        dxSetShaderValue(blurbox,"brightness",2)

        --Property login
                dgsSetProperty(login.blurEditUser,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(login.blurEditPass,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(login.blurIcon,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y,w,h)
                ]],blurbox)
                local tableMasked = {login.passEdit}
                local tableBgColor = {login.userEdit,login.passEdit}
                local tableFont = {login.userEdit}

                dgsSetProperty(tableMasked,"masked",true)
                dgsSetProperty(tableBgColor,"bgColor",0)
                dgsSetProperty(tableFont,"font",fontText)
                dgsSetVisible(login.panel,false)




--register gui

        register.panel = dgsCreateLabel(sW*(0.4221428571428571),sH*(0.1152380952380952), sW*(0.2007142857142857), sH*(0.5923809523809524), "", false)

        register.logo = dgsCreateImage(sW*(0), sH*(0), sW*(0.25), sH*(0.2142857142857143), "fils/img/logo.png", false, register.panel)
        register.backIcon = dgsCreateImage(sW*(0.0071428571428571), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/back.png", false, register.panel)
        register.succeededIcon = dgsCreateImage(sW*(0.0828571428571429), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/succeeded.png", false, register.panel)
        register.exitIcon = dgsCreateImage(sW*(0.155), sH*(0.5380952380952381), sW*(0.0342857142857143), sH*(0.0447619047619048), "fils/icons/exit.png", false, register.panel)
        register.passShowIcon = dgsCreateImage(sW*(0.1642857142857143), sH*(0.3904761904761905), sW*(0.025), sH*(0.0333333333333333), "fils/icons/eye.png", false, register.panel)

        register.rndRect = dgsCreateRoundRect(1.5,tocolor(0,0,0,150))
        
        register.blurEditUser = dgsCreateImage(sW*(0.0071428571428571), sH*(0.2095238095238095), sW*(0.1857142857142857), sH*(0.0428571428571429), register.rndRect, false, register.panel)
        register.blurEditPass = dgsCreateImage(sW*(0.0071428571428571), sH*(0.2571428571428571), sW*(0.1857142857142857), sH*(0.0428571428571429), register.rndRect, false, register.panel)
        register.blurEditRePass = dgsCreateImage(sW*(0.0071428571428571), sH*(0.3047619047619048), sW*(0.1857142857142857), sH*(0.0428571428571429), register.rndRect, false,register.panel)
        register.blurEditEmail = dgsCreateImage(sW*(0.0071428571428571), sH*(0.3523809523809524), sW*(0.1857142857142857), sH*(0.0428571428571429), register.rndRect, false,register.panel)
        
        register.userEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0057142857142857), sW*(0.1378571428571429), sH*(0.0314285714285714), "", false, register.blurEditUser)
        register.passEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0066666666666667), sW*(0.1378571428571429), sH*(0.0314285714285714), "", false, register.blurEditPass)
        register.rePassEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0066666666666667), sW*(0.1378571428571429), sH*(0.0314285714285714),"",false, register.blurEditRePass)
        register.emailEdit = dgsCreateEdit(sW*(0.0428571428571429), sH*(0.0066666666666667), sW*(0.1378571428571429), sH*(0.0314285714285714),"",false, register.blurEditEmail)
        
        register.userImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0314285714285714), sH*(0.0447619047619048), "fils/icons/user.png", false, register.blurEditUser)
        register.passImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0307142857142857), sH*(0.0428571428571429), "fils/icons/pass.png", false, register.blurEditPass)
        register.rePassImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0307142857142857), sH*(0.0428571428571429), "fils/icons/pass.png", false, register.blurEditRePass)
        register.emailImg = dgsCreateImage(sW*(0.0071428571428571), sH*(0), sW*(0.0314285714285714), sH*(0.0447619047619048), "fils/icons/email.png", false, register.blurEditEmail)
        register.blurIcon = dgsCreateImage(sW*(0.0042857142857143), sH*(0.5380952380952381), sW*(0.1857142857142857), sH*(0.0428571428571429), register.rndRect, false, register.panel)
        dgsMoveToBack (register.blurIcon)
        dgsMoveToBack (register.blurEditUser)
        register.blurbox = dgsCreateBlurBox()

        register.infoMsg = dgsCreateLabel(sW*(0),sH*(0.4285714285714286),sW*(0.2),sH*(0.0095238095238095), "Your account Name is take damege!", false, register.panel,tocolor(250,20,20))
        dgsLabelSetHorizontalAlign(register.infoMsg,"center")
        dgsSetFont(register.infoMsg,"aril-bold")
        dgsLabelSetVerticalAlign(register.infoMsg,"center")
        dxSetShaderValue(register.blurbox,"brightness",2)
        --Property register
                dgsSetProperty(register.blurEditUser,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(register.blurEditPass,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(register.blurEditRePass,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(register.blurEditEmail,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y-sH*(1/1050),w,h)
                ]],blurbox)
                dgsSetProperty(register.blurIcon,"functions",[[
                        local arguments = {...}
                        local blurbox = arguments[1]
                        local renderArguments = renderArguments
                        local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
                        dgsBlurBoxRender(blurbox,x-sW*(0.0010714285714286),y,w,h)
                ]],blurbox)
                local tableMasked = {register.passEdit,register.rePassEdit}
                local tableBgColor = {register.userEdit,register.rePassEdit,register.passEdit,register.emailEdit}
                local tableFont = {register.userEdit,register.emailEdit}
                dgsSetProperty(tableMasked,"masked",true)
                dgsSetProperty(tableBgColor,"bgColor",0)
                dgsSetProperty(tableFont,"font",fontText)
                dgsSetVisible (register.panel,false)



-- login code
dgsSetText (login.infoMsg,"")
dgsSetText (register.infoMsg,"")


addEventHandler("onClientResourceStart",getResourceRootElement(),
function ()
        isLoginIn = getElementData(localPlayer,"isPlayerLoggedIn")

        if isLoginIn == false then
                showChat(false)
                showCursor(true)
                smoothMoveCamera(1687.78515625,-2112.896484375,17.675107955933,1591.0621337891,-2113.8806152344,-7.6960048675537,1828.4173583984,-2111.80859375,23.825691223145,1730.4993896484,-2112.8049316406,3.5507338047028,50000)
                fadeCamera(true) 
                dgsSetVisible(login.panel,true)
                isLogin = true
        end
end
)


function infoMsg( panel, text, state)
        if panel == "login" then
                if isLogin == true then
                        if state == "error" then
                                dgsSetText(login.infoMsg,text)
                                dgsLabelSetColor(login.infoMsg,255,0,0)
                        end
                        if state == "good" then
                                dgsSetText(login.infoMsg,text)
                                dgsLabelSetColor(login.infoMsg,0,255,0)
                        end
                end
        end
        if panel == "register" then
                if isRegister == true then
                        if state == "error" then
                                dgsSetText(register.infoMsg,text)
                                dgsLabelSetColor(register.infoMsg,255,0,0)
                        end
                        if state == "good" then
                                dgsSetText(register.infoMsg,text)
                                dgsLabelSetColor(register.infoMsg,0,255,0)
                        end
                end
        end
end
addEvent("infoMsg",true)
addEventHandler("infoMsg",root,infoMsg)

addEventHandler("onDgsRender",root,
function()
        --login
        if isLogin == true then
                if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit
                        dgsSetProperty(login.exitIcon,"color",changeColor)
                else
                        dgsSetProperty(login.exitIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                        dgsSetProperty(login.succeededIcon,"color",changeColor)
                else
                        dgsSetProperty(login.succeededIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then --register
                        dgsSetProperty(login.registerIcon,"color",changeColor)
                else
                        dgsSetProperty(login.registerIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.58428573608398),sH*(0.41809523105621), sW*(0.0271428571428571), sH*(0.0238095238095238)) then --show pass
                        dgsSetProperty(login.passShowIcon,"color",changeColor)
                else
                        dgsSetProperty(login.passShowIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.43857142329216),sH*(0.37428572773933), sW*(0.1764285714285714), sH*(0.04)) then --pass
                        dgsSetProperty(login.passImg,"color",changeColor)
                else
                        dgsSetProperty(login.passImg,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.43285715579987),sH*(0.32571429014206), sW*(0.1764285714285714), sH*(0.04)) then --user 
                        dgsSetProperty(login.userImg,"color",changeColor)
                else
                        dgsSetProperty(login.userImg,"color",defaultColor)
                end
        end
        if isRegister == true then
        --register
                if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit
                        dgsSetProperty(register.exitIcon,"color",changeColor)
                else
                        dgsSetProperty(register.exitIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                        dgsSetProperty(register.succeededIcon,"color",changeColor)
                else
                        dgsSetProperty(register.succeededIcon,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then --back
                        dgsSetProperty(register.backIcon,"color",changeColor)
                else
                        dgsSetProperty(register.backIcon,"color",defaultColor)
                end


                if isMouseInPosition(sW*(0.43285715579987),sH*(0.32571429014206), sW*(0.1764285714285714), sH*(0.04)) then --user 
                        dgsSetProperty(register.userImg,"color",changeColor)
                else
                        dgsSetProperty(register.userImg,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.43857142329216),sH*(0.37428572773933), sW*(0.1764285714285714), sH*(0.04)) then --pass
                        dgsSetProperty(register.passImg,"color",changeColor)
                else
                        dgsSetProperty(register.passImg,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.41928571462631),sH*(0.42190477252007), sW*(0.1764285714285714), sH*(0.04)) then --re pass 
                        dgsSetProperty(register.rePassImg,"color",changeColor)
                else
                        dgsSetProperty(register.rePassImg,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.4135714173317),sH*(0.4723809659481), sW*(0.1764285714285714), sH*(0.04)) then --email
                        dgsSetProperty(register.emailImg,"color",changeColor)
                else
                        dgsSetProperty(register.emailImg,"color",defaultColor)
                end

                if isMouseInPosition(sW*(0.56357145309448),sH*(0.51523810625076), sW*(0.0271428571428571), sH*(0.0238095238095238)) then --show pass
                        dgsSetProperty(register.passShowIcon,"color",changeColor)
                else
                        dgsSetProperty(register.passShowIcon,"color",defaultColor)
                end
        end
        
end
)

function infoInPutChack(state)
        if state == "login" then
                if isLogin == true then

                end
        end
        if state == "register" then
                if isRegister == true then
                        local regUsernameGet = dgsGetText(register.userEdit)
                        local regEmailGet = dgsGetText(register.emailEdit)
                        local regPasswordGet = dgsGetText(register.passEdit)
                        local regRePasswordGet = dgsGetText(register.rePassEdit)
                                if not regUsernameGet or regUsernameGet == "" or not regPasswordGet or regPasswordGet == "" or not regRePasswordGet or regRePasswordGet == "" or not regEmailGet or regEmailGet == ""  then
                                        infoMsg( "register", "Please fill out all the information", "error")
                                elseif string.len(regUsernameGet)< 3 then
                                        infoMsg( "register", "The name must be more than four characters long", "error")
                                elseif string.len(regPasswordGet)< 6 then
                                        infoMsg( "register", "Password must be more than six characters long", "error")
                                elseif string.len(regUsernameGet)>= 15 then 
                                        infoMsg( "register", "The name must be less than fourteen characters long", "error")
                                elseif regPasswordGet ~= regRePasswordGet then
                                        infoMsg( "register", "The password must match the password confirmation", "error")
                                elseif string.match(regUsernameGet,"%W") then
                                        infoMsg( "register", "\"!@#$\"%'^&*()\" are not allowed in username.", "error")	
                                else
                                        infoMsg( "register", "All your information is good !", "good")			
                                end
                end
        end
end
addEvent("infoInPutChack",true)
addEventHandler("infoInPutChack",root,infoInPutChack)

addEventHandler("onClientClick",root,
function( button, state)
        if button == "left" and state == "down" then
                if isLogin == true then

                        dgsMoveToBack (login.blurIcon)
                        dgsMoveToBack (login.blurEditUser)
                        if isMouseInPosition(sW*(0.58428573608398),sH*(0.41809523105621), sW*(0.0271428571428571), sH*(0.0238095238095238)) then -- show pass
                                if getElementData(login.passShowIcon,"passShowIcon") == "fils/icons/eyec.png" then
                                        dgsImageSetImage(login.passShowIcon,"fils/icons/eye.png")
                                        setElementData(login.passShowIcon,"passShowIcon",false)
                                        dgsSetProperty(login.passEdit,"masked",true)
                                else
                                        dgsSetProperty(login.passEdit,"masked",false)
                                        dgsImageSetImage(login.passShowIcon,"fils/icons/eyec.png")
                                        setElementData(login.passShowIcon,"passShowIcon","fils/icons/eyec.png")
                                end
                        end
                        if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit
                                triggerServerEvent("disconnectPlayer",source)
                        end
                        if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- register
                                isRegister = true 
                                isLogin = false
                                dgsSetVisible (login.panel, false)
                                dgsSetVisible (register.panel,true)
                                saveHide = getElementData(login.passShowIcon,"passShowIcon")
                        end
                        if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                                local username = dgsGetText(login.userEdit)
                                local password = dgsGetText(login.passEdit)
                                infoInPutChack("login")
                                triggerServerEvent("loginPlayer", root, username, password)
                        end
                else
        --register
                        if isRegister == true then
                                local regUsername = dgsGetText(register.userEdit)
                                local regEmail = dgsGetText(register.emailEdit)
                                local regPassword = dgsGetText(register.passEdit)
                                dgsMoveToBack (register.blurIcon)
                                dgsMoveToBack (register.blurEditUser)
                                if isMouseInPosition(sW*(0.5864285826683),sH*(0.50952380895615), sW*(0.0271428571428571), sH*(0.0238095238095238)) then --show pass
                                        if getElementData(register.passShowIcon,"passShowIcon") == "fils/icons/eyec.png" then
                                                dgsImageSetImage(register.passShowIcon,"fils/icons/eye.png")
                                                setElementData(register.passShowIcon,"passShowIcon",false)
                                                dgsSetProperty(register.passEdit,"masked",true)
                                                dgsSetProperty(register.rePassEdit,"masked",true)
                                        else
                                                dgsSetProperty(register.passEdit,"masked",false)
                                                dgsSetProperty(register.rePassEdit,"masked",false)
                                                dgsImageSetImage(register.passShowIcon,"fils/icons/eyec.png")
                                                setElementData(register.passShowIcon,"passShowIcon","fils/icons/eyec.png")
                                        end
                                end
                                if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit
                                        triggerServerEvent("disconnectPlayer",source)
                                end
                                if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then --back
                                        isRegister = false
                                        isLogin = true
                                        dgsSetVisible (login.panel, true)
                                        dgsSetVisible (register.panel,false)
                                        saveHide = getElementData(register.passShowIcon,"passShowIcon")

                                end
                                if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                                        infoInPutChack("register")
                                        triggerServerEvent( "registerPlayer", root, regUsername, regPassword, regEmail)
                                end
                        end
                end
        end
end
)




addEventHandler("onClientRender",root,
function()
        local screenx, screeny = getCursorPosition()
        --login
        if isLogin == true then
                if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit 
                        local text = loginHighLightText[1]
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
                if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                        local text = loginHighLightText[2]
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
                if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- register
                        local text = loginHighLightText[3]
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
                if isMouseInPosition(sW*(0.58428573608398),sH*(0.41809523105621), sW*(0.0271428571428571), sH*(0.0238095238095238)) then -- show pass
                        if getElementData(login.passShowIcon,"passShowIcon") == "fils/icons/eyec.png" then
                                text = loginHighLightText[5]
                        else
                                text = loginHighLightText[4]
                        end
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
                if isMouseInPosition(sW*(0.43285715579987),sH*(0.32571429014206), sW*(0.1764285714285714), sH*(0.04)) then --user 
                        local text = loginHighLightText[6]
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
                if isMouseInPosition(sW*(0.43857142329216),sH*(0.37428572773933), sW*(0.1764285714285714), sH*(0.04)) then --pass edit
                        local text = loginHighLightText[7]
                        dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                        getTextWidth = dxGetTextWidth(text)
                        getTextWidth = getTextWidth + 20
                        dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                end
        else
                if isRegister == true then
                        if isMouseInPosition (sW*(0.57857143878937),sH*(0.65809524059296), sW*(0.0342857142857143), sH*(0.04)) then --exit 
                                local text = registerHighLightText[1]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.50499999523163),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- succeeded
                                local text = registerHighLightText[2]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.42642858624458),sH*(0.65619045495987), sW*(0.0342857142857143), sH*(0.04)) then -- back
                                local text = registerHighLightText[3]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.56357145309448),sH*(0.51523810625076), sW*(0.0271428571428571), sH*(0.0238095238095238)) then --show pass
                                if getElementData(login.passShowIcon,"passShowIcon") == "fils/icons/eyec.png" then
                                        text = registerHighLightText[5]
                                else
                                        text = registerHighLightText[4]
                                end                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.43285715579987),sH*(0.32571429014206), sW*(0.1764285714285714), sH*(0.04)) then --user 
                                local text = registerHighLightText[6]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.43857142329216),sH*(0.37428572773933), sW*(0.1764285714285714), sH*(0.04)) then --pass edit
                                local text = registerHighLightText[7]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.41285714507103),sH*(0.42285713553429), sW*(0.1764285714285714), sH*(0.04)) then --re pass edit
                                local text = registerHighLightText[8]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                        if isMouseInPosition(sW*(0.4135714173317),sH*(0.4695238173008), sW*(0.1764285714285714), sH*(0.04)) then --email edit
                                local text = registerHighLightText[9]
                                dxDrawText( text, sW*screenx+10, sH*screeny-15, 20, 20, tocolor(255,255,255),1,"default-bold",alignX,alignY,clip,wordBreak,true)
                                getTextWidth = dxGetTextWidth(text)
                                getTextWidth = getTextWidth + 20
                                dxDrawRectangle ( sW*screenx, sH*screeny-15, getTextWidth, 15, tocolor ( 0, 0, 0, 150 ) )
                        end
                end
        end
        --register

end
)



function successfullLogin() --On player has login then clear any login or register config or panel form the player screen
        if getElementData(localPlayer,"isPlayerLoggedIn") == true then
                isLogin = false
                isRegister = false
                local freeze = isElementFrozen ( localPlayer )
                fadeCamera( true, 1,255, 0, 0)
                dgsSetVisible(login.panel,false)
                setCameraTarget(source, source)
                showCursor(false)
                removeCamHandler()
                showChat(true)
                if freeze == true then
                        setElementFrozen(localPlayer,false)
                        toggleAllControls(true)
                        setElementDimension(localPlayer,0)
                end
        end

end
function registerSuccess(  ) -- On player complet register account then send him to login panel
        isLogin = true
        isRegister = false
        dgsSetVisible(login.panel,true)
        dgsSetVisible(register.panel,false)

end

addEvent("register.success",true)
addEvent("login.success",true)
addEventHandler( "login.success", localPlayer, successfullLogin)
addEventHandler ("register.success",localPlayer,registerSuccess)
