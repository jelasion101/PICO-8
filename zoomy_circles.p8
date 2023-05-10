pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
c = flr(rnd(16))
r = 62

function _init()
    -- setup game / declare global variables
    cls(0)
end

function _update()
    -- update game

end

function _draw()
    -- draw game
    color(c)
    circ(63, 63, r)
    if r != 0 then
        r -= 2
    else
        r = 62   
        if c == 0 then
            c = flr(rnd(16))
        else
            c = 0
        end
    end

end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
