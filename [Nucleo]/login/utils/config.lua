
opacidad = 0
escena = 0 -- Escena lugar



config = {


	camaraPrincipales = { 

        { 1002.8018798828, -334.22470092773, 83.564796447754, 1003.4577026367, -334.9128112793, 83.875205993652 } , 
       },

	camaraLobby = {-1636.9860839844, -2226.9274902344, 30.38279914856, -1636.0620117188, -2227.2819824219, 30.239698410034}
}




pedPos = {
    {-1633.33032, -2229.65405, 29.64020, -0,0,0},
    {-1631.5032, -2229.65405, 29.64020, -0,0,0},
    {-1630.4261474609, -2226.6589355469, 30.288228988647, -0, 0, 118.42651367188},
    {-1632.3588867188, -2224.078125, 30.61421585083, -0, 0, 176.84133911133},
    {-1634.0227050781, -2224.1442871094, 30.639961242676, -0, 0, 183.287109375}
}


AnimacionesPersonajes = {
    [1] = {"BEACH","parksit_m_loop"},
    [2] = {"BEACH","sitnwait_loop_w"},
    [3] = {"BEACH","sitnwait_loop_w"}

}


PosicionesBotones = {
    ["Boton.Jugar"] = {screenW * 0.3836, screenH * 0.5556, screenW * 0.4367, screenH * 0.5903},
    ["Boton.CrearPJ"] = {screenW * 0.3398, screenH * 0.6014, screenW * 0.4773, screenH * 0.6306}
}




local Color_TEXT_JUGAR = tocolor(255, 255,255,opacidad)
local Color_TEXT_Crear_PJ = tocolor(255, 255,255,opacidad)


local btnJugarRender = PosicionesBotones["Boton.Jugar"]
local btnCrearPJ = PosicionesBotones["Boton.CrearPJ"]




function TextoLobbby2D ()

  
    if opacidad >= 0 and opacidad <= 250 then
        opacidad = opacidad + 1
    end


    if isCursorOverText(screenW * 0.3836, screenH * 0.5556, screenW * 0.4367, screenH * 0.5903) then
        Color_TEXT_JUGAR = tocolor(255, 153, 51,opacidad)
    else
        Color_TEXT_JUGAR = tocolor(255, 255, 255,opacidad)
    end

    if isCursorOverText(screenW * 0.3398, screenH * 0.6014, screenW * 0.4773, screenH * 0.6306) then
        Color_TEXT_Crear_PJ = tocolor(255, 153, 51,opacidad)
    else
        Color_TEXT_Crear_PJ = tocolor(255, 255, 255,opacidad)
    end


   
    dxDrawBorderedText(0.35,"Iniciar", btnJugarRender[1], btnJugarRender[2], btnJugarRender[3], btnJugarRender[4], Color_TEXT_JUGAR, 2.00, "default", "left", "top", false, false, false, false, false)
    dxDrawBorderedText(0.35,"Crear Personaje", btnCrearPJ[1], btnCrearPJ[2], btnCrearPJ[3], btnCrearPJ[4], Color_TEXT_Crear_PJ,  2.00, "default", "center", "top", false, false, false, false, false)
    

end












function dxDrawTextOnElement(outline,TheElement,text,height,distance,R,G,B,alpha,size,font,...)


    if not TheElement then
        return
    end

    local x, y, z = getElementPosition(TheElement)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 0.5

        local bonex,boney,bonez = getPedBonePosition( TheElement, 5 )
        local sx, sy = getScreenFromWorldPosition(bonex,boney,bonez+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                

             for oX = (outline * -1), outline do
                for oY = (outline * -1), outline do
                    dxDrawText (text, sx + oX, sy + oY, sx + oX, sy + oY, tocolor(0, 0, 0, 255), size or 1, font or "arial","center","center")
                end
            end
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size), font or "arial", "center", "center")

            end
        end
    
end


function renderPersonajeNombres( ... )
   for Personaje,dato in pairs(PersonajesLobby) do
          local cuentaFormateada = dato.personajeNombreReal:gsub("_"," ") or "Sin Nombre"
          dxDrawTextOnElement(0.5,Personaje,cuentaFormateada,0.5,7,255,255,255,255,1,"default-bold")
   end
end



function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end







