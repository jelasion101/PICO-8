pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include alarms.lua
#include colors.lua



function _init()


	alarm0 = makeAlarm(10,Tick)
	alarm1 = makeAlarm(-1,_init)
	
	list = {}
	top = 1 --the index where you're going to put the biggest number
	
	--Step 1
	--Use a for loop to populate indexes 1 to 128 with
	--the numbers from 1 to 128.
	--
	--for example:  index 1 in the list should contain 1
	--				index 2 in the list should contain 2
	--				index 3 in the list should contain 3...
	
	 for i = 1, 128 do
		add(list, i)
	 end
	 
	
	--Step 2
	--Shuffle the list
	--Repeat 1000 times:
	--	generate a random number 1-128
	--	delete that number from the list
	--	add the number back to the list (to move it to the end)
	
	i = 1
	repeat
		ind = flr(rnd(128)) + 1
		placeholder = list[ind]
		del(list, placeholder)
		add(list, placeholder)
		i += 1
	until i == 1000
end

--Step 3:
--This function performs 1 pass of the sorting algorithm
--to sort "list" into ascending order.
--
--The variable top contains the index to put the highest value in.
--Use a for loop to look at the list entries in indexes 1 to top.
--
--If you find a value at an index that is bigger than the one stored 
--at the top index, exchange the values at those indexes, so the 
--biggest one is at index top.  See the "Shuffling" video.  This is in C#
--but I think you can adapt it to Lua.
--
--
--After the loop, add 1 to top
function Sort()
	 --Complete this using the instructions above
	for i = top + 1, #list do
		if list[top] > list[i] then
			placeholder = list[top]
			list[top] = list[i]
			list[i] = placeholder
		end
	end
	top = top + 1
end

--Don't modify this
function Tick()

	if (top <= 128) then
		Sort()
		
		startAlarm(1, alarm0)
	else
		startAlarm(60, alarm0)
	end

	
end
--Don't alter this
function _update()
	updateAlarms()
end

--Don't modify this
function _draw()
	cls(BLACK)
	color(WHITE)
	print("top index: " .. top, 0, 0)
	
	if (#list == 128) then
	
		for i=1,127 do
			color( (i%15)+1 ) -- draw with the 15 non-black colors
			line(i-1,127,i-1,127 - list[i])
		end
	else
		print("your list needs 128 values!")
	end
end



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
