# only continue with plugin sourcing if plugins are enabled
[[ $ZSH_PLUGIN_ENABLE -eq 0 ]] && return

is_installed "zoxide" && eval "$(zoxide init zsh)"

# improve performance when using auto-suggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

if is_installed "fzf"; then
  export FZF_DEFAULT_OPTS="--height 40%  \
    --color=bg+:1,gutter:-1 \
    --cycle \
    --layout=reverse \
    --inline-info \
    --border"
  is_installed "fd" && export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"

  # keybindings are placed in different locations on linux / mac, check both here
  if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
  fi

fi

# supports any plugin-repository which has a ${PLUGIN_NAME}.plugin.zsh script
# in the project root all plugins here will be automatically installed / sourced
PLUGINS=(
"https://github.com/zsh-users/zsh-autosuggestions"
"https://github.com/zsh-users/zsh-syntax-highlighting"
"https://github.com/romkatv/gitstatus"
)


function install_plugin() {
  is_installed "git" || return
  mkdir -p $ZSH_PLUGIN_DIR
  git clone $1 $ZSH_PLUGIN_DIR/${1##*/}
}

for plugin in ${PLUGINS}; do
  local p=${plugin##*/}                                                                # get only name of plugin (strip of everything before the first '/')
  [[ ! -d ${ZSH_PLUGIN_DIR}/$p ]] && install_plugin "$plugin"                          # clone plugin repository if it does not exist
  [[ -f $ZSH_PLUGIN_DIR/$p/$p.plugin.zsh ]] && source $ZSH_PLUGIN_DIR/$p/$p.plugin.zsh # source plugin script
done

