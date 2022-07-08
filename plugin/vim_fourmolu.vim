if exists('g:loaded_vim_fourmolu')
  finish
endif
let g:loaded_vim_fourmolu = 1

if !exists("g:fourmolu_write")
    let g:fourmolu_write = 1
endif

if !exists("g:fourmolu_executable") && executable("fourmolu")
    let g:fourmolu_executable = "fourmolu"
endif

command! -range=% FourmoluFmt exe "let b:winview = winsaveview() | <line1>, <line2>call vim_fourmolu#FourmoluFmt()"
command! FourmoluWriteOn exe "call vim_fourmolu#FourmoluWriteOn()"
command! FourmoluWriteOff exe "call vim_fourmolu#FourmoluWriteOff()"
command! FourmoluWriteToggle exe "call vim_fourmolu#FourmoluWriteToggle()"
