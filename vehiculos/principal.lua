apiServer = exports["dm_api"]
sql  = exports.mysql
VehiculosJugadores = {}
DatosVehiculos = {}


function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end


function onVehicleLoadStart()
    for indice,player in ipairs(getElementsByType("player")) do
    	local idCharacter = apiServer:getIdPlayerCharacter(player)
        local dataVehicles = getSQLVehicles(idCharacter)
        spawnVehiclePlayer(dataVehicles)
    end
end
addEventHandler("onResourceStart",resourceRoot,onVehicleLoadStart)




function saveDateVehicleProcess(v,dataVeh)
   
	
    
	
	
	
	
	local identificadorSQL = dataVeh.vid
	local rx,ry,rz = getElementRotation(v)
	local x,y,z = getElementPosition(v)
	local posActual = toJSON({x,y,z,rx,ry,rz})
	local colors = toJSON({getVehicleColor (v, false )})
	local estadoMotor = getVehicleEngineState(v) 
	local saludveh = getElementHealth(v) or 500
	local lockedVeh = isVehicleLocked ( v ) and 1 or 0
  

    sql:queryFree("UPDATE `vehiculos` SET positionVehicle = ?, colorVehicle = ?, engineState = ?, locked = ?, health = ?  WHERE id = ?",posActual,colors,estadoMotor,lockedVeh,saludveh,identificadorSQL)
   

end


function onVehicleStopSave()
    local cantidadAutos = 0
    for vehicleElement,dataVehicle in pairs(DatosVehiculos) do
         if isElement(vehicleElement) then
              saveDateVehicleProcess(vehicleElement,dataVehicle)
		     cantidadAutos = cantidadAutos + 1
         end
    end
	
    print("Un total de ",cantidadAutos," vehiculos -> fueron guardados.") 

end
addEventHandler("onResourceStop",resourceRoot,onVehicleStopSave)




function initLoginPlayer(toIDCharacterNumber)

   
   if not VehiculosJugadores[toIDCharacterNumber] then
   
	   local dataSQLVeh = getSQLVehicles(toIDCharacterNumber)
	   if dataSQLVeh and #dataSQLVeh >= 1 then
		   spawnVehiclePlayer(dataSQLVeh)
	   end
	   
    end
   
end
addEventHandler("api:onPlayerLogin",root,initLoginPlayer)



function spawnVehiclePlayer(arrayVehicleData)

    
 
    local longitud = table.size(arrayVehicleData) 



    for i=1,longitud do
        local vehData = arrayVehicleData[i]


        local idCharacterPlayer = vehData.personajeId
        
        if not VehiculosJugadores[idCharacterPlayer] then
               VehiculosJugadores[idCharacterPlayer] = {}
        end

        local pos = fromJSON(vehData.positionVehicle)

        local vehCreado = createVehicle(vehData.vehicleID,pos[1],pos[2],pos[3]) 
        setElementRotation(vehCreado,pos[4],pos[5],pos[6])
		
		
		
        
        local nuevoVehiculo = { 
             vid = vehData.id, 
             estadoPuertas = vehData.locked == 1 and true or false,
             salud = vehData.health,
             motor = vehData.engineState,
             pid = vehData.personajeId	 }
    

        table.insert(VehiculosJugadores[idCharacterPlayer], vehCreado )
		DatosVehiculos[vehCreado] = nuevoVehiculo
       
	   
	   
	    setVehicleEngineState(vehCreado,nuevoVehiculo.engineState == 1 and true or false)
        local colors = fromJSON(vehData.colorVehicle)
        setVehicleColor(vehCreado,colors[1],colors[2],colors[3],colors[4])

        
        if nuevoVehiculo.estadoPuertas then
            setVehicleLocked(vehCreado,nuevoVehiculo.estadoPuertas)
        end
        
		local vehiculoSalud = vehData.health or 800
        if type(vehiculoSalud) == "number" and vehiculoSalud >= 0 then
            setElementHealth(vehCreado,vehiculoSalud)
        end

    end
	
 end








