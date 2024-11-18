


local function resetLobbyAndTimeSync(usuario)
    local nameUser = getPlayerName(usuario)
    print(nameUser,"-> acaba de iniciar sesion con su personaje")
    local time = {getTime()}
    triggerClientEvent(usuario,"onRemoverTodoLobby",usuario,time)
end



function iniciarLoginPersonaje(MiPersonajeID)
	

    if source ~= resourceRoot then
        kickPlayer(client,"Chingas tu madre.")
        return
    end


	local esJugador = getElementType(client) == "player" and client
	
	if not esJugador then
		return
	end
    
    
    
    local estado,messageSpawn = api:spawnGameCharacter(client,MiPersonajeID)
    if not estado then
        return 
    end


    resetLobbyAndTimeSync(client)
    exports.notify:showMessagePlayer(client,messageSpawn,true)

    -- Removemos todo el login 

end
addEvent("onLoginPersonaje",true)
addEventHandler("onLoginPersonaje",resourceRoot,iniciarLoginPersonaje)







function newPlayerCharacterServer(dataClient)


    detectFloodSpam(client)
	
	
    local messageCharacter =  api:createGameCharacterServer(client,dataClient)

    if messageCharacter and messageCharacter ~= nil then
       exports.notify:showMessagePlayer(client,messageCharacter,true)
   end

    if messageCharacter == "CLIENT_PLAYER_CREATED" then
         triggerClientEvent(client,"onCloseWebRegister",client)
         resetLobbyAndTimeSync(client)
    end

end
addEvent("onCreatePlayerCharacterNew",true)
addEventHandler("onCreatePlayerCharacterNew",resourceRoot,newPlayerCharacterServer)