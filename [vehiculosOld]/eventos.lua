

function eventoEntrarVehiculo ( p, seat,jacked,door ) 
    if p and seat and isVehicleLocked(source) then
	    local modelo = getVehicleName(source)
		outputChatBox("El vehiculo "..modelo.." se encuentra cerrado.",p,235,30,0)
		cancelEvent()
	end
end
addEventHandler ( "onVehicleStartEnter", root, eventoEntrarVehiculo )


function VehiculoMotorDetectar ( thePlayer, seat, jacked ) 
    if source and getElementType(source) == "vehicle" and thePlayer then
	    
		
	   if not DatosVehiculos[source] then
		    return
		 end
        
		
		local data = DatosVehiculos[source]
		
		if data.motor == 0 then
		   setVehicleEngineState(source,false)
		end
	end  
end
addEventHandler ( "onVehicleEnter", getRootElement(), VehiculoMotorDetectar ) 




function ExplosionVehiculoReparar()
    if source and isElement(source) and getElementType(source) == "vehicle" then
	    
		 if not DatosVehiculos[source] then
		    return 
		 end
		 
		setTimer(repararVehiculoFix,12000,1,source)

	end
end

-- by using root, it will work for any vehicle (even if it wasn't created via this resource)
addEventHandler("onVehicleExplode", root, ExplosionVehiculoReparar)



function repararVehiculoFix(veh)
    if isElement(veh) then
	   fixVehicle(veh)
	   setElementHealth(veh,1000)
   end	
end