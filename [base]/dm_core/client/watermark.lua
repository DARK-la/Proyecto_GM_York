-- settings
local WATERMARK_ALPHA = 120
local WATERMARK_TOKEN = nil

-- vars
local x,y = guiGetScreenSize()
local info = getGamemodeInfo()

-- functions
local function generateToken(accountId, accountUsername)
  return teaEncode('dreamy_rp', base64Encode(string.format('%s:%s', accountUsername, accountId)))
end

-- rendering


local infoGM = string.format("%s v%s\n%s", info.NAME, string.format('%s-%s', info.VERSION, info.PRODUCTION and 'prod' or 'dev'), formatDate("W, d.m.Y"))


function marcaDeAguaGM()
    dxDrawText(infoGM, 0, 0, x - 5, y - 16, tocolor(255, 255, 255, WATERMARK_ALPHA), 1, "default-bold", "right", "bottom", false, false, true)
end
--addEventHandler("onClientRender", root, marcaDeAguaGM)