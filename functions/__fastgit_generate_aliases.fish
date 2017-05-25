function __fastgit_generate_aliases
    set -l commands (__fastgit_git_commands)
    begin
        echo -e "# Generated with 'fish_update_git_aliases'\n"

        echo "if test \"\$__fastgit_global_commands\" = 'true'"
        for command in $commands
            if not type -q "$command"
                echo "    alias $command='git $command'"
            end
        end
        echo -e "end\n"

        echo "if test \"\$__fastgit_fugitive_commands\" = 'true'"
        for command in $commands
            if not type -q "G$command"
                echo "    alias G$command='git $command'"
            end
        end
        echo -e "end\n"

        echo "function __fastgit_remove_aliases"
        echo "    if test \"\$__fastgit_global_commands\" = 'true'"
        for command in $commands
            if not type -q "$command"
                echo "        functions -e '$command'"
            end
        end
        echo "    end"
        echo "    if test \"\$__fastgit_fugitive_commands\" = 'true'"
        for command in $commands
            if not type -q "G$command"
                echo "        functions -e 'G$command'"
            end
        end
        echo "    end"
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
