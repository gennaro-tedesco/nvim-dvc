if exists('g:loaded_nvim_dvc')
	finish
endif

command! DVCStages execute 'lua require("nvim-dvc").dvc_stages()'
command! DVCMetrics execute 'lua require("nvim-dvc").dvc_metrics()'
command! -complete=customlist,StagesKeys -nargs=? DVCRepro execute '!dvc repro '.<q-args>

function! StagesKeys(A, L, P) abort
	let a = split(system('dvc stage list --names-only 2>/dev/null'))
	call map(a, {idx, val -> substitute(trim(val), '\"', '', 'g')})
	return filter(a, 'v:val =~ ''\V\^''.a:A')
endfunction

let g:loaded_nvim_dvc = 1

