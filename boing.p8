pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
x = 0
y = 0
angle = 0
s = 1
timer = 0

function _init()
    -- setup game / declare global variables
	cls(0)
end

function _update()
    -- update game
    angle = ((x/128) * 360) * 4
    x = x + 1
    if x == 128 then
        cls(0)
        x = 0
    end
    y = (abs(sin(angle/360))) * 32
    timer += 1
    if timer == 60 then
        timer = 0
        s += 1
        if s > 6 then
            s = 1
        end
    end
end

function _draw()
    -- draw game
    cls(0)
    line(0, 100, 127, 100, 10)
    spr(s, x, 92-y)
end

__gfx__
000000000aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000
00000000a71aa71aa17aa17aa17aa17aa71aa71aa17aa17aa17aa17a000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000
000770008aa55aa88aa55aa88aa55aa88a5555a88aa55aa88aa55aa8000000000000000000000000000000000000000000000000000000000000000000000000
0007700085a5aa5885a5aa588555555885ffff588555555885a5aa58000000000000000000000000000000000000000000000000000000000000000000000000
00700700a5aaaa5aa555555aa5f88f5aa5f88f5aa5f88f5aa555555a000000000000000000000000000000000000000000000000000000000000000000000000
00000000aa5555aaaa5555aaaa5555aaaa5555aaaa5555aaaa5555aa000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000