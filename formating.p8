pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include buttons.lua
#include alarms.lua

function _init()
   game_sprites={1,3,5}
   i=1
   player=1
   computer=1
   game_output=""
   player_score=0
   com_score=0
   draws=0
   animate_com_alarm = makeAlarm(90, Animate_com)
end

function _update()
   updateAlarms()
   if btnp(LEFT) then
      i-=1
      if (i>=1) then
         player=game_sprites[i]
      elseif i<=0 then
         i=3
         player=game_sprites[i]
      end
   end
   if btnp(RIGHT) then
      i+=1
      if (i<=3) then
        player=game_sprites[i]
      elseif i>3 then
        i=1
        player=game_sprites[i]
      end
   end
end



function _draw()
   cls()
   --players ui stuff
   print("score: "..player_score,28,45,12)
   print("you",36,52,7)
   spr(player,34,60,2,2,true)
   print("score: "..com_score,72,45,12)
   print("computer",72,52,7)
   spr(computer,78,60,2,2)
   print("draws: "..draws,44,90,12)
   if game_output=="draw" then
      print("its a draw",44,100,8)
   elseif game_output=="Com_Win" then
      print("you lose!!",44,100,8)
   elseif game_output=="Player_Win" then
      print("you win!!",44,100,8)
   end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
