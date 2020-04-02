-- Das Ziel des Avalet-Loggers ist, eine Möglichkeit zu haben, aus verschiedenen
-- Quellen Ausgaben in verschiedene Dateien umzuleiten. Um diese dann optional in den
-- Tabs auf der Oberfläche anzeigen zu können.
-- Quellen für diese Ausleitung sind beispielsweise: 
-- --> Trigger
-- --> ATCP
-- --> Logging-Ausgaben im Code für Debugging und Error-Logging im Betrieb
-- Und zwar vorzugsweise sowohl aus Avalet heraus als auch durch eventuelle
-- Sub-Module.
-- Funktionen sind also:
-- --> Eine Datei angeben zu können, die innerhalb des Profils gespeichert wird,
--     und in die dann die Logausgaben irgendwie in geschickter Weise (Dateigröße?)
--     rausgeschrieben werden.
-- --> Einen Tab im Frontend anlegen können, in dem die Log-Ausgabe, also der Inhalt
--     der Datei, in einer Mini-Konsole angezeigt wird. (Muss es nicht geben, einfach
--     in eine Datei loggen können sollte auch gehen.)
-- --> Aus den verschiedenen Quellen in den entsprechenden Logger reinschreiben zu können.
-- --> Ein intelligenter Umgang mit den Dateien und dem verwendeten Speicher.
--
-- Das Logging (inklusive auch von Triggern, Timern etc.) basiert erstmal auf einer
-- Arbeit vom User Wyd aus dem Mudlet-Forum, die ich unter dieser Adresse gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?t=1424
--
-- Anpassungen von Marco Steffens


Logger = Logger or {
		_currFileNum = 0,

		_fileName = nil,

		_keepOpen = {}
}

function Logger:getLogDirectory()
	if string.char(getMudletHomeDir():byte()) == "/" then _sep = "/" else  _sep = "\\" end
	local logdir = getMudletHomeDir() ..  _sep .. "log" .. _sep
	return logdir
end

function Logger:echo(message)
	cecho("\n<red>Logger: ")
	cecho("<white>" .. message)
end

function Logger:Log(file, val, options)
	options = options or Logger.options or {}

	local line = ""
   if table.contains(options, "timestamp") then
		local time_format = "'['dd'/'MM'/'yyyy' - 'hh':'mm':'ss'.'zzz]: "
		line = line .. getTime(true, time_format)
	end

	if table.contains(options, "split") then
		local maxSize = options.split
		self:_checkFileSize(file, maxSize)
	end
	
	local keepopen = table.contains(options, "keepOpen")

	local f
	
	if not self._keepOpen[file] then
		local filename = self:getLogDirectory()  .. file .. ".txt"
		f = io.open(filename, "a+")
		self._keepOpen[file] = f
	else
		f = self._keepOpen[file]
	end

	line = line .. val
	f:write(line .. "\n")

	if not keepopen then
		self:_closeLog(file)
	end
end

function Logger:CloseLog(file)
	if file then
		self:_closeLog(file)
	else
		for f, _ in pairs(self._keepOpen) do
			self:_closeLog(f)
		end
	end
end

function Logger:SearchLog(file, pattern)
	self:_closeLog(file) -- close the log if its open, so we can access it

	local filename = self:getLogDirectory() .. file .. ".txt"
	if not io.exists(filename) then
		self:echo("File '" .. file .. "' does not exist!")
		return
	end

	local counter = 0

	local numBackups = self:_getCurrentFileNumber(file)

	Logger:echo("Searching for '<green>" .. pattern .. "<white>' in file '" .. file .. "'")
	
	local t = 1;
	local lines = 0
	local r = rex.new(pattern)

	while t <= numBackups do
		local bfilename = self:getLogDirectory() .. file .. "." .. tostring(t) .. ".txt"
		local f = io.open(bfilename, "r")

		for line in f:lines() do
			lines = lines + 1
			if r:match(line) then
				cecho("\n<grey>" .. line .. "  <white>(in " .. file .. "." .. tostring(t) .. ".txt)")
				counter = counter + 1
			end
		end

		f:close()

		t = t + 1
	end

	local f = io.open(filename, "r")

	for line in f:lines() do
		lines = lines + 1
		if r:match(line) then
			cecho("\n<grey>" .. line .. "  <white>(in " .. file .. ".txt)")
			counter = counter + 1
		end
	end

	f:close()

	Logger:echo("Term matched " .. counter .. " times in " .. lines .. " lines.")
end

function Logger:LogSection(file, options)
		if self.trigger_id then 
			Logger:echo("Already logging a section. Do Logger:StopLogging() first")
			return
		end

		options = options or {}
		
		if not table.contains(options, "keepOpen") then table.insert(options, "keepOpen") end
		
		local splitSize = 0
		if table.contains(options, "split") then
			splitSize = options.split
			self:_checkFileSize(file, splitSize)
		end

		-- we don't want to pass this on
		options.split = nil

		self:Log(file, "\n\n", {"keepOpen"})
		self:Log(file, "[[[START OF SECTION]]]", {"timestamp", "keepOpen"})

		self.logging_file = file
		self.options = options
		self.trigger_id = tempRegexTrigger(".*", [[ Logger:Log("]] .. file .. [[", matches[1], Logger.options)]])	
		
		if splitSize ~= 0 then
			self.splitSize = splitSize
			enableTimer("Check File Size")
		end
		Logger:echo("Started logging!")
end

function Logger:StopLogging()
	if self.trigger_id then
		killTrigger(self.trigger_id)
		self:_closeLog(self.logging_file)
		self.trigger_id = nil
		self.options = nil
		self.splitSize = 0
		disableTimer("Check File Size")
		self:Log(self.logging_file, "[[[END OF SECTION]]]", {"timestamp"})

		self.logging_file = nil
		Logger:echo("Logging stopped!")
	end
end

function Logger:_checkFileSize(file, maxSize)
	--Check whether our file size is to big
	if self:_getFileSize(file) >= maxSize then
		-- if it is, we need to rename the current file.txt to file.n.text
		self:_closeLog(file)
		local t = self:_getNextFileNumber(file)
		os.rename(self:getLogDirectory() .. file .. ".txt", self:getLogDirectory() .. file .. "." .. t .. ".txt")
	end
end

function Logger:_getFileSize(file)
	local filename = self:getLogDirectory()  .. file .. ".txt"
	local f = io.open(filename, "r")

	if not f then return 0 end
	local size = f:seek("end")    -- get file size
  	
	f:close()
	return size / 1024 -- We want size in kb's, not bytes
end

function Logger:_getCurrentFileNumber(file)
	local t = 1
	local stop = false
	while not stop do
		local filename = self:getLogDirectory() .. file .. "." .. tostring(t) .. ".txt"
		if io.exists(filename) then
			t = t + 1
		else
			stop = true
		end
	end

	self._currFileNum = t - 1

	return self._currFileNum
end

function Logger:_getNextFileNumber(file)
	local current = self:_getCurrentFileNumber(file)
	self._currFileNum = current + 1
	return self._currFileNum
end


function Logger:_closeLog(file)
	if self._keepOpen[file] then
		self._keepOpen[file]:close()
		self._keepOpen[file] = nil
	end
end