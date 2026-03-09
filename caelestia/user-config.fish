set -l bashrc $HOME/.bashrc
test -f "$bashrc"; and source "$bashrc"

zoxide init fish --cmd cd | source

# Conda initialization for Fish shell
set __conda_setup "$('/home/chujo/miniconda3/bin/conda' 'shell.fish' 'hook' 2> /dev/null)"
if test $status -eq 0
    eval "$__conda_setup"
else
    if test -f "/home/chujo/miniconda3/etc/profile.d/conda.fish"
    . "/home/chujo/miniconda3/etc/profile.d/conda.fish"
    else
    set -gx PATH "/home/chujo/miniconda3/bin:$PATH"
    end
end
set -e __conda_setup