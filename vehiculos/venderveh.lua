

function canVehicleIsOwnerSell(player,toCharacterId) 
   local vehPorVender = getPedOccupiedVehicle(player)
   
   if not vehPorVender then
      return 
   end
   
   if not DatosVehiculos[vehPorVender] then
    return
   end
   
   
   if DatosVehiculos[vehPorVender].pid == toCharacterId then
      return true,vehPorVender
   end
   
   
end



function sellVehicle(pid,veh)
    if pid and veh then
	   local dataEncontrada = {}
	   for vehIndice,vehiculoPersonal in pairs(VehiculosJugadores[pid]) do
	       if vehiculoPersonal == veh then
		    
			  dataEncontrada.idTablaVeh = vehIndice
			  dataEncontrada.vehiculoElemento = vehiculoPersonal
			  break
		   end
	   end
	   
	   if dataEncontrada then
	   
	      local idEncontradoTabla = dataEncontrada.idTablaVeh
		  local userDataVehicle = dataEncontrada.vehiculoElemento
		  
		  if not DatosVehiculos[userDataVehicle] then
		     return
		  end
		  
		  local globalIDVeh = DatosVehiculos[userDataVehicle].vid
		  
		  
		  
		  
			if sql:queryFree("DELETE FROM `vehiculos` WHERE id = ?", globalIDVeh ) then
				table.remove(VehiculosJugadores[pid],idEncontradoTabla)
				DatosVehiculos[userDataVehicle] = nil
				destroyElement(userDataVehicle)
				userDataVehicle = nil
			end
			  
	   end
	end
end


function venderVehiculoServidor(player)
   local idCharacter = apiServer:getIdPlayerCharacter(player)
   local PuedeVender,vehiculoElemento = canVehicleIsOwnerSell(player,idCharacter)

	if not haveVehiclePlayer(player) then
	   outputChatBox("No posee vehiculos para vender.",player,234,1,1)
	   return
	end  
	
	
	if PuedeVender then
	   sellVehicle(idCharacter,vehiculoElemento)
	   outputChatBox("Vehiculo fue vendido a un precio razonable.",root,255,25)
	end
    
end
addCommandHandler("vender",venderVehiculoServidor)