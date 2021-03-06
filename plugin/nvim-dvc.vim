if exists('g:loaded_nvim_dvc')
	finish
endif

command! -complete=customlist,StagesKeys -nargs=? DVCStages execute 'lua require("nvim-dvc").dvc_stages("'..<q-args>..'")'

command! DVCMetrics execute 'lua require("nvim-dvc").dvc_metrics()'
command! DVCFiles execute 'lua require("nvim-dvc").dvc_files()'
command! DVCConfig execute 'lua require("nvim-dvc").dvc_config()'
command! -complete=customlist,StagesKeys -nargs=? DVCRepro execute '!dvc repro '.<q-args>

function! StagesKeys(A, L, P) abort
	let a = split(system('dvc stage list --names-only 2>/dev/null'))
	call map(a, {idx, val -> substitute(trim(val), '\"', '', 'g')})
	return filter(a, 'v:val =~ ''\V\^''.a:A')
endfunction

let g:loaded_nvim_dvc = 1

