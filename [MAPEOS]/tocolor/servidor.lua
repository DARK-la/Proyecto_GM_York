local Weapons = {}

Weapons.ID = {

	[1] = 331,

	[2] = 333,

	[3] = 334,

	[4] = 335,

	[5] = 336,

	[6] = 337,

	[7] = 338,

	[8] = 339,

	[9] = 341,

	[22] = 346,

	[23] = 347,

	[24] = 348,

	[25] = 349,

	[26] = 350,

	[27] = 351,

	[28] = 352,

	[29] = 353,

	[32] = 372,

	[30] = 355,

	[31] = 356,

	[33] = 357,

	[34] = 358,

	[35] = 359,

	[36] = 360,

	[37] = 361,

	[38] = 362,

	[16] = 342,

	[17] = 343,

	[18] = 344,

	[39] = 363,

	--[] = ,

	--[] = ,

	--[] = ,

}

local antiSpamW  = {} 






function createWeaponGround(wep_id, ammo, x, y, z, int, dim, huellas)

	if wep_id ~= 0 then

		if wep_id >= 22 then

			local ID = Weapons.ID[wep_id]

			z = z

			local weapon = createObject(ID, x, y, z)

			local col = createColSphere(x , y, z +.5,1)

			setElementInterior(weapon, int)

			setElementDimension(weapon, dim)

			setElementRotation(weapon,86,270,180)

			--

			setElementData(col,'weapon_data',{weapon,wep_id, ammo,col, corona, huellas})
            
			
			
			
		end

	end

end



addCommandHandler("dejar",

	function(player,cmd, muni)

		local tick = getTickCount()

		if (antiSpamW[player] and antiSpamW[player][1] and tick - antiSpamW[player][1] < 2000) then

			return

		end
		
		
		local muni = tonumber(muni)
		local wep_id_user = getPedWeapon(player)

		if wep_id ~= 0 then

			if wep_id_user >= 22 then

				

				local ID = Weapons.ID[wep_id]

				local ammo = getPedTotalAmmo(player)

				local pos = Vector3(getElementPosition(player))

                
				iprint(pos)
				pos.z = pos.z - 1

				if muni and muni <= ammo then

				
                    createWeaponGround(wep_id_user, muni, pos.x, pos.y, pos.z, 0, 0, "nil")
					takeWeapon(player, wep_id_user, muni)

				else
					player:outputChat('* No tienes esa cantidad de balas.',220,220,0)
				end

			end

		end

		if (not antiSpamW[player]) then

			antiSpamW[player] = {}

		end

		antiSpamW[player][1] = getTickCount()

	end

)






function isElementInRange(ele, x, y, z, range)

   if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then

      return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.

   end

   return false

end




function entregarArmaServidor(t)

		setPedAnimation(client,"BOMBER", "BOM_Plant", -1,true, false, false)

		--

		setTimer(function(client)

			setPedAnimation(client)

		end, 500, 1, client)

		giveWeapon(client, t[2], t[3], true )

		if isElement(t[4]) then

			t[4]:destroy()

		end

		if isElement(t[5]) then

			t[5]:destroy()

		end

		if isElement(t[1]) then

			t[1]:destroy()

		end

	end


