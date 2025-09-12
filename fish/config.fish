if status is-interactive
    # Starship custom prompt
    starship init fish | source

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

if not pgrep --full "ssh-agent" >//dev/null
	eval (ssh-agent -c)
	ssh-add ~/.ssh/id_ed25519
end
