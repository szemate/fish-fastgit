function __fish_create_git_aliases -a abbrev_type
    set -l git_commands \
        (git | perl -nle 'print $1 if /^   (\w+) /') \
        (git config -l | perl -nle 'print $1 if /^alias\.(\w+)/')
    for command in $git_commands
        set -l abbrev
        switch "$abbrev_type"
        case 'global'
            set abbrev "$command"
        case 'fugitive'
            set abbrev "G$command"
        case '*'
            return 2
        end
        if not type "$abbrev" >/dev/null 2>&1
            alias "$abbrev" "git $command"
        end
    end
end

function fish_git_global_commands
    __fish_create_git_aliases 'global'
end

function fish_git_fugitive_commands
    __fish_create_git_aliases 'fugitive'
end
