local VehiculosEnVenta = {480,422,482,478,567,412,576,603,475,402,581,509,462,521,468,527,426,550,540,529,526,555,603,424	}




function nuevoVehiculoComprar(usuario,modelID)
	local positionVeh = toJSON({getElementPosition(usuario)})
	local colorVeh = toJSON({ 0,0,0,0,0 })
	
   if sql:queryFree("INSERT INTO `vehiculos` (vehicleID, positionVehicle, colorVehicle ,personajeId)  VALUES(?,?,?,?)",modelID, positionVeh, colorVeh,14 ) then
      outputChatBox("Nuevo vehiculo creado")
   end
end




