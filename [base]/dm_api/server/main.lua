
AccountOnline = {}
MYSQL = exports.mysql


function validarNombre(nombre)
    
    local patron = "^[A-Za-z]+$"
    
    if nombre:match(patron) then
        return true
    else
        return false
    end
end


local maleSkin = {217,223,240,250,299,306,312,292,261,188}
local femaleSkin = {12,13,41,93,91,150,169,190,192,193,194,195,211,214,216}


local function getValueRandomTable(t)
    return t[math.random(1,#t)] 
end

function getSkinRandomGender(g)
    if g == "Hombre" then
        return getValueRandomTable(maleSkin)
    end

    return getValueRandomTable(femaleSkin)
end





function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
