apiServer = exports["dm_api"]
sql  = exports.mysql

VehiculosJugadores = {}
VehiculoData = {}




local function onLoadVehicle(thePlayer)

   

    local idCharacter = apiServer:getIdPlayerCharacter(thePlayer)
	
	
	if not VehiculosJugadores[idCharacter] then
	    local dataVehicleTable = getVehicleSQLFromPlayerId(idCharacter)
        spawnVehiclePlayer(dataVehicleTable)
	end
	
   
end

local function onVehicleLoadStart()
    for i,player in ipairs(getElementsByType("player")) do
         onLoadVehicle(player)
    end
end
addEventHandler("onResourceStart",resourceRoot,onVehicleLoadStart)



local function LoginLoadVehiclesPlayer(pId)
    if type(pId) == "number" then
	    setTimer(onLoadVehicle,5,1,source) -- Refresco de 5 milisegundos para el servidor.
	end
end
addEventHandler("api:onPlayerLogin",root,LoginLoadVehiclesPlayer)


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
		
		
		
        
        local nuevaDataVehiculo = { 
              identificadorId = vehData.id, 
              bloqueo = vehData.locked == 1 and true or false,
              salud = vehData.health,
              motor = vehData.engineState == 1 and true or false,
              personajeID = vehData.personajeId,
			  placa = "PLACA"
			 }
    

        table.insert(VehiculosJugadores[idCharacterPlayer], vehCreado )
		VehiculoData[vehCreado] = nuevaDataVehiculo
       
	    setVehiclePlateText(vehCreado,nuevaDataVehiculo.placa)
	   
	   
	    setVehicleEngineState(vehCreado,nuevaDataVehiculo.engineState == 1 and true or false)
		
		
        local colors = fromJSON(vehData.colorVehicle)
        setVehicleColor(vehCreado,colors[1],colors[2],colors[3],colors[4])


    end
	
	
	--iprint(VehiculoData,VehiculosJugadores)
 end






function saveVehicle(v,dataVeh)
	
    
	
	
	local identificadorSQL = dataVeh.identificadorId
	local rx,ry,rz = getElementRotation(v)
	local x,y,z = getElementPosition(v)
	local posActual = toJSON({x,y,z,rx,ry,rz})
	local colors = toJSON({getVehicleColor (v, false )})
	local estadoMotor = getDataVehiclePlayer(v,"motor") == true and 1 or 0
	
	
	local saludveh = getElementHealth(v) or 500
	local lockedVeh = getDataVehiclePlayer(v,"bloqueo") == true and 1 or 0
    
	
    sql:queryFree("UPDATE `vehiculos` SET positionVehicle = ?, colorVehicle = ?, engineState = ?, locked = ?, health = ?  WHERE id = ?",posActual,colors,estadoMotor,lockedVeh,saludveh,identificadorSQL)
   
end



function onVehicleStopSave()

    local cantidadAutos = 0
	
    for vehicleElement,dataVehicle in pairs(VehiculoData) do
         if isElement(vehicleElement) then
              saveVehicle(vehicleElement,dataVehicle)
		      cantidadAutos = cantidadAutos + 1
         end
    end
	
    print("Un total de ",cantidadAutos," vehiculos -> fueron guardados.") 

end
addEventHandler("onResourceStop",resourceRoot,onVehicleStopSave)


