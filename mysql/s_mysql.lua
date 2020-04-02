addEventHandler("onResourceStart",root,
function ()
    DBConnection = dbConnect( "mysql", "dbname=databesename;host=127.0.0.1;charset=utf8", "username", "pass" )
end
)


function singleQuery(str,...)
	if (DBConnection) then
		local query = dbQuery(DBConnection,str,...)
		local result = dbPoll(query,-1)
		if (type(result == "table")) then
			return result[1]
		else
			return result
		end
	else
		return false
	end
end

function execute(str,...)
	if (DBConnection) then
		local query = dbExec(DBConnection,str,...)
		return query
	else
		return false
	end
end
