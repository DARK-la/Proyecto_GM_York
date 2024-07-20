screenW, screenH = guiGetScreenSize()



ArchivosData = {}


postGUIBotonesInicioSesion = false

botonesCuentaPrincipal = {
    {0.03, 0.92, 0.11, 0.03},
    {0.18, 0.92, 0.11, 0.03},
    {0.92, 0.92, 0.06, 0.03}
}





function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end



function BarrasCinematica()
    dxDrawLine((screenW * 0.0000) - 1, (screenH * 0.8764) - 1, (screenW * 0.0000) - 1, screenH * 1.0000, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine(screenW * 1.0000, (screenH * 0.8764) - 1, (screenW * 0.0000) - 1, (screenH * 0.8764) - 1, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine((screenW * 0.0000) - 1, screenH * 1.0000, screenW * 1.0000, screenH * 1.0000, tocolor(149, 149, 149, 255), 1, false)
    dxDrawLine(screenW * 1.0000, screenH * 1.0000, screenW * 1.0000, (screenH * 0.8764) - 1, tocolor(149, 149, 149, 255), 1, false)
    dxDrawRectangle(screenW * 0.0000, screenH * 0.8764, screenW * 1.0000, screenH * 0.1236, tocolor(0, 0, 0, 255), postGUIBotonesInicioSesion)

    dxDrawLine((screenW * 0.0000) - 1, (screenH * 0.0000) - 1, (screenW * 0.0000) - 1, screenH * 0.1236, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine(screenW * 1.0000, (screenH * 0.0000) - 1, (screenW * 0.0000) - 1, (screenH * 0.0000) - 1, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine((screenW * 0.0000) - 1, screenH * 0.1236, screenW * 1.0000, screenH * 0.1236, tocolor(140, 140, 140, 96), 1, false)
    dxDrawLine(screenW * 1.0000, screenH * 0.1236, screenW * 1.0000, (screenH * 0.0000) - 1, tocolor(140, 140, 140, 96), 1, false)
    dxDrawRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.1236, tocolor(0, 0, 0, 255), false)
end



function LOGO_RENDER_PRINCIPAL ()
        dxDrawText("CARDSON\nROLEPLAY", (screenW * 0.2852) - 1, (screenH * 0.0139) - 1, (screenW * 0.7188) - 1, (screenH * 0.1111) - 1, tocolor(0, 0, 0, 255), 1.00, ArchivosData.FUENTE_LETRA, "center", "center", false, false, false, false, false)
        dxDrawText("CARDSON\nROLEPLAY", (screenW * 0.2852) + 1, (screenH * 0.0139) - 1, (screenW * 0.7188) + 1, (screenH * 0.1111) - 1, tocolor(0, 0, 0, 255), 1.00, ArchivosData.FUENTE_LETRA, "center", "center", false, false, false, false, false)
        dxDrawText("CARDSON\nROLEPLAY", (screenW * 0.2852) - 1, (screenH * 0.0139) + 1, (screenW * 0.7188) - 1, (screenH * 0.1111) + 1, tocolor(0, 0, 0, 255), 1.00, ArchivosData.FUENTE_LETRA, "center", "center", false, false, false, false, false)
        dxDrawText("CARDSON\nROLEPLAY", (screenW * 0.2852) + 1, (screenH * 0.0139) + 1, (screenW * 0.7188) + 1, (screenH * 0.1111) + 1, tocolor(0, 0, 0, 255), 1.00, ArchivosData.FUENTE_LETRA, "center", "center", false, false, false, false, false)
        dxDrawText("CARDSON\nROLEPLAY", screenW * 0.2852, screenH * 0.0139, screenW * 0.7188, screenH * 0.1111, tocolor(232, 181, 70, 255), 1.00, ArchivosData.FUENTE_LETRA, "center", "center", false, false, false, false, false)

         --[[ local LogoLabel = dgsCreateLabel ( screenW * 0.3852, screenH * 0.0139, screenW * 0.7988, screenH * 0.1111, " CARDSON\nROLEPLAY", false)
          dgsSetPostGUI( LogoLabel, true )
          dgsLabelSetColor ( LogoLabel, 232, 181, 70, 255 )
          dgsSetFont(LogoLabel,FUENTE_LETRA)
          dgsCenterElement(LogoLabel,true,true)
          dgsAlphaTo(LogoLabel,1,"OutQuad",5000) ]]--
       
 end

function isCursorOverText(posX, posY, sizeX, sizeY)

    if ( not isCursorShowing( ) ) then
        return false
    end
    
    local cX, cY = getCursorPosition()
    local screenWidth, screenHeight = guiGetScreenSize()
    local cX, cY = (cX*screenWidth), (cY*screenHeight)

    return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end



function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" then
        scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
    end

    local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
    local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end




local seleccionMano = false
local sx, sy = guiGetScreenSize ( )

function detectarPersonajeJugadorHover() 

    if not isCursorShowing() then
       return 
    end


    local _, _, wX, wY, wZ = getCursorPosition() 
    local oX, oY, oZ = getCameraMatrix() 
    local hit, hitX, hitY, hitZ, hitEl = processLineOfSight(oX, oY, oZ, wX, wY, wZ) 

    if hitEl and getElementType(hitEl) == "ped" and escena == 1 then
        
        local cx, cy = getCursorPosition ( )
        local cx, cy = ( cx * sx ), ( cy * sy )
       
        dxDrawImage(cx,cy,25,25,ArchivosData.ImagenCursorMano,0,0,0,colormouse,true)
        seleccionMano = true


        if getCursorAlpha() ~= 0 then
            setCursorAlpha(0)
         end

    else
        seleccionMano = false
    end


    if not seleccionMano then
        setCursorAlpha(255)
    end
   
end 





local screenWidth, screenHeight = guiGetScreenSize()
webBrowser = nil

function webBrowserRender()
    dxDrawImage(0, 0, screenWidth, screenHeight, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
end




function toMoveMouseBrowser( _, _, absoluteX, absoluteY )

    if not webBrowser then
        return
    end
    injectBrowserMouseMove(webBrowser, absoluteX, absoluteY)
end

function toClickBrowser( button, state )

    if not webBrowser then
        return
    end

    if button == "left" and state == "up" then
         injectBrowserMouseUp(webBrowser, button)
     else
        injectBrowserMouseDown(webBrowser, button)
    end
end




function togVentanaRegistro(direccionURL)


     if not isElement(webBrowser) then
        return
     end

      if  not postGUIBotonesInicioSesion then
           addEventHandler("onClientRender", root, webBrowserRender)
           addEventHandler("onClientCursorMove", root,toMoveMouseBrowser)
           addEventHandler("onClientClick", root,toClickBrowser)
           postGUIBotonesInicioSesion = true
           fadeCamera(false,0.2)
           loadBrowserURL(webBrowser, "http://mta/login/"..tostring(direccionURL))
           focusBrowser(webBrowser)
           return
      end

      removeEventHandler("onClientRender", root, webBrowserRender)
      removeEventHandler("onClientCursorMove", root, toMoveMouseBrowser)
      removeEventHandler("onClientClick", root, toClickBrowser)
      postGUIBotonesInicioSesion = false
      fadeCamera(true,0.05)
      
    
end

function loadWebrosing()

     if not isElement(webBrowser) then
        return
     end
     loadBrowserURL(webBrowser, "http://mta/login/cuenta_principal/formulario.html")
end



addEventHandler("onClientResourceStart",resourceRoot,function()
    webBrowser = createBrowser(screenWidth, screenHeight, true, true)
    addEventHandler("onClientBrowserCreated", webBrowser,loadWebrosing) 
end)


function cerrarWebBrowserRegistro()
     togVentanaRegistro(false)
end
addEvent("onCloseWebRegister",true)
addEventHandler("onCloseWebRegister",root,cerrarWebBrowserRegistro)