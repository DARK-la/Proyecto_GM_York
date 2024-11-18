local VehiculosEnVenta = {480,422,482,478,567,412,576,603,475,402,581,509,462,521,468,527,426,550,540,529,526,555,603,424	}




function nuevoVehiculoComprar(vehicleName)

    local x,y,z = getElementPosition(client)
    local rx,ry,rz = getElementRotation(client)
	local positionVeh = toJSON({x+2,y+2,z,rx,ry,rz})
	local colorVeh = toJSON({ math.random(0,255),math.random(0,255),0,0,0 })
    local modelID = getVehicleModelFromName (vehicleName) 
    local idChar = apiServer:getIdPlayerCharacter(client)
    local _,lastId = sql:query("INSERT INTO `vehiculos` (vehicleID, positionVehicle, colorVehicle ,personajeId)  VALUES(?,?,?,?)",  modelID, positionVeh, colorVeh,idChar) 
      
    if lastId and type(lastId) == "number" then
    outputChatBox("[VEHICULOS] Acabas de comprar un "..vehicleName.." correctamente.",client,150,200,20,true)

    -- Tabla doble, para evitar bugs al momento de spwanear vehiculos de la base de datos.
    spawnVehiclePlayer({{positionVehicle = positionVeh, colorVehicle = colorVeh, id = lastId, personajeId = idChar, vehicleID = modelID}})
    else
        outputChatBox("¡UPS!, ERORR FATAL AL COMPRAR",client,200,0,15 )
   end
end 
addEvent("onClientVehicleBuyS",true)
addEventHandler("onClientVehicleBuyS",resourceRoot,nuevoVehiculoComprar)



