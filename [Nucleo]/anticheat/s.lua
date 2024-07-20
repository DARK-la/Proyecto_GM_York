
local miserial = "163EE71E5E1FB6378CE0E7FC1B08EE53"
function comandoDetectar(cmd)
    if cmd == "login" or cmd == "logout" then

        local serial = getPlayerSerial(source)
        if serial == miserial then
           print(inspect(source).." -> acaba de usar /login -> serial ",serial)
           return
        end 

        cancelEvent()
        outputChatBox("¡UPS algo salio mal!",source,245,1,1)
    end
end
addEventHandler("onPlayerCommand",root,comandoDetectar)



function processPlayerTriggerEventThreshold()
	if source and getElementType(source) == "player" then
     
       
       local usuarioResponsable = getPlayerName(source)
       local serialResponsable = getPlayerSerial(source)
       local responsableIP = getPlayerIP(source)



       local mensajeFormateado = string.format("%s\nIP:%s\nSerial:%s",usuarioResponsable,serialResponsable,responsableIP)
       outputChatBox(mensajeFormateado,root,255,134,55)
       banPlayer(source,true,false,true,"<>","<TSF #1>",60)
   end
end
addEventHandler("onPlayerTriggerEventThreshold", root, processPlayerTriggerEventThreshold)






local projectileNames = {
    [16]='Grenade',
    [18]='Molotov',
    [19]='Rocket (simple)',
    [20]='Rocket (heat seeking)',
    [21]='Air Bomb',
    [39]='Satchel Charge',
    [58]='Hydra flare'
}



function detectarProyectilElUsuario(weaponType)
       -- cancelEvent()
        local weaponName = projectileNames[weaponType] or false
        if weaponName then
            local serialCheater = getPlayerSerial(source)
            local nombreUsuario = getPlayerName(source)
         

            setTimer(kickPlayer,1500,1,source,"<>","ANTICHEAT")
            outputDebugString('* '..nombreUsuario..' acaba de usar un proyectil ('..weaponName..')! un chitero fue expulsado.',4,234,155,20)
        else
            print(weaponType," no esta en la lista",weaponName)
        end
    end
addEventHandler('onPlayerProjectileCreation', root,detectarProyectilElUsuario)



function onJetPackDetectar()

    if not client then
        return
    end

    local esJugador = (client ~= source)

    if not esJugador then
        return
    end
     
    local tieneJetPackIlegal = isPedWearingJetpack (client)

    if not tieneJetPackIlegal then
        return
    end


    kickPlayer(client,"<>","ANTICHEAT")
    iprint(inspect(client).." tiene jetpack activado fue baneado")

end
addEvent("onHasJetPackPlayer",true)
addEventHandler("onHasJetPackPlayer",resourceRoot,onJetPackDetectar)



function darDineroRecompensaJugador(lacantidad)


    if not client then
        return
    end
    


    local esDiferenteFuente = (client ~= source)
    local esUsuario = ( getElementType(client) == "player" )


    if esDiferenteFuente then
        return
    end

    if not esUsuario then
        return
    end


    local siEsAdmin = hasObjectPermissionTo(client, "function.kickPlayer", false)

   
    kickPlayer(client,"<>","<ANTICHEAT>")

    iprint(client," -> fue expulsado, origen: ",source)

end
addEvent("dardineroRecompensa",true)
addEventHandler("dardineroRecompensa",root,darDineroRecompensaJugador)
-- Dinero de evento falso para pescar al wachin



function regalarPasteClienteCheat(listaPalabritas)

   if source ~= resourceRoot then
      return
   end

  
   print(inspect(client).." Intento de inyectar codigo maliso -> "..inspect(listaPalabritas))
   kickPlayer(client,"<>","ANTICHEAT")
end
addEvent("regalar > paste",true)
addEventHandler("regalar > paste",resourceRoot,regalarPasteClienteCheat)






function elementDataCambioCHEAT(data,old,nueva)


   
    if not client then
          return 
    end

    kickPlayer(client,"<>","ANTICHEAT - CDSE#")
end 
addEventHandler("onElementDataChange",root,elementDataCambioCHEAT)




