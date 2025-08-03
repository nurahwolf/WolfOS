# GENERAL SETTINGS
# ----------------

## This fish configuration uses Starship as a base (if installed)
if type -q starship
	source (starship init fish --print-full-init | psub)
end

## If zoxide is installed, init it
if type -q zoxide
	zoxide init --cmd cd fish | source
end

## If fzf is installed, init it
if type -q fzf
	fzf --fish | source
end

## A welcome message for the user, using fastfetch if installed
function fish_greeting
	if command -q fastfetch
		fastfetch -l /usr/share/fish/vendor_functions.d/wolfos.txt
	end
end

## Custom formatting for man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"


# ENVIRONMENT
# -----------

set -x XDG_CACHE_HOME	"$HOME/.cache"			# For user-specific non-essential (cached) data (analogous to /var/cache).
set -x XDG_CONFIG_HOME	"$HOME/.config"			# For user-specific configurations (analogous to /etc).
set -x XDG_DATA_HOME	"$HOME/.local/share"	# For user-specific data files (analogous to /usr/share).
set -x XDG_STATE_HOME	"$HOME/.local/state"	# For user-specific state files (analogous to /var/lib).

## Setting environment variables to try and stop other programs from causing hell
set -x _JAVA_OPTIONS		"-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
set -x CUDA_CACHE_PATH		"$XDG_CACHE_HOME/cuda"
set -x DOTNET_CLI_HOME		"$XDG_DATA_HOME/dotnet"
set -x GNUPGHOME			"$XDG_DATA_HOME/gnupg"
set -x GOPATH				"$XDG_DATA_HOME/go"
set -x NUGET_PACKAGES		"$XDG_CACHE_HOME/NugetPackages"
set -x STARSHIP_CACHE		"$XDG_CACHE_HOME/starship"
set -x STARSHIP_CONFIG		"$XDG_CONFIG_HOME/starship.toml"
set -x VSCODE_EXTENSIONS	"$XDG_DATA_HOME/vscode/extensions"
set -x WGETRC				"$XDG_CONFIG_HOME/wgetrc"
set -x XAUTHORITY			"$XDG_RUNTIME_DIR/Xauthority"
set -x VSCODE_PORTABLE		"$XDG_DATA_HOME/vscode"
set -x OLLAMA_MODELS		"$XDG_DATA_HOME/ollama/models"
set -x VSCODE_PORTABLE		"$XDG_DATA_HOME/vscode"

## RUST: Environment Variables
set -x CARGO_HOME			"$XDG_DATA_HOME/cargo"
set -x CARGO_CONFIG_HOME	"$XDG_CONFIG_HOME/cargo"
set -x CARGO_DATA_HOME		"$XDG_DATA_HOME/cargo"
set -x CARGO_BIN_HOME		"$CARGO_DATA_HOME/bin"
set -x CARGO_CACHE_HOME		"$XDG_CACHE_HOME/cargo"
set -x RUSTUP_HOME			"$XDG_DATA_HOME/rustup"
set -x RUSTUP_CONFIG_HOME	"$XDG_CONFIG_HOME/rustup"
set -x RUSTUP_CACHE_HOME	"$XDG_CACHE_HOME/rustup"
set -x RUSTFLAGS '-C target-cpu=native' # Tell rust to compile to native code, to enable optimisations like SSE

## Alias for pesky programs
if type -q code
    abbr -a 'code'	'code --extensions-dir "$XDG_DATA_HOME/vscode"'
end

## Add ~/.local/bin to PATH
if test -d ~/.local/bin
    fish_add_path ~/.local/bin
end

## Add /opt/homebrew/bin to PATH
if test -d /opt/homebrew/bin
	fish_add_path /opt/homebrew/bin
end

# ALIASES
# -------

## Use eza if installed
if command -q eza
	alias ls='eza -al --color=always --group-directories-first --icons'	# preferred listing
	alias la='eza -a --color=always --group-directories-first --icons'	# all files and dirs
	alias ll='eza -l --color=always --group-directories-first --icons'	# long format
	alias lt='eza -aT --color=always --group-directories-first --icons'	# tree listing
	alias l.="eza -a | grep -e '^\.'"									# show only dotfiles
else
	alias ls='ls --color=auto'											# Pretty colours with ls!
end

## VIM: Curse you muscle memory!
if command -q nvim
    abbr -a 'vim'	'nvim'
    abbr -a 'vi'	'nvim'
    set -gx EDITOR nvim
else if command -q vim
	abbr -a 'nvim'	'vim'
	abbr -a 'vi'	'vim'
    set -gx EDITOR vim
else if command -q vi
	abbr -a 'nvim'	'vi'
	abbr -a 'vim'	'vi'
	set -gx EDITOR vi
end

## Utilities
abbr -a 'print_path' 'echo -e $PATH//:/\\n'	# Print each PATH entry on a separate line
alias grep='grep --color=auto'

if type -q nc
	alias tb='nc termbin.com 9999' # Terminal Bin
end

## Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias update='pacman -Syu'

## Cleanup orphaned packages
alias cleanup='pacman -Rns (pacman -Qtdq)'

## Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

## Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
