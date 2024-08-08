if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.asdf/asdf.fish
    fish_add_path $HOME/.cargo/bin
    fish-ssh-agent
end

# pnpm
set -gx PNPM_HOME "/home/kb/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
