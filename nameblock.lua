--------------------------------
------- Isim Block Luası -------
------- Tag Oyuncu Eren --------
------- usgn id = 18041 --------
--------------------------------
addhook("join","isim_degis")
function isim_degis(id)
	local a,b = string.lower(player(id,"name")),"player"
	if string.find(a,b) then
		parse('setname '..id..' "noname" 1')
	end
end

addhook("minute","isim_kontrol")
function isim_kontrol()
	local a,b = player(0,"table"),"player"
	for i=1,#a do
		if string.find(string.lower(player(i,"name")),b) then
			parse('setname '..i..' "noname" 1')
		end
	end
end