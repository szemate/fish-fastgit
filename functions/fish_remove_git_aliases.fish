function fish_remove_git_aliases
    set -l aliases_file (dirname (status -f))/__fastgit_aliases.fish
    if not type -q __fastgit_remove_aliases; and test -f $aliases_file
        source $aliases_file
    end
    if type -q __fastgit_remove_aliases
        __fastgit_remove_aliases
    end
end
