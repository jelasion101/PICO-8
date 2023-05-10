function makeButton(x, y, colorCode, sfx)
    return {x = x, y = y, colorCode = colorCode, sfx = sfx, ticks = 0, on = false}
end

function drawButton(b)
    if b.on == true then
        rectfill(b.x, b.y, b.x + 48, b.y + 24, b.colorCode)
    else
        rect(b.x, b.y, b.x + 48, b.y + 24, b.colorCode)
    end
end

function turnOn(b)
    if b.on == false then
        b.on = true
        b.ticks = 10
        sfx(b.sfx)
    end
end

function turnOff(b)
    if b.on == true then
        b.on = false
    end
end

function updateButton(b)
    if b.ticks > 0 then
        b.ticks -= 1
        if b.ticks == 0 then
            b.on = false
        end
    end
end