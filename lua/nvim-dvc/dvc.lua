local function git_root()
   return vim.fn.system("git rev-parse --show-toplevel 2> /dev/null"):gsub("[\r\n]", "")
end

local function get_dvc_config(git_root_path, filename)
   local complete_path = git_root_path.."/"..filename
   local f=io.open(complete_path,"r")
   if f~=nil then io.close(f) return complete_path else return nil end
end

local function get_key_location(key)
   return {
	  row = vim.api.nvim_exec([[g/^\s*\(- \)\?]]..key..[[/echo line('.')]], true),
	  col = vim.api.nvim_exec([[g/^\s*\(- \)\?]]..key..[[/execute "normal! ^" | echo col('.')-1]], true) + 1
   }
end

return {
   git_root = git_root,
   get_dvc_yaml = get_dvc_config,
   get_key_location = get_key_location,
}

