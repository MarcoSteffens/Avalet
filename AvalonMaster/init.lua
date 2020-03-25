---------------------------------------------------------------------------
-- Initialisierung des AvalonMaster-Plugins
--
-- 
---------------------------------------------------------------------------







-- Script: onKeyPad
-- fuer das Laufen per Keypad, und fuer das Catchen
-- der letzten Bewegung fuer den Mapper
-- und fuer das automatische Schwimmen/ Klettern
onKeyPad = function ( eventName,key,tDirections )
	tDirections = {"sw","s","so","w","sc","o","nw","n","no","h","r","rein","raus"}
	--tPlayer.sLastMoveDirection=tDirections[key]
	send(tDirections[key],false)
--	if bAutoSchwimmen == true then
--		send("schwimm "..tDirections[key],false)
--		--send("b karte")
--	else
--		send(tDirections[key],false)
--		--send("b pflanzen")
--	end
end --function

registerAnonymousEventHandler("onKeyPad", "onKeyPad")
