--[[
function connect()
    DBConnection = dbConnect( "mysql", "dbname=rp;host=localhost;charset=utf8", "root", "rootroot" )
    if (not DBConnection) then
        outputDebugString("Error: Failed to establish connection to the MySQL database server")
    else
        outputDebugString("Success: Connected to the MySQL database server")
    end
end
addEventHandler("onResourceStart",resourceRoot, connect)

]]--