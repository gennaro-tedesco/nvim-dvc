function! health#nvim-dvc#check()
	if !has('nvim-0.5')
		call health#report_warn("please install nvim > 0.5")
	else
		call health#report_ok("nvim 0.5 installed")
	endif

" 	check more health conditions here
" 	if !executable('gcc')
" 		health#report_error("gcc not installed")
" 	endif
endfunction

