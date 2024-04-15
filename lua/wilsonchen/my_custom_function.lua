local M = {}

function M.skip_floating_buffers()
	local win_id = vim.fn.win_getid()
	local win_type = vim.fn.win_gettype(win_id)
	print(win_id)
	print(win_type)
	if win_type == "popup" or win_type == "float" then
		vim.cmd("wincmd w") -- Move to the next window
		vim.cmd("wincmd w") -- Move to the next window
	else
		vim.cmd("wincmd w") -- Default behavior for non-floating windows
	end
end

return M
