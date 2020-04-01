# NORMAL
`ga` shows the hex code of the cursor position.

`:%!bash` ex ! commands replace their scope with their output.

`g ctrl-A` Like `ctrl-A` but bumps the increment for each matching line.

`Ctrl-w N +/-` moves horizontal splits, accepts a count N

`Ctrl-w N >/<` moves vertical splits, accepts a count N

# INSERT
`ctrl-R` insert register.

# EX
`:e!` or `:bufdo e!` reload buffer or all buffers

`:g/regex/ex` runs ex command on lines that match.

`:v` is the opposite of g. Runs commands on lines that don't match.

`:norm Vim` runs Vim in normal mode on every line in the range.

`:co .` `:mv .` copy or move the range to `.` or a movement.

`:y a` copy range in to the a register. `:y A` append the range to the a register.

# VISUAL
`gv` reuse last visual selection

Visual mode changes can be used as mode changes for movements.
`d<c-V>2j` will convert the motion to blockwise and delete just the middle column.
```
a|bc
abc
abc
```

# VimL
`"=` the expression register evaluates any vimL.

# Plugins
`:[N]T {cmd}` Execute {cmd} in the latest terminal or in terminal#N

# Standards to follow
Use `;` as the inoremap leader because you shouldn't ever type it without a space or newline after.

# Coc
`gd` definition

`gy` type definition

`gi` implementation

`gr` references

`<leader>a` code action; Example: `<leader>aap` for current paragraph

`<leader>ac` code action line

`<leader>qf` quick fix current line

`<leader>rn` rename symbol

`[g` `]g` move forward and back in diagnostics
