pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables


function _init()
    -- setup game / declare global variables
    cls(0)
end

function _update()
    -- update game

end

function _draw()
    -- draw game
    t = flr(rnd(2))
    x = flr(rnd(128))
    y = flr(rnd(128))
    r = flr(rnd(20)) + 10
    c = flr(rnd(16))
    if t == 0 then
        circfill(x, y, r, c)
    else
        rectfill(x, y, r, r, c)
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000