local MessageData = {


   ["bloqueo"] = function (state)
       local msg = state and "colocas" or "quitas"
	   
	   return "#5a39b9 > "..msg.." el seguro de tu vehiculo."
   end,
   
   
   ["motor"] = function (state)
       local msg = state and "encendido" or "apagado"
	   
	   return "#066627* El motor de tu vehiculo fue "..msg.."."
   end
   
   
}





function getMessageFeature(type,value)
    if not MessageData[type] then
	   return
	end
	 
	local tipo = MessageData[type](value)
	return tipo
end



