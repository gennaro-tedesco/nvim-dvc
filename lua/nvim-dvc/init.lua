--[[ this module exposes the interface of lua functions:
define here the lua functions that activate the plugin ]]

local utils = require("nvim-dvc.utils")


local function dvc_stages()
   if utils.git_root() == "" then
	  print("not a git repository")
	  return nil
   else
	  local dvc_yaml_file = utils.get_dvc_yaml(utils.git_root())
	  if dvc_yaml_file == nil then
		 print("no dvc.yaml file found")
		 return nil
	  else
		 local stages_lines = {}
		 for s in vim.fn.system("dvc stage list"):gmatch("[^\r\n]+") do
			table.insert(stages_lines, string.match(s, "%S+"))
		 end
		 print(vim.inspect(stages_lines))
	  end
   end
end

return {
   dvc_stages = dvc_stages,
}

