function! MyTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')

    " let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    " let s .= ' '
    let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
    let s .= ' ' . i . ' '
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, '&buftype')

    if buftype == 'help'
      let file = 'help:' . fnamemodify(file, ':t:r')

    elseif buftype == 'quickfix'
      let file = 'quickfix'

    elseif buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif

    else
      let file = pathshorten(fnamemodify(file, ':p:~:.'))
      if getbufvar(bufnr, '&modified')
        let file = '+' . file
      endif

    endif

    if file == ''
      let file = '[No Name]'
    endif

    let s .= ' ' . file

    let nwins = tabpagewinnr(i, '$')
    if nwins > 1
      let modified = ''
      for b in buflist
        if getbufvar(b, '&modified') && b != bufnr
          let modified = '*'
          break
        endif
      endfor
      let hl = (i == t ? '%#WinNumSel#' : '%#WinNum#')
      let nohl = (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let s .= ' ' . modified . '(' . hl . winnr . nohl . '/' . nwins . ')'
    endif

    if i < tabpagenr('$')
      let s .= ' %#TabLine#|'
    else
      let s .= ' '
    endif

    let i = i + 1

  endwhile

  let s .= '%T%#TabLineFill#%='
  let s .= '%{ObsessionStatus()}'
"  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

" set showtabline=1
"gruvbox tab colours are in hex
"background=#3c3836
"aqua=#8ec07c
"blue=#83a598
highlight! TabNum gui=bold guibg=#504945
highlight! TabNumSel gui=bold guibg=#282828 guifg=#83a598
highlight! TabLine gui=bold guibg=#504945
highlight! TabLineSel gui=bold guibg=#282828 guifg=#b8bb26
highlight! WinNum gui=bold guibg=#504945
highlight! WinNumSel gui=bold guibg=#282828 guifg=#8ec07c
"highlight! TabNum term=bold,underline cterm=bold,underline ctermfg=1 ctermbg=7 gui=bold,underline guibg=LightGrey
"highlight! TabNumSel term=bold,reverse cterm=bold,reverse ctermfg=1 ctermbg=7 gui=bold
"highlight! WinNum term=bold,underline cterm=bold,underline ctermfg=11 ctermbg=7 guifg=DarkBlue guibg=LightGrey
"highlight! WinNumSel term=bold cterm=bold ctermfg=7 ctermbg=14 guifg=DarkBlue guibg=LightGrey