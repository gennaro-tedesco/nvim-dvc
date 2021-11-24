if exists("g:loaded_nvim_dvc")
	finish
endif

command! DVCStages execute 'lua require("nvim-dvc").dvc_stages()'

let g:loaded_nvim_dvc = 1

