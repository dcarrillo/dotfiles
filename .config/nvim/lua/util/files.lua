local M = {}

M.read = function(file)
	local fd = assert(io.open(file, "r"))
	local data = fd:read("*a")
	fd:close()
	return data
end

return M
