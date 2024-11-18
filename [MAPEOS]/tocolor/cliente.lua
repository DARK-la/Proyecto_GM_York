local colorCache = {}
local listaColor = {0,0,0,0,0,0,0,0}
 
 
local x,y = 30, 28
local bucleI = 8


function crearVentana()
	ventana = guiCreateWindow(0.36, 0.25, 0.27, 0.50, "", true)
	guiWindowSetSizable(ventana, false)

    for i=1,bucleI do
	 
	  local toScroll  = guiCreateScrollBar(x, y * i, 250, 16, true, false, ventana)
	  guiScrollBarSetScrollPosition( toScroll, 0)
	  colorCache[i] = {toScroll, 0}
	end
    
	colorTexto = guiCreateLabel ( 300, 50, 400, 100, "texto a mostrar" )
end





function detectarScroll(scroll)

   if not scroll then
    return 
   end 
   
   
   local id = 0
   for i=1,#colorCache do
       local scrollAEncontrar = colorCache[i][1]
	   
	  if (scroll  == scrollAEncontrar) then
	      
		  id = i
	      return id 
	  end
   end 
   
   
   return false
end


function onClientGUIScroll(scrollBar)
   local indexScroll =  detectarScroll(scrollBar)
   local cache = colorCache[indexScroll]
   
   
   local cantidad = guiScrollBarGetScrollPosition(cache[1])
   cache[2] = cantidad
   
   listaColor[indexScroll] = cantidad
  
   setColorFilter(unpack(listaColor))
   
   guiSetText(colorTexto,tostring(inspect(listaColor)))
end
addEventHandler("onClientGUIScroll", root, onClientGUIScroll)










