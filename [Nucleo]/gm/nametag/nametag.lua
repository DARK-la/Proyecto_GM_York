local x, y = guiGetScreenSize() 
local colorGuardado = tocolor (0, 0, 0, 255)
local COLORTEXTONametag = tocolor (255, 255, 255, 225)
local NametagFuente = "default-bold"
local HUESO = 2	;
local COLOR_NOMBRE = "#FFFFFF"
local vida = 0
local distanciaMaxima = 7;
local escalaFuente = (y/720) * 1.1
local jugadoresNametag = {}
local estaEscribiendo = false



function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local outline = (scale or 1) * (1* (outline or 1))
    dxDrawText (removeHEXFromString(text), left - outline, top - outline, right - outline, bottom - outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left + outline, top - outline, right + outline, bottom - outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left - outline, top + outline, right - outline, bottom + outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left + outline, top + outline, right + outline, bottom + outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left - outline, top, right - outline, bottom, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left + outline, top, right + outline, bottom, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left, top - outline, right, bottom - outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (removeHEXFromString(text), left, top + outline, right, bottom + outline, colorGuardado, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, COLORTEXTONametag, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end 
    



function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end



function removeHEXFromString(str) 
    return str:gsub("#%x%x%x%x%x%x", "") 
end 




function RenderNames() 

	
    local camx,camy,camz = getCameraMatrix()
  
	for v,data in pairs(jugadoresNametag) do
	
	    if v == localPlayer then return end
	   
        local x,y,z = getElementPosition(v)
		local distancia = getDistanceBetweenPoints3D ( x,y,z, camx,camy,camz )
		

	 if distancia <= distanciaMaxima then
           
         local p,p2,p3 = getPedBonePosition ( v, HUESO)

           if not p or not p2 then
           	return
           end
		   
		   local x1,y1,z1 = getScreenFromWorldPosition( p,p2,p3+0.25)
		   
	       if x1 and y1 then
   
	       	local Nombre = data[1]
	       	local usuarioID = data[2]
			local estaChateando = ( isChatBoxInputActive() and "..." or "" )

            dxDrawBorderedText (0.8, estaChateando.."\n"..Nombre.." #ff9900｢"..usuarioID.."｣ ",x1,y1, x1, y1, tocolor(234,234,234,245),escalaFuente,NametagFuente,"center","center",false,true,false,true,false)
	      end
	   end
    end
end








function iniciarNameTag(usuario)
	local usuarioNombre = string.gsub( getPlayerName(usuario),"_"," ")
	jugadoresNametag[usuario] = { usuarioNombre,"1" }
end



function initNameTag()

   for i, player in ipairs(getElementsByType("player"),true) do
		if isElementStreamedIn(player) then
			iniciarNameTag(player)
		end
	end

	addEventHandler("onClientRender",root,RenderNames) 

end




function startNameTagCliente( ... )
   
	 initNameTag()
end
addEventHandler("onClientResourceStart",resourceRoot,startNameTagCliente)





