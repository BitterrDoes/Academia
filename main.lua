--- ahhhhhhhhhhhhhhhhhhh
to_big = to_big or function(x) return x end
function len(table)
	local count = 0
	for i in pairs(table) do
		count = count + 1
	end
	return count
end

-- variables
_acad = SMODS.current_mod
G.acad = {}
G.C.acad = {
	border 		= HEX("9df2c2"),
	background 	= HEX("1e4233"),
}

btrFunctions = btrFunctions or {
	tblfind = function(tbl, target)
		for index, value in ipairs(tbl) do
			if value == target then
				return index
			end
		end
		return false
	end
}

_acad.optional_features = function()
    return {
        post_trigger = true,
	}
end

function _acad.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "academia")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			print("Bitter's Temp | loaded ".. file)
			return func
		else
			print("Bitter's Temp | Failed on ".. file, " : ", func)
		end
	end
	return nil
end

function _acad.Load_Dir(directory) -- recursive
	local files = NFS.getDirectoryItems(_acad.path .. "/" .. directory)
	
	for _, filename in ipairs(files) do -- iterate over all files in the directory
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then -- check if its lua
			_acad.Load_file(file_path) -- load lua file
		elseif not file_path:find("%.") then
			_acad.Load_Dir(directory.. "/".. filename)
		end
	end
end

-- load scripts
_acad.Load_Dir("Scripts")

_acad.crossmodded = {}
for _, file in pairs(NFS.getDirectoryItems(_acad.path .. "/Compatibility")) do
	local mod = SMODS.find_mod(file)
	if next(mod) then
		_acad.crossmodded[mod[1].id] = mod
		_acad.Load_Dir("Compatibility/".. file)
	end
end

_acad.reset_game_globals = function(run_start)
	if run_start then
		G.GAME.LastGradeVal = G.acad.GradeReq[#G.acad.GradeReq].grade
		G.GAME.LastGrade = G.acad.GradeReq[#G.acad.GradeReq]
	end
end