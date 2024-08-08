local VehiculosEnVenta = {480,422,482,478,567,412,576,603,475,402,581,509,462,521,468,527,426,550,540,529,526,555,603,424	}




function nuevoVehiculoComprar(vehicleName)
	local positionVeh = toJSON({getElementPosition(client)})
	local colorVeh = toJSON({ 0,0,0,0,0 })
   local modelID = getVehicleModelFromName (vehicleName) 
   if sql:queryFree("INSERT INTO `vehiculos` (vehicleID, positionVehicle, colorVehicle ,personajeId)  VALUES(?,?,?,?)",modelID, positionVeh, colorVeh,14 ) then
      outputChatBox("Vehiculo creado.")

      iprint(positionVeh,colorVeh,modelID)
   end
end
addEvent("onClientVehicleBuyS",true)
addEventHandler("onClientVehicleBuyS",resourceRoot,nuevoVehiculoComprar)



