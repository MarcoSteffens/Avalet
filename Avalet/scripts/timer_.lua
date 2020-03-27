

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
