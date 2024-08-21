setTimer(function()

	function showMessagePlayer(player,txt,isBoolMessage)
		
	     
	    if isElement(player) and #txt >= 2 then
	    	local dataMessage = { text = txt, type = "success", animate = true, isBoolMsg = isBoolMessage or false}
		    triggerClientEvent(player,"onSendMessageUI",player,dataMessage)
		end

	end

   

end,500,1) 


