function fish_git_fugitive_commands
    set -l aliases_file (dirname (status -f))/__fastgit_aliases.fish
    if not test -f "$aliases_file"
        __fastgit_generate_aliases
    end
    set -g __fastgit_fugitive_commands 'true'
    source "$aliases_file"
end
