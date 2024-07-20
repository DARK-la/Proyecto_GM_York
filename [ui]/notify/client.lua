local sx, sy = guiGetScreenSize();
local relativeScale, relativeFontScale = math.min(math.max(sx/1600,0.2),1), math.min(math.max(sx/1600,1),2);




local colors = {
    default = {255,255,255},
    success = {5,255,5},
    info = {0,55,255},
    warn = {255,255,55},
    error = {255,55,0}
}



local ListaMensajes = {

  ["CLIENT_ACCOUNT_INVALID_PASSWORD"] = "#F97D4E¡Error en los datos ingresados!",
  ["CLIENT_ACCOUNT_NOT_EXISTS"] = "#B35D3F¡UPS!, revisa los datos hubo un error.",
  ["CLIENT_LOGIN_SUCCESS"] = "¡Bienvenido!",
  ["CLIENT_ACCOUNTS_LIMIT_REACHED"] = "#B35D3F¡No se permiten crear mas cuentas!",
  ["CLIENT_NO_EMAIL"] = "#B35D3FCorreo no válido.",
  ["CLIENT_INVALID_EMAIL"] = "#B35D3FCorreo no válido.",
  ["CLIENT_EMAIL_ALREADY_TAKEN"] = "#B35D3F¡No se puede usar ese correo!",
  ["NOT_VALID_NAME"] = "#B35D3FNombre invalido.",
  ["CLIENT_ACCOUNT_CREATED"] = "#EF9F09Cuenta creada correctamente.",
  ["CLIENT_UNKNOWN_ERROR"] = "#B35D3FHubo un error extraño, notificalo.",
  ["CLIENT_INVALID_SERIAL_NOT_SAME"] = "#FF8308¡Hubo un error en tu serial y cuenta!",
  ["CLIENT_LOGIN_SUCCESS"] = "#EF9F09¡Un placer tener por aquí!",



  ["CLIENT_PLAYER_NO_CHARACTERS"] = "No tienes personajes creados.",
  ["CLIENT_UNKNOWN_CHARACTER"] = "¡Algo anda mal con tu personajes!",
  ["CLIENT_CHARACTER_SPAWNED"] = "Inicio de personaje correcto.",
  ["CLIENT_CHARACTER_ALREADY_TAKEN"] = "#FF8308¡Nombre de personaje no disponible!",
  ["CLIENT_FIRSTNAME_SHORT_OR_LONG"] = "#FF8308Nombre no válido, intente usar otro.",
  ["CLIENT_LASTNAME_SHORT_OR_LONG"] = "#FF8308Apellido del personaje no válido.",
  ["CLIENT_CHARACTERS_LIMIT_REACHED"] = "#F51604Límite de personajes creados: 3/3.",
  ["CLIENT_PLAYER_CREATED"] = "#EF9F09Personaje creado correctamente",
  ["CLIENT_NOT_VALID_NAME"] = "#FF8308Nombre o apellido incorrecto, probablemente contiene caracteres no permitidos.",
  ["NOT_VALID_AGE"] = "Edad no válida",
  ["GENDER_NOT_VALID"] = "Genero disponible: Hombre o Mujer.",
  ["SHORT_OR_LONG_NATION"] = "#FF8308Nacionalidad demasiada corta o larga.",
  ["NATION_NAME_ERROR"] = "#0E5C8ERevisa la nación de tu personaje."


}





local notifications = {}

notifications.list = {} -- here u save all notifications

-- DESIGN -- 
notifications.padding = 10
notifications.offset = 600 * relativeScale
notifications.offsetWidth = 5
-- TEXT
notifications.font = "default-bold"
notifications.fontScale = 1 * relativeFontScale
notifications.fontHeight = dxGetFontHeight(notifications.fontScale,notifications.font)

notifications.width, notifications.height = math.floor(360 * relativeScale), math.floor(notifications.fontHeight + notifications.padding * 2)
-- SETTINGS
notifications.max = 6 -- MAX NOTIFICATIONS TO SHOW
notifications.interpolator = "Linear" -- interpolator
notifications.timeMaxToShow = 3000 -- mseconds


local math_min = math.min

function addNotification(e)

	

    
	if not (e.text and e.type and e.animate)then 
        return outputDebugString("Syntax Error: \n --->> ( \"text\", Type: [\"default,success,info,warn,error\"], animate [true o false])",4)
    end
  
  
    
    notifications.timeMaxToShow = math.random(4000,7000)
    local description = e.text
    local notification = {}

    if e.isBoolMsg then
    	description = ListaMensajes[e.text] or "NO_ENCONTRADO."
    end
   







    -- TIMERS
    notification.appearTick = getTickCount()
    notification.animationTick = getTickCount()

    notification.fadeTick = getTickCount()
    notification.progressFade = 0
    notification.progressFadeToGo = 1

    notification.alphaTick = 0
    notification.progressAlpha = 0
    notification.progressAlphaToGo = 0

    notification.display = true -- if not show the notifications the value for default = true

    notification.text = description
    notification.offset = notifications.offset
    notification.animate = animate and true or false

    notification.textWidth = dxGetTextWidth(notification.text,notifications.fontScale,notifications.font) -- WITH THIS U HAVE THE LEN OF THE TEXT IN PX

    notification.width = notification.textWidth + notifications.padding * 3
    notification.height = notifications.height
    notification.offsetX = sx - ( notification.width + notifications.offsetWidth)
    notification.color = "default"


    table.insert(notifications.list, 1, notification) -- is important the second value.
    --iprint(notification)

    if #notifications.list > notifications.max then
        for i , notification in pairs(notifications.list)do
            if i > notifications.max and notification.display then
                notification.fadeTick = getTickCount()
                notification.alphaTick = getTickCount()
                notification.display = false
            end
        end
    elseif #notifications.list == 1 then 
        addEventHandler("onClientRender",root,drawNotification)
    end
end
addEvent("onSendMessageUI",true)
addEventHandler("onSendMessageUI",localPlayer,addNotification)

function drawNotification()

    local currentTick = getTickCount()
    local offsetY = notifications.offset


    for i, notification in pairs(notifications.list)do

		-- SI SE CUMPLE ESTA FUNCION CORRE EL CONTADOR PARA APARECER LA NOTIFICACION 
		if currentTick - notification.appearTick > notifications.timeMaxToShow and notification.display then
			notification.alphaTick = getTickCount()
			notification.display = false
		end


		local fadeTick = notification.fadeTick or 0
		notification.progressFade = interpolateBetween(notification.progressFade or 0, 0, 0, notification.progressFadeToGo, 0, 0, math_min(1000, currentTick - fadeTick)/1000, notifications.interpolator)
		if notification.display and notification.progressFade >= 0.8 and notification.progressAlphaToGo == 0 then
			notification.alphaTick = getTickCount()
			notification.progressAlphaToGo = 1
		end

		-- desvanecer
		local alphaTick = notification.alphaTick or 0
		notification.progressAlpha= interpolateBetween(notification.progressAlpha or 0, 0, 0, notification.display and notification.progressAlphaToGo or 0, 0, 0, math_min(2000, currentTick - alphaTick)/2000, notifications.interpolator)
		if not notification.display and notification.progressAlpha <= 0.2 and notification.progressFadeToGo == 1 then
			notification.fadeTick = getTickCount()
			notification.progressFadeToGo = 0
		end	


        local r,g,b = colors[notification.color][1] or 255, colors[notification.color][2] or 255, colors[notification.color][3] or 255

        dxDrawCurvedRectangle(notification.offsetX, offsetY, notification.width, notification.height, tocolor(0,0,0,150 * notification.progressFade * notification.progressAlpha), true )
        --dxDrawStartCurvedRectangle(notification.offsetX, offsetY, notification.width, notification.height, tocolor(r,g,b,255 * notification.progressFade * notification.progressAlpha), true )

        dxDrawText(notification.text, notification.offsetX, offsetY, notification.offsetX + notification.width, offsetY + notification.height, tocolor(255,255,255,255 * notification.progressFade * notification.progressAlpha),notifications.fontScale, notifications.font,"center","center", false,false,true,true)
        
        offsetY = math.ceil(offsetY + notification.height + notifications.offsetWidth)

        if not notification.display and notification.progressAlpha == 0 then
            notifications.list[i] = nil
            if #notifications.list == 0 then
                removeEventHandler("onClientRender", root, drawNotification)
                outputDebugString("["..getResourceName(getThisResource()).."] Notifications were removed.",4)
            end
        end
    end
end



-- THIS FUNCTION IS FOR MAKE A  Curved Rectangle
function dxDrawCurvedRectangle(x, y, width, height, color, postGUI)
	if type(x) ~= "number" or type(y) ~= "number" or type(width) ~= "number" or type(height) ~= "number" then
		return
	end
	local color = color or tocolor(114, 137, 218, 255)
	local postGUI = type(postGUI) == "boolean" and postGUI or false
	local edgeSize = height/2
	width = width - height
	dxDrawImageSection(x, y, edgeSize, edgeSize, 0, 0, 33, 33, "img/edge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x, y + edgeSize, edgeSize, edgeSize, 0, 33, 33, 33, "img/edge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x + width + edgeSize, y, edgeSize, edgeSize, 43, 0, 33, 33, "img/edge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x + width + edgeSize, y + edgeSize, edgeSize, edgeSize, 43, 33, 33, 33, "img/edge.png", 0, 0, 0, color, postGUI)

	if width > 0 then
		dxDrawImageSection(x + edgeSize, y, width, height, 33, 0, 10, 66, "img/edge.png", 0, 0, 0, color, postGUI)
	end
end

-- THIS FUNCTION IS FOR MAKE A  Start Curved Rectangle
function dxDrawStartCurvedRectangle(x, y, width, height, color, postGUI)
	if type(x) ~= "number" or type(y) ~= "number" or type(width) ~= "number" or type(height) ~= "number" then
		return
	end
	local color = color or tocolor(114, 137, 218, 255)
	local postGUI = type(postGUI) == "boolean" and postGUI or false
	local edgeSize = height/2
	width = width - height
	dxDrawImageSection(x, y, edgeSize, edgeSize, 0, 0, 33, 33, "img/startedge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x, y + edgeSize, edgeSize, edgeSize, 0, 33, 33, 33, "img/startedge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x + width + edgeSize, y, edgeSize, edgeSize, 43, 0, 33, 33, "img/startedge.png", 0, 0, 0, color, postGUI)
	dxDrawImageSection(x + width + edgeSize, y + edgeSize, edgeSize, edgeSize, 43, 33, 33, 33, "img/startedge.png", 0, 0, 0, color, postGUI)

	if width > 0 then
		dxDrawImageSection(x + edgeSize, y, width, height, 33, 0, 10, 66, "img/startedge.png", 0, 0, 0, color, postGUI)
	end
end