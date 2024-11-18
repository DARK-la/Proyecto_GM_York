api = exports["dm_api"]
local t1,t2 = 8,0
local privateKey, publicKey = generateKeyPair("rsa", { size = 2048 })
setTime(t1,t2)
print("Tiempo servidor sync en cliente: ",t1,t2)


FloodAccount = {}
local LIMIT_FLOOD_SPAM = 14





addEventHandler("onPlayerQuit",root,function()
    if FloodAccount[source] then
	   FloodAccount[source] = nil
	end

end)

function detectFloodSpam(player,toBanPlayer)

   
    local ban = (type(toBanPlayer) == "boolean")
	
	
	
	
    if not FloodAccount[player] then
        FloodAccount[player] = 0
    end
    
	local AttempsToLogin =  FloodAccount[player]
    FloodAccount[player] = AttempsToLogin + 1
    
	 iprint(FloodAccount)
	
	if FloodAccount[player] >= LIMIT_FLOOD_SPAM then
	   
	   
	 
	   if ban then
	       banPlayer(client,true,false,true,"Consola","¡UPS algo salio mal!", math.random(30,60))
		  
        else
		  kickPlayer(player,"¡Vaya revisa tus datos que sean los correctos, intentalo mas tarde!")
	   end
	   
	  
	   FloodAccount[player] = nil
	   return true
	end
end


function iniciarLoginPrincipal()

    

    if getElementType(client) ~= "player" then
        return
    end
    
    

    setTimer(function(micliente)

        if not exports["dm_api"]:isLoggedAccount(micliente) then

            if isElement(micliente) then
                 triggerClientEvent(micliente,"onIniciarSesionLogin",micliente,publicKey)
                 setPlayerScriptDebugLevel (micliente, 3 )
            end
        end
    end,300,1,client)

    
end
addEvent("onPreLoginCliente",true)
addEventHandler("onPreLoginCliente",root,iniciarLoginPrincipal)







function LogearCuentaPrincipal(dataUser)
   
   
   if not isElement(client) or getElementType(client) ~= "player" then
      return
   end
   
     
    detectFloodSpam(client) 


   
   local claveDecodificada = getPasswordSafe(dataUser.password)
   dataUser.password = claveDecodificada

   local message,charactersArray = api:loginGameAccount(client,dataUser)

     if message == "CLIENT_LOGIN_SUCCESS" then
        triggerClientEvent(client,"onLobby",client,charactersArray)
		FloodAccount[client] = nil  -- Reseteamos el puntero de intentos de spam para evitar bugs en la crecion de personjes
		
        outputConsole("Inicio de sesion exitoso todo correcto.",client)
     else
		if isElement(client) then
		   outputConsole("Hubo un error al momento de obtener los datos",client)
		end
     end

    
    exports.notify:showMessagePlayer(client,tostring(message),true)
end
addEvent("onLoginAccount",true)
addEventHandler("onLoginAccount",resourceRoot,LogearCuentaPrincipal)




local function isContainContent(s,Max)
  return s ~= nil and #s >= Max
end


function getPasswordSafe(claveCodificada)

    if not type(claveCodificada) == "string" then
        return
    end


    local decrypted = decodeString("rsa", claveCodificada, { key = privateKey })

    if not decrypted then
        return false
    end

    return decrypted
end





function crearCuentaServidor(data)

    if not client then 
	   return 
	end
	
	
	
    detectFloodSpam(client,true)
	 
	 
	 
    local claveDecodificada = getPasswordSafe(data.password)
    local claveDecodificada_repeat = getPasswordSafe(data.password_repeat)

    local micorreo = data.miEmail
    
    if claveDecodificada == claveDecodificada_repeat then
        local dataSensible = { username = data.username, password = claveDecodificada , email = micorreo}
        local message = api:createGameAccount(client,dataSensible)
        exports.notify:showMessagePlayer(client,message,"info",true)
        if message == "CLIENT_ACCOUNT_CREATED" then
            triggerClientEvent(client,"onCloseWebRegister",client)
			
        end
    end
    
end
addEvent("onCreatedAccountGame",true)
addEventHandler("onCreatedAccountGame",resourceRoot,crearCuentaServidor)



