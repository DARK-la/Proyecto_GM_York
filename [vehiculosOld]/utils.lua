local radioVehiculoPersonal = 4
local distanciaVehiculoPersonal = 2.598234



function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function getSQLVehicles(characterIDPlayer)
    local data = sql:query("SELECT * FROM `vehiculos` WHERE personajeId = ? ", characterIDPlayer)
    return data
end



function haveVehiclePlayer(p)


    local userID = apiServer:getIdPlayerCharacter(p)
    if not VehiculosJugadores[userID] then
        return false
    end

    return true,userID
end



--- Esta funcion obtiene el vehiculo cercano y si es propietario

function getNearestElement(player, type, distance)
    local result = false
    local dist = nil
    if player and isElement(player) then
	
	
        local elements = getElementsWithinRange(Vector3(getElementPosition(player)), distance, type, getElementInterior(player), getElementDimension(player))
        for i = 1, #elements do
            local element = elements[i]
            if not dist then
                result = element
                dist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
            else
                local newDist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
                if newDist <= dist then
                    result = element
                    dist = newDist
                end
            end
        end
		
		
    end
    return result
end


function getNearVehicleFromPlayer(thePlayer,pIdCharacter)
     
	 local findVehicle = nil
     local x,y,z = getElementPosition(thePlayer)
	 local t = {getElementInterior(thePlayer),getElementDimension(thePlayer)}
	 local vehCercaJugador = getNearestElement(thePlayer,"vehicle",radioVehiculoPersonal)
	 

    if not vehCercaJugador  then
         return 
    end	  
	
	
	 iprint(vehCercaJugador)
	 
	local listaVehiculosPersonales = VehiculosJugadores[pIdCharacter]
	
	
	for indice,vehPersonal in ipairs(listaVehiculosPersonales) do
		 if isElement(vehCercaJugador) and isElement(vehPersonal) then
		      if vehCercaJugador == vehPersonal then
			  
			    
			     findVehicle = vehPersonal
			     break
			  end
		end
	end
	 
	
	return findVehicle
end




function isVehicleOwnerNear(player)

	 if not haveVehiclePlayer(player) then
	 	 return false
	 end
     
	 
	 local _,userIDPlayer = haveVehiclePlayer(player)
	 local vehiculoCerca = getNearVehicleFromPlayer(player,userIDPlayer)
	
	 
	 if not vehiculoCerca then
	    return 
	 end

	 if not DatosVehiculos[vehiculoCerca] then
		return
	 end
	 
	 local data = DatosVehiculos[vehiculoCerca] 
	 
	 if data.pid == userIDPlayer then
	    return vehiculoCerca
	 end
end






function valueVehicleModify(p,veh,type,value)

       if not haveVehiclePlayer(p) then
	     return
	   end
	   
	  
	   DatosVehiculos[veh][type] = value;
	   return true
end


function getVehicleDataPersonal(p,veh,type)

       if not haveVehiclePlayer(p) then
	     return
	   end
	   
	  
	   return DatosVehiculos[veh][type] 
end