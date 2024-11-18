local PlayerMoneyData = {}





function securityParams(player, motonDinero)


    if type(motonDinero) == "number" and player and getElementType(player) == "player" and motonDinero >= 1  then

        if not PlayerMoneyData[player] then
            PlayerMoneyData[player] = {}
        end
   
        return true
    end

    return false
end




function increaseMoney(player,amountNew)
   local dineroActual = getAmountMoney(player) 
   
   if type(amountNew) == "number" and amountNew > 0 then
      
	   local nuevoDinero =  dineroActual + amountNew 
	   PlayerMoneyData[player].money = nuevoDinero
	   setPlayerMoney(player,nuevoDinero,true)
   end
end


function setMoney(p, moton )

    if not securityParams(p,moton) then
        return false
    end

    local dineroADar = math.floor(tonumber(moton))
    PlayerMoneyData[p].money = dineroADar
    setPlayerMoney(p,dineroADar,true)
end





function getAmountMoney(p)

    if not PlayerMoneyData[p] then
      return
    end
   
    
    return PlayerMoneyData[p].money or 1
end


function cleanDataMoneySafe(p)

    if not PlayerMoneyData[p] then
        return
    end
    
   
    PlayerMoneyData[p] = nil
end



function seeMoneySelf(p)
   local cantidad = getAmountMoney(p) or "Nada"
   outputChatBox("Tienes un total de #0da625$"..cantidad,p,255,255,255,true)
end
addCommandHandler("verdinero",seeMoneySelf)

