local screenW, screenH = guiGetScreenSize()



function BarrasCinematicas()
    dxDrawLine((screenW * 0.0000) - 1, (screenH * 0.8764) - 1, (screenW * 0.0000) - 1, screenH * 1.0000, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine(screenW * 1.0000, (screenH * 0.8764) - 1, (screenW * 0.0000) - 1, (screenH * 0.8764) - 1, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine((screenW * 0.0000) - 1, screenH * 1.0000, screenW * 1.0000, screenH * 1.0000, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine(screenW * 1.0000, screenH * 1.0000, screenW * 1.0000, (screenH * 0.8764) - 1, tocolor(149, 149, 149, 255), 1, false)
    dxDrawRectangle(screenW * 0.0000, screenH * 0.8764, screenW * 1.0000, screenH * 0.1236, tocolor(0, 0, 0, 255), false)
    dxDrawLine((screenW * 0.0000) - 1, (screenH * 0.0000) - 1, (screenW * 0.0000) - 1, screenH * 0.1236, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine(screenW * 1.0000, (screenH * 0.0000) - 1, (screenW * 0.0000) - 1, (screenH * 0.0000) - 1, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine((screenW * 0.0000) - 1, screenH * 0.1236, screenW * 1.0000, screenH * 0.1236, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine(screenW * 1.0000, screenH * 0.1236, screenW * 1.0000, (screenH * 0.0000) - 1, tocolor(140, 140, 140, 96), 1, false)
    dxDrawRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.1236, tocolor(0, 0, 0, 255), false)

end


local activo = false
 
function eventoCinematica()
    
    if not activo then
  
   
    addEventHandler("onClientRender",root,BarrasCinematicas)
    resetColorFilter()
    setWeather(3)
    setTime(5,59)
    clearChatBox()
    setPlayerHudComponentVisible("all",false)
    setCameraDrunkLevel(0)
    setWaveHeight(1.2)
    setGameSpeed(0.25)
    activo = true
    --setCameraMatrix(false)
    setCameraDrunkLevel(30)
    else
        removeEventHandler("onClientRender",root,BarrasCinematicas)
        setCameraDrunkLevel(0)
        setGameSpeed(1)
        activo = false
    end
end
addCommandHandler("sl",eventoCinematica)



