let g:gutentags_file_list_command = 'git ls-files'

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" config project root markers.
let g:gutentags_project_root = ['.root']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" noremap <silent> <leader>cs :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <leader>cg :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <leader>cc :GscopeFind c <C-R><C-W><cr>
" noremap <silent> <leader>ct :GscopeFind t <C-R><C-W><cr>
" noremap <silent> <leader>ce :GscopeFind e <C-R><C-W><cr>
" noremap <silent> <leader>cf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>ci :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>cd :GscopeFind d <C-R><C-W><cr>
" noremap <silent> <leader>ca :GscopeFind a <C-R><C-W><cr>
"<leader>cs 	Find symbol (reference) under cursor
"<leader>cg 	Find symbol definition under cursor
"<leader>cd 	Functions called by this function
"<leader>cc 	Functions calling this function
"<leader>ct 	Find text string under cursor
"<leader>ce 	Find egrep pattern under cursor
"<leader>cf 	Find file name under cursor
"<leader>ci 	Find files #including the file name under cursor
"<leader>ca 	Find places where current symbol is assigned
