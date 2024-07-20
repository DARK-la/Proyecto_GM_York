






function creacionDePersonaje()
       removeEventHandler("onClientRender",root,TextoLobbby2D)
       removeEventHandler("onClientKey",root,EventosTeclasCliente)
       crearBotonAtrasLobby()
	outputConsole("Creacion de nuevo personaje iniciado.")
       escena = 2
       togVentanaRegistro("personaje_lobby/crearPJ.html")
end



function addNewPlayerCharacter(nombre, apellido, edad, genero, nacionalidad)




      if #nombre >= 3 and #apellido >= 3 and #edad >= 1 and tonumber(edad) >= 0 then
            local dataPlayerCharacter = { firstName = nombre, lastName = apellido, age = edad, gender = genero, nation = nacionalidad }
            triggerServerEvent("onCreatePlayerCharacterNew",resourceRoot,dataPlayerCharacter)
      else
            outputConsole("Error, te falta algunos datos que llenar.")
      end
end
addEvent("new pj > client",false)
addEventHandler("new pj > client",root,addNewPlayerCharacter)