# Quiggit initializations

function __quiggit_git_root_dir -a dir
    set git_root_dir (command git rev-parse --show-toplevel 2>/dev/null)
    switch $dir
        case $git_root_dir\*
            echo $git_root_dir
            return
    end
    return 1
end

function __quiggit_status
    if [ "$__quiggit_verbose_status" = 'yes' ]
        command git status
    else
        command git status -sb
    end
end

function __quiggit_activate
    function __quiggit_preexec -e fish_preexec -a cmd
        set cmd (string trim "$cmd")
        if [ "$cmd" = "" ]
            __quiggit_status
        end
    end

    set -g __quiggit_active 1
end

function __quiggit_deactivate
    functions -e __quiggit_preexec
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
