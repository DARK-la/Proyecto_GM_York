-- settings
local MAX_CHARACTERS_PER_ACCOUNT = 3
local CHARACTERS_DETAILS = {
  AGE = { -- how much character could be old
    MIN = 18,
    MAX = 99
  },
  LAST_NAME = { -- min & max character last name
    MIN = 4,
    MAX = 15
  },
  FIRST_NAME = { -- min & max character first name
    MIN = 4,
    MAX = 15
  }
}

-- resources
addEvent("api:onPlayerLogin", false)



local posInit = toJSON({-233.77873, 1209.26062, 19.74219,0,0})





local function loadDataCharacterInAccount(usuario,ownerID,data) -- Guardamos cosas basicas en la cuenta array.
     
      AccountOnline[ownerID]["characterID"] = data.id
      AccountOnline[ownerID]["age"] = data.age
      AccountOnline[ownerID]["skin"] = data.skin
      AccountOnline[ownerID]["fname"] = data.firstName
      AccountOnline[ownerID]["lname"] = data.lastName
      
end


function isLoggedCharacter(ownerGlobalId)

      if type(ownerGlobalId) ~= "number"  then
	     return false
	  end
	  
      if not AccountOnline[ownerGlobalId] then
	     return false
	  end
	  
	  if not AccountOnline[ownerGlobalId]["characterID"] then
	     return false
	  end
	  
	  return true 
end



function getIdPlayerCharacter(p)

     if not isLoggedAccount(p) then
        return
     end


   
     if p and isElement(p) and getElementType(p) == "player" then
         local _,CIDCuenta = isLoggedAccount(p)

         if not AccountOnline[CIDCuenta] then
            return false,"NOT_LOGGED"
         end

         local identificadorPersonaje = AccountOnline[CIDCuenta].characterID        
         return identificadorPersonaje
         
     end
end




-- gathering all characters from player
function getAllGameCharacters(client)
  


  local characters = MYSQL:query(string.format('SELECT id FROM `personajes_datos` WHERE `ownerId` = ? LIMIT %d', MAX_CHARACTERS_PER_ACCOUNT), owner)
  
  if #characters > 0 then
    return characters
  end

  return 'CLIENT_PLAYER_NO_CHARACTERS'
end

-- spawn character
function spawnGameCharacter(client, selectedCharacterID)
  if not client or not getElementType(client) == 'player' then return 'GAME_CLIENT_UNIDENTIFIED' end

  -- check if player is logged


  -- gathering current player data
  
  
  if not isLoggedAccount(client) then
     kickPlayer(client,"¡Algo anda mal con tu cuenta!")
     return 
  end
  
  
  
  local _,CID = isLoggedAccount(client) -- Obtenemos la cuenta del ID del pibe

   if isLoggedCharacter(CID) then
      kickPlayer(client,"¡EPA!, No hagas eso.")
      return
   end
  
  
  
   
  local character = MYSQL:query('SELECT id,positionPlayer,firstName,lastName,health,gender,ownerId,moneyPlayer,age,skin,bankMoney FROM `personajes_datos` WHERE `id` = ?', selectedCharacterID)[1]
  if not character then return 'CLIENT_UNKNOWN_CHARACTER' end



 
 

  if CID ~= character.ownerId then
     kickPlayer(client,"¡UPS!, Error fatal al obtener al vertificar tu cuenta.")
     return
  end

 


 
  local pos = fromJSON(character.positionPlayer) or 0,0,20,0,0
  local style = ( character.gender == "Hombre" and 118 or character.gender == "Mujer" and 129   ) 

  spawnPlayer(client,pos[1],pos[2],pos[3], 0, character.skin, pos[4], pos[5],nil)
  setCameraTarget(client, client)
  setElementHealth(client, character.health)
  setPedWalkingStyle(client, style)


  local fullNameCharacter = character.firstName.."_"..character.lastName
  setPlayerName (client,fullNameCharacter)

  local toIDCharacterNumber = character.id
  
  loadDataCharacterInAccount(client,CID,character)

  setMoney(client,character.moneyPlayer)
  triggerEvent("api:onPlayerLogin",client,toIDCharacterNumber)
  return true,'CLIENT_CHARACTER_SPAWNED'
end



function saveDataPlayer()


    if isLoggedAccount(source) then



         local _,cID = isLoggedAccount(source)
         if not AccountOnline[cID] then
             return false
         end


         local data = AccountOnline[cID]
         if not data.characterID then 
            AccountOnline[cID] = nil
            print(data.username," -> se desconecto solo se elimino su ID de cuenta GLOBAL.")
            return false -- Si no tiene ningun personaje, limpio correctamente.
         end



        

         local interior, dimension = getElementInterior(source), getElementDimension(source)
         local x,y,z = getElementPosition(source)
         local posPlayer = toJSON({x,y,z,interior,dimension})



         local personajeSQLID = data.characterID
         local skinID = data.skin
         local moneyCharacter = getAmountMoney(source)
         local cuentaUsuario = data.username
         MYSQL:queryFree("UPDATE `personajes_datos` SET positionPlayer = ?, moneyPlayer = ?,  skin = ? WHERE id = ?",posPlayer,moneyCharacter,skinID,personajeSQLID)
         removeElementData(source,"account_server_id")
          
         AccountOnline[cID] = nil
         cleanDataMoneySafe(source)


         local personajeNombreUsuario = getPlayerName(source)
         print(personajeNombreUsuario," -> salio del servidor cuenta: ",cuentaUsuario)
    end
end
addEventHandler("onPlayerQuit",root,saveDataPlayer)


function createGameCharacterServer(client,data)

  if not isElement(client) or not getElementType(client) == 'player' then 
      return 'GAME_CLIENT_UNIDENTIFIED'
   end

    



   if not isLoggedAccount(client) then
       return "NOT_LOGGED"
   end



   local generoPersonaje = (data.gender == "Hombre" or data.gender == "Mujer")


   if not string.checkLen( data.nation, 5, 14 ) then return "SHORT_OR_LONG_NATION" end
   if not validarNombre(data.nation) then return "NATION_NAME_ERROR" end

   if not generoPersonaje then
      return "GENDER_NOT_VALID"
   end


  
  local _,ownerID = isLoggedAccount(client)


  if not string.checkLen(data.firstName, CHARACTERS_DETAILS.FIRST_NAME.MIN, CHARACTERS_DETAILS.FIRST_NAME.MAX) then return 'CLIENT_FIRSTNAME_SHORT_OR_LONG' end
  if not string.checkLen(data.lastName, CHARACTERS_DETAILS.LAST_NAME.MIN, CHARACTERS_DETAILS.LAST_NAME.MAX) then return 'CLIENT_LASTNAME_SHORT_OR_LONG' end
  

   



 


  local userCharacterCreated = MYSQL:query("SELECT COUNT(*) AS count FROM `personajes_datos` WHERE `ownerId` = ?",ownerID)

  if userCharacterCreated and userCharacterCreated[1] and userCharacterCreated[1].count >= MAX_CHARACTERS_PER_ACCOUNT then
       return 'CLIENT_CHARACTERS_LIMIT_REACHED'
    end


  

  if data.age ~= nil and tonumber(data.age) >= 18 and tonumber(data.age) <= 99 then

      local taken = false
      local charactersName = MYSQL:query('SELECT COUNT(*) AS count FROM `personajes_datos` WHERE firstName = ? AND lastName = ?',data.firstName,data.lastName)

      if charactersName and charactersName[1] and charactersName[1].count == 1 then
           taken = true
      end

      if taken then
          return 'CLIENT_CHARACTER_ALREADY_TAKEN'
      end

      if not validarNombre(data.firstName) or not validarNombre(data.lastName) then
         return "CLIENT_NOT_VALID_NAME"
      end



      
      local DNIRandom = math.random(1000,9000) 
      local skinRandomID = getSkinRandomGender(data.gender) or 0


      local primerNombre = firstToUpper(data.firstName)
      local apellidoFinal = firstToUpper(data.lastName)

      local _,lastCharacterID = MYSQL:query("INSERT INTO `personajes_datos` (firstName,lastName,gender,positionPlayer,ownerId,age,skin,dni) VALUES(?,?,?,?,?,?,?,?)",primerNombre,apellidoFinal,data.gender,posInit,ownerID,data.age,skinRandomID, DNIRandom)
    
       
      if lastCharacterID and type(lastCharacterID) == "number" and lastCharacterID >= 1 then

          spawnGameCharacter(client,lastCharacterID)

          outputConsole("Personje creado correctamente #"..tostring(lastCharacterID),client)

          return "CLIENT_PLAYER_CREATED"
     end

    else
      return "NOT_VALID_AGE"
  end


     return "VERDERO"
  
end



