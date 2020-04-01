--create a new trigger group
--permGroup("Trigger für Timer", "trigger")

-- permRegexTrigger(name, parent, pattern table, lua code)
-- Create a regex trigger that will match on the prompt to record your status
--permRegexTrigger("Prompt", "", {"^(\d+)h, (\d+)m"}, [[health = tonumber(matches[2]); mana = tonumber(matches[3])]])


timerStrings = {} -- name, startstring, stopstring
--table.insert(timerStrings, {["name"]="\1", ["start"]="\2",["stop"]="\3", ["duration"]="600"}))
table.insert(timerStrings, {["name"]="Sternenstaub", ["start"]="Du wirst von Sternenstaub umgeben\\.",["stop"]="Dein Sternenstaub loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Magieaufladung", ["start"]="Du hast einen Teil Deiner regenerativen Energien in Deine Zauber umgelenkt\\.",["stop"]="Deine Energien fliessen wieder normal\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Erdaura", ["start"]="Du hebst Deine Haende, beschreibst einen Halbkreis.*|Die Partikel verdichten sich um Dich\\.",["stop"]="Dein Staubschleier loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Luftaura", ["start"]="Du bist in den Watteflocken kaum noch auszumachen\\.",["stop"]="Deine Watteflocken loesen sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Wasseraura", ["start"]="Es regnet aus der Wolke auf Dich herab.*",["stop"]="Dein Wasserschleier loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Todesaura", ["start"]="Du senkst Deine Haende, aber der Schutz der schwarzen Schleier.*|Die schwarzen Schleier verdichten sich um Dich\\.",["stop"]="Deine Todesaura loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Feueraura", ["start"]="Du senkst Deine Haende, aber der Schutz der Manawolken.*|Die Manawolken verdichten sich um Dich\\.",["stop"]="Deine Feueraura loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Kampfbeschwoerung", ["start"]="Du wirst von einer heiligen Aura umgeben\\.",["stop"]="Deine heilige Aura loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Kernschild", ["start"]="Das Glitzern legt sich als schuetzendes Schild ueber Dich\\.",["stop"]="Dein Kernschild loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Knochenschild", ["start"]="Du erhebst Dich wieder, der wirbelnde Schild aus Knochen umgibt Dich",["stop"]="Deine schuetzende Knochenwolke loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Steinhaut", ["start"]="Du bist nun vollkommen in eine Steinhaut eingehuellt, .*",["stop"]=".*Du befreist Dich von Deiner Steinhaut.*|.*Deine Steinhaut loest sich auf.*|Das hat Deiner Steinhaut den letzten Rest gegeben, sie loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Schild", ["start"]="Du wirst von einem magischen Schild umgeben\\.",["stop"]="Dein magischer Schild loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Licht", ["start"]="Ein grosser Lichtbogen breitet sich ueber Deinem Kopf aus\\.|Du erzeugst Dir eine kleine Feuerkugel\\.|Du erzeugst Dir eine kleine Leuchtflamme\\.",["stop"]="Dein Lichtbogen verschwindet\\.|Deine Feuerkugel erlischt\\.|Deine Leuchtflamme erlischt\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Arkanschild", ["start"]="Du wirst von einem Arkanschild umgeben\\.",["stop"]="Dein Arkanschild loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Manarausch", ["start"]="Dichte Manawolken bilden nun einen gewaltigen Schutz um Dich herum\\.",["stop"]="Dein Manarausch laesst wieder nach\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Magiertrance", ["start"]="Du sinkst in tiefe Trance\\.",["stop"]="Du erwachst aus Deiner Trance\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Windhaut", ["start"]="Du bist nun vollkommen in eine Windhaut eingehuellt\\.",["stop"]="Deine Windhaut loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Daemonenhaut", ["start"]="Du bist nun vollkommen in eine Daemonenhaut eingehuellt\\.",["stop"]="Deine Daemonenhaut loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Lebensaura", ["start"]="Du oeffnest die Augen, aber der Schutz der Bluetenblaetter umgibt Dich",["stop"]="Deine Lebensaura loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Schwarzschild", ["start"]="Du wirst von einem magischen Schild umgeben, der Dich besser parieren",["stop"]="Dein Schwarzschild loest sich auf\\.", ["duration"]="600"})
table.insert(timerStrings, {["name"]="Weissschild", ["start"]="Du wirst von einem magischen Schild umgeben, der Dich Deinen Gegner .*", ["stop"]="Dein Weissschild loest sich auf\\."})
table.insert(timerStrings, {["name"]="Holzhaut", ["start"]="Deine Haut sieht nun hoelzern und sehr widerstandsfaehig aus\\.|Deine Blaetterhaut sieht nun hoelzern und sehr widerstandsfaehig aus\\.|Deine Blaetterhaut fuehlt sich nun recht hoelzern an\\.|Deine Haut fuehlt sich nun recht hoelzern an\\.", ["stop"]="Deine Holzhaut loest sich auf\\."})
table.insert(timerStrings, {["name"]="Blaetterhaut", ["start"]="Deine Haut ist nun mit Blaettern bedeckt, die Dir ein angenehmes Klima|Deine Holzhaut ist nun mit Blaettern bedeckt, die Dir ein angenehmes Klima", ["stop"]="Deine Blaetterhaut loest sich auf\\."})
table.insert(timerStrings, {["name"]="Pflanzenblick", ["start"]="Du siehst die Pflanzen um Dich herum jetzt viel klarer\\.", ["stop"]="Dein besonderer Blick fuer die Pflanzen an Deinem Weg verschwindet wieder\\."})
table.insert(timerStrings, {["name"]="Friedfertigkeit", ["start"]="Du fuehlst Dich nun .* friedfertig\\.", ["stop"]="Du fuehlst Dich wieder kaempferischer, ungestuemer\\."})
table.insert(timerStrings, {["name"]="Kampfeslust", ["start"]="Du bekommst so langsam richtig Lust auf ein kleines Kraeftemessen\\.", ["stop"]="Du fuehlst Dich wieder ruhiger, besonnener\\."})
table.insert(timerStrings, {["name"]="Todkonvertieren", ["start"]="Du wirst von einem heiligen Schutz umgeben\\.", ["stop"]="Dein heiliger Schutz loest sich auf\\."})
table.insert(timerStrings, {["name"]="Zorn", ["start"]="Du wirst von kuehlen Winden umgeben\\.", ["stop"]="Die kuehlen Winde, welche Dich umgeben, verschwinden\\."})
table.insert(timerStrings, {["name"]="Kampfsegen", ["start"]="Du bist motiviert und willig zu kaempfen\\.", ["stop"]="Deine Motivation und Dein Kampfeswille schwinden\\."})
table.insert(timerStrings, {["name"]="Trotz", ["start"]="Du hast nun verbesserte Verteidigungsfertigkeiten\\.", ["stop"]="Deine verbesserten Verteidigungsfertigkeiten schwinden\\."})
table.insert(timerStrings, {["name"]="Vergeltung", ["start"]="Du oeffnest Deine Augen und buendelst Deine Wut\\.", ["stop"]="Die Wut in Dir scheint besiegt\\."})
table.insert(timerStrings, {["name"]="Blutrausch", ["start"]="Du laesst einen fuerchterlichen Urschrei von Dir. Es scheint so, als .*", ["stop"]="Die roetlichen Manawolken loesen sich auf\\."})
--^(Das Ankh auf (Deiner|Deinem|den)([a-z ,]*)([A-z]+)beginnt\, schwach zu leuchten\.)

--echo("Group is active: ".. isActive("AvaletTriggerFuerTimer", "trigger").."\n")

for k, v in pairs(timerStrings) do
	if exists(v["name"].."Start", "trigger") == 0 then
		if v["duration"] == nil then
			v["duration"] = "false"
		end
		--luaCode = "registerTimer("..v["name"]..", "..os.time()..", "..v["duration"]..")"
		luaCode = [[registerTimer("]]..v["name"]..[[", "]]..v["duration"]..[[")]]
		--permRegexTrigger(v["name"].."Start", "AvaletTriggerFuerTimer", {v["start"]}, [[echo("]]..v["name"]..[[Start")]])
		permRegexTrigger(v["name"].."Start", "AvaletTriggerFuerTimer", {v["start"]}, luaCode)
	end
	if exists(v["name"].."Stop", "trigger") == 0 then
		luaCode = [[removeTimer("]]..v["name"]..[[")]]
		--permRegexTrigger(v["name"].."Stop", "AvaletTriggerFuerTimer", {v["stop"]}, [[echo("]]..v["name"]..[[Stop")]])
		permRegexTrigger(v["name"].."Stop", "AvaletTriggerFuerTimer", {v["stop"]}, luaCode)
	end
end
--feedTriggers("\nDu laesst einen fuerchterlichen Urschrei von Dir. Es scheint so, als bla\n")




-- Script: onTimer
CountIt = function (what)
	tCounts[string.format ("%s",what)] = (tCounts[string.format ("%s",what)] or 0 )+ 1
	tCountsToday[string.format ("%s",what)] = (tCountsToday[string.format ("%s",what)] or 0) + 1
	fEcho(string.title(what).." heute:"..tCountsToday[string.format ("%s",what)].." gesamt:"..tCounts[string.format ("%s",what)])
end

StartTimer = function (timername,txt,zeit,count)
	txt = txt or timername
	zeit = zeit or 0
	count = count or 1
	tTimer[string.format ("%s",timername)]={}
	tTimer[string.format ("%s",timername)].txt=txt
	tTimer[string.format ("%s",timername)].time=zeit
	tTimer[string.format ("%s",timername)].count=count
	if zeit == 0 then tTimer[string.format ("%s",timername)].addit = 1 else tTimer[string.format ("%s",timername)].addit = -1 end
	if count == 1 then CountIt(timername) end
end

StopTimer = function (timername)
	if tTimer[string.format ("%s",timername)] ~=nil then
		if tTimer[string.format ("%s",timername)].count == 1 then 
			fEcho("Timer: "..timername.." beendet. Laufzeit:"..tTimer[string.format ("%s",timername)].time)
		end
		tTimer[string.format ("%s",timername)]=nil
	end
end

DirectTimer = function (timername,count)
	count = count or 1
	if count == 1 then CountIt(timername) end
end
