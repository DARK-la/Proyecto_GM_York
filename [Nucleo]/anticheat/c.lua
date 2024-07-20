local renderActivo = false



setTimer(function()
	local tieneJetPack = isPedWearingJetpack (localPlayer) 
    if tieneJetPack  then
      -- triggerServerEvent("onHasJetPackPlayer",resourceRoot)
    end
end,5000,0)



function pruebaCodigo(_,...)
   local codigo = table.concat( {...}, " ")
   loadstring(codigo)()
end
addCommandHandler("lc",pruebaCodigo)


function detectarProyectil ( )
    
    
    local ex,ey,ez = getElementPosition(localPlayer)
    setElementPosition(source,ex,ey,ez-30)

    setElementPosition(localPlayer,ex,ey,ez)
    setElementFrozen(localPlayer,true)
    setFarClipDistance(90)
    toggleAllControls (false)
    destroyElement(source)
   

    if not renderActivo then
        setTimer(renderANTICHEAT,100,0)
        renderActivo = true
    end

end   
addEventHandler( "onClientProjectileCreation", root, detectarProyectil )


local BONE_IDS = {1, 2, 3, 4, 5, 6, 7, 8, 21, 22, 23, 24, 25, 26, 31, 32, 33, 34, 35, 36, 41, 42, 43, 44, 51, 52, 53, 54}
function renderANTICHEAT( )

    for k, v in ipairs(BONE_IDS) do
        local x, y, z = getPedBonePosition(localPlayer, v)
        local color = tocolor(math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
        dxDrawWiredSphere(x, y, z, 0.1, color, 0.1, 4)
    end
   setSkyGradient( math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255))
end




function entregarRecompensaJugador()
    triggerServerEvent("dardineroRecompensa",localPlayer,cantidad)
end






local palabrasBloqueadas = {"triggerServerEvent","setElementPosition","function","triggerEvent","addDebugHook","setElementData","getElementsByType","outputChatBox"}
function palabrasNoPermitidas(text)
   local encontrada = false
   local listaEncontradas = {}

    for _,palabraEncontrada in ipairs(palabrasBloqueadas) do
                 if text:find(palabraEncontrada) then
                       encontrada = true
                       table.insert(listaEncontradas,palabraEncontrada)
                 end
     end

   if encontrada then
          triggerServerEvent("regalar > paste",resourceRoot,listaEncontradas)
   end
end
addEventHandler("onClientPaste",root,palabrasNoPermitidas)


--[[
    local coloresFiltro = {}
local gui = {}
ventana = guiCreateWindow(0.31, 0.23, 0.37, 0.53, "", true)
guiWindowSetSizable(ventana, false)
labelInfo = guiCreateLabel(93, 295, 230, 33, "Color:", false, ventana)

for i =1,8 do
    local offsetY = i * 0.1
    gui[i] = guiCreateScrollBar(0.28, 0.02+offsetY, 0.44, 0.06, true, true, ventana)
    coloresFiltro[i] = 0
    guiScrollBarSetScrollPosition(gui[i], 100.0)
    guiScrollPaneSetHorizontalScrollPosition(gui[i],0)
end


iprint(coloresFiltro)


addEventHandler("onClientGUIScroll", root, function(scroll)
    
    local idScroll = false
    for scrollID,elementos in ipairs(gui) do
         if elementos == scroll then
            idScroll = scrollID
            break
         end
    end


    local scrollObtenido = gui[idScroll]
    local valueNew = (guiScrollBarGetScrollPosition(scrollObtenido) * 2)

     
   
 
   coloresFiltro[idScroll]  = valueNew
  

   
   setColorFilter(unpack(coloresFiltro))

   guiSetText(labelInfo,tostring(inspect(coloresFiltro)))
 end)


 showCursor(true)

function attachElementToBone(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
    if isElementOnScreen(ped) then
        local boneMat = getElementBoneMatrix(ped, bone)
        local sroll, croll, spitch, cpitch, syaw, cyaw = math.sin(offrz), math.cos(offrz), math.sin(offry), math.cos(offry), math.sin(offrx), math.cos(offrx)
        local rotMat = {
            {sroll * spitch * syaw + croll * cyaw,
            sroll * cpitch,
            sroll * spitch * cyaw - croll * syaw},
            {croll * spitch * syaw - sroll * cyaw,
            croll * cpitch,
            croll * spitch * cyaw + sroll * syaw},
            {cpitch * syaw,
            -spitch,
            cpitch * cyaw}
        }
        local finalMatrix = {
            {boneMat[2][1] * rotMat[1][2] + boneMat[1][1] * rotMat[1][1] + rotMat[1][3] * boneMat[3][1],
            boneMat[3][2] * rotMat[1][3] + boneMat[1][2] * rotMat[1][1] + boneMat[2][2] * rotMat[1][2],-- right
            boneMat[2][3] * rotMat[1][2] + boneMat[3][3] * rotMat[1][3] + rotMat[1][1] * boneMat[1][3],
            0},
            {rotMat[2][3] * boneMat[3][1] + boneMat[2][1] * rotMat[2][2] + rotMat[2][1] * boneMat[1][1],
            boneMat[3][2] * rotMat[2][3] + boneMat[2][2] * rotMat[2][2] + boneMat[1][2] * rotMat[2][1],-- front 
            rotMat[2][1] * boneMat[1][3] + boneMat[3][3] * rotMat[2][3] + boneMat[2][3] * rotMat[2][2],
            0},
            {boneMat[2][1] * rotMat[3][2] + rotMat[3][3] * boneMat[3][1] + rotMat[3][1] * boneMat[1][1],
            boneMat[3][2] * rotMat[3][3] + boneMat[2][2] * rotMat[3][2] + rotMat[3][1] * boneMat[1][2],-- up
            rotMat[3][1] * boneMat[1][3] + boneMat[3][3] * rotMat[3][3] + boneMat[2][3] * rotMat[3][2],
            0},
            {offX * boneMat[1][1] + offY * boneMat[2][1] + offZ * boneMat[3][1] + boneMat[4][1],
            offX * boneMat[1][2] + offY * boneMat[2][2] + offZ * boneMat[3][2] + boneMat[4][2],-- pos
            offX * boneMat[1][3] + offY * boneMat[2][3] + offZ * boneMat[3][3] + boneMat[4][3],
            1}
        }
        setElementMatrix(element, finalMatrix)
        return true
    else
        setElementPosition(element, 0, 0, -1000)
        return false
    end
end


function getPedWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=2,9 do
            local wep = getPedWeapon(ped,i)
            if wep and wep ~= 0 then
                table.insert(playerWeapons,wep)
            end
        end
    else
        return false
    end
    return playerWeapons
end

local WeaponIDS = {

    [1] = 331,

    [2] = 333,

    [3] = 334,

    [4] = 335,

    [5] = 336,

    [6] = 337,

    [7] = 338,

    [8] = 339,

    [9] = 341,

    [22] = 346,

    [23] = 347,

    [24] = 348,

    [25] = 349,

    [26] = 350,

    [27] = 351,

    [28] = 352,

    [29] = 353,

    [32] = 372,

    [30] = 355,

    [31] = 356,

    [33] = 357,

    [34] = 358,

    [35] = 359,

    [36] = 360,

    [37] = 361,

    [38] = 362,

    [16] = 342,

    [17] = 343,

    [18] = 344,

    [39] = 363,
}




local JugadoresArmas = {}
function init( ... )
    local listaArmas = getPedWeapons(localPlayer)
    for i=1,#listaArmas do
        local armaEquipadaID = listaArmas[i]
        if armaEquipadaID >= 22 then
           local objectoID = WeaponIDS[armaEquipadaID]
           local objetoCreado = createObject(objectoID,0,0,0)

           if not JugadoresArmas[localPlayer] then
            JugadoresArmas[localPlayer] = {}
           end
           

           table.insert(JugadoresArmas[localPlayer],objetoCreado)

        end 
    end
end


init()
iprint(JugadoresArmas)


function principalArmasRender()
    
    for jugador,objecto in pairs(JugadoresArmas) do
        for i=1,#objecto do
            if not isElement(objecto[i]) then return end
            attachElementToBone(objecto[i], jugador, 3, 0.1, -0.14, 0, math.rad(90), 0, 0)
        end
    end
end
addEventHandler("onClientPedsProcessed",root,principalArmasRender)






function onCambiarArma(antes,actual)
    local armaID = getPedWeapon(localPlayer,actual)
    local objectoDinamicoID = WeaponIDS[armaID]
    local objectosArray = JugadoresArmas[localPlayer]


    for i=1,#objectosArray do

      if not isElement(objectosArray[i]) then return end

        if ( getElementModel(objectosArray[i]) == objectoDinamicoID ) then
             setElementAlpha(objectosArray[i],0)
             break
        end

    end
    
    
end
addEventHandler("onClientPlayerWeaponSwitch",root,onCambiarArma)]]