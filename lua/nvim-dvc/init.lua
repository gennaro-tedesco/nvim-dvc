local dvc = require("nvim-dvc.dvc")
local config = require("nvim-dvc.config")

local function dvc_stages()
   if dvc.git_root() == "" then print("not a git repository") return nil end

   local dvc_yaml_file = dvc.get_dvc_yaml(dvc.git_root(), "dvc.yaml")
   if dvc_yaml_file == nil then print("no dvc.yaml file") return nil end

   local stages_lines = {}
   for s in vim.fn.system("dvc stage list --names-only"):gmatch("[^\r\n]+") do
	  table.insert(stages_lines, s)
   end
   if next(stages_lines) == nil then print("no metrics files") return nil end

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

local function dvc_metrics()
   if dvc.git_root() == "" then print("not a git repository") return nil end

   if dvc.get_dvc_yaml(dvc.git_root(), "dvc.yaml") == nil then print("no dvc.yaml file") return nil end

   local metrics_lines = {}
   for s in vim.fn.system("dvc metrics show --json | jq '.\"\".data' | grep json | cut -d'\"' -f2"):gmatch("[^\r\n]+") do
	  table.insert(metrics_lines, s)
   end
   if next(metrics_lines) == nil then print("no metrics files") return nil end

   local qf_list = {}
   for _, v in pairs(metrics_lines) do
	  table.insert(qf_list, {filename = v, lnum = 1, col = 1})
   end

   if config.use_quickfix then
	  vim.fn.setqflist(qf_list, ' ')
	  vim.cmd('copen')
   else
	  vim.fn.setloclist(0, qf_list, ' ')
	  vim.cmd('lopen')
   end
end

local function dvc_files()
   if dvc.git_root() == "" then print("not a git repository") return nil end

   if dvc.get_dvc_yaml(dvc.git_root(), "dvc.yaml") == nil then print("no dvc.yaml file") return nil end

   local files_lines = {}
   for s in vim.fn.system("dvc list -R --dvc-only ."):gmatch("[^\r\n]+") do
	  table.insert(files_lines, s)
   end
   if next(files_lines) == nil then print("no dvc tracked files") return nil end

   local qf_list = {}
   for _, v in pairs(files_lines) do
	  table.insert(qf_list, {filename = v, lnum = 1, col = 1})
   end

   if config.use_quickfix then
	  vim.fn.setqflist(qf_list, ' ')
	  vim.cmd('copen')
   else
	  vim.fn.setloclist(0, qf_list, ' ')
	  vim.cmd('lopen')
   end
end

local function dvc_config()
   if dvc.git_root() == "" then print("not a git repository") return nil end

   local dvc_config_file = dvc.get_dvc_yaml(dvc.git_root(), ".dvc/config")
   if dvc_config_file == nil then
	  print("no dvc config file")
	  return nil
   else
	  vim.api.nvim_exec([[:e ]]..dvc_config_file, false)
   end
end

return {
   dvc_stages = dvc_stages,
   dvc_metrics = dvc_metrics,
   dvc_files = dvc_files,
   dvc_config = dvc_config,
}

