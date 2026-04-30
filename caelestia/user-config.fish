# set -l bashrc $HOME/.bashrc
# test -f "$bashrc"; and source "$bashrc"

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

# if not pgrep --full "ssh-agent" >//dev/null
# 	eval (ssh-agent -c)
# 	ssh-add ~/.ssh/id_ed25519
# end

# Created by `pipx` on 2025-10-28 16:29:26
set PATH $PATH /home/chujo/.local/bin

# Add bin to path
fish_add_path ~/bin

# Bashrc stuff

# Aliases
alias grep='grep --color=auto'
alias copy='wl-copy'

alias neofetch="fastfetch -c none"
alias startwal="systemctl --user start caelestia-wallpaper.timer"
alias stopwal="systemctl --user stop caelestia-wallpaper.timer"
alias config="cd ~/.local/share/caelestia; code .; exit"

# Mounting aliases:
## CANFAR:
alias mount_arc='sshfs clegue@ws-uv.canfar.net:/ $HOME/mounts/canfar -p 64022 -o reconnect -o cache=yes -o kernel_cache -o auto_cache -o attr_timeout=120 -o entry_timeout=120 -o negative_timeout=60 -o compression=no'
# alias mount_arc='sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=10 -p 64022 clegue@ws-uv.canfar.net:/ $HOME/mounts/canfar'
alias unmount_arc='umount $HOME/mounts/canfar'

## Windows partition:
alias mount_win='sudo mount -t ntfs-3g /dev/nvme0n1p3 $HOME/mounts/windows/'
alias unmount_win="sudo umount $HOME/mounts/windows"

# Fish abbreviations
abbr py 'python'
abbr vi 'nvim'
abbr vim 'nvim'

# Exports
export LD_LIBRARY_PATH="/usr/lib"
# export LD_LIBRARY_PATH=/opt/conda/lib:$LD_LIBRARY_PATH
export EDITOR="nvim"