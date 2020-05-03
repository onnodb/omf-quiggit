# Quiggit initializations

# List of "all" Git commands (or at least the ones we bother with here)
set -g __quiggit_git_commands \
    config \
    init clone \
    add status diff commit notes restore reset rm mv \
    branch checkout switch merge mergetool log stash tag worktree \
    fetch pull push remote submodule \
    show log diff difftool range-diff shortlog describe \
    apply cherry-pick diff rebase revert \
    bisect blame \
    am format-patch send-email request-pull \
    svn \
    clean gc reflog filter-branch instaweb archive bundle

function __quiggit_git_root_dir -a dir
    set git_root_dir (command git rev-parse --show-toplevel 2>/dev/null)
    switch $dir
        case $git_root_dir\*
            echo $git_root_dir
            return
    end
    return 1
end

function __quiggit_get_aliases -d 'Returns a list of git alias names'
    git config -z --get-regexp 'alias\..*' | while read -lz alias command _
        set alias (string replace 'alias.' '' -- $alias)
        echo $alias
    end
end

function __quiggit_status
    if [ "$__quiggit_verbose_status" = 'yes' ]
        command git status
    else
        command git status -sb
    end
end

function __quiggit_activate
    # Running an empty command will now run git-status
    function __quiggit_preexec -e fish_preexec -a cmd
        set cmd (string trim "$cmd")
        if [ "$cmd" = "" ]
            __quiggit_status
        end
    end

    # Set up abbreviations for common git commands
    set -g __quiggit_abbr_created
    for cmd in $__quiggit_git_commands (__quiggit_get_aliases)
        if abbr -q $cmd
            # This abbreviation is already defined. Skip it.
        else
            abbr -a -g $cmd "git $cmd"
            set -a __quiggit_abbr_created $cmd
        end
    end

    set -g __quiggit_active 1
end

function __quiggit_deactivate
    functions -e __quiggit_preexec

    for cmd in $__quiggit_abbr_created
        abbr -g -e $cmd
    end

    set -g -e __quiggit_abbr_created
    set -g -e __quiggit_active
end

function __quiggit_pwd_change -v PWD -d 'Triggers when the user CDs into a directory'
    set -l git_root_dir (__quiggit_git_root_dir $PWD)
    or begin
        set -q __quiggit_active
        and __quiggit_deactivate
        return
    end

    set -q __quiggit_active
    or __quiggit_activate
end

__quiggit_pwd_change
