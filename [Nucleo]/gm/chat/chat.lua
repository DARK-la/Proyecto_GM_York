local spam = {}
local rangoChat = 15
local tiempoEnvioMensaje = 900


local tiposMensaje = {
    [0] = {color = "#FFFFFF",  prefijo = "dice: ", spamtiempo = 1300}, -- Chat Basico
    [1] = {color = "#FF8800* ", prefijo = ""}, -- Comando me
    [2] = {color = "#81bf44| ( ", prefijo = ") | ",rango = 12, spamtiempo = 2300} ,-- Mensaje do
    [3] = {color = "#FFFFFF" ,prefijo = "grita: ", rango = (rangoChat * 2) + 3 , spamtiempo = 1500} -- Comando gritar

}




function UsuarioChatear(message, messageType)
    cancelEvent()
	if messageType == 0 or messageType == 1 then
       enviarMensajeLocal(source,message,messageType)
	end
end
addEventHandler("onPlayerChat", root, UsuarioChatear)






function mensajeChatDo(player,_,...)
    local mensajeDo =  table.concat( {...}, " " )
    if #mensajeDo >= 2 and #mensajeDo <= 150 then
        enviarMensajeLocal(player,mensajeDo,2)
    end
end
addCommandHandler("do",mensajeChatDo)


function mensajeGritarChat( player,_,... )
   local mensajeGritar =  table.concat( {...}, " " )
   if #mensajeGritar >= 3 and #mensajeGritar <= 150 then
        enviarMensajeLocal(player,mensajeGritar,3)
    end
end
addCommandHandler("g",mensajeGritarChat)




local function removeHex (s)
    return s:gsub ("#%x%x%x%x%x%x", "") or false
end



function enviarMensajeLocal( usuario,mensaje, mensajeTipo )
         


       local patronIP = "%d+%.%d+%.%d+%.%d+"



       if string.match(mensaje,patronIP) then
           outputChatBox("Encontrado algo de IP te kickeo por wachin")
           return
       end

    
        local cantidadTimeOut = tiposMensaje[mensajeTipo].spamtiempo or tiempoEnvioMensaje


        

        if spam[usuario] and getTickCount() - spam[usuario] < cantidadTimeOut then
             return 
        end
      


        local contieneEspaciosInicio = string.find(mensaje,"^%s") 
        if contieneEspaciosInicio then
            print("Contienes espacios al inicio")
            return 
        end
 
         local rangoLocal = tiposMensaje[mensajeTipo].rango or rangoChat 
         local x,y,z = getElementPosition(usuario)
         local interior, dimension = getElementInterior(usuario), getElementDimension(usuario)

         local jugadoresCerca = getElementsWithinRange ( x,y,z, rangoLocal, "player", interior, dimension ) or false

          if not type(jugadoresCerca) == "table" then
             return
          end

         
         local infoMensaje = tiposMensaje[mensajeTipo]
         local usuarioNombre = string.gsub(getPlayerName(usuario),"_"," ")
         local color = infoMensaje.color
         local prefix = infoMensaje.prefijo


         local mensajeLimpio = removeHex(mensaje) or "(ERROR)"
        
        

        for i=1,#jugadoresCerca do
            local usuarioCerca = jugadoresCerca[i]
            outputChatBox(color..""..usuarioNombre.." "..prefix..""..mensajeLimpio..".",usuarioCerca,255,255,255,true)
        end


        spam[usuario] = getTickCount()

end


function onSalirUsuario( ... )
    if spam[source] then
       spam[source] = nil
    end
end
addEventHandler("onPlayerQuit",root,onSalirUsuario)





