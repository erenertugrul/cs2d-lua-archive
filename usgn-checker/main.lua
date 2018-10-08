local utf8 = require("utf8")
require("api")
first_start = true
avatar_check = 0
avatar = 0
flag = 0
print_name = ""
print_usgn = ""
text = ""

function love.load( ... )
	love.graphics.setBackgroundColor(0.224,0.224,0.224)
end
function api_giris( a )
	if type(a) == "string" then
		return api:get_usgn(a)
	elseif type(a) == "number" then
		print_name = api:get_name(a)
		print_usgn = api:get_usgn(a)
		return api:get_avatar(a),api:get_flag(a)
	end
end

function love.textinput(t)
	text = text.. t
end

function love.draw( ... )
	if first_start == false then
		if avatar_check == 1 then
			love.graphics.draw(avatar,55,55)
		end
		if avatar_check == 0 and (flag_check == 1 or 0) then
			avatar = love.graphics.newImage("flags/noavatar.png")
			love.graphics.draw(avatar,55,55)
		end
		if flag_check == 1 then
			love.graphics.draw(flag,250,55)
		end
		if flag_check == 0 then
			love.graphics.draw(flag,250,75)
		end
		love.graphics.print("country:",180,75)

		love.graphics.print("usgn:",180,50)
		
	end

	love.graphics.print("input usgn or name",130,130)
	love.graphics.printf(text,170,150,500)
	love.graphics.printf(print_name,250,50,love.graphics.getWidth())
	
end
function love.keypressed(key)
	if key == "backspace" then --https://love2d.org/wiki/love.textinput
        local byteoffset = utf8.offset(text, -1)
 
        if byteoffset then
            text = string.sub(text, 1, byteoffset - 1)
        end
    end
	if key == "return" or key == "kpenter" then
		if first_start == true then
			first_start = false
		end
		if #text > 0 then
			local a = tonumber(text)
		    if a == nil then
		    	api:get_avatar(api_giris(text))
		    	print_name = api:get_usgn(text)
		    	api:get_flag(api_giris(text))
		    else
		    	api_giris(a)
		    end
		    text = ""
		end
	end
end

