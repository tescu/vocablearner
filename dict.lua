#!/usr/bin/env lua
math.randomseed(os.time())

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
print(d[1].word..' '..d[1].def)
