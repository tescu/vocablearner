#!/usr/bin/env lua
-- Dictgame
-- TODO (in order of importance):
-- * choose language at runtime
-- * option between typing the word or choosing it via its assigned number
-- * randomize options
-- * make interface pretty/readable
-- * more game modes
-- * more languages
-- * custom dictionaries?

math.randomseed(os.time())

-- Player score and lose count
local score = 0
local lose = 0
-- Maximum number of wrong guesses
local max = 3

-- Read and parse the tsv file
local function readtsv(filename)
	local data = {}
	local i=1
	
	-- Open the file for reading
	local file = io.open(filename, "r")
	if not file then
		error("Could not open "..filename)
	end
	
	-- Read each line in the file
	for line in file:lines() do
		local fields = {}
		for field in line:gmatch("([^\t]+)") do
			table.insert(fields, field)
		end
		-- I probably could optimize this but it works
		data[i] = {}
		data[i].word = fields[1]
		data[i].def = fields[2]
		i=i+1
	end
	i=_
	
	-- Close the file
	file:close()
	return data
end

d = readtsv('res/en-de.tsv')

while lose < max do
	nr = math.random(1,#d)
	print(d[nr].word)
	print('options:')
	print('\t'..d[math.random(1,#d)].def)
	print('\t'..d[nr].def)
	print('\t'..d[math.random(1,#d)].def)
	opt=io.read()

	if opt == d[nr].def then
		print('Correct!')
		score = score+1
	else
		print('Wrong! '..max-lose..' tries left.')
		lose = lose+1
	end
end

print('\nYou lost!\nscore: '..score)
