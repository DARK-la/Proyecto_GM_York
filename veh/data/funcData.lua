
function vehiculosCercanos(playerElement)

    local vehEncontrado 
    local playerX, playerY, playerZ = getElementPosition(playerElement)
	local playerInterior = getElementInterior(playerElement)
	local playerDimension = getElementDimension(playerElement)
	local searchRange = 5
	local nearbyVehicles = getElementsWithinRange(playerX, playerY, playerZ, searchRange, "vehicle", playerInterior, playerDimension)
	
	for indice, vehiculo in ipairs(nearbyVehicles) do
	    local vx,vy,vz = getElementPosition(vehiculo)
		
		if getDistanceBetweenPoints3D(playerX, playerY, playerZ, vx,vy,vz) <= searchRange - math.random(1,2) then
		   vehEncontrado = vehiculo
		   break
		end
	end
	
	if vehEncontrado then
	   return vehEncontrado
	end
end



function getVehicleInTablePlayer(pId,vehicleToFind)

  local idCharacter = pId
  local vehiculoEncontrado
  
  for index,v in ipairs(VehiculosJugadores[idCharacter]) do
	     if v == vehicleToFind then
			 vehiculoEncontrado = v
		    break
		 end
	end
	
	
	return vehiculoEncontrado
end





function getDataVehiclePlayer(veh,type)

  
	if not VehiculoData[veh] then
	  return 
	end
	
	local data = VehiculoData[veh][type]
	
	return data
end  


function setDataVehiclePlayer(veh,type,value)

  
	if not VehiculoData[veh] then
	  return 
	end
	
	VehiculoData[veh][type] = value
	
	
	
    return true
end  


 

function deleteVehicle(pId,veh)

   if not VehiculoData[veh] then
	  return 
	end
	
	
	
	local findVehicle = getVehicleInTablePlayer(pId,veh)
	local deleteIndex 
	
	--VehiculoData[findVehicle] = nil
	
	for i=1,#VehiculosJugadores[pId] do
	    local porCadaVehiculo = VehiculosJugadores[pId][i]
		
		if isElement(porCadaVehiculo) and porCadaVehiculo == veh then
			deleteIndex = i
            break
		end
		
	end
	
	
	if deleteIndex then
		outputChatBox("Acabas de borrar "..deleteIndex)
		table.remove(VehiculosJugadores[pId],deleteIndex)
		destroyElement(veh)
		VehiculoData[veh] = nil
		
		if #VehiculosJugadores[pId] == 0 then
		   VehiculosJugadores[pId] = nil
		end
		
	end
	
end


