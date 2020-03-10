
--var
loadstring(exports.dgs:dgsImportFunction())()
local registerPanel = nil
local rRt = dgsCreateRoundRect(16,tocolor(85,90,100,150))
local loginPanel = nil
local OswaldBold = dgsCreateFont( "login-panel/fils/fonts/OswaldBold.ttf", 9 )
local fontText = dgsCreateFont("login-panel/fils/fonts/openSans.ttf", 11.65)
local errorFont = dgsCreateFont("login-panel/fils/fonts/openSans.ttf", 8)
local TextGUI = dgsCreateFont("login-panel/fils/fonts/openSans.ttf", 8)
local fontTextLabel = dgsCreateFont("login-panel/fils/fonts/openSans.ttf", 10)
local fontTab = dgsCreateFont("login-panel/fils/fonts/openSans.ttf", 11)
local titleFont = dgsCreateFont("login-panel/fils/fonts/Kalam.ttf", 25)
local OpenSans = dgsCreateFont("login-panel/fils/fonts/openSans.ttf")
local imgJoin = "https://cdn.discordapp.com/attachments/540486415151005707/685496704245825537/256-512.png"


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




--[[////////////////////////////////////(Login Gui)///////////////////////////////////]]--

        loginPanel = dgsCreateWindow ( 409, 257, 308, 475, "login panel", false )
        dgsWindowSetSizable(loginPanel, false)
        dgsSetProperty(loginPanel,"titleHeight",0)

        rndRect = dgsCreateRoundRect(60,tocolor(38, 130, 194,150))
        titleRet = dgsCreateImage(0,3,50,50,rndRect,false,loginPanel)
        titleText = dgsGetText(loginPanel)
        title = dgsCreateLabel(45,10,308,24,titleText,false,loginPanel)
        dgsSetFont(title,titleFont)

        loginBnt = dgsCreateButton(54, 299, 206, 35, "Login", false, loginPanel)
        registerBnt = dgsCreateButton(54, 344, 206, 35, "Register", false, loginPanel)
        userEdit = dgsCreateEdit(71, 187, 206, 30, "", false, loginPanel)
        passEdi = dgsCreateEdit(71, 227, 206, 30, "", false, loginPanel)
        rememberChe = dgsCreateCheckBox(71, 267, 144, 15, "Remmeber me", true, false, loginPanel)
        loginMsgInfo = dgsCreateLabel(0, 42, 308, 24, "loginMsgInfo", false, loginPanel)
        dgsLabelSetHorizontalAlign(loginMsgInfo, "center", false)
        dgsLabelSetVerticalAlign(loginMsgInfo, "center")
        dgsLabelSetColor ( loginMsgInfo, 157, 11, 11 )
        dgsSetFont(loginMsgInfo,errorFont)
        lableINFO = dgsCreateLabel(60, 400, 195, 15, "Island Roleplay @ 2020", false, loginPanel)
        dgsSetFont( lableINFO, fontTextLabel )
        dgsLabelSetHorizontalAlign(lableINFO, "center", false)
        dgsLabelSetVerticalAlign(lableINFO, "center")
        lableINFO2 = dgsCreateLabel(60, 419, 195, 15, "Roleplay gamemode login panel", false, loginPanel)
        dgsLabelSetHorizontalAlign(lableINFO2, "center", false)
        dgsLabelSetVerticalAlign(lableINFO2, "center")
        dgsSetFont( lableINFO2, fontTextLabel )
        usernameLable = dgsCreateLabel(3, 188, 68, 29, "Username", false, loginPanel)
        dgsLabelSetHorizontalAlign(usernameLable, "center", false)
        dgsLabelSetVerticalAlign(usernameLable, "center")
        dgsSetFont( usernameLable, fontTextLabel )
        passwordLable = dgsCreateLabel(3, 227, 68, 29, "Password", false, loginPanel)
        dgsLabelSetHorizontalAlign(passwordLable, "center", false)
        dgsLabelSetVerticalAlign(passwordLable, "center")
        dgsSetFont( passwordLable, fontTextLabel )

        ---avatar setting
        defProfile = dxCreateTexture("login-panel/fils/png/profile.png")    --default profile
        local w,h = dxGetMaterialSize(defProfile)
        profileMask = dgsCreateMask(defProfile,"circle")    --create mask for default profile
        dgsMaskCenterTexturePosition(profileMask,w,h)
        dgsMaskAdaptTextureSize(profileMask,w,h)
        playerProfile = dgsCreateRemoteImage()    -- for player's profile
        profile = dgsCreateImage(85, 60, 130, 130, profileMask,false,loginPanel)
        addEventHandler("onDgsRemoteImageLoad",playerProfile,function()
            dgsMaskSetTexture(profileMask,dgsRemoteImageGetTexture(source))
        end,false)
        


        dgsSetText( loginMsgInfo, "" )


--[[////////////////////////////////////(Register Gui)///////////////////////////////////]]--

        registerPanel = dgsCreateWindow(341, 143, 706, 190, "Register Panel", false)
        dgsWindowSetSizable(registerPanel, false)
        dgsSetProperty(registerPanel,"titleHeight",0)

        titleRet = dgsCreateImage(0,3,50,50,rndRect,false,registerPanel)
        titleText = dgsGetText(registerPanel)
        title = dgsCreateLabel(45,10,308,24,titleText,false,registerPanel)
        dgsSetFont(title,titleFont)
        eY = 25
        backBnt = dgsCreateButton(562, 93+eY, 131, 35, "Back", false, registerPanel)
        regUserEdit = dgsCreateEdit(77, 37+eY, 199, 30, "", false, registerPanel)
        registerSeccBnt = dgsCreateButton(562, 33+eY, 131, 35, "register", false, registerPanel)
        regUsername = dgsCreateLabel(10, 44+eY, 67, 26, "Username", false, registerPanel)
        dgsSetFont(regUsername, fontTextLabel)
        dgsLabelSetVerticalAlign(regUsername, "center")
        regPassword = dgsCreateLabel(10, 90+eY, 67, 26, "Password", false, registerPanel)
        dgsSetFont(regPassword, fontTextLabel)
        dgsLabelSetVerticalAlign(regPassword, "center")
        regRePqssword = dgsCreateLabel(276, 90+eY, 67, 26, "Re Password", false, registerPanel)
        dgsSetFont(regRePqssword, fontTextLabel)
        dgsLabelSetVerticalAlign(regRePqssword, "center")
        regPassEdit = dgsCreateEdit(77, 83+eY, 199, 30, "", false, registerPanel)
        regRePassEdit = dgsCreateEdit(353, 83+eY, 199, 30, "", false, registerPanel)
        regEmail = dgsCreateLabel(280, 44+eY, 67, 26, "Email", false, registerPanel)
        dgsSetFont(regEmail, fontTextLabel)
        dgsLabelSetVerticalAlign(regEmail, "center")
        regEmailEdit = dgsCreateEdit(353, 37+eY, 199, 30, "", false, registerPanel)
        regAcceptCheck = dgsCreateCheckBox(48, 138+eY, 228, 16, "accept server rules", false, false, registerPanel)
        dgsSetFont(regAcceptCheck, fontTextLabel)
        dgsSetProperty(regAcceptCheck, "NormalTextColour", "FF00A1FE")   
        registerMsgInfo = dgsCreateLabel(198, 19+eY, 323, 15, "registerMsgInfo", false, registerPanel)
        dgsLabelSetHorizontalAlign(registerMsgInfo, "center", false)
        dgsLabelSetVerticalAlign(registerMsgInfo, "center")
        dgsLabelSetColor ( registerMsgInfo, 157, 11, 11 )  
        dgsSetText( registerMsgInfo, "" )
        dgsSetFont(registerMsgInfo,errorFont)

        avatarEdit = dgsCreateEdit(335, 127+eY, 212, 30, "", false,registerPanel)
        regAvatar = dgsCreateLabel(235, 135+eY, 100, 16, "Avatar URL .png", false, registerPanel) 


        edit = {passEdi,userEdit,regPassEdit,regEmailEdit,avatarEdit,regRePassEdit,regUserEdit}

        dgsSetVisible( registerPanel, false )


        --------------
        ---Property---
        --------------

        dgsSetProperty(edit,"padding",{9,0})

        --login edit
        dgsSetProperty(passEdi,"bgImage",rRt)
        dgsSetProperty(userEdit,"bgImage",rRt)
        --login bnt 
        dgsSetProperty(registerBnt,"image",{rRt,rRt,rRt})
        dgsSetProperty(loginBnt,"image",{rRt,rRt,rRt})

        --register edit 
        dgsSetProperty(regPassEdit,"bgImage",rRt)
        dgsSetProperty(regEmailEdit,"bgImage",rRt)
        dgsSetProperty(avatarEdit,"bgImage",rRt)
        dgsSetProperty(regRePassEdit,"bgImage",rRt)
        dgsSetProperty(regUserEdit,"bgImage",rRt)


        --register bnt 
        dgsSetProperty(backBnt,"image",{rRt,rRt,rRt})
        dgsSetProperty(registerSeccBnt,"image",{rRt,rRt,rRt})


--[[////////////////////////////////////(Login Config)///////////////////////////////////]]--

function infoLogMsg (text, code) -- if you want send info to login panel use this function
	if code == "error" then
		dgsSetText (loginMsgInfo,text)
                dgsLabelSetColor( loginMsgInfo,157, 11, 11 )
        else
                if code == "good" then
                        dgsSetText (loginMsgInfo,text)
                        dgsLabelSetColor( loginMsgInfo,16, 193, 46 )
                end
	end


end
addEvent("infoLoginMsg",true)
addEventHandler( "infoLoginMsg", getRootElement(), infoLogMsg )



function infoReMsg (text, code) -- if you want send info to register panel use this function
	if code == "error" then
		dgsSetText (registerMsgInfo,text)
                dgsLabelSetColor( registerMsgInfo,157,11,11 )
        else
                if code =="good" then 
                        dgsSetText(registerMsgInfo,text)
                        dgsLabelSetColor(registerMsgInfo,16, 193, 46)
                end
	end
end
addEvent("infoRegisterMsg",true)
addEventHandler( "infoRegisterMsg", getRootElement(), infoReMsg )

function onJoin( ) --On player is join allow to show login panel

                dgsSetVisible( loginPanel , true )
                loginSound = playSound( "login-panel/fils/music/parasyte.mp3")
                smoothMoveCamera(131.16368103027, -1786.4763183594, 39.825199127197, 160.28018188477, -1880.9406738281, 24.701948165894,131.16368103027, -1600.4763183594, 39.825199127197, 160.28018188477, -1880.9406738281, 24.701948165894,20000)
                fadeCamera(true)
                showCursor(true)
                dgsWindowSetCloseButtonEnabled(loginPanel, false)
                showChat(false)

                        toggleAllControls(false)
                        setElementFrozen(localPlayer,true)
                        setElementDimension(localPlayer,1)
                        setElementPosition(localPlayer,0,0,0)
        print(getElementPosition(localPlayer))
               
end       
addEventHandler( "onClientResourceStart", resourceRoot, onJoin )


function loginBntClick ( localPlayer ) --On player use login Button then start get config and send to server side
        
                if (source == loginBnt) then
                        username = dgsGetText(userEdit)
                        password = dgsGetText(passEdi)
                        
                        if (string.len(password) > 4 and string.len(username) > 1) then
                                triggerServerEvent("loginSuccess", root, username, password)
                        else
                                infoLogMsg( "You need +4 chars in Password and +2 chars in Username","error")
                        end
                end
end
addEventHandler( "onDgsMouseClick", loginBnt, loginBntClick )

addEventHandler("onClientRender", root, 
function()
        if isElement(loginPanel) and dgsGetVisible(loginPanel) then
                Getusername = dgsGetText(userEdit)
                triggerServerEvent("mysqlRender",root, Getusername)
                avatarUrl = getElementData(localPlayer,"avatarUrl")
                name = getElementData(localPlayer,"name")

                if Getusername == name then 
                        setElementData(localPlayer,"imgName",avatarUrl)
                else
                        local profileImg1 = "https://cdn.discordapp.com/attachments/540486415151005707/685496704245825537/256-512.png" 
                        setElementData(localPlayer,"imgName",profileImg1)
                end
        end

end)

addEventHandler("onClientKey",root,
function()
        if isElement(loginPanel) and dgsGetVisible(loginPanel) then
                local imageData = getElementData(localPlayer,"imgName")
                if imageData then
                    dgsRemoteImageRequest(playerProfile,imageData,true)
                end
                                
        end
end)

function successfullLogin() --On player has login then clear any login or register config or panel form the player screen
        if getElementData(localPlayer,"isPlayerLoggedIn") == true then
                
                local freeze = isElementFrozen ( localPlayer )
                fadeCamera( true, 1,255, 0, 0)
                dgsSetVisible( loginPanel , false )
                setCameraTarget(source, source)
                showCursor(false)
                removeCamHandler()
                stopSound(loginSound)
                showChat(true)
                if freeze == true then
                        setElementFrozen(localPlayer,false)
                        toggleAllControls(true)
                        setElementDimension(localPlayer,0)
                        print(getElementPosition(localPlayer))
                end
        end

end
addEvent("login.success",true)
addEventHandler( "login.success", localPlayer, successfullLogin)


--[[////////////////////////////////////(Register Config)///////////////////////////////////]]--
function registerBntClick(  ) -- On player use register button then show register panel
        if (source == registerBnt) then
                dgsWindowSetCloseButtonEnabled(registerPanel,false)
		dgsSetVisible( registerPanel, true )
                dgsSetVisible( loginPanel, false )
	end
end
addEventHandler( "onDgsMouseClick", registerBnt, registerBntClick)

function registerPanelBntClick(  ) -- On the player, use the registration panel to create an account, take some security preparations, and send the configuration to the server side
		if (source == registerSeccBnt) then
			regUsernameGet = dgsGetText(regUserEdit)
			regEmailGet = dgsGetText(regEmailEdit)
			regPasswordGet = dgsGetText(regPassEdit)
			regAcceptCheckBox = dgsCheckBoxGetSelected(regAcceptCheck)
                        regRePasswordGet = dgsGetText(regRePassEdit)
				if not regUsernameGet or regUsernameGet == "" or not regPasswordGet or regPasswordGet == "" or not regRePasswordGet or regRePasswordGet == "" or not regEmailGet or regEmailGet == ""  then
					infoReMsg("Please fill out all the information","error")
				elseif string.len(regUsernameGet)< 3 then
					infoReMsg("The name must be more than four characters long","error")
				elseif string.len(regPasswordGet)< 6 then
					infoReMsg("Password must be more than six characters long","error")
				elseif string.len(regUsernameGet)>= 15 then 
					infoReMsg("The name must be less than fourteen characters long","error")
				elseif regPasswordGet ~= regRePasswordGet then
					infoReMsg("The password must match the password confirmation","error")
				elseif string.match(regUsernameGet,"%W") then
					infoReMsg("\"!@#$\"%'^&*()\" are not allowed in username.","error")				
                                end
                                
--[[/////////////////////////////////(Avatar system)/////////////////////////////////]]--

                                avatarGet = dgsGetText(avatarEdit)

                                

                                if (regPasswordGet) == (regRePasswordGet) then
					triggerServerEvent( "registerPlayer", root, regAcceptCheckBox, regUsernameGet, regRePasswordGet ,regPasswordGet, regEmailGet,avatarGet)
				end

		end
	end
addEventHandler( "onDgsMouseClick", registerSeccBnt, registerPanelBntClick)



function backBntClick(  ) -- On player use back Button then clear register panel and show login panel
        if (source == backBnt) then
                dgsWindowSetCloseButtonEnabled(loginPanel, false)
		dgsSetVisible( loginPanel, true )
                dgsSetVisible( registerPanel, false )
	end
end
addEventHandler( "onDgsMouseClick", backBnt, backBntClick )

function registerSuccess(  ) -- On player complet register account then send him to login panel
	dgsSetVisible( loginPanel, true )
        dgsSetVisible( registerPanel, false )

end
addEvent ("register.success", true)
addEventHandler ("register.success",localPlayer,registerSuccess)

--[[/////////////////////////////////(Avatar Config)/////////////////////////////////]]--

