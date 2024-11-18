local cordenadasCamaraAleatoria = config.camaraPrincipales
guiElementos = {} -- Lista para guardar los elementos
local VelocidadJuego = 0.075
miclavesita = false
musicaFondo = nil


function iniciarCliente()

    addEvent("onIniciarSesionLogin",true)
    addEventHandler("onIniciarSesionLogin",root,iniciarInicioDeSesionPrincipal)


    addEvent("onLobby",true)
    addEventHandler("onLobby",root,IniciarLobbyCliente)

    addEvent("onRemoverTodoLobby",true)
    addEventHandler("onRemoverTodoLobby",root,removerTodoLobbyPersonajes)
  
    triggerServerEvent("onPreLoginCliente",resourceRoot,localPlayer)
end
addEventHandler("onClientResourceStart",resourceRoot,iniciarCliente)



function iniciarInicioDeSesionPrincipal(claveServerPublica)

    ArchivosData.FUENTE_LETRA = dxCreateFont(':Login/archivos/DistantGalaxy.ttf', 18, false, 'draft') 
    ArchivosData.ImagenCursorMano = dxCreateTexture( ":Login/archivos/mano.png" ) 
    
   
    
    miclavesita = claveServerPublica


    
    local tiempoAleatorio = math.random(1,2) * 300
    fadeCamera(true,1.0)

    addEventHandler("onClientRender",root,LOGO_RENDER_PRINCIPAL)
    addEventHandler("onClientRender",root,BarrasCinematica)

   showCursor(true)
   showChat(false)
   setPlayerHudComponentVisible("all",false)
   setTime(20,0)
   setGameSpeed(VelocidadJuego)
   setTimer(setCameraDrunkLevel,100,1,90)
   setWeather(2)
   setFarClipDistance(200)
   musicaFondo = playSound("archivos/musica_login.mp3",true)
   local randomPosCamera = cordenadasCamaraAleatoria[math.random(1,#cordenadasCamaraAleatoria)]

  
   setCameraMatrix(unpack(randomPosCamera))


  

   

 

    
   setTimer(function()
        local posBoton = botonesCuentaPrincipal
        guiElementos.edituser =  guiCreateEdit  ( posBoton[1][1], posBoton[1][2], posBoton[1][3], posBoton[1][4], "Usuario", true )
        guiElementos.editcontra =  guiCreateEdit  (  posBoton[2][1],  posBoton[2][2],  posBoton[2][3],  posBoton[2][4], "Contraseña", true)
        guiEditSetMasked( guiElementos.editcontra, true ) 
        guiElementos.btnIniciarSesion = guiCreateButton( posBoton[3][1],  posBoton[3][2],  posBoton[3][3],  posBoton[3][4], "Entrar", true)
        guiSetFont(guiElementos.btnIniciarSesion,"default-bold-small")
        addEventHandler ( "onClientGUIClick",  guiElementos.btnIniciarSesion, iniciarCuentaPrincipal,false )

        togButtonCreateNewAccount = guiCreateStaticImage(0.03, 0.02, 0.06, 0.10, ":login/archivos/newaccount.png", true)    
        addEventHandler("onClientGUIClick",togButtonCreateNewAccount,function()
        togVentanaRegistro("cuenta_principal/formulario.html")
    end,false)
   end,1000,1)

end



function iniciarCuentaPrincipal(button, state)
     
    if button == "left" and state == "up" then
        local user = guiGetText(guiElementos.edituser)
        local clave = guiGetText(guiElementos.editcontra)


        if miclavesita == false then
            outputConsole("ERROR: Vertificacion del algoritmo fallido.")
            return false
        end
        

        if #user >= 3 and #clave >= 3 then
            local dataCliente = { username = user, password = encodeString("rsa",clave,{key = miclavesita}) }
            outputConsole("Informacion enviada al servidor.")
            triggerServerEvent("onLoginAccount",resourceRoot,dataCliente)
            guiSetEnabled(guiElementos.btnIniciarSesion,false)
            setTimer(function(g)
                if isElement(g.btnIniciarSesion) then
                    if isElement(g.btnIniciarSesion) then
                        guiSetEnabled(g.btnIniciarSesion,true)
                    end
                end
            end,800,1,guiElementos)
        end
    end
end



function removerLoginPrincipal()
   
   
   
    removeEventHandler("onClientRender",root,LOGO_RENDER_PRINCIPAL)
    print("-> Todos los elementos del login principal fueron eliminados")
  

     for _,cadaGUI in pairs(guiElementos) do
        if isElement(cadaGUI) then
          destroyElement(cadaGUI)
        end
    end

    guiElementos = nil
    cordenadasCamaraAleatoria = nil

    destroyElement(togButtonCreateNewAccount)
    togButtonCreateNewAccount = nil
    stopSound(musicaFondo)
    musica_login = nil
   
end

