pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include alarms.lua
-- global variables

time = 15

function _init()
    -- setup game / declare global variables
	cls(0)
    alarm0 = makeAlarm(time, alarm0)
    alarm1 = makeAlarm(120, alarm1)
    alarm2 = makeAlarm(180, alarm2)
end

function _update()
    -- update game
	updateAlarms()
end

function _draw()
    -- draw game

end

function alarm0()
    print("tick")
    startAlarm(alarm0, time)
end

function alarm1()
    print("stopped alarm0")
    stopAlarm(alarm0)
end

function alarm2()
    print("started alarm0")
    startAlarm(alarm0, time)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000