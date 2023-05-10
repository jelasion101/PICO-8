pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include colors.lua
#include alarms.lua

strength = 4

function _init()
    -- setup game / declare global variables
	cls(0)
    terrain = {}
    leftbound = 4
    rightbound = 124
    pass = 2
    stage = 1
    done = false
    alarm0 = makeAlarm(-1, r)
    startingy = 70
end

function _update()
    -- update game
    updateAlarms()
    if leftbound < rightbound and stage == 1 then
        add(terrain, {x = leftbound, y = startingy, final = false})
        leftbound += 2
        if leftbound == rightbound then
            stage = 2
            leftbound = 4
        end
    elseif stage == 2 then
        terrain[pass].y = terrain[pass-1].y-strength + flr(rnd(strength*2))
        if pass < 60 then
            pass += 1
        else
            pass = 1
            stage = 3
        end
    elseif stage == 3 and done == false then
        terrain[pass].final = true 
        if pass < 60 then
            pass += 1
        else
            done = true
        end
    end
    if done == true then
        startAlarm(60, alarm0)
    end
end

function _draw()
    -- draw game
    cls(0)
    color(WHITE)
    print(#terrain, 10, 10)
    if stage != 3 then
        line(4, startingy, 123, startingy)
    end
    for i, v in pairs(terrain) do
        if terrain[i].final == false then
            circfill(terrain[i].x, terrain[i].y, 1, WHITE)
        end
    end
    if stage == 2 or stage == 3 then
        for i, v in pairs(terrain) do
            line(terrain[i].x, startingy, terrain[i].x, terrain[i].y, WHITE)
            if stage == 3 then
                if terrain[i].final == true then
                    line(terrain[i].x, startingy, terrain[i].x, (terrain[i].y), BLACK)
                end
            end
            if i > 1 then
                line(terrain[i-1].x, terrain[i-1].y, terrain[i].x, terrain[i].y, WHITE)
            end
        end
    end
end

function r()
    _init()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
