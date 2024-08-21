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





