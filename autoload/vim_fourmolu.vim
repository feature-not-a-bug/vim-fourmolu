function! s:Find_glob(pattern, path)
    let fullpattern = a:path . "/" . a:pattern
    if strlen(glob(fullpattern))
        return 1
    else
        let parts = split(a:path, "/")
        if len(parts)
            let newpath = "/" . join(parts[0:-2], "/")
            return s:Find_glob(a:pattern, newpath)
        else
            return 0
        endif
    endif
endfunction

function! s:Find_cabal()
    if(s:Find_glob("*.cabal", "."))
        return " --stdin-input-file " . @%
    else
        return " --no-cabal "
    endif
endfunction

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

    silent exe "keepjumps " . a:firstline . "," . a:lastline
        \ . "!" . g:fourmolu_executable
        \ . s:Find_cabal()

    if (v:shell_error)
        exe "undo"
            if v:shell_error == 1
                echoerr "General problem"
            elseif v:shell_error == 2
                echoerr "CPP used (deprecated)"
            elseif v:shell_error == 3
                echoerr "Parsing of original input failed"
            elseif v:shell_error == 4
                echoerr "Parsing of formatted code failed"
            elseif v:shell_error == 5
                echoerr "AST of original and formatted code differs"
            elseif v:shell_error == 6
                echoerr "Formatting is not idempotent"
            elseif v:shell_error == 7
                echoerr "Unrecognized GHC options"
            elseif v:shell_error == 8
                echoerr "Cabal file parsing failed"
            elseif v:shell_error == 9
                echoerr "Missing input file path when using stdin input and accounting for .cabal files"
            elseif v:shell_error == 10
                echoerr "Parse error while parsing fixity overrides"
            elseif v:shell_error == 100
                echoerr "In checking mode: unformatted files"
            elseif v:shell_error == 101
                echoerr "Inplace mode does not work with stdin"
            elseif v:shell_error == 102
                echoerr "Other issue (with multiple input files)"
            elseif v:shell_error == 400
                echoerr "Failed to load Fourmolu configuration file"
            endif
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
