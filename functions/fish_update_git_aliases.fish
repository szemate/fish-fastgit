function fish_update_git_aliases
    __fastgit_generate_aliases; and \
        source (dirname (status -f))/__fastgit_aliases.fish
end
