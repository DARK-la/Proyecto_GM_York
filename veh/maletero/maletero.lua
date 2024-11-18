local slotVehiculo = {
   [480] = 4,
   [479] = 6
}


local function getSlotsDisponibles(veh)
     
	 if veh then
		 local modelID = getElementModel(veh)
	     return slotVehiculo[modelID]     
	 end
	
	return false
end



local function mirarMaletero( player, vehicleID ) 
 
		local autoCerca = vehiculosCercanos(player)
		local SlotCantidad = getSlotsDisponibles(autoCerca)
		
		if autoCerca and SlotCantidad then
		   
		   local modelVeh = getVehicleName(autoCerca)
		   
		   outputChatBox(" == "..modelVeh.." ==",player,200,125,15,true)
		   for i=1,SlotCantidad do 
		       outputChatBox("Espacio "..tostring(i)..": ",player,255,255,255,true)
		   end  
		end
		
   
end 
addCommandHandler("vermaletero",mirarMaletero)
