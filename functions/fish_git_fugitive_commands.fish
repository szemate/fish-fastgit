function fish_git_fugitive_commands
    if not test -f "$__fastgit_aliases_file"
        __fastgit_generate_aliases --source
    end
    set -g __fastgit_fugitive_commands 'true'
end
