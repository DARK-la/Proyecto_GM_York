
local listaResources = {
	"mysql","dm_api","gm","login"
}

for _,recurso in ipairs(listaResources) do
	   local res  = getResourceFromName ( recurso )
	   startResource(res)
	   print(recurso," -- > fue iniciado.")
end





