function fish_git_global_commands
    set -l aliases_file (dirname (status -f))/__fastgit_aliases.fish
    if not test -f "$aliases_file"
        __fastgit_generate_aliases; or exit 1
    end
    set -g __fastgit_global_commands 'true'
    source "$aliases_file"
end
