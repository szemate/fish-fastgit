set -g __fastgit_global_commands 'false'
set -g __fastgit_fugitive_commands 'false'
set -g __fastgit_aliases_file (dirname (status -f))/__fastgit_aliases.fish

function __fastgit_generate_aliases
    begin
        echo "# Generated with 'fish_update_git_aliases'"
        echo

        echo "if test \$__fastgit_global_commands = 'true'"
        for command in (__fastgit_git_commands)
            __fastgit_global_alias $command
        end
        echo "end"
        echo

        echo "if test \$__fastgit_fugitive_commands = 'true'"
        for command in (__fastgit_git_commands)
            __fastgit_fugitive_alias $command
        end
        echo "end"
    end > $__fastgit_aliases_file

    if test "$argv[1]" = '--source'
        source $__fastgit_aliases_file
    end
end

function __fastgit_git_commands
    begin
        git help -a | string match -r '  [a-z].*' | string trim | \
            string replace -ra ' +' ' ' | string split ' '
        git config --get-regexp '^alias\.' | string replace 'alias.' '' | \
            string replace -r ' .*' ''
    end | sort | uniq
end

function __fastgit_global_alias -a command
    echo "    if not type -q $command"
    echo "        function $command"
    echo "            git $command \$argv"
    echo "        end"
    echo "    end"
    echo ""
end

function __fastgit_fugitive_alias -a command
    echo "    if not type -q G$command"
    echo "        function G$command"
    echo "            git $command \$argv"
    echo "        end"
    echo "    end"
    echo ""
end
