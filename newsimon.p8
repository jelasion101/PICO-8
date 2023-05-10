pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include colors.lua
#include alarms.lua
#include newbutton.lua
#include buttons.lua

function _init()
    -- setup game / declare global variables
	cls(0)
    inputOk = true -- whether to allow user input
    INDEX = 1
    SCORE = 0
    STARTINGINDEX = nil
    PLAYINDEX = 1
    FIRSTPASS = true
    LOSER = false
    red = makeButton(40, 0, RED, "RED", UP, 0)
    blue = makeButton(0, 40, DARK_BLUE, "BLUE", LEFT, 1)
    yellow = makeButton(78, 40, YELLOW, "YELLOW", RIGHT, 2)
    green = makeButton(40, 80, LIGHT_GREEN, "GREEN", DOWN, 3)
    buttons = {red, blue, yellow, green} --the four buttons
    turnOffAlarm = makeAlarm(-1, turnOffButtons)
    turnOnAlarm = makeAlarm(-1, playNextButton)
    roundAlarm = makeAlarm(-1, playOrder)
    restartAlarm = makeAlarm(-1, reset)
    order = {}
    addOrder()
    startAlarm(30, roundAlarm)
end

function _update()
    -- update game
	updateAlarms()
    playGame()
    if LOSER == true then
        startAlarm(60, restartAlarm)
    end
end

function _draw()
    -- draw game
    cls(BLACK)
    foreach (buttons, drawButton)
    if LOSER == true then
        foreach(buttons, turnOn)
    end
    print(SCORE, 62, 50)
end

function reset()
    _init()
end

function playGame()
    if inputOk == true then
        if btnp(UP) == true and order[PLAYINDEX].keyCode == UP then
            turnOn(order[PLAYINDEX])
            startAlarm(15, turnOffAlarm)
            PLAYINDEX = checkPlayIndex()
            nextRound()
        elseif btnp(DOWN) == true and order[PLAYINDEX].keyCode == DOWN then
            turnOn(order[PLAYINDEX])
            startAlarm(15, turnOffAlarm)
            PLAYINDEX = checkPlayIndex()
            nextRound()
        elseif btnp(LEFT) == true and order[PLAYINDEX].keyCode == LEFT then
            turnOn(order[PLAYINDEX])
            startAlarm(15, turnOffAlarm)
            PLAYINDEX = checkPlayIndex()
            nextRound()
        elseif btnp(RIGHT) == true and order[PLAYINDEX].keyCode == RIGHT then
            turnOn(order[PLAYINDEX])
            startAlarm(15, turnOffAlarm)
            PLAYINDEX = checkPlayIndex()
            nextRound()
        elseif btnp(RIGHT) == true or btnp(LEFT) == true or btnp(UP) == true or btnp(DOWN) == true then
            gameLost()
            return
        end
    end
end

function nextRound()
    if PLAYINDEX == 1 then
        addOrder()
        SCORE += 1
        startAlarm(30, roundAlarm)
    end
end

function addOrder()
    c = flr(rnd(4))
    if c == 0 then
        add(order, red)
    elseif c == 1 then
        add(order, blue)
    elseif c == 2 then
        add(order, yellow)
    elseif c == 3 then
        add(order, green)
    end
end

function playOrder()
    inputOk = false
    FIRSTPASS = true
    STARTINGINDEX = INDEX
    playNextButton()
    startAlarm(30, turnOnAlarm)
end

function playNextButton()
    if INDEX != 1 or FIRSTPASS == true then
        turnOn(order[INDEX])
        FIRSTPASS = false
        INDEX = checkIndex()
    end
    startAlarm(15, turnOffAlarm)
    if INDEX != 1 then
        startAlarm(30, turnOnAlarm)
    else
        inputOk = true
        return
    end
end

function turnOffButtons()
    for i, v in pairs(buttons) do
        turnOff(v)
    end
end

function checkIndex()
    if INDEX >= #order then
        return 1
    else
        return INDEX + 1
    end
end

function checkPlayIndex()
    if PLAYINDEX >= #order then
        return 1
    else
        return PLAYINDEX + 1
    end
end

function gameLost()
    LOSER = true
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00100000100501005010050000000f0000f0001300013000130000a0000e00012000170001b0001f0001800000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001c0501c0501c0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001305013050130500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002405024050240500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
