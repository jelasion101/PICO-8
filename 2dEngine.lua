
-- draws the supplied object centered at it's x and y
function DrawObject(o)
    if (o.visible == true) then
        spr(o.sprite, o.x-4, o.y-4)
    end
end

-- creates and returns a new object
function NewObject(x, y, sprite, speed, direction, width, height)
    if width == nil then
        width = 8
    end
    if height == nil then
        height = 8
    end
    return {
        x = x,
        y = y,
        sprite = sprite,
        speed = speed, 
        direction = direction, 
        destroy = false, 
        visible = true, 
        Draw = DrawObject,
        w = width,
        h = height
    }
end

-- moves an object based on its speed and directon
function MoveObject(o)
    o.x = o.x + cos(o.direction/360) * o.speed
    o.y = o.y + sin(o.direction/360) * o.speed
end


-- returns true or false based on if x,y is inside of object
function PtInRect(x, y, o)
    if x >= o.x-o.w/2 and x <= o.x+o.w/2 then
        if y >= o.y-o.h/2 and y <= o.y+o.h/2 then
            return true
        end
    end
    return false
end

-- returns true or false based on whether the objects overlap
function RectHit(o1, o2)
    local dx = abs(o2.x - o1.x)
    local dy = abs(o2.y - o1.y)
    if dx <= o1.w/2 + o2.w/2 then
        if dy <= o1.h/2 + o2.h/2 then
            return true
        end
    end
    return false
end

-- moves an object toward destX destY
function MoveToward(o, destX, destY, newSpeed)
    if newSpeed != nil then
        o.speed = newSpeed
    end
    o.direction = atan2(destX - o.x, destY - o.y)*360
end

-- moves an object toward another object
function MoveTowardObject(o, o2, newSpeed)
    if newSpeed != nil then
        o.speed = newSpeed
    end
    o.direction = atan2(o2.x - o.x, o2.y - o.y)*360
end

-- returns the distance between 2 objects
function Distance(o1, o2)
    dx = o1.x - o2.x
    dy = o1.y - o2.y
    return sqrt(dx*dx + dy*dy)
end

-- returns the distance between an object and point
function DistanceToPoint(o1, px, py)
    dx = o1.x - px
    dy = o1.y - py
    return sqrt(dx*dx + dy*dy)
end