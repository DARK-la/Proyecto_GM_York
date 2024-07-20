

local function informacionCuenta(p)
	if getElementData(p,"account_server_id") then
        
        local idCuenta = getElementData(p,"account_server_id")


        if not AccountOnline[idCuenta] then
        	return
        end
		

		local data = AccountOnline[idCuenta]

		for k,d in pairs(data) do
			 outputChatBox(tostring(k).."-> "..tostring(d),p,234,135,5,true)
		end

	end
end
addCommandHandler("cuenta",informacionCuenta)

