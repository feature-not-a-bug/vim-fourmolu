function! vim_fourmolu#FourmoluWriteOn()
    let g:fourmolu_write = 1
endfunction

function! vim_fourmolu#FourmoluWriteOff()
    let g:fourmolu_write = 0 
endfunction

function! vim_fourmolu#FourmoluWriteToggle()
    let g:fourmolu_write = !g:fourmolu_write
endfunction

function! vim_fourmolu#FourmoluFmt() range
    if !executable(g:fourmolu_executable)
        echoerr "Couldn't run " . g:fourmolu_executable
    else

        silent! exe "undojoin"
        silent! exe "keepjumps " . a:firstline . "," . a:lastline
            \ . "!" . g:fourmolu_executable
            \ . " --no-cabal "

        call winrestview(b:winview)
    endif
endfunction

function! vim_fourmolu#FourmoluWriteRun()
    if g:fourmolu_write
        let b:winview = winsaveview()
        exe "%call vim_fourmolu#FourmoluFmt()"
    endif
endfunction
