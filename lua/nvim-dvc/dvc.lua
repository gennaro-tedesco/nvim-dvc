local function git_root()
   return vim.fn.system("git rev-parse --show-toplevel 2> /dev/null"):gsub("[\r\n]", "")
end

local function get_dvc_yaml(git_root_path)
   local dvc_yaml_file = git_root_path.."/dvc.yaml"
   local f=io.open(dvc_yaml_file,"r")
   if f~=nil then io.close(f) return dvc_yaml_file else return nil end
end

local function get_key_location(key)
   return {
	  row = vim.api.nvim_exec([[g/^\s*\(- \)\?]]..key..[[/echo line('.')]], true),
	  col = vim.api.nvim_exec([[g/^\s*\(- \)\?]]..key..[[/execute "normal! ^" | echo col('.')-1]], true)
   }
end

return {
   git_root = git_root,
   get_dvc_yaml = get_dvc_yaml,
   get_key_location = get_key_location,
}

