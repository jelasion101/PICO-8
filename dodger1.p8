pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include 2dEngine.lua
#include buttons.lua
SPRITE_PLAYER = 1
SPRITE_BADDIE = 2
SPRITE_SMALLBADDIE = 3
cx = 63
cy = 63
SCORE = 0
HIGHSCORE = 0
function _init()
    -- setup game / declare global variables
	cls(0)
    objects = {}
    lastUpdate = time()
    player = NewObject(cx, cy, SPRITE_PLAYER, 2, 0)
    for i = 0, 10 do
        makeBaddie(SPRITE_BADDIE, 1.5, 8, 8)
    end
    for i = 0, 5 do
        makeBaddie(SPRITE_SMALLBADDIE, 2, 4, 4)
    end
end

function _update()
    -- update game
    if time() - lastUpdate > 1 then
        lastUpdate = time()
        SCORE += 1
        if SCORE > HIGHSCORE then
            HIGHSCORE = SCORE
        end
    end
	for i, o in pairs(objects) do
        MoveObject(o)
        if RectHit(player, o) then
            SCORE = 0
            cx = 63
            cy = 63
        end
        if o.y > 132 then
            makeBaddie(o.sprite, o.speed)
            deleteBaddie(i)
        end
    end
    if btn(UP) and cy > 5 then
        cy -= player.speed
    elseif btn(DOWN) and cy < 123 then
        cy += player.speed
    end
    if btn(LEFT) and cx > 5 then
        cx -= player.speed
    elseif btn(RIGHT) and cx < 123 then
        cx += player.speed
    end
    player.x = cx
    player.y = cy
end

function _draw()
    -- draw game
    cls(0)
    print("CURRENT SCORE: " .. SCORE)
    print("HIGH SCORE: " .. HIGHSCORE, 0, 7.5)
    for o in all(objects) do
        o.Draw(o)
    end
    player.Draw(player)
end

function makeBaddie(sprite, speed, w, h)
    local o = NewObject(flr(rnd(128)), -flr(rnd(128)), sprite, 0, w, h) 
    MoveToward(o, o.x, 144, speed)
    add(objects, o)
end

function deleteBaddie(i)
    deli(objects, i)
end

__gfx__
0000000000aaaa009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa09999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aa1aa1aa9199991900222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa9999999900122100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa9911119900222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aa3aa3aa9119911900211200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aa33aa09999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
