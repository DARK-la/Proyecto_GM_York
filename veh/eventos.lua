

function DetectarVehiculoBloqueo ( player, seat, jacked ) 
   local estadoBloqueo = getDataVehiclePlayer(source,"bloqueo")
   
    if estadoBloqueo then
       local vehiculoNombre = getVehicleName(source)
       outputChatBox("El vehículo "..vehiculoNombre.." se encuentra cerrado.",player,255,25,2)
	   cancelEvent()
       return
    end
    
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), DetectarVehiculoBloqueo )




function LogicaMotorDetectar ( thePlayer, seat, jacked ) -- when a player enters a vehicle
    local estadoMotor = getDataVehiclePlayer(source,"motor")
	
	if not estadoMotor then
	    setDataVehiclePlayer(source,"motor",false)
		setVehicleEngineState(source,false)
	end
	
end
addEventHandler ( "onVehicleEnter", getRootElement(), LogicaMotorDetectar )

