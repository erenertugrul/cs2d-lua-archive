-- don't use this lua.
-- under construction



-- to do list
-- ayni anda olmeyi düzelt
-- restart süresi olsun geri sayim ile ikinci yari 
--bomba patlatma cozme
-- iki farka uzamasi

------------------ Global Values ------------------------
vs_active = false -- lock spec all
vs_start = false -- vs basladiginda roundu arttircak
vs_rounds = 0 --toplam round sayisi
vs_half = 0 -- round sayisi/ 2 dir. esit olunca takimlar degisir
vs_halve = 0 -- ilk yari ikinci yari durumu
vs_table = {} -- vs atanlari tabloya ekler ordan skorlari cekeriz
rounds = 0 -- roundlar burdan artiyor
takim_kilit = false
---------------------------------------------------------

-------------------- Functions --------------------------
function init(value,mode)
	local a = {}
	for i=1,value do
		if mode then a[i] = 0
		 else a[i] = false
	    end
	end
	return a
end
vs_players = init(32) -- versus players
vs_scores = init(32,1) -- vs atanlarin skorlari

function clamp(x,min,max)
  if x <= min then x = min
  	else x = max end
  	return x
end

function takimdegis()
	if takim_kilit then
		for i,v in ipairs(vs_table) do
			if player(v,"team") == 1 then
				parse("makect "..v)
				elseif player(v,"team") == 2 then
					parse("maket "..v)
				end
		end
		takim_kilit = false
	end
end
---------------------------------------------------------

------------------ Addhook Functions --------------------

addhook("say","yaz")
function yaz(id,txt)
	if string.lower(txt:sub(1,3)) == "!vs" then
		if not vs_active then
			local t = {}
			for i in string.gmatch(txt, "%S+") do
				table.insert(t,i)
			 end
			local player_1,player_2 = tonumber(t[2]),tonumber(t[3])
			if player(player_1,"exists") and player(player_2,"exists") then
				vs_rounds,vs_halve,vs_half = tonumber(t[4]),clamp(tonumber(t[5]),1,2),math.floor(tonumber(t[4])/2)
				 table.insert(vs_table,player_1)
				 table.insert(vs_table,player_2)
				--msg(player_1.." "..player_2.." "..vs_rounds.. " "..vs_halve) -- debug
				vs_players[player_1],vs_players[player_2],vs_active = true,true,true
				local spec_at = player(0,"table")
				for i,v in ipairs(spec_at) do
					if not vs_players[i] then
						parse("makespec "..i)
					 end
				 end
				parse("restartround 5")
			else
				return 0
			end
		end
	end
	if txt == "!iptal" then
		if vs_active then
			rounds,vs_players,vs_rounds,vs_halve,vs_half,vs_table,vs_active,vs_start,vs_scores = 0,init(32),0,0,0,{},false,false,init(32,1)
			msg("vs bitti")
		end
	end
	if txt == "!reround" then -- düzelt
		for i=1,32 do
			if vs_scores[i] > 0 and rounds >= 0 then
				vs_scores[i] = vs_scores[i] - 1
				rounds = rounds - 1
				parse("restartround 5")
			end
		end
		msg("wtf")
	end
end

addhook("team","degistirme")
function degistirme(id,takim)
    if (takim > 0) and vs_active and not vs_players[id] then
    	return 1
   end
   if player(id,"team") == 1 or player(id,"team") == 2 then
	   	if vs_active and vs_players[id] and not takim_kilit then
	   		return 1
	   	end
    end
end

addhook("join","init_reset")
function init_reset(id)
	vs_players[id] = false
end

addhook("kill","oldur")
function oldur(x,y)
	if vs_active and vs_start then
	  vs_scores[x] = vs_scores[x] + 1
	--rounds = rounds + 1
	-- body
	  msg(vs_scores[x].." "..vs_scores[y].." round "..vs_rounds)
     end
end

addhook("startround","wtf")
function wtf()
	if not vs_start then
		if vs_active then
			vs_start = true
		end
	end
end

addhook("endround","ann")
function ann()
	if vs_active and vs_start then
	  rounds = rounds + 1
	end
	if vs_active and vs_start then
		if (vs_scores[vs_table[1]] > vs_rounds/2) or (vs_scores[vs_table[2]] > vs_rounds/2) then
			rounds,vs_players,vs_rounds,vs_halve,vs_half,vs_table,vs_active,vs_start,vs_scores = 0,init(32),0,0,0,{},false,false,init(32,1)
		    msg("vs bitti")
		end
	end
	if vs_halve == 2 then
		if rounds == vs_half then
			takim_kilit = true
			takimdegis()
			vs_half = 0
			rounds = rounds - 1
			parse("restartround 5")
		end
	end
end

addhook("second","hudgosterim")
function hudgosterim()
	if vs_active then
	 parse('hudtxt 1 '..player(vs_table[1],"name").. "  "..vs_scores[vs_table[1]]..'" 50 50"')
	 parse('hudtxt 2 '..player(vs_table[2],"name").. "  "..vs_scores[vs_table[2]]..'" 50 100"')
	 parse('hudtxt 3 '..rounds.. " / "..vs_rounds..'" 50 150"')
	else
	parse('hudtxt 1 " " 50 50')
	parse('hudtxt 2 " " 50 100')
	parse('hudtxt 3 " " 50 150')
	end
end