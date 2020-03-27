----------------------------------------
-- GUI-Geraffel
-- In diesem Script wird das User-Interface erzeugt. Das Ziel ist, ein 
-- Interface mit Funktionen zu erhalten, das auch von anderen Modulen
-- mit benutzt werden kann. 
-- Dieses Script basiert auf einem Template von Akaya aus dem mudlet.org-Forum,
-- das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?t=4098
-- Es enthält außerdem Arbeiten von Vadi aus dem gleichen Forum:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=3502&p=17268&hilit=CSSMan#p17264
----------------------------------------












----------------------------------------
-- CSSMan
----------------------------------------

CSSMan = {}
CSSMan.__index = CSSMan

function CSSMan.new(stylesheet)
  local obj  = { stylesheet = {} }
  setmetatable(obj,CSSMan)
  local trim = string.trim

  assert(type(stylesheet) == "string", "CSSMan.new: no stylesheet provided. A possible error is that you might have used CSSMan.new, not CSSMan:new")

  for line in stylesheet:gmatch("[^\r\n]+") do
    local attribute, value = line:match("^(.-):(.-);$")
    if attribute and value then
      attribute, value = trim(attribute), trim(value)
      obj.stylesheet[attribute] = value
    end
  end

  return obj
end

function CSSMan:set(key, value)
  self.stylesheet[key] = value
end

function CSSMan:get(key)
  return self.stylesheet[key]
end

function CSSMan:getCSS(key)
  local lines, concat = {}, table.concat
  for k,v in pairs(self.stylesheet) do lines[#lines+1] = concat({k,": ", v, ";"}) end
  return concat(lines, "\n")
end

function CSSMan:gettable()
  return self.stylesheet
end

function CSSMan:settable(tbl)
  assert(type(tbl) == "table", "CSSMan:settable: table expected, got "..type(tbl))

  self.stylesheet = tbl
end

----------------------------------------
-- GUI
----------------------------------------

GUI = GUI or {}

----------------------------------------
-- Set Borders
----------------------------------------

local w,h = getMainWindowSize()
setBorderLeft(w/4)
setBorderTop(h/10)
setBorderBottom(h/10)
setBorderRight(w/4)

----------------------------------------
-- Create Background
----------------------------------------

GUI.BackgroundCSS = CSSMan.new([[
  background-color: rgb(20,0,20);
]])

GUI.Left = Geyser.Label:new({
  name = "GUI.Left",
  x = 0, y = 0,
  width = "25%",
  height = "100%",
})
GUI.Left:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Right = Geyser.Label:new({
  name = "GUI.Right",
  x = "-25%", y = 0,
  width = "25%",
  height = "100%",
})
GUI.Right:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Top = Geyser.Label:new({
  name = "GUI.Top",
  x = "25%", y = 0,
  width = "50%",
  height = "10%",
})
GUI.Top:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Bottom = Geyser.Label:new({
  name = "GUI.Bottom",
  x = "25%", y = "90%",
  width = "50%",
  height = "10%",
})
GUI.Bottom:setStyleSheet(GUI.BackgroundCSS:getCSS())

----------------------------------------
-- Header Icons
----------------------------------------

GUI.Header = Geyser.HBox:new({
  name = "GUI.Header",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},GUI.Top)

GUI.IconCSS = CSSMan.new([[
  background-color: rgba(0,0,0,100);
  border-style: solid;
  border-width: 1px;
  border-color: white;
  border-radius: 5px;                   
  margin: 5px;
  qproperty-wordWrap: true;
]])

--GUI.IconCSS = CSSMan.new([[
--  background-color: rgba(0,0,0,100);
--  border-style: solid;
--  border-width: 1px;
--  border-color: white;
--  border-radius: 5px;                       ]]..tostring(compass.back:get_width()/2-14)..[[px; margin: 10px;
--  margin: 5px;
--  qproperty-wordWrap: true;
--]])

for i=1,12 do
  GUI["Icon"..i] = Geyser.Label:new({
    name = "GUI.Icon"..i,
  },GUI.Header)
  GUI["Icon"..i]:setStyleSheet(GUI.IconCSS:getCSS())
  GUI["Icon"..i]:echo("<center>GUI. Icon"..i)
end

-----------------------------------
-- Gauges
-----------------------------------

GUI.Footer = Geyser.HBox:new({
  name = "GUI.Footer",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},GUI.Bottom)

GUI.LeftColumn = Geyser.VBox:new({
  name = "GUI.LeftColumn",
},GUI.Footer)

GUI.RightColumn = Geyser.VBox:new({
  name = "GUI.RightColumn",
},GUI.Footer)

GUI.GaugeBackCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  margin: 5px;
]])

GUI.GaugeFrontCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  margin: 5px;
]])

GUI.Health = Geyser.Gauge:new({
  name = "GUI.Health",
},GUI.LeftColumn)
GUI.Health.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","red")
GUI.Health.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Health:setValue(math.random(100),100)
GUI.Health.front:echo("GUI.Health")

GUI.Mana = Geyser.Gauge:new({
  name = "GUI.Mana",
},GUI.LeftColumn)
GUI.Mana.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","blue")
GUI.Mana.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Mana:setValue(math.random(100),100)
GUI.Mana.front:echo("GUI.Mana")

GUI.Endurance = Geyser.Gauge:new({
  name = "GUI.Endurance",
},GUI.RightColumn)
GUI.Endurance.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","yellow")
GUI.Endurance.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Endurance:setValue(math.random(100),100)
--GUI.Endurance.front:echo("GUI.Endurance")
GUI.Endurance.front:echo([[<span style = "color: black">GUI.Endurance</span>]])

GUI.Willpower = Geyser.Gauge:new({
  name = "GUI.Willpower",
},GUI.RightColumn)
GUI.Willpower.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","purple")
GUI.Willpower.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Willpower:setValue(math.random(100),100)
GUI.Willpower.front:echo("GUI.Willpower")

----------------------------------------
-- Boxes
----------------------------------------

GUI.BoxCSS = CSSMan.new([[
  background-color: rgba(0,0,0,100);
  border-style: solid;
  border-width: 1px;
  border-radius: 10px;
  border-color: white;
  margin: 10px;
]])

GUI.Box1 = Geyser.Label:new({
  name = "GUI.Box1",
  x = 0, y = 0,
  width = "100%",
  height = "50%",
},GUI.Right)
GUI.Box1:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box1:echo("<center>GUI.Box1")

GUI.Box2 = Geyser.Label:new({
  name = "GUI.Box2",
  x = 0, y = "50%",
  width = "50%",
  height = "50%",
},GUI.Right)
GUI.Box2:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box2:echo("<center>GUI.Box2")

GUI.Box3 = Geyser.Label:new({
  name = "GUI.Box3",
  x = "50%", y = "50%",
  width = "50%",
  height = "50%",
},GUI.Right)
GUI.Box3:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box3:echo("<center>GUI.Box3")

GUI.Box4 = Geyser.Label:new({
  name = "GUI.Box4",
  x = "0%", y = "0%",
  width = "100%",
  height = "25%",
},GUI.Left)
GUI.Box4:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box4:echo("<center>GUI.Box4")

GUI.Box5 = Geyser.Label:new({
  name = "GUI.Box5",
  x = "0%", y = "25%",
  width = "50%",
  height = "50%",
},GUI.Left)
GUI.Box5:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box5:echo("<center>GUI.Box5")

GUI.Box6 = Geyser.Label:new({
  name = "GUI.Box6",
  x = "50%", y = "25%",
  width = "50%",
  height = "50%",
},GUI.Left)
GUI.Box6:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box6:echo("<center>GUI.Box6")

GUI.Box7 = Geyser.Label:new({
  name = "GUI.Box7",
  x = "0%", y = "75%",
  width = "100%",
  height = "25%",
},GUI.Left)
GUI.Box7:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box7:echo("<center>GUI.Box7")

GUI.Box7 = Geyser.Label:new({
  name = "GUI.Box7",
  x = "0%", y = "75%",
  width = "100%",
  height = "25%",
},GUI.Left)
GUI.Box7:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box7:echo("<center>GUI.Box7")




--  background-color: rgba(0,0,0,0);



GUI.myGaugeBackCSS = CSSMan.new([[
  background-color: QRadialGradient(cx:.3,cy:1,radius:1,stop:0 rgb(0,0,50),stop:.5 rgb(0,0,100),stop:1 rgb(0,0,255));
  border-style: solid;
  border-color: white;
  border-width: 1px;
  width: 100px;
  height: 100px;
  border-radius: 46px;
  margin: 2px;
]])

GUI.myGaugeFrontCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 2px;
  width: 100px;
  height: 100px;
  border-radius: 42px;
  margin: 2px;
]])

GUI.Arkanschild = Geyser.Gauge:new({
  name = "GUI.Arkanschild",
  width="100px", height="100px",
  orientation="vertical",
},GUI.Box6)
GUI.Arkanschild.back:setStyleSheet(GUI.myGaugeBackCSS:getCSS())
GUI.myGaugeFrontCSS:set("background-color","red")
--GUI.myGaugeFrontCSS:set("border-radius","36px")
--GUI.myGaugeBackCSS:set("border-radius","48px")
GUI.Arkanschild.front:setStyleSheet(GUI.myGaugeFrontCSS:getCSS())
GUI.Arkanschild:setValue(math.random(100),100)
--GUI.Arkanschild.front:echo("GUI.Arkanschild")
GUI.Arkanschild.front:echo([[<span style = "color: black">GUI.Arkanschild</span>]])



--testuserwindow = Geyser.UserWindow:new({
--  name = "DockedTestUserWindow",
--  docked = true
--})

-- Script-Group: Gui
-- Script: Clock
InitClock = function ()
	--Clock = Geyser.Label:new({ name = "Clock", x = 10, y = 0 ,width = 300 , height = 30})
	--Clock:setStyleSheet(LabelCSS:getCSS())
end

UpdateClock = function ()
	local sec = os.time(os.date("*t"))-808437600
	local jahr = math.floor(sec/31536000*13)
	sec = sec-(jahr*31536000/13)
	local tag = math.floor(sec/86400*13+1)
	sec = sec-((tag-1)*86400/13)
	local stunde = math.floor(sec/3600*13)
	if (stunde <=9) then stunde ="0"..stunde;end 
	sec = sec-(stunde*3600/13)
	local minute = math.floor(sec/60*13)
	if (minute <=9) then minute ="0"..minute;end 
	wtage={"Sonntag","Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"}
	if (tag<=365) then monat=12;atag=tag-334;end
	if (tag<=334) then monat=11;atag=tag-304;end
	if (tag<=304) then monat=10;atag=tag-273;end
	if (tag<=273) then monat=9;atag=tag-243;end 
	if (tag<=243) then monat=8;atag=tag-212;end
	if (tag<=212) then monat=7;atag=tag-181;end
	if (tag<=181) then monat=6;atag=tag-151;end
	if (tag<=151) then monat=5;atag=tag-120;end
	if (tag<=120) then monat=4;atag=tag-90;end
	if (tag<=90) then monat=3;atag=tag-59;end
	if (tag<=59) then monat=2;atag=tag-31;end
	if (tag<=31) then monat=1;atag=tag;end
	season = "-"
	if tag >=0 and tag <=76 then season = "W";end
	if tag >=77 and tag <= 132 then season = "F";end
	if tag >=133 and tag <= 256 then season = "S";end
	if tag >=257 and tag <= 322 then season = "H";end
	if tag >=323 then season = "W";end
	datum = {}
	datum.monat = monat
	datum.jahr = jahr
	datum.wtag = atag
	datum.wtagdesc = wtage[((tag+(jahr*365)+3)%7)+1]
	datum.stunde = stunde
	datum.minute = minute
	datum.season = season
	ClockBox:echo([[<p style="font-size:12px"><b><font color="white">]]..wtage[((tag+(jahr*365)+3)%7)+1]..", "..atag.."."..monat.."."..jahr.." "..stunde..":"..minute.." ("..season..")")
end
				</script>
				<eventHandlerList />
			</Script>



			<Script isActive="yes" isFolder="no">
				<name>Gauges</name>
				<packageName></packageName>
				<script>InitGauges = function()
GaugeBackCSS = CSSMan.new([[background-color: #000000;border-width: 1px;border-color: ]]..tConfig.MainColorBorder..[[;border-style: solid;border-radius: 7;padding: 3px;]])
GaugeRedCSS = CSSMan.new([[background-color: #880000;border-color: ]]..tConfig.MainColorBorder..[[;border-top: 1px black solid;border-left: 1px black solid;border-bottom: 1px black solid;border-radius: 7;padding: 3px;]])
GaugePurpleCSS = CSSMan.new([[background-color: #880088;border-top: 1px black solid;border-left: 1px black solid;border-bottom: 1px black solid;border-radius: 7;padding: 3px;]])
GaugeGreenCSS = CSSMan.new([[background-color: #008800;border-top: 1px black solid;border-left: 1px black solid;border-bottom: 1px black solid;border-radius: 7;padding: 3px;]])
GaugeBlueCSS = CSSMan.new([[background-color: #000088;border-top: 1px black solid;border-left: 1px black solid;border-bottom: 1px black solid;border-radius: 7;padding: 3px;]])

--createGauge(name, width, height, Xpos, Ypos, gaugeText, colorName, orientation)
if tConfig.iMainWidth and tConfig.iMainWidth-1 >= 1600 then
createGauge("tpbar", 140, 25, 10, tConfig.iMainHeight-60, nil, "red")
createGauge("spbar", 140, 25, 150, tConfig.iMainHeight-60, nil, "blue")
createGauge("apbar", 140, 25, 10, tConfig.iMainHeight-30, nil, "green")
createGauge("mpbar", 140, 25, 150, tConfig.iMainHeight-30, nil, "purple")
else
createGauge("tpbar",(tConfig.iMainWidth/4)-14, 25, 10, tConfig.iMainHeight-30, nil, "red")
createGauge("spbar",(tConfig.iMainWidth/4)-14, 25, 10+(1*(tConfig.iMainWidth/4)), tConfig.iMainHeight-30, nil, "blue")
createGauge("apbar",(tConfig.iMainWidth/4)-14, 25, 10+(2*(tConfig.iMainWidth/4)), tConfig.iMainHeight-30, nil, "green")
createGauge("mpbar",(tConfig.iMainWidth/4)-14, 25, 10+(3*(tConfig.iMainWidth/4)), tConfig.iMainHeight-30, nil, "purple")
end
setGaugeStyleSheet("tpbar",GaugeRedCSS:getCSS(),GaugeBackCSS:getCSS())
setGaugeStyleSheet("spbar",GaugeBlueCSS:getCSS(),GaugeBackCSS:getCSS())
setGaugeStyleSheet("apbar",GaugeGreenCSS:getCSS(),GaugeBackCSS:getCSS())
setGaugeStyleSheet("mpbar",GaugePurpleCSS:getCSS(),GaugeBackCSS:getCSS())
end

UpdateGauges = function()
 setGauge("tpbar", tonumber(tPlayer.tp), tonumber(tPlayer.maxtp), [[<p style="font-weight:bold;color:#C9C9C9;letter-spacing:1pt;word-spacing:2pt;font-size:12px;text-align:center;font-family:arial black, sans-serif;">]]..tPlayer.tp.." / "..tPlayer.maxtp..[[ TP (]]..tPlayer.difftp..[[)</p>]])
 setGauge("mpbar", tonumber(tPlayer.mp), tonumber(tPlayer.maxmp), [[<p style="font-weight:bold;color:#C9C9C9;letter-spacing:1pt;word-spacing:2pt;font-size:12px;text-align:center;font-family:arial black, sans-serif;">]]..tPlayer.mp.." / "..tPlayer.maxmp..[[ MP (]]..tPlayer.diffmp..[[)</p>]])
 setGauge("apbar", tonumber(tPlayer.ap), tonumber(tPlayer.maxap), [[<p style="font-weight:bold;color:#C9C9C9;letter-spacing:1pt;word-spacing:2pt;font-size:12px;text-align:center;font-family:arial black, sans-serif;">]]..tPlayer.ap.." / "..tPlayer.maxap..[[ AP (]]..tPlayer.diffap..[[)</p>]])
 setGauge("spbar", tonumber(tPlayer.sp), tonumber(tPlayer.maxsp), [[<p style="font-weight:bold;color:#C9C9C9;letter-spacing:1pt;word-spacing:2pt;font-size:12px;text-align:center;font-family:arial black, sans-serif;">]]..tPlayer.sp.." / "..tPlayer.maxsp..[[ SP (]]..tPlayer.diffsp..[[)</p>]])
end</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>MenuBar</name>
				<packageName></packageName>
				<script>function attrdir (path)
    local f = {}
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            table.insert(f,string.sub(file,1,-5))
        end
    end
return f
end


ClickTopMenuLocation = function(hash)
  if tMapper then fMapperGoto(getRoomIDbyHash(hash)) else fEcho("Hier wuerdest du nach "..hash.." laufen, aber kein Mapper aktiv") end
end

ClickTopMenuCallback = function(name,path)
  --if _G["t"..name] == nil  then installModule(getMudletHomeDir()..[[\..\..\modules\]]..path..[[\]]..name..[[.xml]]) 
  --else uninstallModule(name)
  --end
echo("BLA:"..path.." / "..name.."\n")
end

ClickTopMenuPref = function (nr,pref,msgein,msgaus)
 if not _G[pref] then
   cecho("\n<red>*** "..msgein.."\n")
  _G[var] = true
else
  _G[var] = nil
	 cecho("\n<red>*** "..msgaus.."\n") 
 TopMenuPrefs[nr]:echo()
end
end


UpdatePreferences = function()
if not bAutoMove then TopMenuPrefs1:echo([[<p style="font-size:12px"><b><font color="white">AutoKlett/Schwimm: <font color="red">Aus]]) else
       TopMenuPrefs1:echo([[<p style="font-size:12px"><b><font color="white">AutoKlett/Schwimm: <font color="green">An]]) end

if not bAutoSchwimmen then TopMenuPrefs2:echo([[<p style="font-size:12px"><b><font color="white">Perma Schwimmen: <font color="red">Aus]]) else
       TopMenuPrefs2:echo([[<p style="font-size:12px"><b><font color="white">Perma Schwimmen: <font color="green">An]]) end

if not bAutoOpfer then TopMenuPrefs3:echo([[<p style="font-size:12px"><b><font color="white">Auto Opfer: <font color="red">Aus]]) else
       TopMenuPrefs3:echo([[<p style="font-size:12px"><b><font color="white">Auto Opfer: <font color="green">An]]) end

if not bAutoSchild then TopMenuPrefs4:echo([[<p style="font-size:12px"><b><font color="white">Auto Schild: <font color="red">Aus]]) else
       TopMenuPrefs4:echo([[<p style="font-size:12px"><b><font color="white">Auto Schild: <font color="green">An]]) end

if not bSprachausgabe then TopMenuPrefs5:echo([[<p style="font-size:12px"><b><font color="white">Sprachausgabe: <font color="red">Aus]]) else
       TopMenuPrefs5:echo([[<p style="font-size:12px"><b><font color="white">Sprachausgabe: <font color="green">An]]) end

if not bZweitieCheck then TopMenuPrefs6:echo([[<p style="font-size:12px"><b><font color="white">Zweitiecheck: <font color="red">Aus]]) else
       TopMenuPrefs6:echo([[<p style="font-size:12px"><b><font color="white">Zweitiecheck: <font color="green">An]]) end


end

ClickTopMenuPref = function(pref,msgein,msgaus)
fToggle(pref,msgein,msgaus)
UpdatePreferences()
end

ClickTopMenuPreferences = function()
  if bShowPreferences == nil then
	bShowPreferences = true
	UpdatePreferences()
  showWindow("TopMenuPrefs")
	showWindow("TopMenuPrefs1")
	showWindow("TopMenuPrefs2")
	showWindow("TopMenuPrefs3")
	showWindow("TopMenuPrefs4")
	showWindow("TopMenuPrefs5")
	showWindow("TopMenuPrefs6")
else
	bShowPreferences = nil
  hideWindow("TopMenuPrefs")
	hideWindow("TopMenuPrefs1")
	hideWindow("TopMenuPrefs2")
	hideWindow("TopMenuPrefs3")
	hideWindow("TopMenuPrefs4")
	hideWindow("TopMenuPrefs5")
	hideWindow("TopMenuPrefs6")
	end
end



InitTopMenuBar = function()
TopMenuBar = Geyser.Label:new({ name = "TopMenuBar", x = tConfig.iMainBorderLeft, y = 0 ,width = tConfig.iMainWidth-tConfig.iMainBorderLeft-tConfig.iMainBorderRight , height = 33})
TopMenuBar:setStyleSheet(LabelCSS:getCSS())

local tDir = attrdir(getMudletHomeDir()..[[/../../modules/Spiele/]])
TopMenuSpiele = Geyser.Label:new({ name = "TopMenuSpiele", x = 6, y = 6 , width = 100,height = 22,nestable = true},TopMenuBar)
TopMenuSpiele:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuSpiele:echo([[<p style="font-size:16px"><b><font color="white">Spiele]])
TopMenuSpiel = {}
for i = 1,#tDir do
TopMenuSpiel[i] = TopMenuSpiele:addChild({name = "TopMenuSpiel"..i,height = 30,width = 100, flyOut=true,layoutDir="BV", message=tDir[i]})
TopMenuSpiel[i]:setStyleSheet(LabelCSS:getCSS())
setLabelClickCallback( "TopMenuSpiel"..i, "ClickTopMenuCallback",tDir[i],"Spiele")
end --for

tDir = attrdir(getMudletHomeDir()..[[/../../modules/Raetsel/]])
TopMenuRaetsel= Geyser.Label:new({ name = "TopMenuRaetsel", x = 110, y = 6 , width = 100,height = 22,nestable = true},TopMenuBar)
TopMenuRaetsel:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuRaetsel:echo([[<p style="font-size:16px"><b><font color="white">Raetsel]])
TopMenuQuest = {}
for i = 1,#tDir do
TopMenuQuest[i] = TopMenuRaetsel:addChild({name = "TopMenuQuest"..i,height = 30,width = 100, flyOut=true,layoutDir="BV", message=tDir[i]})
TopMenuQuest[i]:setStyleSheet(LabelCSS:getCSS())
setLabelClickCallback( "TopMenuQuest"..i, "ClickTopMenuCallback",tDir[i],"Raetsel")
end -- for

TopMenuGebiete= Geyser.Label:new({ name = "TopMenuGebiete", x = 220, y = 6 , width = 120,height = 22,nestable = true},TopMenuBar)
TopMenuGebiete:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuGebiete:echo([[<p style="font-size:16px"><b><font color="white">Metzelskripte]])
TopMenuGebiet = {}
tDir = attrdir(getMudletHomeDir()..[[/../../modules/Metzelgebiete/]])
for i = 1,#tDir do
TopMenuGebiet[i] = TopMenuGebiete:addChild({name = "TopMenuGebiet"..i,height = 30,width = 70, flyOut=true,layoutDir="BV", message=tDir[i]})
TopMenuGebiet[i]:setStyleSheet(LabelCSS:getCSS())
setLabelClickCallback( "TopMenuGebiet"..i, "ClickTopMenuCallback",tDir[i],"Metzelgebiete")
end -- for

TopMenuLocations= Geyser.Label:new({ name = "TopMenuLocations", x = 400, y = 6 , width = 120,height = 22,nestable = true},TopMenuBar)
TopMenuLocations:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuLocations:echo([[<p style="font-size:16px"><b><font color="white">Locations]])
for i = 1,#tRoom.tLocations do
TopMenuLocation = {}
local loc,hash = rex.match( tRoom.tLocations[i], [[(.*)/([A-z0-9]+)]] )
TopMenuLocation[i] = TopMenuLocations:addChild({name = "TopMenuLocation"..i,height = 30,width = 100, flyOut=true,layoutDir="BV", message=loc})
TopMenuLocation[i]:setStyleSheet(LabelCSS:getCSS())
setLabelClickCallback( "TopMenuLocation"..i, "ClickTopMenuLocation",hash)
end--for

TopMenuOptions= Geyser.Label:new({ name = "TopMenuOptions", x = 560, y = 6 , width = 120,height = 22},TopMenuBar)
TopMenuOptions:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuOptions:echo([[<p style="font-size:16px"><b><font color="white">Preferences]])
setLabelClickCallback( "TopMenuOptions", "ClickTopMenuPreferences")
TopMenuPrefs= Geyser.Label:new({ name = "TopMenuPrefs", x = 850, y = 38 , width = 200,height = 300})
TopMenuPrefs:setStyleSheet(LabelCSS:getCSS())

TopMenuPrefs1 = Geyser.Label:new({ name = "TopMenuPrefs1", x = 6, y = 6 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs1:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs1", "ClickTopMenuPref","bAutoMove","Automatisches Klettern / Schwimmen angeschaltet","Automatisches Klettern / Schwimmen ausgeschaltet" )

TopMenuPrefs2 = Geyser.Label:new({ name = "TopMenuPrefs2", x = 6, y = 30 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs2:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs2", "ClickTopMenuPref","bAutoSchwimmen","Permanentes Schwimmen angeschaltet","Permanentes Schwimmen ausgeschaltet" )

TopMenuPrefs3 = Geyser.Label:new({ name = "TopMenuPrefs3", x = 6, y = 54 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs3:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs3", "ClickTopMenuPref","bAutoOpfer","Automatisches Opfersetzen angeschaltet","Automatisches Opfersetzen ausgeschaltet" )

TopMenuPrefs4 = Geyser.Label:new({ name = "TopMenuPrefs4", x = 6, y = 78 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs4:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs4", "ClickTopMenuPref","bAutoSchild","Automatisches Schild erneuern angeschaltet","Automatisches Schild erneuern ausgeschaltet" )

TopMenuPrefs5 = Geyser.Label:new({ name = "TopMenuPrefs5", x = 6, y = 102 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs5:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs5", "ClickTopMenuPref","bSprachausgabe","Sprachausgabe eingeschaltet","Sprachausgabe ausgeschaltet" )

TopMenuPrefs6 = Geyser.Label:new({ name = "TopMenuPrefs6", x = 6, y = 125 ,width = "98%" , height = 30},TopMenuPrefs)
TopMenuPrefs6:setStyleSheet([[background-color: ]]..tConfig.MainLabelBackground..[[; margin: 5px;qproperty-wordWrap: true;]])
setLabelClickCallback( "TopMenuPrefs6", "ClickTopMenuPref","bZweitieCheck","Zweiticheck eingeschaltet","Zweitiecheck ausgeschaltet" )



hideWindow("TopMenuPrefs")
hideWindow("TopMenuPrefs1")
hideWindow("TopMenuPrefs2")
hideWindow("TopMenuPrefs3")
hideWindow("TopMenuPrefs4")
hideWindow("TopMenuPrefs5")
hideWindow("TopMenuPrefs6")
end


</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>ChannelBox</name>
				<packageName></packageName>
				<script>fChannelInit = function()

--border-top-left-radius: 10px;
--    border-top-right-radius: 10px;
--    margin-right: 1px;
--    margin-left: 1px;


ChatTabCSS = CSSMan.new([[background-color:#202020;border-width: 1px;border-color: ]]..tConfig.MainColorBorder..[[;margin-left: 1px;margin-right: 1px; border-style: solid;border-top-left-radius: 7px;border-top-right-radius: 7px;]])
ChatTabHCSS = CSSMan.new([[background-color: rgba(230,0,0,40);border-width: 1px;border-color: ]]..tConfig.MainColorBorder..[[;margin-left: 1px;margin-right: 1px; border-style: solid;border-top-left-radius: 7px;border-top-right-radius: 7px;]])
ChatConCSS = CSSMan.new([[background-color:#202020;border-width: 1px;border-color: ]]..tConfig.MainColorBorder..[[;margin: 2px; border-style: solid;border-radius: 7;padding: 3px;]])

tChat = tChat or{}
tChat.mp = tChat.mp or {}

tChat.x = -740
tChat.y = -480
tChat.width = 740
tChat.height = 470
-- font 9 wrap 102, font 10 wrap 90, font 12 wrap 72
tChat.fontsize = 9
tChat.wrap =102
if io.exists(getMudletHomeDir().."/../../modules/ki.lua") then
 tChat.tabs = {"Rede","Sage","Gelaber","Gilde","Info","Gruppe","System","ATCP","KI"}
else
 tChat.tabs = {"Rede","Sage","Gelaber","Gilde","Info","Gruppe","System","ATCP"}
end
tChat.kanaele = { default="Info",Gruppe="Gruppe",gruppe="Gruppe",system ="System",hobbit="Gelaber", gebruell="Gelaber",hyraskrieger="Gilde",golemkultisten="Gilde",daemonenkrieger="Gilde",runenschmied="Gilde",barden="Gilde",kleriker="Gilde",druiden="Gilde",IRC="Gelaber",laber="Gelaber",nekromanten ="Gilde",magier="Gilde",neuling="Gelaber",REDEN="Rede",SAGEN="Sage",schwafel="Gelaber"}
--tChat.colors = { default="<magenta>",gilden="<green>",hobbit="<cyan>",druiden="<cyan>",laber="<yellow>",spiele="<green>",raetsel="<green>",SEELE="<white>",REDEN="<cyan>",SAGEN="<white>",IRC="<white>",schwafel="<white>",tod="<red>"}
tChat.colors = { default="<255,0,127>",gilden="<0,153,0>",hobbit="<0,255,255>",druiden="<0,255,255>",laber="<255,255,0>",spiele="<0,153,0>",raetsel="<0,153,0>",SEELE="<255,255,255>",REDEN="<0,255,255>",SAGEN="<255,255,255>",IRC="<255,255,255>",schwafel="<255,255,255>",tod="<255,0,0>"}
ChatContainer = Geyser.Container:new({name = "ChatContainer", x = tChat.x , y = tChat.y, width = tChat.width ,height = tChat.height})
ChatTabBox = Geyser.HBox:new({name = "ChatTabBox", x = 10 , y = 5, width = 720 ,height = 35},ChatContainer)
ChatConBox = Geyser.Label:new({ name = "ChatConBox", x = 0 , y = 37 ,width = 740, height = 440},ChatContainer )
ChatConBox:setStyleSheet(ChatConCSS:getCSS())
showWindow("ChatConBox")
local v
for _,v in ipairs( tChat.tabs ) do
  tChat.mp[v] = tChat.mp[v] or {}
	tab = "tab" .. v
  tab = Geyser.Label:new({name = "tab"..v,},ChatTabBox)
  tab:setStyleSheet(ChatTabCSS:getCSS())
  tab:setClickCallback ("ChatChange", v )
  tab:echo(v,nil,"cb")
  local console = "con"..v
  local con = Geyser.MiniConsole:new({name=console,x=5,y=5,width = 730, height = 432,color="#202020"},ChatConBox)
  con:setWrap(tChat.wrap)
	setBgColor(console,30,30,30)
	setMiniConsoleFontSize(console,tChat.fontsize)
  hideWindow(console)
end
showWindow("conInfo")
setLabelStyleSheet("tabInfo",ChatTabHCSS:getCSS())
local kk,vv
for _,v in pairs( tChat.mp ) do
 for kk,vv in ipairs( v ) do
  decho("con".._,"<120,120,120>".."<:32,32,32>"..v[kk].. "\n" )
 end
end 

end--InitChannelBox()



function ChatChange(console)
 for _,v in ipairs( tChat.tabs ) do
  setLabelStyleSheet("tab"..v,ChatTabCSS:getCSS())
  hideWindow("con"..v)
 end
setLabelStyleSheet("tab"..console,ChatTabHCSS:getCSS())
showWindow("con"..console)
end
</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>Timer</name>
				<packageName></packageName>
				<script>
InitTimer = function()
local i
tTimerSlot = {}
tConfig.iTimerSlots = 9
tConfig.iReserviereSlots = 4
i=tConfig.iMainHeight-95-(tConfig.iTimerSlots*30)

TimerLabelVBox = Geyser.VBox:new({name="TimerLabelVBox",x = 10, y= i,height = tConfig.iTimerSlots*30, width = 300,})
for i = 1,tConfig.iTimerSlots do 
tTimerSlot[i] = Geyser.Label:new({name="tTimerSlot"..i ,},TimerLabelVBox)
tTimerSlot[i]:setStyleSheet(LabelCSS:getCSS())
end -- for
end --InitTimer


UpdateTimer = function()
local k,v,l,m = 0 -- MUHAHAHAHA
local txt,time
for m = tConfig.iTimerSlots,1,-1 do echo(string.format ("tTimerSlot%d",m),"");end
for k,v in pairs(tTimer) do
    txt = tTimer[string.format ("%s",k)].txt
    tTimer[string.format ("%s",k)].time = tTimer[string.format ("%s",k)].time + tonumber(tTimer[string.format ("%s",k)].addit)
    time = math.abs(tTimer[string.format ("%s",k)].time)
    if (tonumber(time) <= 0) or tonumber(time) >4000 then
    tTimer[string.format ("%s",k)]=nil
    fEcho("Timer:"..k.." beendet!")
    else
    l = (l or tConfig.iTimerSlots+1) -1
		txt = txt:title()
	  if tTimer[string.format ("%s",k)].addit == -1 and time <=20 then
		echo(string.format ("tTimerSlot%d",l), [[<p style="font-size:16px"><b><font color="red">]]..txt..[[: ]]..time..[[</font></center></b></p>]] );
    else
    echo(string.format ("tTimerSlot%d",l), [[<p style="font-size:14px"><b><font color="white">]]..txt..[[: ]]..time..[[</font></center></b></p>]] );
    end
  end
 end -- do


end -- fun</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>InfoBox</name>
				<packageName></packageName>
				<script>InitInfoBox = function ()
 InfoBox = Geyser.Label:new({ name = "InfoBox", x = 10, y = 5 ,width = 300 , height = 210})
 InfoBox:setStyleSheet(LabelCSS:getCSS())
 ClockBox = Geyser.Label:new({ name = "ClockBox", x = 6, y = 5 ,width = "95%" , height = 30},InfoBox)
 ClockBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;qproperty-alignment: 'AlignLeft | AlignTop';]])
 SpielerBox = Geyser.Label:new({ name = "SpielerBox", x = 6, y = 25 ,width = "95%" , height = 20},InfoBox)
 SpielerBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 LevelBox = Geyser.Label:new({ name = "LevelBox", x = 6, y = 45 ,width = "95%" , height = 20},InfoBox)
 LevelBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 EpBox = Geyser.Label:new({ name = "EpBox", x = 6, y = 65 ,width = "95%" , height = 20},InfoBox)
 EpBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 AlignBox = Geyser.Label:new({ name = "AlignBox", x = 6, y = 85 ,width = "95%" , height = 20},InfoBox)
 AlignBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 FoodBox = Geyser.Label:new({ name = "FoodBox", x = 6, y = 105 ,width = "95%" , height = 50},InfoBox)
 FoodBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 
 OpferBox = Geyser.Label:new({ name = "OpferBox", x = 6, y = 155 ,width = "95%" , height = 25},InfoBox)
 OpferBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 --ScriptBox = Geyser.Label:new({ name = "ScriptBox", x = 6, y = 385 ,width = "95%" , height = 100},InfoBox)
 --ScriptBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
 GildenBox = Geyser.Label:new({ name = "GildenBox", x = 6, y = 175 ,width = "95%" , height = 25},InfoBox)
 GildenBox:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
--GildenBox:setStyleSheet([[background-color: blue;]])

 
 
 

end

ClickScriptBoxCallback = function(hash)
  if tRoom.Hash and tRoom.Hash ~= -1 and tRaetsel.sStartraumHash and tRaetsel.sStartraumHash == tRoom.Hash then 
	tRaetsel.fSpecialRoomHandler()
	else
	fMapperGoto(getRoomIDbyHash(tRaetsel.sStartraumHash))
	end
end

--fFoodColor = function(txt)
--local tFoodColor = { "Du hast ein unangenehmes Voellegefuehl." = "green",
--"Du hast ausreichend gegessen." = "green",
--"Dein Magen knurrt." = "gelb",
--"Du verspuerst Hunger." = "gelb",
--"Dir wird fast schlecht vor Hunger." = "red",
--"Deine Gedanken kreisen nur noch um Deinen Hunger." = "red",
--"Wenn Du jetzt nicht bald was zwischen die Zaehne bekommst ." = "red",-
--}
--if table.contains(tFoodColor,txt) == true then return tFoodColor[txt] else return "cyan" end 
--end


UpdateInfoBox = function()
local output=""
local fontcolor,x,y,z
fontcolor = "cyan"
SpielerBox:echo([[<p style="font-size:12px"><b><font color="white">Spieler: <font color="cyan">]]..tPlayer.name:title()..[[&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; <font color="white">Gilde: <font color="cyan">]]..tPlayer.gilde:title())
LevelBox:echo([[<p style="font-size:12px"><b><font color="white">Stufe: <font color="cyan">]]..tPlayer.stufe..[[ von ]]..tPlayer.levelstufen.." in "..tPlayer.level)
EpBox:echo([[<p style="font-size:12px"><b><font color="white">Ep: <font color="cyan">]]..tPlayer.ep)
AlignBox:echo([[<p style="font-size:12px"><b><font color="white">Align: <font color="cyan">]]..tPlayer.gesinnung:title())
output = ""
if tPlayer.hunger then output = output ..[[<p style="font-size:12px"><b><font color="white">Hunger: <font color="cyan">]]..tPlayer.hunger end
if tPlayer.durst then output = output ..[[<br><b><font color="white">Durst:&amp;nbsp;&amp;nbsp;&amp;nbsp;<font color="cyan">]]..tPlayer.durst end
if tPlayer.alkohol then output = output ..[[<br><b><font color="white">Alk:&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;<font color="cyan">]]..tPlayer.alkohol end

FoodBox:echo([[<p style="font-size:12px"><b><font color="]]..fontcolor..[[">]]..output)

OpferBox:echo([[<p style="font-size:12px"><b><font color="white">Opfer: &amp;nbsp; <font color="green">]]..tPlayer.sOpfer:title())


--if tRaetsel then
--output =""
--if tRaetsel.sName then output = output ..[[<font color="white">Aktives Skript: <font color="cyan">]]..tRaetsel.sName..[[<br>]] end
--if tRaetsel.iStatus then output = output ..[[<font color="white">Status:  <font color="cyan">]]..tRaetsel.iStatus..[[<br>]] end
--if tRaetsel.sStartraumHash then
-- if tRoom.Hash and tRoom.Hash ~= -1 and tRaetsel.sStartraumHash == tRoom.Hash then 
-- output = output ..[[<br><font color="white">    Hier klicken um Raetsel zu starten.]]
-- else
-- output = output ..[[<br><font color="white">    Hier klicken um hinzulaufen.]] 
-- end
-- setLabelClickCallback( "ScriptBox", "ClickScriptBoxCallback",tRaetsel.sStartraumHash)
--end
--ScriptBox:echo([[<p style="font-size:12px"><b><font color="]]..fontcolor..[[">]]..output)
--else
--ScriptBox:echo("")
--end --tRaetsel


--if fGildenBoxUpdate ~= nil then fGildenBoxUpdate() end


end</script>
				<eventHandlerList />
			</Script>
			<Script isActive="yes" isFolder="no">
				<name>Shieldbox</name>
				<packageName></packageName>
				<script>InitShieldBox = function ()
 ShieldBox = Geyser.Label:new({ name = "ShieldBox", x = 10, y = -90 ,width = 145 , height = 30})
 ShieldBox:setStyleSheet(LabelCSS:getCSS())
 AuraBox = Geyser.Label:new({ name = "AuraBox", x = 155, y = -90 ,width = 145 , height = 30})
 AuraBox:setStyleSheet(LabelCSS:getCSS())
end</script>
				<eventHandlerList />
			</Script>
		</ScriptGroup>
