love.window.setTitle("Meliorare Day Counter")  -- Sets the title of the application
love.window.setMode( 600, 600 )
love.graphics.setBackgroundColor(0.161, 0.173, 0.235)
font = love.graphics.setNewFont(24)


function love.load()
	local icon = love.image.newImageData("icon.png")
	love.window.setIcon(icon)
end


-- State variables
local days = ""
local start_date = ""
local editing = false
local input_text = ""


-- Save the start date
local function save_start_date()
        local file = io.open("start_date.txt", "w")
        if file then
		file:write(start_date)
        	file:close()
    	end
end


local button = {x = 200, y = 400, width = 200, height = 50, text = "Change Start Date"}
button.width = font:getWidth(button.text) + 20   -- Text goes off the sides otherwise. 

-- Calculates the days since the start date
local function calculate_days()
        local handle = io.popen([[bash -c '
                start_date="]] .. start_date .. [["
	         echo $(( ( $(date +%s) - $(date -d "$start_date" +%s) ) / 86400 ))
        ']])
        days = handle:read("*a")
        handle:close()

        days = days:gsub("%s+$", "")
end


local function load_start_date()
    local file = io.open("start_date.txt", "r")
    if file then
        start_date = file:read("*l")  -- read first line
        file:close()
    end
end


-- Load from file first
load_start_date()
calculate_days()


--initial calculation
calculate_days()

-- Bigger font for the day
local dayfont = love.graphics.newFont(100)



function love.draw()
	-- Day number
        love.graphics.setFont(dayfont)
	local textWidth = dayfont:getWidth(days)
	local textHeight = dayfont:getHeight()

	local x = 300 - textWidth / 2
	local y = 300 - textHeight / 2
	love.graphics.print(days, x, y)
	
	-- Restore previous font (main font)
	love.graphics.setFont(font)

	-- In the draw function:
	if not editing then
	    -- Draw button background
	    button.x = (600 - button.width) / 2
	    love.graphics.setColor(0, 0, 1)
	    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height, 5, 5)

	    -- Draw button text with buttonFont
 	   love.graphics.setColor(1, 1, 1)
	    local btnTextWidth = font:getWidth(button.text)
	    local ascent = font:getAscent()
	    local descent = font:getDescent()
	    local btnTextHeight = ascent + descent

	    love.graphics.print(
	        button.text,
	        button.x + (button.width - btnTextWidth)/2,
	        button.y + (button.height - btnTextHeight)/2
	    )

	else
	    -- Draw input field
	    love.graphics.setColor(0.8, 0.8, 0.8)
	    love.graphics.rectangle("fill", 150, 400, 300, 50, 5, 5)
	    love.graphics.setColor(0, 0, 0)
	    love.graphics.print(input_text .. "_", 160, 410)
	end
end
-- Detects mouse button being pressed
function love.mousepressed(mx, my, buttonPressed)
	if buttonPressed == 1 and not editing then
		if mx > button.x and mx < button.x + button.width and
		   my > button.y and my < button.y + button.height then
			        editing = true
				input_text = start_date  --starts at current start_date
			end
		end
	end  -- I don't know why there is a gap, but it works fine


	
function love.textinput(t)
	if editing then
		input_text = input_text .. t
	end
end

-- Key presses
function love.keypressed(key)
	if editing then
		if key == "backspace" then
			input_text = input_text:sub(1, -2)
		elseif key == "return" then
			start_date = input_text
			calculate_days()
			save_start_date()
			editing = false
		elseif key == "escape" then
			editing = false --cancels editing
		end
	end
end
