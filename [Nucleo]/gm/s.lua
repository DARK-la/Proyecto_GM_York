local usuarioHerido = {}
local tiempoSpawn = 4500
local HPosiciones = {2038.26416, -1414.58252, 17.1640612}
local servidorFPS = 60



function resetDatos()
    setFPSLimit ( servidorFPS )  
    print ( servidorFPS," FPS -> es el limite del servidor" )  
end
addEventHandler("onResourceStart",resourceRoot,resetDatos)



function onUsuarioDamage()
	if bodypart == 9 and getElementType(attacker) == "player" and attacker ~= source then
		local suerte = math.random(1,10) < 10
		if not suerte then
			return
		end
	    setElementHealth(source,0)
	 end
end
addEventHandler("onPlayerDamage",root,onUsuarioDamage)


function onUsuarioDerrota()
	if source and isElement(source)  then
        establecerEstadoPersona(source)
    end
end
addEventHandler("onPlayerWasted",root,onUsuarioDerrota)



function establecerEstadoPersona(usuario)
	 usuarioHerido[source] = true
	 local x,y,z = getElementPosition(usuario)
    local skinID = getElementModel(usuario)

	   setTimer(function(usuario,posx,posy,posz)
       	     if isElement(usuario) then
         	      spawnPlayer(usuario,posx,posy,posz,0,skinID)
         	      setPedAnimation(usuario,"CRACK","crckdeth4",-1,false,false,false,true,250,false)
         	 end
     end,tiempoSpawn,1,source,x,y,z)
end


function spawnearUsuarioComando(source)
   if usuarioHerido[source] and not isPedDead(source) then
       
       	  local skinIDUsuario = getElementModel(source)
       	  local interior = getElementInterior(source)
	        local dim = getElementDimension(source)
	        local team = getPlayerTeam(source) or nil
       		
       		setElementPosition(source,unpack(HPosiciones))
       		setElementDimension(source,dim)
       		setElementInterior(source,interior)
       		setElementModel(source,skinIDUsuario)
       		usuarioHerido[source] = nil
       else
       	outputChatBox("No estas en un estado alterado/herido",source,234,12,12,true)
    end
end
addCommandHandler("spawnear",spawnearUsuarioComando)




local LIMITED_COMMANDS = {
    ["gpsveh"] = 2.5,
    ["motor"] = 4,  
    ["lock"] = 2.3,
    ["maletero"] = 2,
    ["vermaletero"] = 2,
    
}

local EXEC = {}

addEventHandler("onPlayerCommand", root, function(cmd)
    

    local limit_sec = LIMITED_COMMANDS[cmd]
	
	
    if not limit_sec then return end

    local tick = getTickCount()

    if not EXEC[source]      then EXEC[source] = {}     end
    if not EXEC[source][cmd] then EXEC[source][cmd] = 0 end

    if EXEC[source][cmd] + (limit_sec * 1000) > tick then
        cancelEvent()
        local tiempoRestante = (EXEC[source][cmd] + (limit_sec * 1000) - tick) / (1000  + 1)
        local formateado = math.ceil(tiempoRestante)
        return outputChatBox("Limite de #edad21"..formateado.." #FFFFFFsegundos para este comando.", source, 255, 255, 255, true)
    end
    EXEC[source][cmd] = tick
end)

function limpiarTablaComandosJugador()
    if EXEC[source] then
       EXEC[source] = nil -- limpia la tabla cuando sale del servidor.
    end
end
addEventHandler("onPlayerQuit", root, limpiarTablaComandosJugador)




