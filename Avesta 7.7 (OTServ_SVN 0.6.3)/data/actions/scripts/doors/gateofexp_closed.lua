-- Author: 		Rodrigo (Nottinghster) - (OTLand, OTFans, XTibia, OTServBR)
-- Country:		Brazil
-- From: 		Tibia World RPG OldSchool
-- Email: 		god.rodrigo@hotmail.com
-- Compiler:	Tibia World Script Maker (Action)

function onUse(cid, item, frompos, item2, topos)
	local isLevelDoor = (item.actionid >= 1001 and item.actionid <= 1999)
	local isVocationDoor = (item.actionid >= 2001 and item.actionid <= 2008)
      local playerPos = getPlayerPosition(cid)


	if not(isLevelDoor or isVocationDoor) then
		doTransformItem(item.uid, item.itemid+1)
		return TRUE
	end

	local canEnter = true
	if(isLevelDoor and getPlayerLevel(cid) < (item.actionid-1000)) then
		canEnter = false
	end

	if (isVocationDoor) then
		local doorVoc = item.actionid-2000
		if (doorVoc == 1 and not(isSorcerer(cid))) or
		   (doorVoc == 2 and not(isDruid(cid)))    or
		   (doorVoc == 3 and not(isPaladin(cid)))  or
		   (doorVoc == 4 and not(isKnight(cid)))   or
		   (doorVoc ~= getPlayerVocation(cid))     then
			canEnter = false
		end
	end

	if (not canEnter and getPlayerAccess(cid) == 0) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Only the worthy may pass.")
		return TRUE
	end

	doTransformItem(item.uid, item.itemid+1)
	local canGo = (queryTileAddThing(cid, frompos, bit.bor(2, 4)) == RETURNVALUE_NOERROR)
	if not(canGo) then
		return FALSE
	end

	local dir = getDirectionTo(playerPos, topos)

	doMoveCreature(cid, dir)
	return TRUE
end