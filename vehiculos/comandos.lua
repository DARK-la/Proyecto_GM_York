function traerVehiculoPersonal(p,_,personajeID,slot)

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


   	    	outputChatBox(inspect(vehData))
   	    end


   	 
   end
end
addCommandHandler("traerveh",traerVehiculoPersonal)


function verVehiculos(p)
    if haveVehiclePlayer(p) then
	
        local _,userID = haveVehiclePlayer(p)
        for slotEspacio,v in ipairs(VehiculosJugadores[userID]) do
		
		    local vehiculoPersonal = v
		    local zonaVehiculo = getZoneName(getElementPosition(vehiculoPersonal))
			
            outputChatBox("Slot: "..tostring(slotEspacio).." -> "..getVehicleName(vehiculoPersonal)..": "..zonaVehiculo,p,255,255,255)
        end
    end
end
addCommandHandler("gpsveh",verVehiculos)



function bloquearVehiculo(p)

      
      if not isVehicleOwnerNear(p) then
        return
      end


      local veh = isVehicleOwnerNear(p)
      local estado = not isVehicleLocked(veh)
	  
	  if not veh then
	    return 
	  end

      setVehicleLocked(veh, estado)
      
      local modeloVehiculo = getVehicleName(veh)
      local tipoEstado = estado and "cerrado" or "abierto"
      local msg = string.format("#EDAD21%s #FFFFFFfue %s.",modeloVehiculo,tipoEstado)
      outputChatBox(msg,p,255,124,25,true)
       
end
addCommandHandler("lock",bloquearVehiculo)





function motorVehiculo(p)


    if not getPedOccupiedVehicle(p) then
     	return
	end
	 
	if not isVehicleOwnerNear(p) then
		return
	end
	
	
	if getPedOccupiedVehicleSeat(p) > 0 then
	   return
	end
	

    local veh = isVehicleOwnerNear(p)	
	
	local tipoEstadoMotor = not getVehicleEngineState(veh) == true and "enciende" or "apaga"
	local ms = not getVehicleEngineState(veh) == true and 3200 or 500
	
     
	exports["gm"]:enviarMensajeLocal(p,""..tipoEstadoMotor.." su motor del vehiculo",1)

	if  getVehicleEngineState(veh) then
		setVehicleEngineState(veh, false)
	else
		setTimer(setVehicleEngineState,math.random(1000,2500),1,veh,true)
	end
	
	
end
addCommandHandler("motor",motorVehiculo)



