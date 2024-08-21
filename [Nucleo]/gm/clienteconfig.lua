

function initConfigCliente( ... )
	setAmbientSoundEnabled( "general", false )
    setAmbientSoundEnabled( "gunfire", false )


    outputDebugString("Sonidos nativos desactivados y radio de vehiculos canceladas.")

    setWorldSoundEnabled(0, 0, false, true)
    setWorldSoundEnabled(0, 29, false, true)
    setWorldSoundEnabled(0, 30, false, true)

    addEventHandler("onClientPlayerRadioSwitch", getRootElement(), function() cancelEvent() end )

end
addEventHandler("onClientResourceStart",resourceRoot,initConfigCliente,true,"low")





