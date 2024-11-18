local VehiculosEnVenta = { 480,
422,482,478,567,412,576,603,475,402,581,509,462,521,468,527,426,550,540,529,526,555,603,424	}
local ax,ay,az = getElementPosition(localPlayer)
local gui = {}







local function llenarListaVeh(l)
   for i = 1,#VehiculosEnVenta do
      local vehName = getVehicleNameFromModel ( VehiculosEnVenta[i] ) or "/"    
            guiGridListAddRow(l,vehName)	  
	  end
end



function vistaAutoPrevia()

    if not gui["btnComprarVehiculo"] then
		gui.btnComprarVehiculo = guiCreateButton(0.47, 0.91, 0.07, 0.05, "Comprar", true)
		guiSetProperty(gui.btnComprarVehiculo, "NormalTextColour", "FFCB7017")
		gui.listaVehiculos = guiCreateGridList(0.03, 0.32, 0.24, 0.56, true)
		guiGridListAddColumn(gui.listaVehiculos, "Vehiculo", 0.5)
		guiGridListAddColumn(gui.listaVehiculos, "Precio", 0.5)
		llenarListaVeh(gui.listaVehiculos)
		addEventHandler("onClientGUIClick",gui.btnComprarVehiculo,comprar)
		showCursor(true)
		else
		 for _,elemento in pairs(gui) do
		       destroyElement(elemento)
		 end
		 showCursor(false)
		 gui = {}
	end

   
end
addCommandHandler("comprarveh",vistaAutoPrevia)



function comprar()
	local vehiculo = guiGridListGetItemText ( gui.listaVehiculos, guiGridListGetSelectedItem ( gui.listaVehiculos ), 1 )
	if vehiculo then
		 triggerServerEvent("onClientVehicleBuyS",resourceRoot,vehiculo)
	end
end
