pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include alarms.lua
#include buttons.lua
#include colors.lua
function _init()
    -- setup game / declare global variables
	cls(0)
    dead = false
    STATE = 0
    cursorSelection = 0
    player = {x = 6.4, y = 6.4, gridx = 1, gridy = 1, DIRECTION = RIGHT, SIZE = 6.4, SPEED = 1.28, isGod = false, flipx = false, flipy = false}
    redghost = {x = 51.2, y = 70.4, gridx = 9, gridy = 12, SPRITE1 = 27, SPRITE2 = 28, CURRENTSPRITE = 27, RUNNING = false, newx = 2, newy = 2, name = "red"}
    blueghost = {x = 57.6, y = 70.4, gridx = 10, gridy = 12, SPRITE1 = 29, SPRITE2 = 31, CURRENTSPRITE = 31, RUNNING = false, newx = 19, newy = 2, name = "blue"}
    yellowghost = {x = 64, y = 70.4, gridx = 9, gridy = 12, SPRITE1 = 32, SPRITE2 = 33, CURRENTSPRITE = 32, RUNNING = false, newx = 2, newy = 19, name = "yellow"}
    pinkghost = {x = 70.4, y = 70.4, gridx = 10, gridy = 12, SPRITE1 = 34, SPRITE2 = 35, CURRENTSPRITE = 35, RUNNING = false, newx = 19, newy = 19, name = "pink"}
    ghosts = {redghost, blueghost, yellowghost, pinkghost}
    depoghosts = {redghost, blueghost, yellowghost, pinkghost}
    redcorners = {{2, 2}, {10, 10}, {10, 2}, {2, 8}}
    bluecorners = {{19, 2}, {11, 10}, {11, 2}, {19, 8}}
    yellcorners = {{2, 14}, {2, 19}, {10, 19}, {10, 14}}
    pinkcorners = {{19, 19}, {11, 19}, {11, 14}, {19, 14}}
    randy = nil
    r = true
    debug = nil
    SCORE = 0

    map = {
        {8,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  9},
        {3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3},
        {3,  0, 14, 20, 20, 17,  0, 14, 20, 20, 20, 20, 17,  0, 14, 20, 20, 17,  0,  3},
        {3,  0, 21, 30, 30, 22,  0, 21, 30, 30, 30, 30, 22,  0, 21, 30, 30, 22,  0,  3},
        {3,  0, 15, 19, 19, 18,  0, 15, 19, 19, 19, 19, 18,  0, 15, 19, 19, 18,  0,  3},
        {3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3},
        {3,  0, 10,  4,  4, 11,  0, 13,  0, 10, 11,  0, 13,  0, 10,  4,  4, 11,  0,  3},
        {3, 36,  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0, 36,  3},
        {3,  4,  4,  4,  4,  9,  0, 12,  0, 10, 11,  0, 12,  0,  8,  4,  4,  4,  4,  3},
        {3, 30, 30, 30, 30,  3,  0,  0,  0,  0,  0,  0,  0,  0,  3, 30, 30, 30, 30,  3},
        {3, 30, 30, 30, 30,  3,  0, 14, 20, 26, 26, 20, 17,  0,  3, 30, 30, 30, 30,  3},
        {3, 30, 30, 30, 30,  3,  0, 21, 30, 30, 30, 30, 22,  0,  3, 30, 30, 30, 30,  3},
        {3,  4,  4,  4,  4,  5,  0, 15, 19, 19, 19, 19, 18,  0,  7,  4,  4,  4,  4,  3},
        {3, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36,  3},
        {3,  0, 13,  0, 13,  0, 13,  0, 14, 20, 20, 17,  0, 13,  0, 13,  0, 13,  0,  3},
        {3,  0, 12,  0, 12,  0, 12,  0, 15, 19, 19, 18,  0, 12,  0, 12,  0, 12,  0,  3},
        {3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3},
        {3,  0, 10,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4, 11,  0,  3},
        {3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3},
        {7,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  5}
    }
    currentPacAnimationFrame = 1
    pacAnimationAlarm = makeAlarm(5, updatePacAnimation)
    pacMovementAlarm = makeAlarm(1, updatePacMovement)
    ghostsLeaveAlarm = makeAlarm(90, startGhostAi)
    ghostsAnimationAlarm = makeAlarm(5, updateGhostsAnimation)
    ghostMovementAlarm = makeAlarm(7, updateGhostMovement)
    pacGodAlarm = makeAlarm(-1, updatePacGodMode)
    ghostResetAlarm = makeAlarm(-1, restartGhost)
    randyDoubleCheekedUpOnAFridayNight = false
    Markas_KaRPoVaS = {}
end

function _update()
    -- update game
    if STATE == 1 then
        if dead != true or SCORE < 160 then
            updateAlarms()
            randyDoubleCheekedUpOnAFridayNight = checkGhostCollision()
            if randyDoubleCheekedUpOnAFridayNight == true then
                sfx(3)
                dead = true
            end
            if player.x % player.SIZE == 0 and player.y % player.SIZE == 0 then
                player.gridx = player.x / player.SIZE + 1
                player.gridy = player.y / player.SIZE + 1
                handleInput()
                handleNomNom()
            end
            for ghost in all(ghosts) do
                if ghost.x % 6.4 < 1 then
                    ghost.gridx = (ghost.x / 6.4) + 1
                end
                if ghost.y % 6.4 < 1 then
                    ghost.gridy = (ghost.y / 6.4) + 1
                end
            end
        else
            if btnp(BUTTON1) then
                _init()
            end
        end
    elseif STATE == 0 then
        if btnp(DOWN) and cursorSelection < 3 then
            cursorSelection += 1
            sfx(4)
        elseif btnp(UP) and cursorSelection > 1 then
            cursorSelection -= 1
            sfx(4)
        elseif btnp(BUTTON1) then
            if cursorSelection == 3 then
                sfx(5)
                cls()
                stop()
            elseif cursorSelection == 1 then
                sfx(5)
                STATE = 1
            elseif cursorSelection == 2 then
                sfx(5)
                STATE = 2
            end
        end
    else
        if btnp(BUTTON1) then
            sfx(5)
            cursorSelection = 0
            STATE = 0
        end
    end
end

function _draw()
    -- draw game
    cls(0)
    if STATE == 1 then
        if dead != true then
            if SCORE < 160 then
                print("score\n" .. SCORE, 9, 62)
                for i = 1, #map do
                    for k, v in pairs(map[i]) do
                        spr(v, k*6.4 - 6.4, i*6.4 - 6.4)
                    end
                end
                spr(currentPacAnimationFrame, player.x, player.y, 1, 1, player.flipx, player.flipy)
                for ghost in all(ghosts) do
                    if player.isGod == false then
                        spr(ghost.CURRENTSPRITE, ghost.x, ghost.y)
                    else
                        spr(37, ghost.x, ghost.y)
                    end
                end
            else
                print("you won!", 48, 53)
            end
        else
            print("you died", 48, 53)
            print("pRESS z TO CONTINUE", 28, 73)
        end
    elseif STATE == 0 then
        rect(33,28,93,43,YELLOW)
        print("play",55,33)
        rect(33,48,93,63,YELLOW)
        print("how to play",42,53)
        rect(33,68,93,83,YELLOW)
        print("quit",56,73)
        print("manpac",52,13)
        print("remastered", 43, 19)
        print("remastered", 43, 19)
        print("recreation trademark of\nblobber games 2023-2023", 17, 115)
        if(cursorSelection == 1) then
            rectfill(33,28,93,43,ORANGE)
            print("play",55,33,WHITE)
        elseif(cursorSelection == 2) then
            rectfill(33,48,93,63,ORANGE)
            print("how to play",42,53, WHITE)
        elseif(cursorSelection == 3) then
            rectfill(33,68,93,83,ORANGE)
            print("quit",56,73, WHITE)
        end
    else
        cls(1)
        print("how to play",42,4, WHITE)
        line(41, 11, 85, 11)
        spr(2, 10, 20)
        print("control man-pac using\n   the arrow keys", 28, 18)
        spr(0, 10, 37)
        print("collect 160 food to win", 28, 38)
        spr(36, 10, 54)
        print("yellow food allows\nyou to kill ghosts", 28, 52)
        spr(27, 10, 71)
        spr(29, 15, 71)
        spr(32, 10, 76)
        spr(34, 15, 76)
        print("ghosts will patrol the\nmap... try your best\nnot to get caught", 28, 69)
        spr(38, 10, 90)
        print("you only get 1 life\n    good luck!", 28, 90)
        rectfill(33,108,93,123,ORANGE)
        print("back",56,113, WHITE)
    end
end

function updatePacAnimation()
    if currentPacAnimationFrame == 1 then
        if player.DIRECTION == UP or player.DIRECTION == DOWN then
            currentPacAnimationFrame = 25
        else
            currentPacAnimationFrame = 2
        end
    else
        currentPacAnimationFrame = 1
    end
    startAlarm(5, pacAnimationAlarm)
end

function updatePacMovement()
    if player.DIRECTION == RIGHT then
        if map[player.gridy][player.gridx + 1] == 0 or map[player.gridy][player.gridx + 1] == 30 or map[player.gridy][player.gridx + 1] == 36 then
            player.x += player.SPEED
        end
    elseif player.DIRECTION == LEFT then
        if map[player.gridy][player.gridx - 1] == 0 or map[player.gridy][player.gridx - 1] == 30 or map[player.gridy][player.gridx - 1] == 36 then
            player.x -= player.SPEED
        end
    elseif player.DIRECTION == UP then
        if map[player.gridy - 1][player.gridx] == 0 or map[player.gridy - 1][player.gridx] == 30 or map[player.gridy - 1][player.gridx] == 36 then
            player.y -= player.SPEED
        end
    elseif player.DIRECTION == DOWN then
        if map[player.gridy + 1][player.gridx] == 0 or map[player.gridy + 1][player.gridx] == 30 or map[player.gridy + 1][player.gridx] == 36 then
            player.y += player.SPEED
        end
    end
    startAlarm(1, pacMovementAlarm)
end

function handleInput()
    if btn(UP) then
        player.DIRECTION = UP
        player.flipx = false
        player.flipy = true
    elseif btn(DOWN) then
        player.DIRECTION = DOWN
        player.flipx = false
        player.flipy = false
    elseif btn(RIGHT) then
        player.DIRECTION = RIGHT
        player.flipx = false
        player.flipy = false
    elseif btn(LEFT) then
        player.DIRECTION = LEFT
        player.flipx = true
        player.flipy = false
    end
end

function handleNomNom()
    if map[player.gridy][player.gridx] == 0 then
        map[player.gridy][player.gridx] = 30
        SCORE += 1
        sfx(0)
    end
    if map[player.gridy][player.gridx] == 36 then
        map[player.gridy][player.gridx] = 30
        SCORE += 1
        player.isGod = true
        sfx(2)
        startAlarm(300, pacGodAlarm)
    end 
end

function updateGhostsAnimation()
    for ghost in all(ghosts) do
        if ghost.CURRENTSPRITE == ghost.SPRITE1 then
            ghost.CURRENTSPRITE = ghost.SPRITE2
        else
            ghost.CURRENTSPRITE = ghost.SPRITE1
        end
    end
    startAlarm(5, ghostsAnimationAlarm)
end

function goToPoint(ghost, x, y)
    if ghost.gridx != x or ghost.gridy != y then
        if ghost.RUNNING == true then
            if ghost.gridx > x then
                if map[ghost.gridy][ghost.gridx - 1] == 0 or map[ghost.gridy][ghost.gridx - 1] == 30 or map[ghost.gridy][ghost.gridx - 1] == 36 then
                    ghost.x -= 1.28
                    return
                end
            elseif ghost.gridx < x then
                if map[ghost.gridy][ghost.gridx + 1] == 0 or map[ghost.gridy][ghost.gridx + 1] == 30 or map[ghost.gridy][ghost.gridx + 1] == 36 then
                    ghost.x += 1.28
                    return
                end
            end
            if ghost.gridy > y then
                if map[ghost.gridy - 1][ghost.gridx] == 0 or map[ghost.gridy - 1][ghost.gridx] == 30 or map[ghost.gridy - 1][ghost.gridx] == 36 then
                    ghost.y -= 1.28
                    return
                end
            elseif ghost.gridy < y then
                if map[ghost.gridy + 1][ghost.gridx] == 0 or map[ghost.gridy + 1][ghost.gridx] == 30 or map[ghost.gridy + 1][ghost.gridx] == 36 then
                    ghost.y += 1.28
                    return
                end
            end
        end
    end
    return true
end

function startGhostAi()
    if #depoghosts > 0 then
        ghosts[1].x = 57.6
        ghosts[1].y = 57.6
        ghosts[1].RUNNING = true
        ghosts[1].gridx = (ghosts[1].x / 6.4) + 1
        ghosts[1].gridy = (ghosts[1].y / 6.4) + 1
        deli(depoghosts, 1)
        temp = ghosts[1]
        deli(ghosts, 1)
        add(ghosts, temp)
        startAlarm(30, ghostsLeaveAlarm)
    end
end

function updateGhostMovement()
    for ghost in all(ghosts) do
        randy = goToPoint(ghost, ghost.newx, ghost.newy)
        if randy == true then
            if ghost.name == "red" then
                randcorner = flr(rnd(#redcorners)) + 1
                ghost.newx = redcorners[randcorner][1]
                ghost.newy = redcorners[randcorner][2]
            elseif ghost.name == "blue" then
                bluecorner = flr(rnd(#bluecorners)) + 1
                ghost.newx = bluecorners[bluecorner][1]
                ghost.newy = bluecorners[bluecorner][2]
            elseif ghost.name == "yellow" then
                yellcorner = flr(rnd(#yellcorners)) + 1
                ghost.newx = yellcorners[yellcorner][1]
                ghost.newy = yellcorners[yellcorner][2]
            else
                pinkcorner = flr(rnd(#pinkcorners)) + 1
                ghost.newx = pinkcorners[pinkcorner][1]
                ghost.newy = pinkcorners[pinkcorner][2]
            end
        end
    end
    startAlarm(2, ghostMovementAlarm)
end

function checkGhostCollision()
    if pget(player.x + 4, player.y + 4) != 10 or pget(player.x + 4, player.y + 3) != 10 then
        if pget(player.x + 4, player.y + 4) == 15 or pget(player.x + 4, player.y + 3) == 15 then return false end
        if pget(player.x + 4, player.y + 4) == 0 or pget(player.x + 4, player.y + 3) == 0 then return false end
        if player.isGod == false then
            return true
        else
            sfx(1)
            resetGhost(getGhostNearPlayer())
        end
    end
    return false
end

function updatePacGodMode()
    player.isGod = false
end

function resetGhost(ghost)
    ghost.RUNNING = false
    if ghost.name == "red" then
        ghost.x = 51.2
        ghost.y = 70.4
    elseif ghost.name == "blue" then
        ghost.x = 57.6
        ghost.y = 70.4
    elseif ghost.name == "yellow" then
        ghost.x = 64
        ghost.y = 70.4
    else
        ghost.x = 70.4
        ghost.y = 70.4
    end
    add(Markas_KaRPoVaS, ghost)
    startAlarm(300, ghostResetAlarm)
end

function getGhostNearPlayer()
    local distance = 32767
    local AndrewTate = nil
    for ghost in all(ghosts) do
        x = ghost.x - player.x
        y = ghost.y - player.y
        if sqrt(x*x + y*y) < distance then
            distance = sqrt(x*x + y*y)
            AndrewTate = ghost
        end
    end
    return AndrewTate
end

function restartGhost()
    if #Markas_KaRPoVaS > 0 then
        ghost = Markas_KaRPoVaS[1]
        if ghost.name == "red" then
            ghosts[1].RUNNING = true
            ghosts[1].x = 57.6
            ghosts[1].y = 57.6
        elseif ghost.name == "blue" then
            ghosts[2].RUNNING = true
            ghosts[2].x = 57.6
            ghosts[2].y = 57.6
        elseif ghost.name == "yellow" then
            ghosts[3].RUNNING = true
            ghosts[3].x = 57.6
            ghosts[3].y = 57.6
        else
            ghosts[4].RUNNING = true
            ghosts[4].x = 57.6
            ghosts[4].y = 57.6
        end
        del(Markas_KaRPoVaS, ghost)
        startAlarm(300, ghostResetAlarm)
    end
end

__gfx__
00000000000000000000000000100100000000000010010000100100001001000000000000000000000000000000000000100100000000000000000000100000
00000000000000000000000000100100000000000010010000100100001001000000000000000000000000000000000000100100000110000000000000100000
00000000000aa000000aaa0000100100111111111110010011100111001001110011111111111100001111111111110000100100001001000000111100100000
000ff00000aaaa0000aaa00000100100000000000000010000000000001000000010000000000100010000000000001000100100001001000001000000100000
000ff00000aaaa0000aaa00000100100000000000000010000000000001000000010000000000100010000000000001000100100001001000010000000010000
00000000000aa000000aaa0000100100111111111111110011100111001111110010011111100100001111111111110000100100001001000010000000001111
00000000000000000000000000100100000000000000000000100100000000000010010000100100000000000000000000011000001001000010000000000000
00000000000000000000000000100100000000000000000000100100000000000010010000100100000000000000000000000000001001000010000000000000
00000000000000000000010000000000000000000010000000000100000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000010000000000000000000010000000000100000000000000000000000000000000000000000000000000000000000000000000000000
000000001111000000000100000000001111111100100000000001001100000000000011000aa000cccccccc0008800000088000000cc00000000000000cc000
00000000000010000000010000000000000000000010000000000100001000000000010000aaaa00000000000068680000868600006c6c000000000000c6c600
00000000000001000000100000000000000000000010000000000100001000000000010000aaaa0000000000008888000088880000cccc000000000000cccc00
00000000000001001111000011111111000000000010000000000100001000000000010000a00a0000000000008008000080080000c00c000000000000c00c00
00000000000001000000000000000000000000000010000000000100001000000000010000000000000000000000000000000000000000000000000000000000
00000000000001000000000000000000000000000010000000000100001000000000010000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa000000aa000000ee000000ee000000000000001100000080800000000000000000000000000000000000000000000000000000000000000000000000000
006a6a0000a6a600006e6e0000e6e600000aa0000016160000888880000000000000000000000000000000000000000000000000000000000000000000000000
00aaaa0000aaaa0000eeee0000eeee00000aa0000011110000888880000000000000000000000000000000000000000000000000000000000000000000000000
00a00a0000a00a0000e00e0000e00e00000000000010010000088800000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000e0501f0502705032050370503c0503f05017550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000004250082500d250122501525004350043502f0002b000250001b0000f0000600003000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000205002050030500505015050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002c55006550075502c4500a550095502955007550085502945003550055502455008550000000c050000000c0500000000000000000000000000000000000000000000000000000000000000000000000
001000001675000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002675000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
