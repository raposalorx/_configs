let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


let g:haskell_indent_if = 3
" if bool
" >>>then ...
" >>>else ...

let g:haskell_indent_case = 2
" case xs of
" >>[]     -> ...
" >>(y:ys) -> ...

let g:haskell_indent_let = 4
" let x = 0 in
" >>>>x

let g:haskell_indent_where = 6
" where f :: Int -> Int
" >>>>>>f x = x

let g:haskell_indent_before_where = 2
" foo
" >>where

let g:haskell_indent_after_bare_where = 2
" where
" >>foo

let g:haskell_indent_do = 3
" do x <- a
" >>>y <- b

let g:haskell_indent_in = 1
" let x = 1
" >in x

let g:haskell_indent_guard = 2
" f x y
" >>|

let g:haskell_indent_case_alternative = 1
" f xs ys = case xs of
" >>[]     -> ...
" >>(y:ys) -> ...

