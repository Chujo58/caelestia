if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Direnv + Zoxide
    command -v direnv &> /dev/null && direnv hook fish | source
    command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

    # Better ls
    functions -e ls
    alias ls='eza --icons'

    # Abbrs
    abbr lg 'lazygit'
    abbr gd 'git diff'
    abbr ga 'git add .'
    abbr gc 'git commit -m'
    abbr gl 'git log'
    abbr gs 'git status'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb 'git branch'
    abbr gbd 'git branch -d'
    abbr gco 'git checkout'
    abbr gsh 'git show'

    abbr l 'ls'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'


    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
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
end

# if not pgrep --full "ssh-agent" >//dev/null
# 	eval (ssh-agent -c)
# 	ssh-add ~/.ssh/id_ed25519
# end

# Created by `pipx` on 2025-10-28 16:29:26
set PATH $PATH /home/chujo/.local/bin

# Add bin to path
fish_add_path ~/bin
