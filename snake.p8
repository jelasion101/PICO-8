pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include alarms.lua
#include colors.lua
#include buttons.lua



function _init()
    -- setup game / declare global variables
	cls(0)
    FLOWER = 1
    TOP = 8
    SIZE = 4
    player = {x = 60, y = 60, direction = RIGHT, alive = true}
    trail = {}
    max = 16
    score = 0
    flower = {x = 24, y = 24}
end

function _update()
    -- update game
	if player.alive == true then
        movePlayer()

        if player.x < 0 or player.y < TOP or player.x > 124 or player.y > 124 then
            player.alive = false
        end
        
        s = {x = player.x, y = player.y}
        add(trail, s)
        if #trail > max then
            del(trail, trail[1])
        end

        if player.x % SIZE == 0 and player.y % SIZE == 0 then
            handleInput()

            for i = 1, #trail-1 do
                if player.x == trail[i].x and player.y == trail[i].y  then
                    player.alive = false
                end
            end

            if player.x == flower.x and player.y == flower.y then
                score += 1
                flower.x = flr(rnd(32)) * SIZE
                flower.y = flr(rnd(30) + 2) * SIZE
                max += SIZE
            end
            
        end
    else
        if btnp(BUTTON1) or btnp(BUTTON2) then
            _init()
        end
    end
end

function _draw()
    -- draw game
    cls(DARK_BLUE)
    rectfill(0, 0, 127, TOP-1, BLACK)
    print("score: " .. score, 56, 1, WHITE)
    rectfill(player.x, player.y, player.x + SIZE-1, player.y + SIZE-1, WHITE)
    spr(FLOWER, flower.x, flower.y)
    for i, v in pairs(trail) do
        rectfill(v.x, v.y, v.x + SIZE-1, v.y + SIZE-1, WHITE)
    end
end

function movePlayer()
    if player.direction == UP then
        player.y -= 1
    elseif player.direction == DOWN then
        player.y += 1
    elseif player.direction == RIGHT then
        player.x += 1
    elseif player.direction == LEFT then
        player.x -= 1
    end
end

function handleInput()
    if btn(UP) and player.direction != DOWN then
        player.direction = UP
    elseif btn(DOWN) and player.direction != UP then
        player.direction = DOWN
    elseif btn(RIGHT) and player.direction != LEFT then
        player.direction = RIGHT
    elseif btn(LEFT) and player.direction != RIGHT then
        player.direction = LEFT
    end
end

__gfx__
00000000797000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000979000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700797000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
