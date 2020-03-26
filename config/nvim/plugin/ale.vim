scriptencoding=utf-8

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

" Settings for Ale
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_column_always = 1
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

augroup AleGroup
  autocmd!
  autocmd User ALELint call TouchOpenFile()
augroup END
func! TouchOpenFile() " turn off and sleep and turn on to avoid getting in the way of live server updates.
  let g:ale_enabled = 0
  sleep 500m
  w                                                 
  let g:ale_enabled = 1
endfunc
