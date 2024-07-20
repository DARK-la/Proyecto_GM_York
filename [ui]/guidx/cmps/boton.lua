dxElementos = {}
local chatbox = getChatboxLayout()


function onDxClick(button,state)
   
    
    if button == "left" and state == "down" then
        
        local btnEncontrado = getButtonFind()
        if not isElement(btnEncontrado) then
            return
        end
       
        destroyElement(btnEncontrado)
        
    end


  
end
addEventHandler("onClientClick",root,onDxClick)



function onDestruirBTN()

    
    removeEventHandler("onClientRender",root,dxElementos[source].render)
    dxElementos[source] = nil

end
addEventHandler("onClientElementDestroy",resourceRoot,onDestruirBTN)





function crearBoton(texto,x,y,ancho,alto,arrayColor,fondoColor)
  local dataDx = createElement("boton-dx")

  local colorFondo = tocolor(unpack(fondoColor))
  local anchoPixeles = dxGetTextWidth(texto,chatbox["chat_scale"][1])
  local colorTexto = tocolor(unpack(arrayColor))

  dxElementos[dataDx] = {
    mensaje = texto,
    render = function()
        

        local textoActualizado =  dxElementos[dataDx].mensaje
        dxDrawRectangle(x,y,anchoPixeles,alto,colorFondo)
        dxDrawText(textoActualizado,x,y,x + anchoPixeles, y+alto,colorTexto,1,"deafult-bold","center","center")
    end,
    pos = { x = x, y = y, ancho = anchoPixeles, alto = alto }

  }

  addEventHandler("onClientRender",root,dxElementos[dataDx].render)
 
end


