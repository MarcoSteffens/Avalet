----------------------------------------
-- ATCP-Handling
-- In diesem Script findet der Umgang mit den ATCP-Daten statt,
-- die Avalon sendet (und empfängt) 
-- Eine Beschreibung der ATCP-Schnittstelle von Avalon findet sich im Wiki:
-- https://avalon.mud.de/wiki/avalon:atcp
-- Dieses Script basiert auf einem Demo-Script von Vadi aus dem mudlet.org-Forum,
-- das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=1243
----------------------------------------

-- The following scripts attach handlers to the ATCP functions and echos them. 
-- It also parses the stats line and stores all stats in a easily accecble table,
-- and exits too.



----------------------------------------
-- CharVitals
----------------------------------------
status = {}

function CharVitals(event, arg)
		-- please note that this line changes from IRE MUD to MUD! This is the
		-- Achaean version, you might need to adapt to yours
		local r = rex.new( "H:(\\d+)/(\\d+) M:(\\d+)/(\\d+) E:(\\d+)/(\\d+) W:(\\d+)/(\\d+) NL:(\\d+)/(\\d+)" )
		if r:match( arg ) then
			status.current_health, status.max_health, 
			status.current_mana, status.max_mana, 
			status.current_endurance, status.max_endurance, 
			status.current_willpower, status.max_willpower, 
			status.next_level = r:match( arg )
		end

		display(status)
end

registerAnonymousEventHandler("CharVitals", "CharVitals")



----------------------------------------
-- RoomBrief
----------------------------------------

function RoomBrief(event, arg)
	room_title = arg
	echo("Current room title: " .. room_title .. "\n")
end

registerAnonymousEventHandler("RoomBrief", "RoomBrief")



----------------------------------------
-- RoomExits
----------------------------------------

room_exits = {}

function RoomExits(event, arg)
	room_exits = arg:split(",")
	display(room_exits)
end

registerAnonymousEventHandler("RoomExits", "RoomExits")



----------------------------------------
-- RoomNum
----------------------------------------

function RoomNum(event, arg)
	room_number = tonumber(arg)
	echo("Room ID: " .. room_number .. "\n")
end

registerAnonymousEventHandler("RoomNum", "RoomNum")

