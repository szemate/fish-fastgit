function __fastgit_generate_aliases
    begin
        echo "# Generated with 'fish_update_git_aliases'"
        echo

        echo "if test \"\$__fastgit_global_commands\" = 'true'"
        for command in (__fastgit_git_commands)
            if not type -q "$command"
                echo "    alias $command='git $command'"
            end
        end
        echo "end"
        echo

        echo "if test \"\$__fastgit_fugitive_commands\" = 'true'"
        for command in (__fastgit_git_commands)
            if not type -q "G$command"
                echo "    alias G$command='git $command'"
            end
        end
        echo "end"
    end > (dirname (status -f))/__fastgit_aliases.fish
end

function __fastgit_git_commands
    begin
        git help -a | string match -r '  [a-z].*' | string trim | \
            string replace -ra ' +' ' ' | string split ' '
        git config --get-regexp '^alias\.' | string replace 'alias.' '' | \
            string replace -r ' .*' ''
    end | sort | uniq
end
