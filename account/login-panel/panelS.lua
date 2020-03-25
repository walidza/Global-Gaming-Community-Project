--Varbls
local mysql = exports.mysql

--Functions

function loginPlayer ( username, password)
	if (mysql:singleQuery("SELECT * FROM accounts WHERE username=? LIMIT 1",string.lower(username))) then
		local accData = mysql:singleQuery("SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1",string.lower(username),sha256(password))
		if (accData) then

			triggerClientEvent(client,"infoMsg",client,"login","Login has been confirmed...!","good")
			setTimer(function(thePlayer)
					--spawnPlayer(thePlayer,0,0,10)
				setElementData(thePlayer,"isPlayerLoggedIn",true)
				setElementData(thePlayer,"accountID",accData.id)
				setElementData(thePlayer,"accountUsername",accData.username)
				setElementData(thePlayer,"isInCharecterSelect",true)
				triggerClientEvent(thePlayer,"login.success",thePlayer)
			end,2500,1,client)

		else
			triggerClientEvent(client,"infoMsg",client,"login","Your username and/or password is incorrect!","error")
		end
	else
		triggerClientEvent(client,"infoMsg",client,"login","This username doesn't exist!","error")
	end
end

function registerPlayer(regUsername, regPassword, regEmail)
	if (mysql:singleQuery("SELECT username FROM accounts WHERE username=? LIMIT 1",string.lower(regUsername))) then
		triggerClientEvent(client,"infoMsg",client,"register","This username is taken! please choose another!","error")
	else
		local serial = getPlayerSerial(client)
		local ip = getPlayerIP(client)
		local username =string.lower(regUsername)
		local password = sha256(regPassword)
		if (mysql:execute("INSERT INTO accounts (username,password,email,serial,ip) VALUES (?,?,?,?,?)",username,password,regEmail,serial,ip)) then
			triggerClientEvent(client,"infoMsg",client,"register","Your account was registered successfully!","good")
			setTimer(function(thePlayer)triggerClientEvent(thePlayer,"register.success",thePlayer)end,2500,1,client)

		end
	end
end

function disconnectPlayer( )

	kickPlayer(client,"You are logged out of the server")

end




--Events


--loginPlayer
addEvent("loginPlayer",true)
addEventHandler("loginPlayer",root,loginPlayer)

--registerPlayer
addEvent("registerPlayer",true)
addEventHandler("registerPlayer",root,registerPlayer)

--disconnectPlayer
addEvent( "disconnectPlayer",true)
addEventHandler("disconnectPlayer",root,disconnectPlayer)