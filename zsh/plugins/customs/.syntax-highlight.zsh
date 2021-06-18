# This is custom syntax highlight configurations for
# https://github.com/zsh-users/zsh-syntax-highlighting
#
# below settings based on:
# https://framagit.org/phineas0fog/dotfiles/blob/\
#     51385cb0d9ff4b244ecd0293a49c189b1352c1c4/custom/plugins/\
#     zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
ZSH_HIGHLIGHT_STYLES+=(
	default			               'fg=248'
	unknown-token		           'fg=196,bold,bg=234'
	reserved-word		           'fg=197,bold'
	alias			               'fg=magenta,bold'
	builtin			               'fg=107,bold'
	function		               'fg=85,bold'
	command			               'fg=166,bold'
	hashed-command		           'fg=70'
	path			               'fg=30'
	globbing		               'fg=170,bold'
	history-expansion	           'fg=blue'
	single-hyphen-option	       'fg=244'
	double-hyphen-option	       'fg=244'
	back-quoted-argument	       'fg=220,bold'
	single-quoted-argument	       'fg=137'
	double-quoted-argument	       'fg=137'
	dollar-double-quoted-argument  'fg=148'
	back-double-quoted-argument    'fg=172,bold'
	assign			               'fg=240,bold'
)

# Declare the variable
typeset -A ZSH_HIGHLIGHT_PATTERNS

# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
