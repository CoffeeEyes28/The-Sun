pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--[[

sun platformer 
- control piece of sun

- sun can move and jump 
		in order to platform home
		
- bomb boxes and other hazards 

]]--

--var

function _init()

--player
		plyr={
		sp=1,
		x=10,
		y=10,
		w=8,
		h=8,
		flp=false,
		dx=0,
		dy=0,
		max_dx=2,
		max_dy=3,
		acc=0.4,
		bounce=4,
 	anim=0,
		moving=false ,
		sliding=false,
		jumping=false ,
		falling=false ,
		landed=false,	
	}
	gravity=0.2
	friction=0.83
end






-->8
--update and draw

function _update()

	plyr_update()

	

--plyr_anim()
end

function _draw()
	cls()
	map(0,0)
		spr(
					plyr.sp,
					plyr.x,
					plyr.y,
					plyr.w/8,
					plyr.h/8,
					plyr.flp
						)
end


-->8
--collision 

function map_collide(obj,aim,flag)
--obj = table x,y,w,h
--aim= left,right,up,down
	
	local x=obj.x local y=obj.y
	local w=obj.w local h=obj.h
	
	local x1=0 local y1=0
	local	x2=0	local y2=0
	
	if aim=="left" then
				x1=x-1 y1=y
				x2=x			y2=y+h-2
				
	elseif aim=="right" then
				x1=x+w		 y1=y
				x2=x+w+1 y2=y+h-1
	
	elseif aim=="up" then
				x1=x+1	 	 y1=y-1
				x2=x+w-1  y2=y
				
	elseif aim=="down" then
			
				x1=x	  	y1=y+h
				x2=x+w  y2=y+h			
	end
	
	--pixels to tiles 
		x1/=8			y1/=8
		x2/=8		 y2/=8
		
		if fget(mget(x1,y1), flag)
		or fget(mget(x1,y2), flag)
		or fget(mget(x2,y1), flag)
		or fget(mget(x2,y2), flag) then
			return true
	else
		return false
		end
		
end
-->8
--plyr
function plyr_update()
	--physics
	plyr.dy+=gravity
	plyr.dx*=friction

	--controls
		if btn(⬅️) then
			plyr.dx-=plyr.acc
			plyr.moving=true
			plyr.flp=true
		end
		
		
		if btn(➡️) then
			plyr.dx+=plyr.acc
			plyr.moving=true
			plyr.flp=false
		end
		
		--slide
		if plyr.moving
		and not btn(⬅️)
		and not btn(➡️)
		and not plyr.falling
		and not plyr.jumping then
						plyr.moving=false
						plyr.sliding=true
		end
		
		--jump
		if btnp(❎)
			and plyr.landed then
			plyr.dy-=plyr.bounce
			plyr.landed=false
		end	
			
			--up and down
		
			if plyr.dy>0 then
				plyr.falling=true
				plyr.landed=false
				plyr.jumping=false
			end
			
			if map_collide(plyr,"down",0) then
						plyr.landed=true
						plyr.falling=false
						plyr.dy=0			
						plyr.y-=(plyr.y+plyr.h)%8
								
	elseif plyr.dy<0 then
					plyr.jumping=true
					if map_collide(plyr,"up",1) then
					plyr.dy=0
			
			end
	end		

	-- left and right
	if plyr.dx<0 then
		
		if map_collide(plyr,"left",1) then
					plyr.dx=0
	 end
		
 elseif plyr.dx>0 then
 	if map_collide(plyr,"right",1) then
 				plyr.dx=0
 	end
	end
 
 plyr.x+=plyr.dx
 plyr.y+=plyr.dy
	
end
				

	
		
			
	
	
	
	
	
	
	
	
	
	
	
	
	

__gfx__
00000000aaaaaaaaaaaaaaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ac7aac7aaaaaaaaaa77aa77a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000accaaccaac7aac7aaccaacca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000accaaccaaccaaccaaccaacca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaccaaccaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaa99aaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaa9999aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaa9999aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaa00aaa6155550634453444707070706666666656666665ccc00cccc5c00c5cccc0043b44454434344544434443444344544334555555550000000000000000
aaa00aaa1155550044353344070707076666666664f66666ccc00cccc5c00c5c33b0033343454343434543343443443434543443555555550000000000000000
aaa00aaa55555555555555557070707066666666a6600666ccc00cccc5c00c5c43300c5c34353444443534434334334443534334555555550000000000000000
00000000555555554544435307070707666666666600706600000000000000000000000055555555555555555555555555555555555555550000000000000000
00000000555555553544435470707070666666666000000600000000000000000000000043443435344443343443534434443444555555550000000000000000
aaa00aaa5555555555555555070707076666666660000006ccc00cccc5c00c5cc5c00c5c44334345434434434334543343434434555555550000000000000000
aaa00aaa0055551144543454707070706666666666000066ccc00cccc5c00c5cc5c00c5c43434435443343344344534434344443555555550000000000000000
aaa00aaa6055551643544453070707076666666656600665ccc00cccc5c00c5cc5c00c5c55555555555555555555555555555555555555550000000000000000
00000000000000000000000000000000000000006600006600000000000000000000000044453444444454444444444454444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044454334344454444444444454444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044454433444454444444444454444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044454444344454444444444454444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055555555555555555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444454444444444444445444444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444454444444444444445444444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444454444444444444445444444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444454444444444444445444444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055555555555555555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444444544444444444444454444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444444544444444444444454444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444444544444444444444454444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055555555555555555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044445444444444444444444544444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044445444444444444444444544444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044445444444444444444444544444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044445444444444444444444544444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055555555555555555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444454444444444544444445444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444454444444444544444445444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444454444444444544444445444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044444444454444444444544444445444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055555555555555555555555555555555000000000000000000000000
__gff__
0000000000000003030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010109010700000003030303010100000000000000000000030303030000000000000000000000000303030300000000000000000000000003030303000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4c46464a4b4c494a4b4c494a4b4c494a4b4c4e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5946464646464646464646404040404046464e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6946464646464646464646404040404046464e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7946464646464646464646404040404046464e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494646464646464646464646404040404e4e4e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
594646464646464646464646464646464e4e4e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
694646464646464646464646464646464e4e4e4e4e4e4e4e4e4e4e4e4e4e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
794646464646464646464646464646464e4e4e4e4e4e4e4e4e4e4e4e4e4e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494646484848484848484848484848484848484848484e4e4e4e4e4e4e4e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
595a48474747474747474747474747474747474848484e4e4e4e4e4e4e4e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
696a6b484848484848484848484848484848484848484e4e4e4e4e4e4e4e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
797a7b7c48484748474c4c4845484c4c48484848484e4e4e4e4e4e4e4e4e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494a4b4c494a4b4c494a4b4c494a494a4b4c494a4b4c494a4b4c494a4b4c494a4b4c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
595a5b5c595a5b5c595a5b5c595a595a5b5c595a5b5c595a5b5c595a5b5c595a5b5c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
696a6b6c696a6b6c696a6b6c696a696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
797a7b7c797a7b7c797a7b7c797a797a7b7c797a7b7c797a7b7c797a7b7c797a7b7c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4941414141414141414141414141414141414141414141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000036500c6501165014650166501b6501e650206502165021650216502065020650206502165021650206501d6501b6501a650186501565014650126500f6500d6500a6500965007650046500265000650
