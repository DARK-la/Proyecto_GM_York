local elementosLobby = {}
PersonajesLobby = {}
local pedSeleccionado = nil
local btnAtrasLobby = nil






function IniciarLobbyCliente(cachePersonajes)


    removerLoginPrincipal()
    addEventHandler("onClientKey", root, EventosTeclasCliente)
    setCameraDrunkLevel(0)
    setFarClipDistance(250)
	showCursor(true)
	setCameraMatrix(unpack(config.camaraLobby))
	setPlayerHudComponentVisible("all",false)
	showChat(false) 
	setColorFilter (12, 0, 0, 0, 0, 0, 0, 23)
	setGameSpeed(1)
	
   
	elementosLobby.Fuego = createEffect ("fire", -1633.39099, -2227.79395, 28.97381,0,0,0,30,true )
	elementosLobby.fogata = createObject(1463,-1633.39099, -2227.79395, 28.89381)
    setTime(4,37)
    setWeather(3)

    local h,n = getTime()

    crearPersonajeLobbySeleccion( cachePersonajes )
    addEventHandler("onClientRender",root,TextoLobbby2D)

end





function volverLobbyAtras()

    if escena == 2 then
        togVentanaRegistro(false)
    end

    addEventHandler("onClientRender",root,TextoLobbby2D)

    if not isEventHandlerAdded( "onClientKey", root, EventosTeclasCliente ) then
        addEventHandler("onClientKey",root,EventosTeclasCliente)
    end


    removeEventHandler("onClientRender",root,renderPersonajeNombres)
    destroyElement(source)
    escena = 0
    btnAtrasLobby = nil
    opacidad = 30

end


function crearBotonAtrasLobby()
    
    setTimer(function()
        btnAtrasLobby = guiCreateStaticImage ( 0.01, 0.04, 0.035, 0.06, "archivos/atras.png", true )-- guiCreateButton(0.01, 0.05, 0.05, 0.03, "Atras", true)
        addEventHandler("onClientGUIClick",btnAtrasLobby,volverLobbyAtras,false)

    end,200,1)
    
end

function crearPersonajeLobbySeleccion( cachePersonajes )
              
          
            

    local cantidadPersonajes = table.size(cachePersonajes) or false
    local listaPeds = {}
        

    if cantidadPersonajes >= 1 then
                for personajeID,datos in pairs(cachePersonajes) do
                        if personajeID  then
                                 local globalIDPersonaje = datos.id
                                 local skinID = datos.skin
                                 local cuentaNombre = datos.firstName .." "..datos.lastName 
                                 local pedCreado = createPed(skinID,0,0,0)
                                 table.insert(listaPeds,pedCreado)
                                 PersonajesLobby[pedCreado] = { idPersonajeGlobal = globalIDPersonaje, personajeNombreReal = cuentaNombre }
                       end
                 end


            for i=1,#listaPeds do
                    local porCadPed = listaPeds[i]
                    local pos = pedPos[i]
                    setElementPosition(porCadPed,pos[1],pos[2],pos[3])
                    setElementRotation(porCadPed,pos[4],pos[5],pos[6])
                    
                    setTimer(function()
                        local data = AnimacionesPersonajes[i]
                        setPedAnimation(porCadPed,data[1],data[2],-1,true,false,false,true,500,false)
                    end,90,1)
              end

           addEventHandler("onClientClick",root,clickPersonajeJugable)
           addEventHandler("onClientRender",root,detectarPersonajeJugadorHover)
         
     end
    

end




function Jugar()

    if  escena == 0 then -- Si estoy en 0 es lobby
        escena = 1
        removeEventHandler("onClientRender",root,TextoLobbby2D)
        addEventHandler("onClientRender",root,renderPersonajeNombres)
        crearBotonAtrasLobby()
    end


   -- removeEventHandler("onClientKey",root,EventosTeclasCliente)
   
end






function clickPersonajeJugable(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)


   

      if button == "left" and state == "down" and isElement(clickedElement) and getElementType(clickedElement) == "ped" then
           if escena == 1 then
             local personajeJugable = PersonajesLobby[clickedElement]
             local globalPersonajeID = personajeJugable.idPersonajeGlobal
             triggerServerEvent("onLoginPersonaje",resourceRoot,globalPersonajeID)
            
           end
     end
end


function EventosTeclasCliente(button, press)
    if button == "mouse1" and press and isCursorOverText(unpack(PosicionesBotones["Boton.Jugar"])) then
            Jugar()
        elseif button == "mouse1" and press and isCursorOverText(unpack(PosicionesBotones["Boton.CrearPJ"])) then
            creacionDePersonaje()
     end
end





function limpiarLobby()

    if PersonajesLobby then
        for personajePed,_ in pairs(PersonajesLobby) do
              if isElement(personajePed) then
                 destroyElement(personajePed)
              end
        end
        PersonajesLobby = nil
    end

    if isElement(btnAtrasLobby) then
           destroyElement(btnAtrasLobby)
           btnAtrasLobby = nil
    end


    
    destroyElement(elementosLobby.fogata)

 end

function removerArchivosData()
   for clave,elementoData in pairs(ArchivosData) do
        if isElement(elementoData) then
            destroyElement(elementoData)
        end

   end
   ArchivosData = nil
end



function removerTodoLobbyPersonajes(timeServerSync)

   



    
    removeEventHandler("onClientRender",root,renderPersonajeNombres)
    removeEventHandler("onClientRender",root,TextoLobbby2D)
    removeEventHandler("onClientRender",root,BarrasCinematica)
    removeEventHandler("onClientKey",root,EventosTeclasCliente)
    removeEventHandler("onClientClick",root,clickPersonajeJugable)
    removeEventHandler("onClientRender",root,detectarPersonajeJugadorHover)
    removeEventHandler("onClientRender",root,LOGO_RENDER_PRINCIPAL)


   limpiarLobby()

   
   showChat(true)
   showCursor(false)
   clearChatBox()
   setCursorAlpha(255)
   

   
   setTime(timeServerSync[1],timeServerSync[2])
   resetFarClipDistance()
   outputConsole("Tiempo correctamente sincronizado con el servidor.")
   removerArchivosData()
   miclavesita = nil
   escena = nil

   local porCadaHudVisible = {"ammo","weapon","money","crosshair"}
   for i=1,#porCadaHudVisible do
       setPlayerHudComponentVisible(porCadaHudVisible[i],true)
   end
   

   if isElement(webBrowser) then
        destroyElement(webBrowser)
    end
end
    


