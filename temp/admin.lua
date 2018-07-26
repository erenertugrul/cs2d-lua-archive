-- @author Eren Ertugrul (usgnname = oyuncu)
-- don't use this lua.
-- under construction
---------------------------------------------------------
------------------ Lua Settings -------------------------
-- Server Configs --
server_config = {
	server_name = "sunucu adý",
	server_name_color = "©255255255",
	welcome_message = "welcome my server",
	welcome_message_color = "©255255255",
	player_name_show = true,
	player_name_color = "©000255155"
}
--Reset Score Configs --
reset_score_config = {
	commands = {"rs","!rs","@rs"},
	text = "»Skorun Resetlendi«@C",
	color = "©255255255"
}
-- Bad Words Configs --
badword_config = {
	bad_words = {"oc","orospu"},
	sensitive = true,
	punishment = "kick"
}
---------------------------------------------------------
------------------ Helper Functions ---------------------
helper= {}

function helper.matchlength(value,match)
    local v = {}
    for i in string.gmatch(value,match) do
        table.insert(v,i)
    end
    return(#v)
end

------------------ Lua Functions ------------------------
addhook("say","say_commands")
function say_commands(id,text)
    -- Score Restart Lua (reset_score_config)
	for i,v in ipairs(reset_score_config.commands) do
		local r_t = string.lower(text)
		if r_t == v then
			parse('setscore '..id..' 0')
			parse('setdeaths '..id..' 0')
			msg2(id,reset_score_config.color..reset_score_config.text)
			return 1
	    end
    end
    -- Bad Words Lua (badword_config)
    if badword_config.sensitive then
    	local k_t = string.lower(text)
    	for i,v in ipairs(badword_config.bad_words) do
    		if string.find(k_t,v) then
    			if badword_config.punishment == "slap" then
    				    msg("slap")
    			    elseif badword_config.punishment == "kick" then
    				    msg("kicklendi")
    			    elseif badword_config.punishment == "msj" then
    				    msg("msjbu")
    			end
    			return 1
    		end
    	end
    end
    if not badword_config.sensitive then
    	for i,v in ipairs(badword_config.bad_words) do
    		if text == v then
    			if badword_config.punishment == "slap" then
    				    msg("slap")
    				elseif badword_config.punishment == "kick" then
    					msg("kick")
    				elseif badword_config.punishment == "msj" then
    					msg("msjbu")	
    			end
    			return 1
    		end
    	end
    end
end

addhook("join","join_functions")
function join_functions(id)
    -- Welcome Message Lua (server_config)
	if server_config.player_name_show then
	 msg2(id,server_config.player_name_color.." "..player(id,"name").." "..server_config.welcome_message_color..server_config.welcome_message)
     else
	 msg2(id,server_config.welcome_message_color..server_config.welcome_message)
    end
    -- Show server name command
    parse('hudtxt 1 '..server_config.server_name_color.. " "..server_config.server_name.. ' "240 10"')
end

open_menu_config = {
    f2 = {
    [1] = "f2 menu name,item1,item2,item3,1,2,3,4,(<<),>>",
    [2] = "f2 menu page 2 name,item4,item5,item6,xd,dd,<<,>>",
    [3] = "f2 menu page 3 name,item7,item8,item9,a,a,a,2,<<,(>>)"
},
    f3 = {
    [1] = "f3 menu name,item1,item2,item3,(<<),>>",
    [2] = "f3 menu page 2 name,item4,item5,item6,<<,>>",
    [3] = "f3 menu page 3 name,item7,item8,item9,<<,(>>)"
},
    f4 = {
    [1] = "f4 menu name,item1,item2,item3,(<<),>>",
    [2] = "f4 menu page 2 name,item4,item5,item6,<<,>>",
    [3] = "f4 menu page 3 name,item7,item8,item9,<<,(>>)"
}
}



addhook("serveraction","open_menu")
function open_menu(id,action)
    if action == 1 then
        menu(id,open_menu_config.f2[1])
        elseif action == 2 then
            menu(id,open_menu_config.f3[1])
        elseif action == 3 then
            menu(id,open_menu_config.f4[1])
    end
end

addhook("menu","is_open_menu")
function is_open_menu(id,title,button)
    if title == "f2 menu name" and button == helper.matchlength(open_menu_config.f2[1],",") then
        menu(id,open_menu_config.f2[2])
            elseif title == "f2 menu page 2 name" and button == helper.matchlength(open_menu_config.f2[2],",") - 1 then
                menu(id,open_menu_config.f2[1])
            elseif title == "f2 menu page 2 name" and button == helper.matchlength(open_menu_config.f2[2],",") then
                menu(id,open_menu_config.f2[3])
            elseif title =="f2 menu page 3 name" and button == helper.matchlength(open_menu_config.f2[3],",") - 1 then
                menu(id,open_menu_config.f2[2])
    end
    if title == "f3 menu name" and button == 5 then
        menu(id,open_menu_config.f3[2])
             elseif title == "f3 menu page 2 name" and button == 4 then
                menu(id,open_menu_config.f3[1])
            elseif title == "f3 menu page 2 name" and button == 5 then
                menu(id,open_menu_config.f3[3])
            elseif title == "f3 menu page 3 name" and button == 4 then
                menu(id,open_menu_config.f3[2])
     end
    if title == "f4 menu name" and button == 5 then
        menu(id,open_menu_config.f4[2])
             elseif title == "f4 menu page 2 name" and button == 4 then
                menu(id,open_menu_config.f4[1])
            elseif title == "f4 menu page 2 name" and button == 5 then
                menu(id,open_menu_config.f4[3])
            elseif title == "f4 menu page 3 name" and button == 4 then
                menu(id,open_menu_config.f4[2])
     end     
end

helper.matchlength(open_menu_config.f2[1],",")





