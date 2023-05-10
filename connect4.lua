
EMPTY = WHITE

function _init()

	gameOver = false	
	turnColor = RED -- whose turn it is
	cursorCol = 0  -- which column the cursor is in

	board = {}
	
	--TODO: make board a 8 x 8 grid
	for i = 0, 7 do
		board[i] = {}
	end
	--TODO: set all 64 squares to EMPTY
	for i = 0, 7 do
		for k = 0, 7 do
			board[i][k] = EMPTY
		end
	end
end


function _draw()

	--TODO:  1) Clear the screen to yellow
	--		 2) Draw all 64 squares using the DrawSquare function
	--	     3) Call DrawCursor() to draw the cursor
	cls(7)
	for i = 0, 7 do
		for k = 0, 7 do
			DrawSquare(i, k, board[i][k])
		end
	end
	DrawCursor()
end


--Draws a square at x,y in color c
--x is the column (i), y is the row (j)
--x and y should be between 0-7 inclusive
--c is the color of the board at [x][y]
--Don't modify this!
function DrawSquare(x, y, c)
	
	rectfill(x*16,y*16,x*16+15,y*16+15, YELLOW)	 
	circfill(x*16+8,y*16+8,6, c)	
	circ(x*16+8,y*16+8,6, BLACK)

end

--draws the cursor
function DrawCursor()
	
	if (turnColor == RED) then
		rect(cursorCol*16,0,cursorCol*16+16,16,RED)
	else
		rect(cursorCol*16,0,cursorCol*16+16,16,BLACK)
	end

end


--Drop a check in column i
function DropChecker(i)
	--TODO:  Set the highest EMPTY row j in column i in the row to turnColor
	--		 Once you have placed the checker, play sound effect 0 and then
	-- 		 use break to quit out of the loop
	j = 7
	while j >= 0 do
		if board[i][j] == EMPTY then
			board[i][j] = turnColor
			sfx(0)
			SwitchTurn()
			break
		else
			j -= 1
		end
	end
end

--Don't have to modify this
function _update()
	if (gameOver) then
		if (btnp(BUTTON1)) _init()
	else
		if (btnp(LEFT)) then
			if (cursorCol > 0) then
				cursorCol-=1
			end
		elseif (btnp(1)) then
			if (cursorCol < 7) then
				cursorCol +=1
			end
		elseif (btnp(BUTTON1)) then
			DropChecker(cursorCol)
			CheckForWin()
		end
	end
end

function SwitchTurn()
	--TODO:  If turnColor is RED make it BLACK
	--		 Otherwise, make it RED
	if turnColor == RED then
		turnColor = BLACK
	else
		turnColor = RED
	end
end


--Don't have to modify this
function CheckForWin()
	if ( CheckHorizonWin() or
	CheckVerticalWin() or 
	CheckDiagUpWin() or 
	CheckDiagDownWin() ) then
	 sfx(1)
	 gameOver=true
	end
	
end

function CheckHorizonWin()
	
	--put your logic here
	for i = 0, 5 do
		for k = 0, 7 do
			if board[i][k] != WHITE then
				if board[i][k] == board[i+1][k] then
					if board[i][k] == board[i+2][k] then
						if board[i][k] == board[i+3][k] then
							return true
						end
					end
				end
			end
		end
	end
	return false -- leave this as the last line
end

function CheckVerticalWin()
	
	--put your logic here
	for i = 0, 4 do
		for k = 0, 5 do
			if board[i][k] != WHITE then
				if board[i][k] == board[i][k+1] then
					if board[i][k] == board[i][k+2] then
						if board[i][k] == board[i][k+3] then
							return true
						end
					end
				end
			end
		end
	end
	return false -- leave this as the last line
end

function CheckDiagUpWin()
	
	--put your logic here
	for i = 0, 4 do
		for k = 3, 7 do
			if board[i][k] != WHITE then
				if board[i][k] == board[i+1][k-1] then
					if board[i][k] == board[i+2][k-2] then
						if board[i][k] == board[i+3][k-3] then
							return true
						end
					end
				end
			end
		end
	end
	return false -- leave this as the last line
end

function CheckDiagDownWin()

	--put your logic here
	for i = 0, 4 do
		for k = 0, 4 do
			if board[i][k] != WHITE then
				if board[i][k] == board[i+1][k+1] then
					if board[i][k] == board[i+2][k+2] then
						if board[i][k] == board[i+3][k+3] then
							return true
						end
					end
				end
			end
		end
	end
	return false -- leave this as the last line
end