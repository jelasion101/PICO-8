EMPTY_SPRITE = 1
NONE_SPRITE = 1
MINE_SPRITE = 2
ONE_SPRITE = 3
TWO_SPRITE = 4
THREE_SPRITE = 5
FOUR_SPRITE = 6
FIVE_SPRITE = 7
SIX_SPRITE = 8
SEVEN_SPRITE = 9
EIGHT_SPRITE = 10
HIDDEN_SPRITE = 11
FLAGGED_SPRITE = 12
CURSOR_SPRITE = 13
BOARDSIZE = 15

function _init()

	gameOver = false
	cursorX = 0
	cursorY = 0
	
	board = {} --the grid of squares
	
	--make a 16 x 16 grid starting at 0,0
	--Each cell in the grid contains an object
	for i=0,BOARDSIZE do
		board[i] = {}
		for j = 0, BOARDSIZE do
			board[i][j] = {hidden = true, mined = false, flagged = false, adjacentMines = 0}
		end
	end
	
	ResetGame()	
end

function _update()
	
	if (btnp(LEFT) and cursorX > 0) then cursorX -= 1 
	elseif (btnp(RIGHT) and cursorX < BOARDSIZE) then  cursorX += 1 
	elseif (btnp(UP) and cursorY > 0) then cursorY -= 1 
	elseif (btnp(DOWN) and cursorY < BOARDSIZE) then  cursorY += 1 
	elseif (btnp(BUTTON1)) then
		if (not gameOver) then
			ShowSquare(cursorX,cursorY)
		else
			ResetGame()
		end
	elseif (btnp(BUTTON2) and board[cursorX][cursorY].hidden) then
		board[cursorX][cursorY].flagged = not board[cursorX][cursorY].flagged
	end
	
end


--Do not modify
function _draw()

	cls(0)

	for i=0,BOARDSIZE do
		for j=0,BOARDSIZE do
			s = board[i][j]
			if (s.hidden and not s.flagged  ) then
				spr(HIDDEN_SPRITE, i*8, j*8)
			elseif (s.hidden and s.flagged  ) then
				spr(FLAGGED_SPRITE, i*8, j*8)  
			elseif (not s.hidden) then
				if (s.mined == true) then
					spr(MINE_SPRITE, i*8, j*8)  
				elseif (s.adjacentMines == 0 )  then
					spr(NONE_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 1 )  then
					spr(ONE_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 2)  then
					spr(TWO_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 3)  then
					spr(THREE_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 4)  then
					spr(FOUR_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 5)  then
					spr(FIVE_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 6)  then
					spr(SIX_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 7) then
					spr(SEVEN_SPRITE, i*8, j*8)
				elseif (s.adjacentMines == 8) then
					spr(EIGHT_SPRITE, i*8, j*8)
				end	
			end
		end
	end
	
	spr(CURSOR_SPRITE, cursorX*8, cursorY * 8)
end

--Don't make any changes
function ResetGame()
	ResetBoard()
	PlaceMines()
	SetAdjacentMineCounts()	
	gameOver = false
end

--This function tests if a square has a mine.
--It needs to return 1 if square i,j has a mine
--and 0 if it doesn't (or i or j is off the board).  
--
--Step 1: Check that square i,j is actually on the board
--meaning if i or j is less than 0 or greater 15, return 0.
--
--Step 2: If square i,j has a mine, return 1, otherwise 
--return 0
function HasMine(i,j)
	if i < 0 or i > BOARDSIZE then return 0 end
	if j < 0 or j > BOARDSIZE then return 0 end
	if board[i][j].mined == true then
		return 1
	end
	return 0
end


--This function returns the number of mines adjacent 
--to square i,j.
--
--Use the HasMine() function to get a count of the 
--the mines in the eight squares around i,j
--See the diagram in the PDF.

function CountAdjacentMines(i,j)
	return HasMine(i-1, j-1) +
			HasMine(i, j-1) +
			HasMine(i+1, j-1) +
			HasMine(i+1, j) +
			HasMine(i+1, j+1) +
			HasMine(i, j+1) +
			HasMine(i-1, j+1) +
			HasMine(i-1, j)
end

--This function needs to place 35 mines 
--at random coordinates on the board.
function PlaceMines()
	--Make a loop that runs 35 times
	--Inside the loop generate 2 numbers, x and y, 
	--that are between 0-15 (inclusive)
	--Use the numbers as the indexes to set the "mined"
	--property of the square at that coordinate to true
	for i = 0, flr(BOARDSIZE * 2.33) do
		x = flr(rnd(BOARDSIZE + 1))
		y = flr(rnd(BOARDSIZE + 1))
		board[x][y].mined = true
	end
end

--Do not modify
function SetAdjacentMineCounts()
	for i=0,15 do
		for j=0,15 do
			board[i][j].adjacentMines = CountAdjacentMines(i,j) 
		end
	end

end

--Don't make any changes to this
function ShowSquare(i,j)
	if i < 0 or i > BOARDSIZE then return end
	if j < 0 or j > BOARDSIZE then return end
	if board[i][j].hidden == true then
		board[i][j].hidden = false
		if board[i][j].mined == true then
			gameOver = true
			sfx(0)
			RevealBoard()
		else
			if CountAdjacentMines(i, j) == 0 then
				ShowSquare(i-1, j-1)
				ShowSquare(i, j-1)
				ShowSquare(i+1, j-1)
				ShowSquare(i+1, j)
				ShowSquare(i+1, j+1)
				ShowSquare(i, j+1)
				ShowSquare(i-1, j+1)
				ShowSquare(i-1, j)
			end
		end
	else
		return
	end
end




--This function returns the board to a "clean"
--state without any mines.
function ResetBoard()	

	--Set every cell on the board's:
	--hidden property to false,
	--mined property to false
	--adjacentMines to 0
	--flagged to false

	for i=0,BOARDSIZE do
		for j=0,BOARDSIZE do
			board[i][j].hidden = true
			board[i][j].mined = false
			board[i][j].flagged = false
			board[i][j].adjacentMines = 0
		end
	end
end

--Set the hidden property of every cell on the 
--board to false
function RevealBoard()
	for i=0,15 do
		for j=0,15 do
			board[i][j].hidden = false
		end
	end
end

