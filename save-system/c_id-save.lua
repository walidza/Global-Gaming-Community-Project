

local players = getElementsByType("player")


addEventHandler("onClientPlayerJoin",root,function()
    for k,v in pairs(players) do
        setElementData(v,"id",k)
    end 
end)
addEventHandler("onClientResourceStart",root,function()
    for k,v in pairs(players) do
        setElementData(v,"id",k)
    end 
end)

function getPlayerID(player)
    if (player) then
        return getElementData(player,"id")
    end
end

