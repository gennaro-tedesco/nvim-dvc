if exists("g:loaded_nvim_dvc")
	finish
endif

command! DVCStages execute 'lua require("nvim-dvc").dvc_stages()'
command! DVCMetrics execute 'lua require("nvim-dvc").dvc_metrics()'

let g:loaded_nvim_dvc = 1

