--------------------------------
-- Son saniye Bomba imha luası -
------- Tag Oyuncu Eren -------- 
------- usgn id = 18041 --------
--------------------------------

local c4_timer = game("mp_c4timer")
local bomba_aktif = false 

addhook("startround","deger_resetleme")
function deger_resetleme()
	c4_timer = game("mp_c4timer")
	bomba_aktif = false
end

addhook("bombplant","bomba_yerlestirme")
function bomba_yerlestirme()
	bomba_aktif = true
end

addhook("second","geri_sayim")
function geri_sayim()
	if bomba_aktif then
		c4_timer = c4_timer - 1
	end
end

addhook("bombdefuse","bomba_cozuldu")
function bomba_cozuldu(id)
	if c4_timer <= 1 then
		msg("©000255155"..player(id,"name").." ©255255255Son anda bombayi cozdu!!!@C")
	end
end