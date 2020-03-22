-- local AvalonGUI = {}

-- echo "verdammte Axt\n"

function createGUI()

	echo "createGUI start"

	-- Erzeugt die linke Spalte
	setBorderLeft(200)
	left_container = Geyser.Container:new({
	  name = "left_container",    -- give it a unique name here
	  x=0, y=0,                   -- have it start at the top-left corner of mudlet
	  width = 200, height="100%", -- with a width of 200, and a height of the full screen, hence 100%
	})

	-- Unterteilt die linke Spalte in einen oberen und einen unteren Bereich
	left_container_top = Geyser.Container:new({
	  name = "left_container_top",
	  x=0, y=0,                     -- this container occupies the top, so it starts top-left as well
	  width = "100%", height="50%", -- but only uses up half of the height
	}, left_container)              -- this is the important bit - it says that left_container_top should be inside left_container

	left_container_bottom = Geyser.Container:new({
	  name = "left_container_bottom",
	  x=0, y="50%",                 -- this container starts halfway down the first one
	  width = "100%", height="50%", -- and has the same half height of the original container
	}, left_container)

	echo "createGUI fertig"

end


function echoWas(str)
	echo (str .. "\n")
end -- function echoWas

-- echo "Hallo, hier spricht das script"

-- AvalonGUI.echoWas = echoWas
 
-- return AvalonGUI


local function getMyPath(str)
	return str:match("(.*[/\\])")
end
