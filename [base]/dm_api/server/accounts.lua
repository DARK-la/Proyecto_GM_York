-- settings
local VERIFY_EMAIL = true
local ACCOUNT_DETAILS = {
  USERNAME = {
    MIN = 4,
    MAX = 15
  },
  PASSWORD = {
    MIN = 4,
    MAX = 20
  }
}
local VERIFY_ACCOUNT_SERIAL = true
local MAX_ACCOUNTS_PER_SERIAL = 1


--addEvent('api:onPlayerLogged', true)


--local CORE = exports.dm_core
local MYSQL = exports.mysql


function createGameAccount(client, data)
  if not client or not getElementType(client) == 'player' then return 'GAME_CLIENT_UNIDENTIFIED' end

  
  local serialUsuario = getPlayerSerial(client)

  
  if VERIFY_ACCOUNT_SERIAL then

    local SQLCantidadCuentas = MYSQL:query("SELECT COUNT(ID) from `cuenta_usuario` WHERE serial = ?",serialUsuario)
	
	if not SQLCantidadCuentas[1] then
	end
	
	local cantidadCuentasCreadasActuales  =  SQLCantidadCuentas[1]["COUNT(ID)"]
	
	if cantidadCuentasCreadasActuales >=MAX_ACCOUNTS_PER_SERIAL then
	   return "CLIENT_ACCOUNTS_LIMIT_REACHED"
     end	
  end

  -- checking if username or email is already taken & making sure is everything perfect
  if not string.checkLen(data.username, ACCOUNT_DETAILS.USERNAME.MIN, ACCOUNT_DETAILS.USERNAME.MAX) then return 'CLIENT_USERNAME_SHORT_OR_LONG' end
  if not string.checkLen(data.password, ACCOUNT_DETAILS.PASSWORD.MIN, ACCOUNT_DETAILS.PASSWORD.MAX) then return 'CLIENT_PASSWORD_SHORT_OR_LONG' end

  if VERIFY_EMAIL then
    if not data.email or not type(data.email) == 'string' then
      return 'CLIENT_NO_EMAIL'
    end

    if not validateEmail(data.email) then
      return 'CLIENT_INVALID_EMAIL'
    end

    local emailTaken = #MYSQL:query('SELECT `id` FROM `cuenta_usuario` WHERE `email` = ? LIMIT 1', data.email) >= 1
    if emailTaken then
      return 'CLIENT_EMAIL_ALREADY_TAKEN'
    end
  end

  local usernameTaken = #MYSQL:query('SELECT `id` FROM `cuenta_usuario` WHERE Binary `username` = ? LIMIT 1', data.username) >= 1
  if usernameTaken then return 'CLIENT_USERNAME_ALREADY_TAKEN' end


  if not validarNombre(data.username) then
     return "NOT_VALID_NAME"
  end

  -- hashing password and making new account
  local PassWordHasheada = passwordHash(data.password, 'bcrypt', {})
  local cuentaIP = getPlayerIP(client)
   
  local created = MYSQL:queryFree('INSERT INTO `cuenta_usuario` (`email`, `ip`, `serial`, `username`, `password`, `createdAt`,`lastOnline`) VALUES(?,?,?,?,?,CURRENT_TIME(), CURRENT_TIME())',data.email, cuentaIP,serialUsuario, data.username, PassWordHasheada )
  if created then
    return 'CLIENT_ACCOUNT_CREATED'
  end

  return 'CLIENT_UNKNOWN_ERROR'
end


function loginGameAccount(client, data)


  if not isElement(client) or not getElementType(client) == 'player' then return 'GAME_CLIENT_UNIDENTIFIED' end
  
  
  local dataQuerySQL = MYSQL:query('SELECT id,password,username FROM `cuenta_usuario` WHERE BINARY `username` = ? LIMIT 1', data.username)
  
  local isDataNotValid = ( type(dataQuerySQL[1]) ~= "table" )
  local account = dataQuerySQL[1]
  
  
	  if isDataNotValid then
		 return "CLIENT_ACCOUNT_NOT_EXISTS"
	  end


   --[[ if AccountOnline[account.id] then
       outputConsole("Ya existe una sesion activa actualmente.")
       return false
    end]]


    
    -- elements data to set
   

    local passwordHashVaild = passwordVerify(data.password, account.password)

    if passwordHashVaild then

       local dataCharacter = MYSQL:query("SELECT id,firstName,lastName,skin,ownerId FROM `personajes_datos` WHERE ownerId = ?", account.id )

        AccountOnline[tonumber(account.id)] = {
            ["username"] = account.username
        }

      triggerEvent('api:onLoginAccount', resourceRoot, client)
      setElementData(client,"account_server_id",account.id,false)
     
      return 'CLIENT_LOGIN_SUCCESS', dataCharacter
    else return 'CLIENT_ACCOUNT_INVALID_PASSWORD' end
 

  return 'CLIENT_UNKNOWN_ERROR'
end


function isLoggedAccount(p)

     if getElementData(p,"account_server_id") then
         return true,getElementData(p,"account_server_id")
     end

     return false
end



function getNameFullCharacter(p)

    if not isLoggedAccount(p) then
	  return
	end
	
	
	local idCuentaUsuario = getElementData(p,"account_server_id")
	local data = AccountOnline[idCuentaUsuario]
	
	return data.fname, data.lname
end 




function findPlayerByAccountId(accountId)
  if not accountId or not type(accountId) == 'number' then return end

  for k, player in ipairs(getElementsByType('player')) do
    local accId = getElementData(player, 'account_server_id')

    if accountId == accId then
      return player
    end
  end

  return nil
end



