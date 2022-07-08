function! vim_fourmolu#FourmoluWriteOn()
    let g:fourmolu_write = 1
endfunction

function! vim_fourmolu#FourmoluWriteOff()
    let g:fourmolu_write = 0 
endfunction

function! vim_fourmolu#FourmoluWriteToggle()
    if g:fourmolu_write
        let g:fourmolu_write = 0
    else
        let g:fourmolu_write = 1
    endif
endfunction

function! vim_fourmolu#FourmoluFmt() range
    if !executable(g:fourmolu_executable)
        echoerr "Couldn't run " . g:fourmolu_executable
    else

        silent! exe "w !" . g:fourmolu_executable . " --no-cabal > /dev/null 2>&1"

        if v:shell_error
            echo "Parse error"
        else
            silent! exe "undojoin"
            silent! exe "keepjumps " . a:firstline . "," . a:lastline
                \ . "!" . g:fourmolu_executable
                \ . " --no-cabal "
        endif

        call winrestview(b:winview)
	endif
endfunction

function! vim_fourmolu#FourmoluWriteRun()
	if g:fourmolu_write
		let b:winview = winsaveview()
		exe "%call vim_fourmolu#FourmoluFmt()"
	endif
endfunction
