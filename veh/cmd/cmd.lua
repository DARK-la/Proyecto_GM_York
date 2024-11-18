function localizarVehiculos(player)
   
    if not secureVertifyParams(player) then
	  return
	end
	
	local characterID = apiServer:getIdPlayerCharacter(player)
	local vehiclesTable = VehiculosJugadores[characterID]
	
	
	for indice, veh in ipairs(vehiclesTable) do
	   local vx,vy,vz = getElementPosition(veh) 
	   local zone = getZoneName(vx,vy,vz)
	   local name = getVehicleName(veh)
	   local slotID = tostring(indice)
	   outputChatBox("Slot: "..slotID.." -> "..name..": "..zone,player,255,255,255,true)
	   createBlip(vx,vy,vz)
	
	end

end
addCommandHandler("gpsveh",localizarVehiculos)




local function TraerVehiculoPersonal(p,_,personajeID,slot)

   if personajeID and slot then

        local userID = tonumber(personajeID)
        local mislot = tonumber(slot)
		
		
   	    if not VehiculosJugadores[userID] or not VehiculosJugadores[userID][mislot] then
   	    	outputChatBox("/traerveh (id) (slot)",p,150,15,2)
   	    	return
   	    end


   	    local vehData = VehiculosJugadores[userID][mislot]

   	    if vehData then

   	    	local veh = vehData

   	    	local x,y,z = getElementPosition(p)
   	    	local rx,ry,rz = getElementRotation ( p ) 

   	    	setElementPosition(veh,x+2,y+2,z+1)
   	    	setElementRotation(veh,rx,ry,rz)

            
			local vehModel = getVehicleName(veh)
   	    	outputChatBox("#f3a450"..vehModel.." #fafafafue traido a tu posición.",p,255,255,255,true)
   	    end


   	 
   end
end
addCommandHandler("traerveh",TraerVehiculoPersonal)








local function toggleVehicleFeature(player, type)

    local vehiculoPropiedad = isVehicleOwner(player)
    
    if not vehiculoPropiedad then
        return
    end
    
   
    local estadoActual = getDataVehiclePlayer(vehiculoPropiedad, type)
    

    local nuevoEstado = not estadoActual
   
   
    local messageData = getMessageFeature(type,nuevoEstado)
	
	
    outputChatBox(messageData, player, 0, 0, 0,true)
    
  
    setDataVehiclePlayer(vehiculoPropiedad, type, nuevoEstado)
	
	
	if type == "motor" then
	  setTimer(setVehicleEngineState,math.random(500,1200),1,vehiculoPropiedad,nuevoEstado)
	end
	
	
	return nuevoEstado
end



local function desbloquearAutoServer(player)
     toggleVehicleFeature(player,"bloqueo")	
end
addCommandHandler("lock",desbloquearAutoServer)



local function motorVehiculo(player)
      toggleVehicleFeature(player,"motor")
end
addCommandHandler("motor",motorVehiculo)

