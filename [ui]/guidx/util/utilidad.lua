bindKey("m", "down",
    function()
        showCursor(not isCursorShowing())
    end
)

local sx, sy = guiGetScreenSize ( )

function isMouseInPosition ( x, y, width, height )

	if ( not isCursorShowing( ) ) then
		return false
	end
	
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end



function getButtonFind()
	
	for elementoDx, data in pairs(dxElementos) do
		local cords = data.pos
		if isMouseInPosition(cords.x,cords.y,cords.ancho,cords.alto) then
			
		   btnEncontrado = elementoDx
		   break
		end
   end
   
   return btnEncontrado
end