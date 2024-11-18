function isElementInRange(ele, x, y, z, range)
    if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
        return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.
    end
    return false
end


function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function getVehicleSQLFromPlayerId(characterIDPlayer)
    local dataTable = sql:query("SELECT * FROM `vehiculos` WHERE personajeID = ?",characterIDPlayer)
    return dataTable
end



function secureVertifyParams(p)
    if p and getElementType(p) == "player" then
	   
	     local idCharacter = apiServer:getIdPlayerCharacter(p)
		 if not VehiculosJugadores[idCharacter] then --- Si no tiene vehiculos, no hacer nada
		    return false 
		 end
		    
	      
	     return true -- En este caso si existe, devuelve true.
	end 
	return false
end





function isVehicleOwner(player,vehicleToFind)
    
	
	if not secureVertifyParams(player) then
	    return 
	end
	
	
	
	local find
	local vehPersonalEncontrado
	local idCharacter = apiServer:getIdPlayerCharacter(player)
	local findVehicle = nil
	local vehiculoSubido = getPedOccupiedVehicle (player )
	
	if isElement(vehiculoSubido) then
	    findVehicle = vehiculoSubido
	else
		local autoCerca = vehiculosCercanos(player)
		findVehicle = getVehicleInTablePlayer(idCharacter,autoCerca)
	end
	
	
	if not findVehicle then
	   return 
	end
	
	    
		
	if not VehiculoData[findVehicle] then
		 return false
	end
		
		
		
		local dataVeh = VehiculoData[findVehicle]
		if dataVeh.personajeID == idCharacter then
		    return findVehicle
		end
		
		

	
	return false
end






local function sellVehiclePlayer(player)
	
    local vehiculoPersonal = getPedOccupiedVehicle ( player ) 
	
	
	if not vehiculoPersonal then
	   return 
	end
	
	if not isVehicleOwner(player,vehiculoPersonal) then
	   return
	end
	
	
	 local globalVehiculoID = getDataVehiclePlayer(vehiculoPersonal,"identificadorId")
	 local CharacterID = getDataVehiclePlayer(vehiculoPersonal,"personajeID")
	 
	 removePedFromVehicle ( player ) 
	 deleteVehicle(CharacterID,vehiculoPersonal)
	    
end
addCommandHandler("vender",sellVehiclePlayer)