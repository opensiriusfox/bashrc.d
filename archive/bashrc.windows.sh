#!/bin/bash

# When notepad++ is available, use it
function npp() {
    export IFS=$'\n'
    NOTEPADPP_EXE='/c/Program Files/Notepad++/notepad++.exe'
        if [[ -e "${NOTEPADPP_EXE}" ]]; then
                echo 'notepad++.exe '$*' &'
            "${NOTEPADPP_EXE}" $* &
        return 0
    else
        echo "notepad++ not found."
        return 1
    fi
}


alias _wrapping_fix='kill -WINCH $$'
