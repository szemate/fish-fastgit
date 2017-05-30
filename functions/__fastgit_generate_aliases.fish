function __fastgit_generate_aliases
    set -l commands (__fastgit_useful_git_commands)
    begin
        echo -e "# Generated with 'fish_update_git_aliases'\n"

        echo "if test \"\$__fastgit_global_commands\" = 'true'"
        for command in $commands
            if not type -q "$command"
                __fastgit_global_alias $command
            end
        end
        echo -e "end\n"

        echo "if test \"\$__fastgit_fugitive_commands\" = 'true'"
        for command in $commands
            if not type -q "G$command"
                __fastgit_fugitive_alias $command
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

function __fastgit_useful_git_commands
    for command in (__fastgit_all_git_commands)
        switch $command
            case 'credential-*' \
                 'remote-*' \
                 add--interactive \
                 fmt-merge-msg \
                 receive-pack \
                 sh-i18n--envsubst \
                 shell \
                 submodule--helper \
                 upload-archive \
                 upload-pack
                # Skip these
            case '*'
                echo $command
        end
    end
end

function __fastgit_all_git_commands
    begin
        git help -a | string match -r '  [a-z].*' | string trim | \
            string replace -ra ' +' ' ' | string split ' '
        git config --get-regexp '^alias\.' | string replace 'alias.' '' | \
            string replace -r ' .*' ''
    end | sort | uniq
end

function __fastgit_global_alias -a command
    echo    "    function $command"
    echo    "        git $command \$argv"
    echo -e "    end\n"
    echo -e "    complete -c $command -w git-$command\n"
end

function __fastgit_fugitive_alias -a command
    echo    "    function G$command"
    echo    "        git $command \$argv"
    echo -e "    end\n"
    echo -e "    complete -c G$command -w git-$command\n"
end
