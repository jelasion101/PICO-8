pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- global variables
#include colors.lua
#include alarms.lua
#include button.lua
#include buttons.lua

function _init()
    -- setup game / declare global variables
    index = 1 -- index of the light to flash or check for a match
    inputOk = true -- whether to allow user input
    red = makeButton(40, 0, RED, 1)
    blue = makeButton(0, 40, DARK_BLUE, 2)
    yellow = makeButton(78, 40, YELLOW, 3)
    green = makeButton(40, 80, LIGHT_GREEN, 4)
    buttons = {red, blue, yellow, green} --the four buttons
    lights={} --the sequence to repeat
    nextLightAlarm = makeAlarm(-1, flashLight)
    resetAlarm = makeAlarm(-1, reset)
    addLight()
end

function _update()
    -- update game
    updateAlarms()
	if inputOk == true then
        if btnp(UP) == true then
            pressButton(red)
        elseif btnp(DOWN) == true then
            pressButton(green)
        elseif btnp(LEFT) == true then
            pressButton(blue)
        elseif btnp(RIGHT) == true then
            pressButton(yellow)
        end
    end
end

function _draw()
    -- draw game
    cls(BLACK)
    foreach (buttons, drawButton)
end

function pressButton(b)
    turnOn(b)
    if b.colorCode == lights[index].colorCode then
        index = index + 1
        if index > #lights then
            addLight()
            playAll()
        end
    else
        foreach(buttons, turnOn)
        startAlarm(30, resetAlarm)
    end
end

function addLight()
    c = flr(rnd(4))
    if c == 0 then
        add(lights, makeButton(40, 0, RED, 1))
    elseif c == 1 then
        add(lights, makeButton(0, 40, DARK_BLUE, 2))
    elseif c == 2 then
        add(lights, makeButton(78, 40, YELLOW, 3))
    elseif c == 3 then
        add(lights, makeButton(40, 80, LIGHT_GREEN, 4))
    end
end

function reset()
    lights = {}
    addLight()
    playAll()
end

function flashLight()
    lights[index].on = true
    if index <= #lights then
        index += 1
        startAlarm(15, nextLightAlarm)
        turnOff(lights[index-1])
    else
        index = 1
        inputOk = true
    end

end

function playAll()
    inputOk = false
    index = 1
    startAlarm(30, nextLightAlarm)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000c0500c0500c050000000f0500f0500f0500f0501a0501c050101500f1501305010050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001205012050120500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000705007050070500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000c0500c0500c0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
