alarms = {}

function makeAlarm(t, func)
    local a = {ticks = t, action = func, running = true}
    add(alarms, a)
    return a
end

function updateAlarm(alarm)
    if alarm.ticks > 0 then
        alarm.ticks -= 1
    elseif alarm.ticks == 0 and alarm.running == true then
        alarm.ticks = -1
        alarm.action()
    end
end

function updateAlarms()
    foreach(alarms, updateAlarm)
end

function startAlarm(t, alarm)
    alarm.running = true
    if alarm.ticks == -1 then
        alarm.ticks = t
    end
end

function stopAlarm(alarm)
    alarm.running = false
end