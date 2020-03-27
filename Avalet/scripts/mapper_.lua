	tRoom.tExclude = {"Racheengel","Abscheulichkeit","Lich","Luftvortex","Schwarm von Lichtwesen"}
	tRoom.sHash = ""
	tRoom.tObject={}
	tRoom.tPlayer={}
	tRoom.tMobs={}
	tRoom.tLocations = {
		"Haus Walhalla/a86ce95c7f971df51db1d15b3f461492",
		"Hafen Affenkopf/692ec42948d7aad6c261e86fe1234164",
		"DhungarUW/ea6e4bf47829217cddc775896ba171d0",
		"Minias/1363d90eb536ec54b8e893d46d73a598",
		"Teich/42b0bf70c4cc2757c0f43a24eb522944",
		"Gilde Nekros/198922fbdadb5a8af28604fabc411b6b",
		"Gilde Gk/623a821fe2e3522c038e5c1a6ace1547",
		"Hafen Amphibos/33629ffcefb2c08a5300379e03ca1d78",
		"Hafen Holbytla/63ab4d672c1bb5fbac5bc23f3b31396b",
		"Ashar Kneipe/107e0608db24dee1136396c8ef609310",
		"Druidenhain/975c9d2e133fdcbb68e2b170e0b6b52d",
		"Tiefebene/94d8ac47e171a4d4622c4bf49fda53c8",
		"Burg Losaria/3ad9d9e430091b746159a1f2f9b0a85a",
		"Droloff/1ba559412b6b5fbd0c3eb0c0eb36a1ba",
	}






		<TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
			<name>Mapper</name>
			<script></script>
			<triggerType>0</triggerType>
			<conditonLineDelta>0</conditonLineDelta>
			<mStayOpen>0</mStayOpen>
			<mCommand></mCommand>
			<packageName></packageName>
			<mFgColor>#ff0000</mFgColor>
			<mBgColor>#ffff00</mBgColor>
			<mSoundFile></mSoundFile>
			<colorTriggerFgColor>#000000</colorTriggerFgColor>
			<colorTriggerBgColor>#000000</colorTriggerBgColor>
			<regexCodeList />
			<regexCodePropertyList />
			<TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Weg Scripte</name>
				<script></script>
				<triggerType>0</triggerType>
				<conditonLineDelta>99</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList />
				<regexCodePropertyList />
				<TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
					<name>Transportkorb Dhungar</name>
					<script></script>
					<triggerType>0</triggerType>
					<conditonLineDelta>0</conditonLineDelta>
					<mStayOpen>0</mStayOpen>
					<mCommand></mCommand>
					<packageName></packageName>
					<mFgColor>#ff0000</mFgColor>
					<mBgColor>#ffff00</mBgColor>
					<mSoundFile></mSoundFile>
					<colorTriggerFgColor>#000000</colorTriggerFgColor>
					<colorTriggerBgColor>#000000</colorTriggerBgColor>
					<regexCodeList>
						<string>return wege_aufzug_dhungar</string>
					</regexCodeList>
					<regexCodePropertyList>
						<integer>4</integer>
					</regexCodePropertyList>
					<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="yes" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
						<name>in Aufzug einsteigen</name>
						<script>send("s")</script>
						<triggerType>0</triggerType>
						<conditonLineDelta>99</conditonLineDelta>
						<mStayOpen>0</mStayOpen>
						<mCommand></mCommand>
						<packageName></packageName>
						<mFgColor>#ff0000</mFgColor>
						<mBgColor>#ffff00</mBgColor>
						<mSoundFile></mSoundFile>
						<colorTriggerFgColor>#000000</colorTriggerFgColor>
						<colorTriggerBgColor>#000000</colorTriggerBgColor>
						<regexCodeList>
							<string>Der Transportkorb kommt.*und haelt hier an</string>
						</regexCodeList>
						<regexCodePropertyList>
							<integer>1</integer>
						</regexCodePropertyList>
					</Trigger>
					<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="yes" isPerlSlashGOption="no" isColorizerTrigger="yes" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
						<name>ebenen detektor</name>
						<script>-- ebene 0: eaf3d4f246bbec252b66f83b2b75d52b
-- ebene 1: e004dda09968e9a63464ea2191c6cede
-- ebene 2: 7380c211fa363daa4ea79a849a74027a
-- ebene 3: 62733b0fc85683d590345e3ba8fe9bcc

warte_aufzug_aktuelle_ebene = tonumber( multimatches[2][2] )

cecho("&lt;red&gt;Transportkorb: ebene:".. warte_aufzug_aktuelle_ebene .."\n")


</script>
						<triggerType>0</triggerType>
						<conditonLineDelta>1</conditonLineDelta>
						<mStayOpen>0</mStayOpen>
						<mCommand></mCommand>
						<packageName></packageName>
						<mFgColor>#ff0000</mFgColor>
						<mBgColor>#ffff00</mBgColor>
						<mSoundFile></mSoundFile>
						<colorTriggerFgColor>#000000</colorTriggerFgColor>
						<colorTriggerBgColor>#000000</colorTriggerBgColor>
						<regexCodeList>
							<string>Du wirfst einen Blick auf die in den Stein eingelassene Zahl und stellst</string>
							<string>^fest, dass Du auf Ebene (\d) bist</string>
						</regexCodeList>
						<regexCodePropertyList>
							<integer>2</integer>
							<integer>1</integer>
						</regexCodePropertyList>
						<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
							<name>aussteigen</name>
							<script>cecho("&lt;red&gt; Ziel erreicht steige aus (Ebene:" .. warte_aufzug_aktuelle_ebene .. "\n")
warte_aufzug_ebene = -1
wege_aufzug_dhungar=false
send("n")</script>
							<triggerType>0</triggerType>
							<conditonLineDelta>0</conditonLineDelta>
							<mStayOpen>0</mStayOpen>
							<mCommand></mCommand>
							<packageName></packageName>
							<mFgColor>#ff0000</mFgColor>
							<mBgColor>#ffff00</mBgColor>
							<mSoundFile></mSoundFile>
							<colorTriggerFgColor>#000000</colorTriggerFgColor>
							<colorTriggerBgColor>#000000</colorTriggerBgColor>
							<regexCodeList>
								<string>if warte_aufzug_ebene == warte_aufzug_aktuelle_ebene then return true else return false end</string>
							</regexCodeList>
							<regexCodePropertyList>
								<integer>4</integer>
							</regexCodePropertyList>
						</Trigger>
					</Trigger>
				</TriggerGroup>
				<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="yes" isPerlSlashGOption="no" isColorizerTrigger="yes" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
					<name>Aufzug Dhungar Ebenen erkennen</name>
					<script>local _ebene = tonumber( multimatches[2][2] )
__mapper_room_z = _ebene - 1
cecho("&lt;red&gt;neue z-ebene="..__mapper_room_z.."\n")
</script>
					<triggerType>0</triggerType>
					<conditonLineDelta>1</conditonLineDelta>
					<mStayOpen>0</mStayOpen>
					<mCommand></mCommand>
					<packageName></packageName>
					<mFgColor>#ff0000</mFgColor>
					<mBgColor>#ffff00</mBgColor>
					<mSoundFile></mSoundFile>
					<colorTriggerFgColor>#000000</colorTriggerFgColor>
					<colorTriggerBgColor>#000000</colorTriggerBgColor>
					<regexCodeList>
						<string>Du wirfst einen Blick auf die in den Stein eingelassene Zahl und stellst</string>
						<string>^fest, dass Du auf Ebene (\d) bist</string>
					</regexCodeList>
					<regexCodePropertyList>
						<integer>2</integer>
						<integer>1</integer>
					</regexCodePropertyList>
				</Trigger>
			</TriggerGroup>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>SesamOeffneDich</name>
				<script>local tuer = matches[2]
if tuer == "Hafengatter" then tuer = "gatter" end
send("oeffne "..tuer)
if tMapper and tMapper.Mode and tMapper.Mode == "Speedwalk" then continueSpeedWalk(); end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>^Dort versperrt Dir ein (Tor) den Weg\.$</string>
					<string>^Da ist Dir doch das (Tor) im Weg</string>
					<string>^Dort versperrt Dir eine (Pforte|Tuer) den Weg\.$</string>
					<string>^Die (Zaunpforte) ist geschlossen und versperrt Dir folglich den Weg\.$</string>
					<string>^Solange das (Hafengatter) geschlossen ist\, kommst Du nicht durch\.$</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>1</integer>
					<integer>1</integer>
					<integer>1</integer>
					<integer>1</integer>
					<integer>1</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Corona Steintuer</name>
				<script>if tRoom.Hash == "ddb0a07ccaf07cd5617ba697c763e8b1" and tRoom.OldHash and tRoom.OldHash == "d40620bc448ec9ef50da45c8669d08a3" then send("s") end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>Wie von Geisterhand oeffnet sich die suedliche Steintuer.</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Ashar Tor</name>
				<script>if tPlayer.sLastMoveDirection == "o" or tPlayer.sLastMoveDirection == "osten" then 
 tempTimer( 2.0, [[send("osten")]] )
else
tempTimer( 2.0, [[send("sueden")]] )
end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand>sag hi;sag hi;sag hi;sag hi;sag hi;sag hi</mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>Du versuchst in die Stadt zu gelangen, doch die</string>
					<string>Die untersetzte Stadtwache packt Dich am Kragen.</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Beinbruch</name>
				<script>unpauseCq()
if tMapper and tMapper.Mode and tMapper.Mode == "Speedwalk" then continueSpeedWalk(); end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>Du kannst Deine Beine wieder bewegen.</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Beinbruch1</name>
				<script>if tMapper then pauseCq() end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>In einem unkonzentrierten Moment kommst Du ins Trudeln und stolperst</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Matrosenfesthalten</name>
				<script>if tMapper and tMapper.Mode and tMapper.Mode == "Speedwalk" then tempTimer(1.0, [[continueSpeedWalk()]]) end
</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>0</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>Obwohl Du herumzappelst wie ein Wilder, kannst Du Dich nicht von der</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="yes" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Matrose_geht</name>
				<script>if tMapper and tMapper.Mode == "Speedwalk" then
continueSpeedWalk();
end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>1</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>Der Matrose winkt Dir zum Abschied zu.</string>
					<string>Der Matrose entfernt sich.</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>2</integer>
					<integer>2</integer>
				</regexCodePropertyList>
			</Trigger>
		</TriggerGroup>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<ScriptGroup isActive="yes" isFolder="yes">
			<name>Mapper</name>
			<packageName></packageName>
			<script>-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external Scripts --
-------------------------------------------------
</script>
			<eventHandlerList />
			<Script isActive="yes" isFolder="no">
				<name>AvalonSpecialRooms</name>
				<packageName></packageName>
				<script>-- Wird aufgerufen wenn wir den roomhash ueber atcp bekommen

AvalonSpecialRooms = function (event,arg)

if tMapper.Mode == "Walk" then

if tRoom.Hash then

--- die hashes der Sitem Rooms einbauen MUHAHAHAHA


-- Miobaas Park autobeerenpfluecken
if tRoom.Hash =="e62e039cde5f8ea5dd20ca32101dcbf6" or tRoom.Hash =="7022178fa7833f5a7d18fbeaee462266" or tRoom.Hash =="36cc197118693a9a058f1a7665d25734" or tRoom.Hash =="cea8530fd220fa75ddef7f8d87f9a1d9"then
  sendAll("pfluecke beere","pfluecke beere","pfluecke beere")
 end

 -- Losaria Mondschwert Burgmauer
 if tRoom.Hash =="93286c0e5afe923a155f79e7a504078b" then
  sendAll("b moos","kratze moos","druecke knopf")
 end
 -- Losaria Mondschwert Bohlen
 if tRoom.Hash =="01c771cac01af7093b49cbf1aa650625" then
  sendAll("b boden","b bohlen","unt bohlen","ziehe bohle")
 end


  --Wallhalla Teich
  if tRoom.Hash == "718b91f6b42e217f3640b8ce2ffbeb18" then
   -- von oben kommend auftauchen
    if tRoom.OldHash and (tRoom.OldHash == "9a6882a633b65265bb5d8c2637d2844e" or tRoom.OldHash =="1ce8e224cb171cedaf855267d41dfc27") then send("tauche auf") end
    -- von land durch portal tauchen
    if tRoom.OldHash and tRoom.OldHash == "42b0bf70c4cc2757c0f43a24eb522944" then send("tauche portal") end
  end -- wallateich
	
 -- Corona Eingang
 if tRoom.Hash == "ddb0a07ccaf07cd5617ba697c763e8b1" then 
 if tRoom.OldHash and tRoom.OldHash == "d40620bc448ec9ef50da45c8669d08a3" then sendAll("sag freund") end
 if tRoom.OldHash and tRoom.OldHash == "0a259e2ce66b7105bdf416cf0ae128fb" then send("raus") end
 end -- corona


---------------- Raeume von Spielen -----------------------------

if tRoom.Hash == "d0b87f8e51ca18721228a12723856d9e" and tSpiel.aktiv == "Apfelhaufen" then send("sag will spielen riemann") end


----------------- Raeume von Raetseln ---------------------------






end -- if roomhahs
end -- if walkmode
end -- function</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperInit</name>
				<packageName></packageName>
				<script>fMapperInit = function ()
local i,v,k
tMapper = tMapper or {}
mudlet = mudlet or {}; mudlet.mapper_script = true
tMapper.MapBox = Geyser.Label:new({ name = "MapBox", x = -740, y = 0 ,width = 740 , height = 420})
tMapper.MapBox:setStyleSheet(LabelCSS:getCSS())
tMapper.Mapper = Geyser.Mapper:new({ name = "Mapper",x = -380, y = 5, width = 375, height = 320})

--tMapper.Container = Geyser.Container:new({x=-740,y=0,width="740",height="420",name="tMapperContainer"})
--tMapper.mapper = Geyser.Mapper:new({name = "mapper",x = 5, y = 5, width = 730, height = 405}, tMapper.Container)
tMapper.Mapper:setColor(0, 0, 0)

 tMapper.RaumBox = Geyser.Label:new({ name = "MapperRaumBox", x = 360, y = 328 ,width = 395 , height = 84},tMapper.MapBox)
 tMapper.RaumBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;qproperty-wordWrap: true;]])

 tMapper.ObjectBox = Geyser.Label:new({ name = "MapperObjectBox", x = 235, y = 5 ,width = 110 , height = 405},tMapper.MapBox)
 tMapper.ObjectBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;qproperty-wordWrap: true;qproperty-alignment: 'AlignLeft | AlignTop';]])

tMapper.PlayerBox = Geyser.Label:new({ name = "MapperPlayerBox", x = 120, y = 5 ,width = 110 , height = 405},tMapper.MapBox)
tMapper.PlayerBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;qproperty-wordWrap: true;qproperty-alignment: 'AlignLeft | AlignTop';]])
--tMapper.PlayerBox:setStyleSheet([[background-color: blue;qproperty-wordWrap: true;qproperty-alignment: 'AlignLeft | AlignTop';]])

tMapper.MobBox = Geyser.Label:new({ name = "MapperMobBox", x = 5, y = 5 ,width = 110 , height = 405},tMapper.MapBox)
tMapper.MobBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;qproperty-wordWrap: true;qproperty-alignment: 'AlignLeft | AlignTop';]])
--tMapper.MobBox:setStyleSheet([[background-color: green;qproperty-wordWrap: true;qproperty-alignment: 'AlignLeft | AlignTop';]])

setWindowWrap("MapperMobBox", 15)

tMapper.Farben = { MAP_RED=257, MAP_GREEN=258, MAP_YELLOW=259, MAP_BLUE=260, MAP_MAGENTA=261, MAP_CYAN=262, MAP_WHITE=263, MAP_BLACK=264, MAP_HI_RED=265, MAP_HI_GREEN=266, MAP_HI_YELLOW=267, MAP_HI_BLUE=268, MAP_HI_MAGENTA=269, MAP_HI_CYAN=270, MAP_HI_WHITE=271, MAP_HI_BLACK=272 }

--default steplenght - in nicht mapraeumen 3 (createRoom()) ansonsten hier setzen :)
tMapper.AreaLength = { Miobaas=6, Ashar=6, Nereid=1, Losaria = 1}

tMapper.Mode = "Walk"
--fMapperLocationsInit()

dirs={n="n",no="ne",o="e",so="se",s="s",sw="sw",w="w",nw="nw",h="u",ru="d",ra="out"}
odirs={n="s",no="sw",o="w",so="nw",s="n",sw="nw",w="e",nw="se",h="d",ru="u",ra="in"}

stop_cq = false
pause_cq = false
_waitingForCondition = false


_cq = {} -- command queue enthaelt die Befehle und wird der reihe nach abgearbeitet
-- __cmd = {} command data structure of _cq commands
-- __cmd[__a] somd command or Lua function
-- __cmd[__t] time interval before this command is being executed
-- __cmd[__c] some condition that must be met before the command is being delete otherwise it's repeated unless that is not wanted -&gt; next arg 
-- __cmd[__r] repeat interval or 0 if the command is not supposed to be repeated until the condition is met
cq_timer_id = cq_timer_id or 0;

_cq_StopWatch = createStopWatch(); 
startStopWatch(_cq_StopWatch)
_time_next_command = -1
processCq()	-- starte command queue
end


fMapBoxUpdate = function()
local fontcolor,x,y,z
fontcolor = "cyan"

if tRoom.tObject then
output = [[&lt;font color="white"&gt;Objekte:&lt;br&gt;&lt;font color="cyan"&gt;]]
 for i=1,#tRoom.tObject do
 output = output..tRoom.tObject[i][2]:title().."&lt;br&gt;"
 --if i&lt;#tRoom.tObject then output = output.."," else output = output.."." end
 end
  tMapper.ObjectBox:echo([[&lt;b&gt;]]..output)
resetFormat()
end -- objects

if tRoom.tPlayer then
output = [[&lt;font color="white"&gt;Spieler:&lt;br&gt;&lt;font color="cyan"&gt;]]
 for i=1,#tRoom.tPlayer do
 output = output..tRoom.tPlayer[i][2]:title().."&lt;br&gt;"
 --if i&lt;#tRoom.tPlayer then output = output..", " else output = output.."." end
 end
  tMapper.PlayerBox:echo([[&lt;p style="font-size:12px"&gt;&lt;b&gt;&lt;font color="cyan"&gt;]]..output)
resetFormat()
end -- Player


if tRoom.tMobs then
output = [[&lt;font color="white"&gt;Mobs:&lt;br&gt;&lt;font color="cyan"&gt;]]
 for i=1,#tRoom.tMobs do
 output = output..tRoom.tMobs[i][2]:title().."&lt;br&gt;"
 --if i&lt;#tRoom.tMobs then output = output..", " else output = output.."." end
 end
  tMapper.MobBox:echo([[&lt;p style="font-size:12px"&gt;&lt;b&gt;&lt;font color="cyan"&gt;]]..output)
resetFormat()
end -- Mobs


output =""
if tMapper and tMapper.Mode and tMapper.Mode == "Map" then fontcolor = "Red" end
if tMapper and tMapper.Mode and tMapper.Mode == "Speedwalk" then fontcolor = "Green" end

if tRoom.Hash and tRoom.Hash ~= -1 then output = output .. [[&lt;font color="white"&gt;Hsh: &lt;font color=]]..fontcolor..[[&gt;]]..tRoom.Hash ..[[&lt;br&gt;]]end
if tRoom.ID and tRoom.ID ~="" then output = output .. [[&lt;font color="white"&gt;RoomID: &lt;font color=]]..fontcolor..[[&gt;]]..tRoom.ID end
if tRoom.AreaName and tRoom.AreaName ~= "" then output = output ..[[&lt;font color="white"&gt;&amp;nbsp;&amp;nbsp;Area:&lt;font color=]]..fontcolor..[[&gt; ]]..tRoom.AreaName end
if tPlayer.sLastMoveDirection and tPlayer.sLastMoveDirection ~="" then output = output .. [[&lt;font color="white"&gt;&amp;nbsp;&amp;nbsp;Last: &lt;font color=]]..fontcolor..[[&gt;]]..tPlayer.sLastMoveDirection end
output = output .. [[&lt;br&gt;]]
if tRoom.ID and tRoom.ID ~=-1 then x,y,z = getRoomCoordinates(tRoom.ID) else x,y,z = nil end

if tRoom.tmpx and tRoom.tmpy then
x = tRoom.tmpx
y = tRoom.tmpy
z = 0
end
if x and y and z then
output = output .. [[&lt;font color="white"&gt;Pos: &lt;font color=]]..fontcolor..[[&gt;]]..x..[[&lt;font color="white"&gt;/&lt;font color=]]..fontcolor..[[&gt;]]..y..[[&lt;font color="white"&gt;/&lt;font color=]]..fontcolor..[[&gt;]]..z..[[&lt;br&gt;]] 
end

if tRoom.Site and tRoom.Site ~= -1 then output = output .. [[&lt;font color="white"&gt;Site: &lt;font color=]]..fontcolor..[[&gt;]]..tRoom.Site..[[&lt;br&gt;]] end
if tRoom.Brief and tRoom.Brief ~= "" then output = output ..[[&lt;font color="white"&gt;Kurz: &lt;font color=]]..fontcolor..[[&gt;]]..tRoom.Brief..[[&lt;br&gt;]] end
if tMapper and tMapper.Mode then output = output ..[[&lt;font color="white"&gt;Mode:&lt;font color=]]..fontcolor..[[&gt; ]]..tMapper.Mode..[[&lt;br&gt;]];end

tMapper.RaumBox:echo([[&lt;p style="font-size:12px"&gt;&lt;b&gt;&lt;font color="]]..fontcolor..[["&gt;]]..output)--

end

</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperFindAreaID</name>
				<packageName></packageName>
				<script>fMapperFindAreaID = function(areaname)
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
</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperCreateRoom</name>
				<packageName></packageName>
				<script>fMapperCreateRoom = function(hash)
 local ID = createRoomID()
 setRoomIDbyHash( ID, hash )
 addRoom( ID )
 --fEcho("Neuer Raum "..hash.." mit ID "..ID.." hinzugefuegt.\n")
end
</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperCheckRoom</name>
				<packageName></packageName>
				<script>fMapperCheckRoom = function(hash)
local neighbor
local dirs={n="n",no="ne",o="e",so="se",s="s",sw="sw",w="w",nw="nw",h="u",ru="d",ra="out"}
local odirs={n="s",no="sw",o="w",so="nw",s="n",sw="nw",w="e",nw="se",h="d",ru="u",ra="in"}

  tRoom.ID = getRoomIDbyHash( tRoom.Hash ) or -1
	
  if tRoom.ID == -1 and tMapper.Mode and tMapper.Mode == "Map" then fMapperCreateRoom(hash) tRoom.ID = getRoomIDbyHash( tRoom.Hash ) end-- Raum existiert noch nicht
	
	  if tMapper.Mode and tMapper.Mode == "Map" then
		if tRoom.AreaID then setRoomArea(tRoom.ID, tRoom.AreaID) end
		if tRoom.Site then setRoomName(tRoom.ID,tRoom.Site) end
    if tRoom.MapRoom == true then
		--fEcho("Mapraum!")
      if tRoom.tmpx ~= false and tRoom.tmpy ~= false and tRoom.z ~= false then
			--fEcho("Got Coordinates!")
      if tRoom.zOverwrite then setRoomCoordinates(tRoom.ID, tRoom.tmpx, tRoom.tmpy, tRoom.zOverwrite) else setRoomCoordinates(tRoom.ID, tRoom.tmpx, tRoom.tmpy, tRoom.z) end
			tRoom.x = tRoom.tmpx tRoom.y = tRoom.tmpy
      --n = y+1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x,tRoom.y+1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "n"); setExit(tonumber(neighbor), tRoom.ID, "s");  end
      --no = x+1 y+1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x+1,tRoom.y+1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "ne"); setExit(tonumber(neighbor), tRoom.ID, "sw");  end
      --o = x+1  
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x+1,tRoom.y,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "e"); setExit(tonumber(neighbor), tRoom.ID, "w");  end
      --so x+1 y-1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x+1,tRoom.y-1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "se"); setExit(tonumber(neighbor), tRoom.ID, "nw");  end
      --s = y-1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x,tRoom.y-1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "s"); setExit(tonumber(neighbor), tRoom.ID, "n");  end
      --sw = y-1 x-1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x-1,tRoom.y-1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "sw"); setExit(tonumber(neighbor), tRoom.ID, "ne");  end
      --w = x-1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x-1,tRoom.y,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "w"); setExit(tonumber(neighbor), tRoom.ID, "e");  end
      --nw = x-1 y+1
      neighbor = getRoomsByPosition(tRoom.AreaID, tRoom.x-1,tRoom.y+1,0)[0]
      if neighbor then setExit(tRoom.ID, tonumber(neighbor), "nw"); setExit(tonumber(neighbor), tRoom.ID, "se");  end
	  end -- got coordinates
   if getRoomEnv(tRoom.ID) == -1 then
    if tRoom.Color then setRoomEnv( tRoom.ID, tMapper.Farben[tRoom.Color] ) end
    if tRoom.Char then setRoomChar( tRoom.ID, tRoom.Char ) end
   --if tonumber(tRoom.Weg) ~= 1 then setRoomWeight(tRoom.ID,3) fEcho("Kein Weg, Weight 3") else fEcho(" Weg, Weight 1") end
	 if tonumber(tRoom.Weg) ~= 1 then setRoomWeight(tRoom.ID,3) end
	
   end
	  else -- mapraum - kein Mapraum :)
		 fEcho("Kein Mapraum, handle coordinates myself")
      local lx,ly,lz = getRoomCoordinates(tRoom.OldID) 
       local step = tMapper.AreaLength[tRoom.AreaName] or 3
       if tRoom.AreaName == tRoom.OldAreaName then
         if tPlayer.sLastMoveDirection == "n" then setRoomCoordinates(tRoom.ID, lx, ly+step, lz) end
         if tPlayer.sLastMoveDirection == "no" then setRoomCoordinates(tRoom.ID, lx+step, ly+step, lz) end
         if tPlayer.sLastMoveDirection == "o" then setRoomCoordinates(tRoom.ID, lx+step, ly, lz) end
         if tPlayer.sLastMoveDirection == "so" then setRoomCoordinates(tRoom.ID, lx+step, ly-step, lz) end
         if tPlayer.sLastMoveDirection == "s" then setRoomCoordinates(tRoom.ID, lx, ly-step, lz) end
         if tPlayer.sLastMoveDirection == "sw" then setRoomCoordinates(tRoom.ID, lx-step, ly-step, lz) end
         if tPlayer.sLastMoveDirection == "w" then setRoomCoordinates(tRoom.ID, lx-step, ly, lz) end
	       if tPlayer.sLastMoveDirection == "nw" then setRoomCoordinates(tRoom.ID, lx-step, ly+step, lz) end
       end -- same Area
			 
       local exits = string.split(tRoom.exits,",")
       --display(exits)
       local i,dir,rid,rhash
for i = 1,#exits do
     dir,rhash = rex.match( exits[i], [[([a-z]+)=raum/([^ ]+)]] ) 
     rid = getRoomIDbyHash(rhash)
 		 if rid~=-1 then
		    echo("setExit("..tRoom.ID..","..rid..","..dirs[dir]..")\n")
				echo("setExit("..rid..","..tRoom.ID..","..odirs[dir]..")\n")

        setExit(tRoom.ID,rid,dirs[dir])
				setExit(rid,tRoom.ID,odirs[dir])
		else
				fMapperCreateRoom(rhash)
				rid = getRoomIDbyHash(rhash)
				setExit(tRoom.ID,rid,dirs[dir])
				setExit(rid,tRoom.ID,odirs[dir])
				end
		 
		 if tRoom.OldAreaName and tRoom.AreaName and tRoom.OldAreaName ~= tRoom.AreaName then
		    -- Uebergang zwischen zwei Areas
       if dir == odirs[sLastMoveDirection] then
			  echo("BAEM\n")
				
				--setExit(tRoom.ID,-1,dirs[dir])
        --setExit(tRoom.ID,tRoom.OldID,dirs[dir])
				--setExit(tRoom.OldID,-1,odirs[dir])
				--setExit(tRoom.OldID,tRoom.ID,odirs[dir])
			 end
		 end	
end --for
			 if getRoomEnv(tRoom.ID) == -1 then
    if tRoom.Color then setRoomEnv( tRoom.ID, tMapper.Farben[tRoom.Color] ) end
    if tRoom.Char then setRoomChar( tRoom.ID, tRoom.Char ) end
   end
	 local stubs = getExitStubs(tRoom.ID)
  --display(stubs)
	if stubs then
    for i,v in pairs(stubs) do
    --connectExitStub(tRoom.ID, v)
  
	end
end
	 
	 
		 end -- else kein maproom
--else --raum existiert!
 local stubs = getExitStubs(tRoom.ID)
  if stubs then
    for i,v in pairs(stubs) do
    connectExitStub(tRoom.ID, v)
  end
end
	--end
end -- tMapper.Mode = Map
	centerview(tRoom.ID)
	end
</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperLocationsInit</name>
				<packageName></packageName>
				<script>fMapperLocationsInit = function()
local id,v,k,i,j,id2
tMapper = tMapper or {}

-- SE = Special Exit, E = Exit ( achtung, englische richtungen e fuer osten, down, up fuer hochrunter)
tMapper.SpecialLocations = {
--{name = "",hash =""},
--{name = "", hash ="", area = "", E={{hash = "", ziel = [[n]]},},},

-- todesraum der elfen raum/22726fcd7a203b9078a9632dfb4fb440 irgendwo" In einer Drachenhoehle - &gt; "raum/05fecc6ba96eabbe071d9178114f0eb4 Ilmelorn"
-- Bleiente: b4294fe18d016b465f8a35f00d2e43bb Schiffe" AvalonSite = Schiff Bleiente,Schiff,Bleiente

{name = "Alotria Nordtor1", hash ="27aafa0f474dd1f7589cd93fe04e97ee", area = "Nereid", E={{hash = "e3aee6f4930ac6684152e3066ec5f8d2", ziel = [[s]]},},},
{name = "Alotria Nordtor2", hash ="e3aee6f4930ac6684152e3066ec5f8d2", area = "Alotria", E={{hash = "27aafa0f474dd1f7589cd93fe04e97ee", ziel = [[n]]},},},
{name = "Alotria Westtor1", hash ="e4fdca13e0ce2426c14221923d632606", area = "Nereid", E={{hash = "044f4707386e07ea2e5692fe13a219b2", ziel = [[e]]},},},
{name = "Alotria Westtor2", hash ="044f4707386e07ea2e5692fe13a219b2", area = "Alotria", E={{hash = "e4fdca13e0ce2426c14221923d632606", ziel = [[w]]},},},

{name = "Ashar Westtor",hash ="73ac2a2750e36f05acc92bace3cd6eba", E={{hash = "c533453f062b25bffaee9dab634619e7", ziel = [[e]]},},},
{name = "Ashar Westtor2",hash ="c533453f062b25bffaee9dab634619e7", E={{hash = "73ac2a2750e36f05acc92bace3cd6eba", ziel = [[w]]},},},
{name = "Ashar Nordtor",hash ="0e88b5bc7e8fb99c9ad6648af2cc6bbb", E={{hash = "0ecb04ef8d9947bc7a2f6fa12fb7bc1d", ziel = [[s]]},},},
{name = "Ashar Nordtor2",hash ="0ecb04ef8d9947bc7a2f6fa12fb7bc1d", E={{hash = "0e88b5bc7e8fb99c9ad6648af2cc6bbb", ziel = [[n]]},},},

{name = "Bauernhof Eingang", hash ="dc079ccd118639e80ab82f9a9c777177", area = "Bauernhof", E={{hash = "019b840e0dd29a3a78616585d499b46a", ziel = [[s]]},},},
{name = "Bauernhof Eingang2", hash ="019b840e0dd29a3a78616585d499b46a", area = "Nereid", E={{hash = "dc079ccd118639e80ab82f9a9c777177", ziel = [[n]]},},},

{name = "Raetselhallen Eingang", hash ="40c1974596801ffd899953d669faae0a", area = "Raetselhallen", E={{hash = "641df4a23f46d1086ad11419f400c40e", ziel = [[sw]]},},},
{name = "Raetselhallen Eingang2", hash ="641df4a23f46d1086ad11419f400c40e", area = "Nereid", E={{hash = "40c1974596801ffd899953d669faae0a", ziel = [[ne]]},},},

{name = "Corona1",hash ="ddb0a07ccaf07cd5617ba697c763e8b1",area="Corona",
            SE={{hash = "d40620bc448ec9ef50da45c8669d08a3", ziel = [[raus]]},
						{hash = "0a259e2ce66b7105bdf416cf0ae128fb", ziel = [[sag freund]]},},},
{name = "Corona2",hash ="d40620bc448ec9ef50da45c8669d08a3",area="Corona",
            SE={{hash = "ddb0a07ccaf07cd5617ba697c763e8b1", ziel = [[betrete hoehle]]},},},
{name = "CoronaAusgang",hash ="0a259e2ce66b7105bdf416cf0ae128fb",area="Corona", E={{hash = "ddb0a07ccaf07cd5617ba697c763e8b1", ziel = [[n]]},},},


{name = "Dhungar Uwzugang1",hash ="ea6e4bf47829217cddc775896ba171d0",area="Dhungar",SE={{hash = "3399a4ad659c3e478a13ab13c10c3a03", ziel = [[script:uwzugang1()]]},},},
{name = "Dhungar Uwzugang2",hash ="8fb3743530d80112dd741b994bab34d5",area="Dhungar", E={ {hash = "d858ec628dcb427858ee0004ef6ebf08", ziel = [[up]]},
                                                                                         {hash = "7e8e54c3bd128dc802f8643fcd92fb4a", ziel = [[w]]},},},
{name = "Dhungar Uwzugang3",hash ="7e8e54c3bd128dc802f8643fcd92fb4a",area="Dhungar", E={ {hash = "8fb3743530d80112dd741b994bab34d5", ziel = [[e]]},
                                                                                         {hash = "7a2fd4857f5874ed6b95d39a6e2cdbd9", ziel = [[s]]},},},
{name = "Dhungar Uwzugang4",hash ="7a2fd4857f5874ed6b95d39a6e2cdbd9",area="Dhungar", SE={{hash = "1764696492d443b64f23faa9d3f4b9f9", ziel = [[script:uwzugang3w()]]},
                                                                                         {hash = "7e8e54c3bd128dc802f8643fcd92fb4a", ziel = [[script:uwzugang3n()]]},},},
{name = "Dhungar Uwzugang5",hash ="1764696492d443b64f23faa9d3f4b9f9",area="Dhungar", E={ {hash = "7a2fd4857f5874ed6b95d39a6e2cdbd9", ziel = [[e]]},
                                                                                         {hash = "f993d061de9fbda79362acd2ff18835c", ziel = [[s]]},},},
{name = "Dhungar Uwzugang6",hash ="f993d061de9fbda79362acd2ff18835c",area="Dhungar", E={ {hash = "1764696492d443b64f23faa9d3f4b9f9", ziel = [[n]]},
                                                                                         {hash = "2eff0dc2a996c96be2d2d8699ee7cce5", ziel = [[s]]},},},
{name = "Dhungar Uwzugang7",hash ="2eff0dc2a996c96be2d2d8699ee7cce5",area="Dhungar", E={ {hash = "3399a4ad659c3e478a13ab13c10c3a03", ziel = [[sw]]},
                                                                                         {hash = "f993d061de9fbda79362acd2ff18835c", ziel = [[n]]},},},																																										 
																																												 
{name = "Dhungar E0",hash ="5dfe55b0c8d769e865fd85ba63127fbc",area="Dhungar",
            SE={{hash = "e004dda09968e9a63464ea2191c6cede", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=1]]},
               {hash = "7380c211fa363daa4ea79a849a74027a", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=2]]},
               {hash = "62733b0fc85683d590345e3ba8fe9bcc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=3]]},},},
{name = "Dhungar E1",hash ="e004dda09968e9a63464ea2191c6cede",area="Dhungar",
            SE={{hash = "5dfe55b0c8d769e865fd85ba63127fbc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=0]]},
               {hash = "7380c211fa363daa4ea79a849a74027a", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=2]]},
               {hash = "62733b0fc85683d590345e3ba8fe9bcc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=3]]},},},
{name = "Dhungar E2",hash ="7380c211fa363daa4ea79a849a74027a",area="Dhungar",
            SE={{hash = "5dfe55b0c8d769e865fd85ba63127fbc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=0]]},
               {hash = "e004dda09968e9a63464ea2191c6cede", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=1]]},
               {hash = "62733b0fc85683d590345e3ba8fe9bcc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=3]]},},},
{name = "Dhungar E3",hash ="62733b0fc85683d590345e3ba8fe9bcc",area="Dhungar",
            SE={{hash = "5dfe55b0c8d769e865fd85ba63127fbc", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=0]]},
               {hash = "e004dda09968e9a63464ea2191c6cede", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=1]]},
               {hash = "7380c211fa363daa4ea79a849a74027a", ziel = [[script:wege_aufzug_dhungar=true warte_aufzug_ebene=2]]},},},

{name = "Dhungar Burgtor",hash ="98cc0c4ba3b01326a1fb291e82f3a8ec",area="Nereid", E={{hash = "c2358c9dce3d10f05f06a9be2e378287", ziel = [[n]]},},},
{name = "Dhungar2 Burgtor",hash ="c2358c9dce3d10f05f06a9be2e378287",area="Nereid", E={{hash = "98cc0c4ba3b01326a1fb291e82f3a8ec", ziel = [[s]]},},},

{name = "Dhungar UW",hash ="ea6e4bf47829217cddc775896ba171d0",area="Dhungar", SE={{hash = "3399a4ad659c3e478a13ab13c10c3a03", ziel = [[script:uwrein()]]},},},
{name = "Dhungar UW2",hash ="3399a4ad659c3e478a13ab13c10c3a03",area="Dhungar", SE={{hash = "ea6e4bf47829217cddc775896ba171d0", ziel = [[script:uwraus()]]},},},

{name = "Gwendon Suedtor1",hash ="5c8450f4ee0ad1e55a0f44f8c78a2a68",area="Tintagel", SE={{hash ="ac77a0b477d00f3c4f13c35bd76467e0", ziel = [[n]]},},},
{name = "Gwendon Suedtor2",hash ="ac77a0b477d00f3c4f13c35bd76467e0",area="Gwendon", pos = {0,0,0}, SE={{hash = "5c8450f4ee0ad1e55a0f44f8c78a2a68", ziel = [[s]]},},},

{name = "Hafen Affenkopfinsel",hash ="692ec42948d7aad6c261e86fe1234164",area="Affenkopf",
                SE={{hash = "b303671ed42d6fc79297397fb8171c71", ziel = [[warte auf schiff nach jasthan]]},
					      	 {hash = "f35d335387b00ddca20c8572aef1a126", ziel = [[warte auf schiff nach vulkania]]},},},

{name = "Hafen Alotria",hash ="e28caa04f27498834d00756f2eccd2f6",area="Alotria", weight = 10,
                SE={{hash = "63ab4d672c1bb5fbac5bc23f3b31396b", ziel = [[warte auf schiff nach holbytla]]},
					      	 {hash = "93804619cea283877cde3fd8a8581333", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Amphibos",hash ="33629ffcefb2c08a5300379e03ca1d78",area="Amphibos",
                SE={{hash = "5b6339ba77f2a76b4abe286c940c78fb", ziel = [[warte auf schiff nach losaria]]},
								   {hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Flotsam",hash ="2bb629d877a810d8746ce7fc51884fee",area="Flotsam", weight = 10,
               SE={{hash = "a8fecc7971c9e7ec1f27e22cc0009152", ziel = [[warte auf schiff nach minias]]},
				          {hash = "10881e7e62b006afee9816649642327f", ziel = [[warte auf schiff nach gwendon]]},
									{hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Gwendon",hash ="10881e7e62b006afee9816649642327f",area="Gwendon", weight=10,
               SE={{hash = "a8fecc7971c9e7ec1f27e22cc0009152", ziel = [[warte auf schiff nach minias]]},
		      		    {hash = "2bb629d877a810d8746ce7fc51884fee", ziel = [[warte auf schiff nach flotsam]]},
									{hash = "c4f3980a3bb496da0d4646f4195625d6", ziel = [[warte auf schiff nach tolsgal]]},
									{hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Holbytla",hash ="63ab4d672c1bb5fbac5bc23f3b31396b",area="Holbytla",
                SE={{hash = "e28caa04f27498834d00756f2eccd2f6", ziel = [[warte auf schiff nach alotria]]},
					      	 {hash = "93804619cea283877cde3fd8a8581333", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Jasthan",hash ="b303671ed42d6fc79297397fb8171c71",area="Jasthan",
                SE={{hash = "692ec42948d7aad6c261e86fe1234164", ziel = [[warte auf schiff nach affenkopfinsel]]},
					      	 {hash = "f35d335387b00ddca20c8572aef1a126", ziel = [[warte auf schiff nach vulkania]]},},},

{name = "Hafen Lorinand",hash ="51c6d00a73fae493f310ba99895a8f1e",area="Lorinand",
                SE={{hash = "2bb629d877a810d8746ce7fc51884fee", ziel = [[warte auf schiff nach flotsam]]},
    						 	 {hash = "85371d2ae3f3317b3a55ba03192c9eaa", ziel = [[warte auf schiff nach Ruwenda]]},
								   {hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Losaria",hash ="5b6339ba77f2a76b4abe286c940c78fb",
            SE={{hash = "33629ffcefb2c08a5300379e03ca1d78", ziel = [[warte auf schiff nach amphibos]]},
				       {hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Minias",hash ="a8fecc7971c9e7ec1f27e22cc0009152",
                SE={{hash = "2bb629d877a810d8746ce7fc51884fee", ziel = [[warte auf schiff nach flotsam]]},
						       {hash = "10881e7e62b006afee9816649642327f", ziel = [[warte auf schiff nach gwendon]]},
									 {hash = "93804619cea283877cde3fd8a8581333", ziel = [[warte auf schiff nach skilletan]]},},},
						
{name = "Hafen Ruwenda",hash ="85371d2ae3f3317b3a55ba03192c9eaa",area="Losaria",
                SE={{hash = "51c6d00a73fae493f310ba99895a8f1e", ziel = [[warte auf schiff nach lorinand]]},
								   {hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Skilletan",hash ="93804619cea283877cde3fd8a8581333",area="Skilletan",
                 E={{hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[n]]},},
                SE={{hash = "e28caa04f27498834d00756f2eccd2f6", ziel = [[warte auf schiff nach alotria]]},
					      	 {hash = "63ab4d672c1bb5fbac5bc23f3b31396b", ziel = [[warte auf schiff nach holbytla]]},
						       {hash = "a8fecc7971c9e7ec1f27e22cc0009152", ziel = [[warte auf schiff nach minias]]},},},

{name = "Hafen Skilletan N",hash ="53c9d802c2b3894bf4cc787fa0f6661b",area="Skilletan",
             E={{hash = "93804619cea283877cde3fd8a8581333", ziel = [[s]]},},
            SE={{hash = "51c6d00a73fae493f310ba99895a8f1e", ziel = [[warte auf schiff nach lorinand]]},
						   {hash = "33629ffcefb2c08a5300379e03ca1d78", ziel = [[warte auf schiff nach amphibos]]},
							 {hash = "2bb629d877a810d8746ce7fc51884fee", ziel = [[warte auf schiff nach flotsam]]},
					     {hash = "5b6339ba77f2a76b4abe286c940c78fb", ziel = [[warte auf schiff nach losaria]]},
							 {hash = "10881e7e62b006afee9816649642327f", ziel = [[warte auf schiff nach gwendon]]},
							 {hash = "c4f3980a3bb496da0d4646f4195625d6", ziel = [[warte auf schiff nach tolsgal]]},
	    				 {hash = "85371d2ae3f3317b3a55ba03192c9eaa", ziel = [[warte auf schiff nach Ruwenda]]},},},
	
{name = "Hafen Tolsgal",hash ="c4f3980a3bb496da0d4646f4195625d6",area="Tolsgal",
            SE={{hash = "10881e7e62b006afee9816649642327f", ziel = [[warte auf schiff nach gwendon]]},
				       {hash = "53c9d802c2b3894bf4cc787fa0f6661b", ziel = [[warte auf schiff nach skilletan]]},},},

{name = "Hafen Vulkania",hash ="f35d335387b00ddca20c8572aef1a126",area="Vulkania",
                SE={{hash = "692ec42948d7aad6c261e86fe1234164", ziel = [[warte auf schiff nach affenkopfinsel]]},
					      	 {hash = "b303671ed42d6fc79297397fb8171c71", ziel = [[warte auf schiff nach jasthan]]},},},

{name = "Hoehlenbewohner1", hash ="8c8ee7a2af3b6b60b29a989c069b2d69", area = "Nereid", E={{hash = "7cdb83b51ff54465d23fb20ff7d63599", ziel = [[down]]},},},
{name = "Hoehlenbewohner2", hash ="7cdb83b51ff54465d23fb20ff7d63599", area = "Ashar", E={{hash = "8c8ee7a2af3b6b60b29a989c069b2d69", ziel = [[up]]},},},



{name = "Limarch Suedtor1", hash ="8b1b11b86e425b2d294c51cf4fa9fb26", area = "Holbytla", E={{hash = "d130282ea13fcd7bec4ec141e7612ae1", ziel = [[n]]},},},
{name = "Limarch Suedtor2", hash ="d130282ea13fcd7bec4ec141e7612ae1", area = "Limarch", E={{hash = "8b1b11b86e425b2d294c51cf4fa9fb26", ziel = [[s]]},},},



{name = "Miobaas Nordtor1",hash ="bad4992c2ae7cd9702810f98281703ac", area="Nereid", E={{hash = "6e13411d7f0d3e4c51fa072b7855d908", ziel = [[s]]},},},
{name = "Miobaas Nordtor2",hash ="6e13411d7f0d3e4c51fa072b7855d908", area="Miobaas", E={{hash = "bad4992c2ae7cd9702810f98281703ac", ziel = [[n]]},},},
{name = "Miobaas Osttor1",hash ="80a527ba10308b2388d28f997baa92cc", area="Nereid", E={{hash = "1620e0f4c4dcec37f682e4d3dbbcf354", ziel = [[w]]},},},
{name = "Miobaas Osttor2",hash ="1620e0f4c4dcec37f682e4d3dbbcf354", area="Miobaas", E={{hash = "80a527ba10308b2388d28f997baa92cc", ziel = [[e]]},},},
{name = "Miobaas Suedtor1",hash ="1ee98166f6ed002d9bc42e8e46993125", area="Nereid", E={{hash = "902a2cde42c858d512c962815cd85013", ziel = [[n]]},},},
{name = "Miobaas Suedtor2",hash ="902a2cde42c858d512c962815cd85013", area="Miobaas", E={{hash = "1ee98166f6ed002d9bc42e8e46993125", ziel = [[s]]},},},
{name = "Miobaas Westtor1",hash ="31379d273740504dbae513e9a3b07104", area="Nereid", E={{hash = "0230c67c69e4f4c64f3746ed9f05186d", ziel = [[e]]},},},
{name = "Miobaas Westtor2",hash ="0230c67c69e4f4c64f3746ed9f05186d", area="Miobaas", E={{hash = "31379d273740504dbae513e9a3b07104", ziel = [[w]]},},},

{name = "Zentrum Minias",hash ="1363d90eb536ec54b8e893d46d73a598",area="Minias",},
{name = "Minias Nordtor1",hash ="edb4e88714d4e25f7385ed16ff9bfb76",area="Nereid", E={{hash = "7b523b322e32109e0f9d83bface15934", ziel = [[s]]},},},
{name = "Minias Nordtor2",hash ="7b523b322e32109e0f9d83bface15934",area="Minias", E={{hash = "edb4e88714d4e25f7385ed16ff9bfb76", ziel = [[n]]},},},
{name = "Minias Osttor1",hash ="7ad2ea3e30eb7589bee7a1d08ae79cb2",area="Nereid", E={{hash = "aa00307c10da31c361c351f327f74f9d", ziel = [[w]]},},},
{name = "Minias Osttor2",hash ="aa00307c10da31c361c351f327f74f9d",area="Minias", E={{hash = "7ad2ea3e30eb7589bee7a1d08ae79cb2", ziel = [[e]]},},},
{name = "Minias Suedtor1",hash ="98a781c3ea124d681f752f82cec99d64",area="Nereid", E={{hash = "730a2cfb40043672c5c4f9d65e1ca2e0", ziel = [[n]]},},},
{name = "Minias Suedtor2",hash ="730a2cfb40043672c5c4f9d65e1ca2e0",area="Minias", E={{hash = "98a781c3ea124d681f752f82cec99d64", ziel = [[s]]},},},

{name = "Mondtor Abtei",hash ="25f532c1edc30a82cd8fd82977f853ba",area="Nereid",},
{name = "Mondtor Alotria",hash ="2bcb8b05509ef84ce6bb36dd50729e2c",area="Nereid",},
{name = "Mondtor Minias",hash ="af86dda24087a60231795e18e03b3b78",area="Nereid",},
{name = "Mondtor Schlucht",hash ="00797360afb606f1a33f5a8342cc18c4",area="Nereid",},
{name = "Mondtor Wueste NO",hash ="bbf61be3631c2f5f9402bce3ffd9a795",area="Nereid",},
{name = "Mondtor Wueste SW",hash ="044e996d908244b0bbb62e018d47d610",area="Nereid",},
{name = "Mondtor Zwerge",hash ="9593dfdc9de52235fbcbcb84507ab690",area="Nereid",},

{name = "Mondtor Amphibos",hash ="e75e105053625dce0f77ce56e879f25c",area="Amphibos",},

{name = "Orkjaegerlager Tor1", hash ="5bc897b006a7f64bd8ac5606382df2b6", area = "Nereid", E={{hash = "739b006d693db57a422bd7fb594a85c0", ziel = [[n]]},},},
{name = "Orkjaegerlager Tor2", hash ="739b006d693db57a422bd7fb594a85c0", area = "Orks", E={{hash = "5bc897b006a7f64bd8ac5606382df2b6", ziel = [[s]]},},},

{name = "Sanduz Westtor1", hash ="dc8813a136c9b097b327ce3062d41599", area = "Nereid", E={{hash = "63e6cae7c73baf707d65744b668bdf1a", ziel = [[w]]},},},
{name = "Sanduz Westtor2", hash ="63e6cae7c73baf707d65744b668bdf1a", area = "Sanduz", E={{hash = "dc8813a136c9b097b327ce3062d41599", ziel = [[e]]},},},
{name = "Sanduz Suedtor1", hash ="9677492e37dc76e4b21b25510f9945f1", area = "Nereid", E={{hash = "94f241668f82e0cba3673dc7c9d797f6", ziel = [[n]]},},},
{name = "Sanduz Suedtor2", hash ="94f241668f82e0cba3673dc7c9d797f6", area = "Sanduz", E={{hash = "9677492e37dc76e4b21b25510f9945f1", ziel = [[s]]},},},

{name = "Solgard Osttor1", hash ="17e951b9157fdfe4cb9a05677c6a6ffa", area = "Flotsam", E={{hash = "b9f6c421be444a29caffbe95f2eaafa8", ziel = [[w]]},},},
{name = "Solgard Osttor2", hash ="b9f6c421be444a29caffbe95f2eaafa8", pos = {0,0,0}, area = "Solgard", E={{hash = "17e951b9157fdfe4cb9a05677c6a6ffa", ziel = [[e]]},},},

{name = "Solgard Westtor1", hash ="c2b1da553b5b590c5444b4c985290080", area = "Flotsam", E={{hash = "334e0b1d8b7b29921c1c57c085160f37", ziel = [[ne]]},},},
{name = "Solgard Westtor2", hash ="334e0b1d8b7b29921c1c57c085160f37", area = "Solgard", E={{hash = "c2b1da553b5b590c5444b4c985290080", ziel = [[sw]]},},},

{name = "Teich",hash ="42b0bf70c4cc2757c0f43a24eb522944",area="Nereid",},

{name = "Teich1",hash ="42b0bf70c4cc2757c0f43a24eb522944",area="Nereid",site="Teich",
            SE={{hash = "718b91f6b42e217f3640b8ce2ffbeb18", ziel = [[tauche teich]]},},},
{name = "Teich2",hash ="718b91f6b42e217f3640b8ce2ffbeb18",area="Walhalla",
            SE={{hash = "42b0bf70c4cc2757c0f43a24eb522944", ziel = [[tauche auf]]},
				        {hash = "d51b6dc32c681867d4168ceb5408f8ce", ziel = [[tauche portal]]},},},
{name = "Teich3",hash ="d51b6dc32c681867d4168ceb5408f8ce",area="Walhalla",site = "Zentrum Walhalla",
            SE={{hash = "718b91f6b42e217f3640b8ce2ffbeb18", ziel = [[kletter loch]]},},},

{name = "Usagoor Tor1", hash ="4b5669394b264fdb825dc8ea35489f26", area = "Nereid", E={{hash = "8aa3530005fea01886d981ff76260980", ziel = [[w]]},},},
{name = "Usagoor Tor2", hash ="8aa3530005fea01886d981ff76260980", area = "Usagoor", E={{hash = "4b5669394b264fdb825dc8ea35489f26", ziel = [[e]]},},},

{name = "UTurm1", hash ="d3b273a63b2841bc3c5fcc81bf0a31a3", area = "Nereid", E={{hash = "f9e6e04088fd99d7dceeb891054011ca", ziel = [[down]]},},},
{name = "UTurm2", hash ="f9e6e04088fd99d7dceeb891054011ca", area = "UTurm", E={{hash = "d3b273a63b2841bc3c5fcc81bf0a31a3", ziel = [[up]]},},},

{name = "Walhalla Haus",hash ="df1dbfec877a3da4aca355d291ba51a2",area="Walhalla", SE={{hash = "a86ce95c7f971df51db1d15b3f461492", ziel = [[script:hausrein()]]},},},
{name = "Walhalla Haus2",hash ="a86ce95c7f971df51db1d15b3f461492",area="Walhalla", SE={{hash = "a7ca3bf35d7bbc72c580ef5857d51f0f", ziel = [[turm]]},{hash = "df1dbfec877a3da4aca355d291ba51a2", ziel = [[script:hausraus()]]}},},
{name = "Walhalla Haus Erdgeschoss",hash ="a7ca3bf35d7bbc72c580ef5857d51f0f",area="Walhalla", SE={{hash = "a86ce95c7f971df51db1d15b3f461492", ziel = [[out]]},},},




--{name = "", hash ="", area = "", E={{hash = "", ziel = [[n]]},},},

}

for k,v in pairs(tMapper.SpecialLocations) do
id = getRoomIDbyHash( v.hash )
if id == -1 then
echo("Raum: "..v.name.." ".. v.hash .. " existiert nicht, lege ihn an.\n")
id = createRoomID()
setRoomIDbyHash(id,v.hash)
addRoom( id )
if v.area then addAreaName(v.area);setRoomArea(id,v.area) end
if v.weight then setRoomWeight(id,v.weight) end 
if v.pos then setRoomCoordinates(id,v.pos[1],v.Pos[2],v.pos[3]) end
end -- if id
end -- for

for k,v in pairs(tMapper.SpecialLocations) do
  
   id = getRoomIDbyHash( v.hash )
   if v.SE then
     clearSpecialExits(id)
     for i,j in pairs(v.SE) do
         id2 = getRoomIDbyHash( j.hash )
         --echo("exit:"..id.." ziel: "..id2.."Ziel: "..j.ziel.."\n")
				 addSpecialExit( id, id2,j.ziel)
     end
   end --if v.SE
	if v.E then
    for i,j in pairs(v.E) do
         id2 = getRoomIDbyHash( j.hash )
         --echo("exit:"..id.." ziel: "..id2.."Ziel: "..j.ziel.."\n")
				 setExit( id, id2,j.ziel)
     end
   end --if v.SE 
if v.area then addAreaName(v.area);setRoomArea(id,v.area) end
if v.weight then setRoomWeight(id,v.weight) end 
if v.site then setRoomName(id,v.site) end
if v.pos then setRoomCoordinates(id,v.pos[1],v.pos[2],v.pos[3])end
end -- for


end -- function</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>MapperSkripts</name>
				<packageName></packageName>
				<script>uwrein = function()
sendAll("nimm muenze aus mein rucksack","schiebe brocken","klettere in loch","w","s","w","s","s","sw","lege meine muenze in mein rucksack")
end

uwraus = function()
sendAll("nimm muenze aus mein rucksack","betrete hoehle","n","n","o","n","o","h","h","lege meine muenze in mein rucksack")
end

hausrein = function()
sendAll("schliesse tor auf","oeffne tor","betrete haus","schliesse tor ab","turm")
end

hausraus = function()
sendAll("raus","schliesse tor auf","oeffne tor","a","schliesse tor ab")
end

uwzugang1 = function()
sendAll("schiebe brocken","klettere in loch")
end

uwzugang3w = function()
sendAll("nimm muenze aus mein sack","w")
end

uwzugang3n = function()
sendAll("nimm muenze aus mein sack","n")
end</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>fMapperGoto</name>
				<packageName></packageName>
				<script>tMapper = tMapper or {}
tMapper.Goto = function(where)
fMapperGoto(where)
end

fMapperGoto = function(where)
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
	local _path = getPath(tRoom.ID, tonumber(where))
	if not _path then 
		cecho("&lt;red&gt;Leider keinen Weg gefunden\n")
	else
    tMapper.SpeedwalkMode = true
		doSpeedWalk()
	end
end
end</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>central command queue</name>
				<packageName></packageName>
				<script>-- command queue enthaelt die Befehle und wird der reihe nach abgearbeitet
-- __cmd = {} command data structure of _cq commands
-- __cmd[__a] somd command or Lua function
-- __cmd[__t] time interval before this command is being executed
-- __cmd[__c] some condition that must be met before the command is being delete otherwise it's repeated unless that is not wanted -&gt; next arg 
-- __cmd[__r] repeat interval or 0 if the command is not supposed to be repeated until the condition is met

function processCq()
	local time = getStopWatchTime(_cq_StopWatch)

if _time_next_command == -1 and #_cq &gt; 0 then 
	_time_next_command = _cq[#_cq].__t; 
end

if _time_next_command &gt; -1 and __debug__ then 
	--cecho("\n&lt;red&gt;time:"..time.." nextRunTime: ".._time_next_command) 
end

if time &gt;= _time_next_command then
	if not pause_cq and #_cq &gt; 0 then
		if not _waitingForCondition then
			stopStopWatch(_cq_StopWatch)
			startStopWatch(_cq_StopWatch)

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
				--cecho("\n&lt;red&gt;SYS: deleting command from queue conditon OK\n")
				table.remove(_cq, #_cq)
			else
				_waitingForCondition = true
				--cecho("\n&lt;red&gt;SYS: NOT deleting command from queue conditon FALSE\n")
			end
			if #_cq &gt; 0 then
				_time_next_command = _cq[#_cq].__t;
				--cecho("&lt;blue&gt; setting time next command to: ".._time_next_command.."\n")
			else
				_time_next_command = -1
			end
		else
			if not _cq[#_cq].__c() and _cq[#_cq].__r &gt; 0 then
				_cq[#_cq].__r = _cq[#_cq].__r - 1;
				stopStopWatch(_cq_StopWatch)
				startStopWatch(_cq_StopWatch)
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
				if #_cq &gt; 0 then
					_time_next_command = _cq[#_cq].__t;
					--cecho("&lt;blue&gt; setting time next command to: ".._time_next_command.."\n")
				else
					_time_next_command = -1
				end
			else
				_waitingForCondition = false
				cecho("\n&lt;red&gt;SYS: deleting command from queue conditon OK\n")
				table.remove(_cq, #_cq)
			end

		end

	end
end
	if #_cq == 0 then 
		_time_next_command = -1
	end

	if cq_timer_id then killTimer( cq_timer_id ); end
	if not stop_cq then
		cq_timer_id = tempTimer(0.1,[[processCq()]])

	else
		--cecho("&lt;red&gt;[SYS]&lt;green&gt; stopping cq\n")
		cq_timer_id = 0;
	end
end

-- command queue enthaelt die Befehle und wird der reihe nach abgearbeitet
-- __cmd = {} command data structure of _cq commands
-- __cmd[__a] somd command or Lua function
-- __cmd[__t] time interval before this command is being executed
-- __cmd[__c] some condition that must be met before the command is being delete otherwise it's repeated unless that is not wanted -&gt; next arg 
-- __cmd[__r] repeat interval or 0 if the command is not supposed to be repeated until the condition is met

function addCommand( c, _t, __cond, __repeat )
	t = _t or 0.5
	_cond = __cond or function() return true end 
	_repeat = __repeat or 1
	__cmd = { __a=c, __t=t, __c=_cond, __r=_repeat }
	table.insert( _cq, 1, __cmd )
	--display(_cq)
end


function pauseCq()
	cecho("&lt;red&gt;[SYS]&lt;green&gt; pausing cq\n")
	pause_cq = true
end

function unpauseCq()
	cecho("&lt;red&gt;[SYS]&lt;green&gt; resuming cq\n")
	pause_cq = false
end

function stopCq()
	stop_cq = true
	cecho("&lt;red&gt;[SYS]&lt;green&gt; stop cq\n")
end

function clearCq()
	cecho("&lt;red&gt;[SYS]&lt;green&gt; clear cq\n")
	_cq = {}
end

--processCq()	
--stopCq()
--pauseCq()
--unpauseCq()</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>Speedwalk</name>
				<packageName></packageName>
				<script>speedWalkWatch = createStopWatch()
speedWalkPath = {}
speedWalkCounter = 0

function speedwalking( event, num )
	if speedWalkPath[speedWalkCounter] == tRoom.ID then
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
	resetStopWatch(speedWalkWatch)
	startStopWatch(speedWalkWatch)
	echo("Starting speedwalk from "..tRoom.ID.." to"..speedWalkPath[#speedWalkPath]..": ")
	cecho(table.concat(speedWalkDir, ", "))
   speedWalkCounter = 1;
	--mmp.paused = false
	tMapper.Mode = "Speedwalk"
	addCommand(speedWalkDir[1],0.13)
end

function continueSpeedWalk()
	if speedWalkDir[speedWalkCounter] then 
	addCommand( speedWalkDir[speedWalkCounter], 0.3 )
	cecho(string.format("&lt;red&gt;(&lt;maroon&gt;%d - &lt;dark_slate_grey&gt;%s&lt;red&gt;)", #speedWalkDir - speedWalkCounter, speedWalkDir[speedWalkCounter]))
	end
  
end
</script>
				<eventHandlerList />
			</Script>
		</ScriptGroup>		