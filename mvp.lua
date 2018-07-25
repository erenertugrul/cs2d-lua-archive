--------------------------------
---------- MVP Luası -----------
------- Tag Oyuncu Eren -------- 
------- usgn id = 18041 --------
--------------------------------
function dizi(sayi)
	local a = {}
	for i=1,sayi do
		a[i] = 0
	end
	return a
end

mvp = dizi(32)

addhook("hit","hasar")
function hasar(v,vuran,s,hasar)
	mvp[vuran] = mvp[vuran] + hasar
end

addhook("endround","sifirla")
function sifirla()
	local yuksek, sira = -math.huge
	for k,v in ipairs(mvp) do
		if v > yuksek then
			yuksek, sira = v, k
		end
	end
		msg ("©032178170"..player(sira,"name").." ©255255000"..yuksek.. " hasar ile ©255255255 MVP oldu!@C")
	for i=1,32 do
		mvp[i] = 0
	end
end
