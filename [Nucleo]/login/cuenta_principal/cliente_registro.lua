local screenW, screenH = guiGetScreenSize()









function crearCuentaServidor(username, email, pass,passtwo)
   
        if not miclavesita then
                outputConsole("ERROR: Vertificacion con la autenticidad.")
                return
        end

        local cuenta_usuario = username
        local contra = pass
        local contra2 = passtwo

        if #cuenta_usuario >= 4 and #contra >= 4 and #contra2 >= 4 then
             local data = { username = cuenta_usuario, password = encodeString("rsa",contra,{ key = miclavesita }), miEmail = email , password_repeat = encodeString("rsa",contra2,{ key = miclavesita })  }
             triggerServerEvent("onCreatedAccountGame",resourceRoot,data)
        end

end
addEvent("new account > client",false)
addEventHandler("new account > client",root,crearCuentaServidor)



