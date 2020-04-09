--teilen wir Mudlet mal mit das wir einen Mapper haben
mudlet = mudlet or {}; mudlet.mapper_script = true

-- Der eigene Namespace :)
tMapper = tMapper or {}

-- Uebersetzen der Map farben in Mudletfarben
tMapper.tFarben = { MAP_RED=257, MAP_GREEN=258, MAP_YELLOW=259, MAP_BLUE=260, MAP_MAGENTA=261, MAP_CYAN=262, MAP_WHITE=263, MAP_BLACK=264, MAP_HI_RED=265, MAP_HI_GREEN=266, MAP_HI_YELLOW=267, MAP_HI_BLUE=268, MAP_HI_MAGENTA=269, MAP_HI_CYAN=270, MAP_HI_WHITE=271, MAP_HI_BLACK=272 }

--default steplenght - in nicht mapraeumen 3 (createRoom()) ansonsten hier setzen :)
--So viele Felder sind die Raeume auf der grafischen Karte entfernt. Wird gebraucht um die Pos zu ermitteln beim Mappen
tMapper.tAreaLength = { Miobaas=6, Ashar=6, Nereid=1, Losaria = 1}

-- Die Modi des Mappers, Walk, Map und Speedwalk
tMapper.sMode = "Walk"

tMapper.tDirs={n="n",no="ne",o="e",so="se",s="s",sw="sw",w="w",nw="nw",h="u",ru="d",ra="out"}
tMapper.tOdirs={n="s",no="sw",o="w",so="nw",s="n",sw="nw",w="e",nw="se",h="d",ru="u",ra="in"}

--Die Stopwatch fuer die zentrale Command Queue
createStopWatch("cq")
--die Command Queue ansich
_cq = {}
stop_cq = false
pause_cq = false
_waitingForCondition = false
_time_next_command = -1



speedWalkPath = {}
speedWalkCounter = 0

function speedwalking( event, num )
	if speedWalkPath[speedWalkCounter] == tMapper.iID then
		speedWalkMoved = true
		speedWalkCounter = speedWalkCounter + 1
		continueSpeedWalk();
	end
end

function doSpeedWalk()
display(speedWalkDir)
	for k,v in ipairs(speedWalkDir) do
		if speedWalkDir[k] == "e" then speedWalkDir[k] = "o"
		elseif speedWalkDir[k] == "se" then speedWalkDir[k] = "so"
		elseif speedWalkDir[k] == "ne" then speedWalkDir[k] = "no"
		elseif speedWalkDir[k] == "up" then speedWalkDir[k] = "hoch"
		elseif speedWalkDir[k] == "down" then speedWalkDir[k] = "runter"
		elseif speedWalkDir[k] == "in" then speedWalkDir[k] = "rein"
		elseif speedWalkDir[k] == "out" then speedWalkDir[k] = "raus"
		end
	end
	send("grafik aus")
	echo("Starting speedwalk from "..tMapper.iID.." to"..speedWalkPath[#speedWalkPath]..": ")
	cecho(table.concat(speedWalkDir, ", "))
   speedWalkCounter = 1;
	tMapper.sMode = "Speedwalk"
	addCommand(speedWalkDir[1],0.13)
end

function continueSpeedWalk()
	if speedWalkDir[speedWalkCounter] then 
	addCommand( speedWalkDir[speedWalkCounter], 0.3 )
	cecho(string.format("<red>(<maroon>%d - <dark_slate_grey>%s<red>)", #speedWalkDir - speedWalkCounter, speedWalkDir[speedWalkCounter]))
	end
  
end


--Kleiner Helfer zum Fehlerfinden...moment..ich mache keine Fehler, also obsolet :)
tMapper.fDebug = function(arg)
cecho("<yellow>"..arg.."\n")
end

-- ATCP Ist es dunkel ? brauchen wir zum Speedwalken im dunklen.
tMapper.fAvalonDunkel = function (event,arg)
 tMapper.fDebug(event.." "..arg)
  if tonumber(arg) == 1 then 
   if tMapper.sMode and tMapper.sMode == "Speedwalk" then
     speedWalkCounter = speedWalkCounter + 1
		continueSpeedWalk();
   end  
 end
end
if tMapper.iAvalonDunkelHandlerID then killAnonymousEventHandler(tMapper.iAvalonDunkelHandlerID) end
tMapper.iAvalonDunkelHandlerID = registerAnonymousEventHandler("AvalonDunkel", "tMapper.fAvalonDunkel")

--ATCP Hat der Raum einen Namen ? wenn ja als Sprungziel zugaenglich machen
tMapper.fAvalonSite = function (event,arg)
 tMapper.fDebug(event.." "..arg)
 tMapper.sSite = arg
 end
if tMapper.iAvalonSiteHandlerID then killAnonymousEventHandler(tMapper.iAvalonSiteHandlerID) end
tMapper.iAvalonSiteHandlerID = registerAnonymousEventHandler("AvalonSite", "tMapper.fAvalonSite")

--ATCP Ist der Raum ein Wegraum ? Wirkt sich auf das RoomWeight aus, damit der Mapper moeglichst auf den Wegen laeuft.
tMapper.fAvalonWeg = function (event,arg)
 tMapper.fDebug(event.." "..arg)
 tMapper.iWeg = arg
 end
if tMapper.iAvalonWegHandlerID then killAnonymousEventHandler(tMapper.iAvalonWegHandlerID) end
tMapper.iAvalonWegHandlerID = registerAnonymousEventHandler("AvalonWeg", "tMapper.fAvalonWeg")

tMapper.fAvalonIcon16 = function (event,arg)
 tMapper.fDebug(event.." "..arg)
 if tMapper and tMapper.sMode and tMapper.sMode == "Map" then
   tMapper.sColor = "MAP_WHITE"
   tMapper.sChar = nil
   tMapper.sColor,tMapper.sChar = rex.match( arg, [[%\^(\w+)%\^(.)]] )
 end
end
if tMapper.iAvalonIcon16HandlerID then killAnonymousEventHandler(tMapper.iAvalonIcon16HandlerID) end
tMapper.iAvalonIcon16HandlerID = registerAnonymousEventHandler("AvalonIcon16", "tMapper.fAvalonIcon16")

tMapper.fAvalonExits = function (event,arg)
 tMapper.fDebug(event.." "..arg)
 tMapper.tExits = arg or {}
end
if tMapper.iAvalonExitsHandlerID then killAnonymousEventHandler(tMapper.iAvalonExitsHandlerID) end
tMapper.iAvalonExitsHandlerID = registerAnonymousEventHandler("AvalonExits", "tMapper.fAvalonExits")


tMapper.fAvalonRoomID = function(event, arg)
 tMapper.sOldHash = tMapper.sHash or -1
 tMapper.iOldID = tMapper.iID or -1
 tMapper.sOldAreaName = tMapper.sArea or -1
 tMapper.iOldy = tMapper.iY or 0
 tMapper.iOldx = tMapper.iX or 0
 tMapper.iOldz = tMapper.iZ or 0
 tMapper.iAreaID = nil
 tMapper.sHash, tMapper.sArea, tMapper.iTmpx, tMapper.iTmpy = rex.match(arg, [[raum/([^ ]+) ?([^ ]+)? ?(?:x=(.*) y=(.*))?]])
 tMapper.iID = getRoomIDbyHash(tMapper.sHash) or -1
 tMapper.iY = 0
 tMapper.iX = 0
 tMapper.iZ = 0
 tMapper.bNewArea = false
 tMapper.iWeg = -1
 tMapper.sSite = nil
 tMapper.bMapRoom = false
 tMapper.fDebug(event.." "..arg)
 
 --Fuer Dungeons die keine eigene Area haben:
 -- z.B tMapper.AreaNameOverwrite = "Duestergarten"
 --tMapper.AreaNameOverwrite = "Kratylon"
 
 if tMapper.sAreaOverwrite then tMapper.sArea = tMapper.sAreaOverwrite end
 
 if tMapper.iTmpx and tMapper.iTmpy then tMapper.bMapRoom = true end
 
 centerview(tMapper.iID)
 if tMapper.sMode then
   if tMapper.sMode == "Walk" then
  sendATCP("ava_req_inv", "hier")
   end--mode walk
   if tMapper.sMode == "Map" then
     sendATCP("ava_req_inv", "hier")
   end-- mode map
   if tMapper.sMode == "Speedwalk" then
     if tonumber(tMapper.iID) == tonumber(speedWalkPath[#speedWalkPath]) then
       tMapper.sMode = "Walk"
       speedWalkPath = {}
       speedWalkDir = {}
       speedWalkCounter = 0
       stopStopWatch(speedWalkWatch)
       speedWalkPath = {}
       sendATCP("ava_req_inv", "hier")
       send("grafik an")
			 send("schau")
     elseif tonumber(speedWalkPath[speedWalkCounter]) == tMapper.iID then
       speedWalkMoved = true
       speedWalkCounter = speedWalkCounter + 1
       continueSpeedWalk()
     end
    end -- mode speedwalk
  end --if tMapper.Mode	
end -- function
if tMapper.iAvalonRoomIDHandlerID then killAnonymousEventHandler(tMapper.iAvalonRoomIDHandlerID) end
tMapper.iAvalonRoomIDHandlerID = registerAnonymousEventHandler("AvalonRoomID", "tMapper.fAvalonRoomID")


tMapper.fAvalonInv = function (event,arg)
 tMapper.fDebug(event.." "..arg)
 if string.sub(arg,1,4) == "hier" then
  if tMapper then tMapper.fCheckRoom(tMapper.sHash) end
  centerview(tMapper.iID)
 end -- hier
end -- fun
if tMapper.iAvalonInvHandlerID then killAnonymousEventHandler(tMapper.iAvalonInvHandlerID) end
tMapper.iAvalonInvHandlerID = registerAnonymousEventHandler("AvalonInv", "tMapper.fAvalonInv")

tMapper.fFindAreaID = function(areaname)
  local returnid, fullareaname
	local list = getAreaTable()
  for area, id in pairs(list) do
    if area:find(areaname, 1, true) then
      if returnid then return false, "more than one area matches" end
      returnid = id; fullareaname = area
    end
  end
 return returnid, fullareaname
end

tMapper.fGoto = function(where)
local destinations = {}
if not tonumber( where ) then
	destinations = searchRoom( where )
	local _got_results = false;
	local i = 1
	for k,v in pairs(destinations) do
		_got_results = true;
		setFgColor(0,120,0)
		echo( "\n" .. i .. ". ");
		if tonumber( i%2 ) == 1 then
			setFgColor(0,250,0)
		else
			setFgColor(0,150,0)
		end
		echo( k .. " ( " )

		echoLink( v, [[expandAlias("goto ]]..tonumber(k)..[[")]], "click to auto walk", false)
		echo( " )" );
		i = i + 1
	end
	if not _got_results then
		setFgColor(0,250,0)
		echo("\nDie Bookmarksuche enthielt leider keine Treffer.\n")
	else
		echo("\n")
	end
else
	local _path = getPath(tMapper.iID, tonumber(where))
	if not _path then 
		cecho("<red>Leider keinen Weg gefunden\n")
	else
    tMapper.sMode = "Speedwalk"
		doSpeedWalk()
	end
end
end

tMapper.fCheckRoom = function(hash)
 local neighbor
 tMapper.iID = getRoomIDbyHash( hash ) or -1
 if tMapper.iID == -1 and tMapper.sMode and tMapper.sMode == "Map" then
  tMapper.fCreateRoom(hash) tMapper.iID = getRoomIDbyHash( hash )
 end-- Raum existiert noch nicht
 if tMapper.sMode and tMapper.sMode == "Map" then
   tMapper.iAreaID = addAreaName(tMapper.sArea)
   if tMapper.iAreaID == nil then
     tMapper.iAreaID = tMapper.fFindAreaID(tMapper.sArea)
   else 
     echo("Neues Gebiet " .. tMapper.sArea .. " mit ID " .. tMapper.iAreaID .." hinzugefuegt, ggfs Map Mode einschalten.\n")
     tMapper.bNewArea = true
   end
 if tMapper.iAreaID then setRoomArea(tMapper.iID, tMapper.iAreaID) end
 if tMapper.sSite then setRoomName(tMapper.iID,tMapper.sSite) end
 if tMapper.bMapRoom == true then
   tMapper.fDebug("Mapraum!")
   if tMapper.iTmpx ~= false and tMapper.iTmpy ~= false and tMapper.iZ ~= false then
	 tMapper.fDebug("Got Coordinates!")
     setGridMode(tMapper.iAreaID,true)
     if tMapper.iZOverwrite then tMapper.iZ = tMapper.iZOverwrite end
      setRoomCoordinates(tMapper.iID, tMapper.iTmpx, tMapper.iTmpy, tMapper.iZ)
	  tMapper.iX = tMapper.iTmpx tMapper.iY = tMapper.iTmpy
      --n = y+1
      neighbor = getRoomsByPosition(tMapper.iAreaID, tMapper.iX,tMapper.iY+1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "n"); setExit(tonumber(neighbor), tMapper.iID, "s");  end
      --no = x+1 y+1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX+1,tMapper.iY+1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "ne"); setExit(tonumber(neighbor), tMapper.iID, "sw");  end
      --o = x+1  
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX+1,tMapper.iY,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "e"); setExit(tonumber(neighbor), tMapper.iID, "w");  end
      --so x+1 y-1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX+1,tMapper.iY-1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "se"); setExit(tonumber(neighbor), tMapper.iID, "nw");  end
      --s = y-1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX,tMapper.iY-1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "s"); setExit(tonumber(neighbor), tMapper.iID, "n");  end
      --sw = y-1 x-1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX-1,tMapper.iY-1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "sw"); setExit(tonumber(neighbor), tMapper.iID, "ne");  end
      --w = x-1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX-1,tMapper.iY,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "w"); setExit(tonumber(neighbor), tMapper.iID, "e");  end
      --nw = x-1 y+1
      neighbor = getRoomsByPosition(tMapper.AreaID, tMapper.iX-1,tMapper.iY+1,0)[0]
      if neighbor then setExit(tMapper.iID, tonumber(neighbor), "nw"); setExit(tonumber(neighbor), tMapper.iID, "se");  end
	  end -- got coordinates
   if getRoomEnv(tMapper.iID) == -1 then
    if tMapper.sColor then setRoomEnv( tMapper.iID, tMapper.tFarben[tMapper.sColor] ) end
    if tMapper.sChar then setRoomChar( tMapper.iID, tMapper.sChar ) end
	 if tonumber(tMapper.Weg) ~= 1 then setRoomWeight(tMapper.iID,3) end
	
   end
	  else -- mapraum - kein Mapraum :)
		 tMapper.fDebug("Kein Mapraum, handle coordinates myself")
     
      if tMapper.bNewArea == false then
       tMapper.fDebug("Kein 0")
       lx,ly,lz = getRoomCoordinates(tMapper.iOldID)
       
       step = tMapper.tAreaLength[tMapper.sArea] or 3
       if tMapper.sArea == tMapper.sOldArea then
         tMapper.fDebug("Yea same Area")
         if player and player.lastMove then
         if player.lastMove == "n" then ly=ly+step end
         if player.lastMove == "no" then lx=lx+step ly=ly+step end
         if player.lastMove == "o" then lx=lx+step end
         if player.lastMove == "so" then lx=lx+step ly=ly-step end
         if player.lastMove == "s" then ly=ly-step end
         if player.lastMove == "sw" then lx=lx-step ly=ly-step end
         if player.lastMove == "w" then lx=lx-step fDebug("X:"..lx) end
	     if tMapper.lastMove == "nw" then lx=lx-step ly=ly+step end
         setRoomCoordinates(tMapper.iID,lx,ly,lz)
         tMapper.fDebug("POS: "..lx.." "..ly.." "..lz)
         end --last move vorhanden
       end -- same Area
       else -- aha new area !
       tMapper.fDebug("New Area 0 0 0 ")
       setRoomCoordinates(tMapper.iID,0,0,0)
       tMapper.bNewArea = false
       end
       local exits = string.split(tMapper.sExits,",")
    
       local i,dir,rid,rhash
for i = 1,#exits do
     dir,rhash = rex.match( exits[i], [[([a-z]+)=raum/([^ ]+)]] ) 
     rid = getRoomIDbyHash(rhash)
 		 if rid~=-1 then
		    echo("setExit("..tMapper.iID..","..rid..","..tMapper.tDirs[dir]..")\n")
				echo("setExit("..rid..","..tMapper.iID..","..tMapper.tOdirs[dir]..")\n")

        setExit(tMapper.iID,rid,tMapper.tDirs[dir])
				setExit(rid,tMapper.iID,tMapper.tOdirs[dir])
		else
				fMapperCreateRoom(rhash)
				rid = getRoomIDbyHash(rhash)
				setExit(tMapper.iID,rid,tMapper.tDirs[dir])
				setExit(rid,tMapper.iID,tMapper.tOdirs[dir])
				end
		 
		 if tMapper.sOldArea and tMapper.sArea and tMapper.sOldArea ~= tMapper.sArea then
		    -- Uebergang zwischen zwei Areas
       if dir == tMapper.tOdirs[player.lastMove] then
			  echo("BAEM\n")
				
				--setExit(tMapper.iID,-1,dirs[dir])
        --setExit(tMapper.iID,tMapper.OldID,dirs[dir])
				--setExit(tMapper.OldID,-1,odirs[dir])
				--setExit(tMapper.OldID,tMapper.iID,odirs[dir])
			 end
		 end	
end --for
			 if getRoomEnv(tMapper.iID) == -1 then
    if tMapper.sColor then setRoomEnv( tMapper.iID, tMapper.tFarben[tMapper.sColor] ) end
    if tMapper.sChar then setRoomChar( tMapper.iID, tMapper.sChar ) end
   end
	 local stubs = getExitStubs(tMapper.iID)
 
	if stubs then
    for i,v in pairs(stubs) do
    --connectExitStub(tMapper.iID, v)
  
	end
end
	 
	 
		 end -- else kein maproom
--else --raum existiert!
 local stubs = getExitStubs(tMapper.iID)
  if stubs then
    for i,v in pairs(stubs) do
    connectExitStub(tMapper.iID, v)
  end
end
	--end
end -- tMapper.Mode = Map
	centerview(tMapper.iID)
	end


tMapper.fCreateRoom = function(hash)
 local ID = createRoomID()
 setRoomIDbyHash( ID, hash )
 addRoom( ID )
 tMapper.fDebug("Neuer Raum "..hash.." mit ID "..ID.." hinzugefuegt.\n")
end
-- command queue enthaelt die Befehle und wird der reihe nach abgearbeitet
-- __cmd = {} command data structure of _cq commands
-- __cmd[__a] some command or Lua function
-- __cmd[__t] time interval before this command is being executed
-- __cmd[__c] some condition that must be met before the command is being delete otherwise it's repeated unless that is not wanted -> next arg 
-- __cmd[__r] repeat interval or 0 if the command is not supposed to be repeated until the condition is met

-- Entnommen aus Heikos Demo Automapper fuer Avalon.

function fCq()

	local time = getStopWatchTime("cq")

if _time_next_command == -1 and #_cq > 0 then 
	_time_next_command = _cq[#_cq].__t; 
end

if _time_next_command > -1 and __debug__ then 
	cecho("\n<red>time:"..time.." nextRunTime: ".._time_next_command) 
end

if time >= _time_next_command then
	if not pause_cq and #_cq > 0 then
		if not _waitingForCondition then
			stopStopWatch("cq")
			startStopWatch("cq")

			if type( _cq[#_cq].__a ) == "function" then 
				_cq[#_cq].__a();
			else
				--local _s = tostring(_cq[#_cq].__a);
				--send( _s );
				-- execute command scripts (prefixed with "script:" or send plain text commands
				local cmd = tostring(_cq[#_cq].__a)
				if string.find( cmd, "script:" ) == 1 then
					cmd = string.gsub( cmd, "script:", "" )
					loadstring( cmd )()
				else
					send( cmd );
				end
			end
			if _cq[#_cq].__c() then
				--cecho("\n<red>SYS: deleting command from queue conditon OK\n")
				table.remove(_cq, #_cq)
			else
				_waitingForCondition = true
				cecho("\n<red>SYS: NOT deleting command from queue conditon FALSE\n")
			end
			if #_cq > 0 then
				_time_next_command = _cq[#_cq].__t;
				cecho("<blue> setting time next command to: ".._time_next_command.."\n")
			else
				_time_next_command = -1
			end
		else
			if not _cq[#_cq].__c() and _cq[#_cq].__r > 0 then
				_cq[#_cq].__r = _cq[#_cq].__r - 1;
				stopStopWatch("cq")
				startStopWatch("cq")
				-- _time_next_command = _cq[#_cq].__t;
				if type(_cq[#_cq].__a) == "function" then 
					_cq[#_cq].__a();
				else
					-- execute command scripts (prefixed with "script:" or send plain text commands
					local cmd = tostring(_cq[#_cq].__a)
					local _w = string.find( cmd, "script:" ) 
echo("\n_w=".._w.."\n")
					if _w == 1 then
						cmd = string.gsub( cmd, "script:", "" )
						loadstring( cmd )()
					else
						send( cmd );
					end
				end
				if #_cq > 0 then
					_time_next_command = _cq[#_cq].__t;
					cecho("<blue> setting time next command to: ".._time_next_command.."\n")
				else
					_time_next_command = -1
          stopStopWatch("cq")
          resetStopWatch("cq")
				end
			else
				_waitingForCondition = false
				--cecho("\n<red>SYS: deleting command from queue conditon OK\n")
				table.remove(_cq, #_cq)
			end

		end

	end
end
	if #_cq == 0 then 
		_time_next_command = -1
          stopStopWatch("cq")
          resetStopWatch("cq")
	end
	if stop_cq then
		cecho("<red>[SYS]<green> stopping cq\n")
		disableTimer("CommandQueueTimer")
	end
end

-- command queue enthaelt die Befehle und wird der reihe nach abgearbeitet
-- __cmd = {} command data structure of _cq commands
-- __cmd[__a] somd command or Lua function
-- __cmd[__t] time interval before this command is being executed
-- __cmd[__c] some condition that must be met before the command is being delete otherwise it's repeated unless that is not wanted -> next arg 
-- __cmd[__r] repeat interval or 0 if the command is not supposed to be repeated until the condition is met

function addCommand( c, _t, __cond, __repeat )
	t = _t or 0.5
	_cond = __cond or function() return true end 
	_repeat = __repeat or 1
	__cmd = { __a=c, __t=t, __c=_cond, __r=_repeat }
	table.insert( _cq, 1, __cmd )
  startStopWatch("cq")
  --fDebug("addCommand!")
	--display(_cq)
end


function pauseCq()
	cecho("<red>[SYS]<green> pausing cq\n")
	pause_cq = true
end

function unpauseCq()
	cecho("<red>[SYS]<green> resuming cq\n")
	pause_cq = false
end

function stopCq()
	stop_cq = true
	cecho("<red>[SYS]<green> stop cq\n")
  disableTimer("CommandQueueTimer")
end

function clearCq()
	cecho("<red>[SYS]<green> clear cq\n")
	_cq = {}
end
