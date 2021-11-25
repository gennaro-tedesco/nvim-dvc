--[[ this module exposes the interface of lua functions:
define here the lua functions that activate the plugin ]]

local dvc = require("nvim-dvc.dvc")
local config = require("nvim-dvc.config")


local function dvc_stages()
   if dvc.git_root() == "" then
	  print("not a git repository")
	  return nil
   else
	  local dvc_yaml_file = dvc.get_dvc_yaml(dvc.git_root())
	  if dvc_yaml_file == nil then
		 return nil
	  else
		 local stages_lines = {}
		 for s in vim.fn.system("dvc stage list --names-only"):gmatch("[^\r\n]+") do
			table.insert(stages_lines, s)
		 end
		 vim.api.nvim_exec([[:e ]]..dvc_yaml_file, false)
		 local qf_list = {}
		 for _, v in pairs(stages_lines) do
			table.insert(qf_list, {filename = dvc_yaml_file, lnum = dvc.get_key_location(v).row, col = dvc.get_key_location(v).col, text = v})
		 end

		 if config.loc == 'quickfix' then
			vim.fn.setqflist(qf_list, ' ')
			vim.cmd('copen')
		 else
			vim.fn.setloclist(0, qf_list, ' ')
			vim.cmd('lopen')
		 end
	  end
   end
end

local function dvc_metrics()
   if dvc.git_root() == "" then
	  print("not a git repository")
	  return nil
   else
	  local dvc_yaml_file = dvc.get_dvc_yaml(dvc.git_root())
	  if dvc_yaml_file == nil then
		 return nil
	  else
		 local metrics_lines = {}
		 for s in vim.fn.system("dvc metrics show --json | jq '.\"\".data' | grep json | cut -d'\"' -f2"):gmatch("[^\r\n]+") do
			table.insert(metrics_lines, s)
		 end
		 local qf_list = {}
		 for _, v in pairs(metrics_lines) do
			table.insert(qf_list, {filename = v, lnum = 1, col = 1})
		 end

		 if config.loc == 'quickfix' then
			vim.fn.setqflist(qf_list, ' ')
			vim.cmd('copen')
		 else
			vim.fn.setloclist(0, qf_list, ' ')
			vim.cmd('lopen')
		 end
	  end
   end
end

return {
   dvc_stages = dvc_stages,
   dvc_metrics = dvc_metrics,
}

