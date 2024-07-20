local ID = {}




------------------------- [ Events ] --------------------------
addEventHandler("onPlayerJoin", root, 
function()
    for i = 0, getMaxPlayers() do
	    if not ID[i] then
		   ID[i] = source
		   setElementData(source, "ID", i,false)
		   break;
		end
	end
end)



addEventHandler("onPlayerQuit", root, 
function()

	if ID[getPlayerID(source)] then
       ID[getPlayerID(source)] = nil
    end
end)


addEventHandler("onResourceStart", resourceRoot, 
function()
    for _, v in ipairs(getElementsByType("player")) do
	    for i = 0, getMaxPlayers() do
		    if not ID[i] then
			   ID[i] = v
			   setElementData(v, "ID",i,false)
			   break
			end
		end
	end
end)




addEventHandler("onResourceStop", resourceRoot, 
function()
    for _, v in ipairs(getElementsByType("player")) do
	     if getElementData(v,"ID") then
	     	removeElementData(v,"ID")
	     end
	end

	print("[SISTEMA ID] El recurso se acaba de detener -> remuevo el element data ID de todo los usuarios conectados.")
end)

------------------------- [ Functions ] -----------------------

function getPlayerID(player)
    if player and isElement(player) and getElementType(player) == "player" then
	   return getElementData(player, "ID")
	end
	return false
end





function getPlayerFromID(id)

 
	

    if id and type(id) == "number" and tonumber(id) >= 0 then

    	local usuarioID = tonumber(id)
    	if ID[usuarioID] then
    		 return ID[usuarioID], getPlayerName(ID[usuarioID]):gsub("_"," ")
    	end

	end

	return false,false
end



  
function informacionID(player,_,id)
    local usuarioID = tonumber(id)
 	local target,UsuarioNombre = getPlayerFromID(usuarioID)
	if target and #UsuarioNombre > 0 then
	   outputChatBox("#D2691E"..UsuarioNombre.." ["..id.."]",player,255,255,255,true)
	else
		outputChatBox("No encuentro ese usuario",player,234,1,1)
	end
	
end
addCommandHandler("id",informacionID,false)


