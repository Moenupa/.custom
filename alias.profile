#!/bin/sh

# dev tools --------------------------------------------------------------------
alias zshconfig='vim ~/.zshrc'
alias fishconfig='vim ~/.config/fish/config.fish'
alias sshconfig='vim ~/.ssh/config'
alias gm='git commit -m'
alias duhid='du -sh .[^.]*'
alias tf='tail -f'
alias t='xargs tail -f'

alias prj='cd $prj'
alias lst='cd $lst'

alias tp='template'

# assume adaptive_alias defined, syntax: adaptive_alias better_cmd fallback_cmd
# if better_cmd exists, alias fallback_cmd to better_cmd
adaptive_alias "vim" "vi"
adaptive_alias "bat" "cat"
adaptive_alias "podman" "docker"
adaptive_alias "tldr" "eg"
adaptive_alias "nail" "pq"

# python -----------------------------------------------------------------------
alias py='python3'
alias pyconfig='vim pyproject.toml'
alias va='source .venv/bin/activate'
alias vd='deactivate'

alias pp='export PYTHONPATH=$(pwd)'

alias ff='ruff format'
alias ffi='ruff check --select I --fix'
alias hfdata='hf download --repo-type dataset'

# slurm ------------------------------------------------------------------------
export SQUEUE_FORMAT='%.10i %.4P %.56j %.8u %.2t %.12M %.2D %R'
export SACCT_FORMAT='JobID%-10,JobName%-56,State,ExitCode,Start,End,Elapsed,NodeList,WorkDir%30'

alias sb='sbatch'
alias scc='scancel'
alias sd='scontrol show jobid -d'
alias sq='squeue'
alias usq='squeue --me'
alias slist='sacct -X -S now-1days'
alias shist='slist | head -n 2; slist -n | sort -k 5 -r' # sorted by start time
alias slast='slist | head -n 2; slist -n | sort -k 6 -r' # sorted by end time
alias sl='slog'
alias sll='slog --local'
