local x,y,z, lx,ly,lz =  191.04539489746, 1219.4133300781, 23.576200485229, 191.09797668457, 1220.3953857422, 23.757228851318
local timer = {}
local screenW, screenH = guiGetScreenSize()
local sonidito = nil
local opacidad = 0
local musicaFondo = "https://dl225.filemate2.shop/?file=M3R4SUNiN3JsOHJ6WWQ2a3NQS1Y5ZGlxVlZIOCtyZ1hnZGdxeGdRckdPQnFxWjlrNCt5bGFPMUtPSzREZzRleVFwaFMvRExkVHNDS0pBZlU4OG9BVzN5VTQ4TS92SHFkMVlNd0Nvd2pjQkM5eWNDWHppWi92MVdzUk5iVkV2WmJmU1E5cEVWc2pnNjlpdlRNcVJ6cXRtbWtxa2plUFhOYjRHNVpaS0tKcE5sYjNIUE9NcUcxZzhaVytuUFo4WXdVM3ZMTTVBPT0%3D"

local tiempoFade = 5100;
local PermitirComenzar = false

local mensaje = "Jugar"
--2078.7465820312, -1927.0782470703, 34.360500335693, 2078.8010253906, -1926.0926513672, 34.200649261475 -- original

local colorFondo = tocolor(255, 153,0, 255)
local inicio = true
function Barritas()



        dxDrawLine((screenW * 0.0000) - 1, screenH * 0.1194, screenW * 1.0000, screenH * 0.1194, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 1.0000, screenH * 0.1194, screenW * 1.0000, (screenH * 0.0000) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.1194, tocolor(5, 0, 0, 255), false)
        dxDrawLine((screenW * 0.0000) - 1, screenH * 1.0056, screenW * 1.0000, screenH * 1.0056, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 1.0000, screenH * 1.0056, screenW * 1.0000, (screenH * 0.8861) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.0000, screenH * 0.8861, screenW * 1.0000, screenH * 0.1194, tocolor(5, 0, 0, 255), false)
       
end





function btnJugarXD()
        
	    setTime(6,0)
        setColorFilter (234, 23, 234, 2, 12, 234, 12, 34)
        setFarClipDistance( 300 )
        setPlayerHudComponentVisible( "all", false )

end



local v = math.random(5,9) / 200






function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end



local siguiente = 0;
function isSoundFinished(theSound)
    return ( getSoundPosition(theSound) == getSoundLength(theSound) )
end








function initCinematica()
    fadeCamera (false,0, 0, 0, 0 )
	btnJugarXD()
    addEventHandler("onClientRender",root,Cinematica)
    setCameraDrunkLevel(0)
    sonidito = playSound (musicaFondo,false)
    setWeather(3)
    setTime(4,0)
    


    if sonidito then

        setTimer(fadeCamera,tiempoFade,1,true)
        timer[localPlayer] = setTimer(function()
            inicio = false

  
        x,y,z,lx,ly,lz = -347.48458862305, 1077.4847412109, 98.099197387695, -347.37069702148, 1078.0166015625, 97.26005554199
        

        end,22*1000,1)
    end
end






function EmpezarAJugar(button,press)
    if button == "enter" and press  then
    	killTimer(timer[localPlayer])
    	setCameraTarget(localPlayer)
    	showCursor(false)
    	stopSound( sonidito )
        removeEventHandler("onClientRender",root,Cinematica)
        removeEventHandler("onClientKey",root,EmpezarAJugar)
    end
end
addEventHandler("onClientKey",root,EmpezarAJugar)








function Cinematica()

    if inicio then
        y = y - v
        lx = lx - v
        ly = ly + v
    else
         x = x + v
         lx = lx + v
         z = z + 0.00005
    end

   
    setCameraMatrix(x,y,z,lx,ly,lz,0,34)
    Barritas()

end






function comenzarIntroServidorCinematica()
    initCinematica()
end


 initCinematica()
