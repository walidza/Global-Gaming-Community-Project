--[[
    ___         __                               __ 
   /   |  _____/ /__________  ____  ____ ___  __/ /_
  / /| | / ___/ __/ ___/ __ \/ __ \/ __ `/ / / / __/
 / ___ |(__  ) /_/ /  / /_/ / / / / /_/ / /_/ / /_  
/_/  |_/____/\__/_/   \____/_/ /_/\__,_/\__,_/\__/ 

--Script: notif system
--Created In 05-04-2020 by iWalidza.

]]--



function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		if (not bgColor) then
			bgColor = borderColor;
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
	end
end


local sW , sH = guiGetScreenSize()
local sx, sy = sW/1400, sH/1050
local timer = false
local timeShow = 10

local notifs = {}

local types ={
  --["type"] ={r, g, b,path};
    ["error"] ={82, 16, 16,"png/error.png"};
    ["sucssful"] ={37, 142, 37,"png/scc.png"};
    ["info"] ={26, 83, 255,"png/info.png"};
}


outputNotf = {
    
    drawNotf = function(type,...)
        if not type or type == "" or not types[type] then 
            type = "sucssful"
        end
        local texts = {...}
        if not texts or #texts == 0 then
            return false
        end
        local index = table.maxn(notifs) + 1
        notifs[index] = {}
        notifs[index]["texts"] = {}
       --
           for i, text in ipairs(texts) do
               table.insert(notifs[index]["texts"], text)
           end
            notifs[index]["type"] = type
            notifs[index]["tick"] = getTickCount( ) 
    end;

    renderNotf = function()
        for i, notif in ipairs(notifs) do
            local type = notif["type"]
            local tick = notif["tick"]
            local ticknow = getTickCount()
            local texts = notif["texts"]
            local width = 0
            local colors = types[type]
            for i, text in ipairs(texts) do
                width = dxGetTextWidth(text, 1, "sans")
            end
                if ( ticknow - tick >= timeShow * 500 ) then 
                    table.remove( notifs, i ) 
                end

            local height = i * 35
            local x = interpolateBetween(-60,0,0,100,0,0,(getTickCount( ) - tick) / ((tick + 5000+i*5) - tick), "OutElastic")
            local y = interpolateBetween(-60,0,0,width,0,0,(getTickCount( ) - tick) / ((tick + 5000+i*5) - tick), "OutElastic")
            move= x+width
            roundedRectangle(x-90, 361 + height, width+8, 22,tocolor(colors[1],colors[2],colors[3],155),tocolor(colors[1],colors[2],colors[3],155),false)
            for i, textS in ipairs(texts) do
                dxDrawText(textS, x-88, 362 + height , 193, 383, tocolor(255, 255, 255, 255), 1, "sans", "left", "top", false, false, false, false, false)
            end
            dxDrawImage(move-80, 351 + height , 35, 35,colors[4],0,0,0,tocolor(colors[1],colors[2],colors[3],226))
        end
    end;
}
addEventHandler("onClientRender",root,outputNotf.renderNotf)

function drawNotif(type,...)
    return outputNotf.drawNotf(type,...)
end
addEvent("drawNotif",true)
addEventHandler("drawNotif",root,drawNotif)