local http=require'socket.http'
api ={
	check_name = "http://www.unrealsoftware.de/connect.php?getname=",
	check_usgn = "http://www.unrealsoftware.de/connect.php?getid=",
	check_data = "http://www.unrealsoftware.de/getuserdata.php?id="
}

function api:get_name( usgn_id )
	local r = http.request(api.check_name..usgn_id)
	return r
end

function api:get_usgn( usgn_name )
	local r = http.request(api.check_usgn..string.gsub(usgn_name, "%s+", '%%20'))
	return r
end

function api:get_data( usgn_id,data )
	local r = http.request(api.check_data..usgn_id.."&data="..data)
	return r
end
function api:get_flag( usgn_id )
	local a = api:get_data(usgn_id,"country")
	if #a ~= 0 then
		print(a,#a)
		flag = love.graphics.newImage("flags/"..(string.upper(a))..".png")
		flag_check = 1
	else if a ~= "--" then
		flag = love.graphics.newImage("flags/no_user.png")
		flag_check = 0
	else
		flag = love.graphics.newImage("flags/nocountry.png")
		flag_check = 0
	end
	end
end
function api:get_avatar( usgn_id )
	local a = api:get_data(usgn_id,"avatar")
	if #a > 1 then
		local p = http.request("http://unrealsoftware.de/"..a)
		local d = love.filesystem.newFileData(p,"avatar.jpg")
	    avatar = love.graphics.newImage(d)
	    avatar_check = 1
	else
		avatar_check = 0
		avatar = 0
	end
end
return api