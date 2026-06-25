#!/bin/zsh
# Usage: tart-prep [vm-name] [branch] [user]
# Writes the bootstrap command to ~/bootstrap.sh on the VM so you can run it from the GUI terminal.
VM="${1:-sequoia-test}"
BRANCH="${2:-main}"
USER="${3:-admin}"

[[ -f ~/.dotfiles.config.zsh ]] && source ~/.dotfiles.config.zsh

IP=$(tart ip "$VM" 2>/dev/null) || { echo "error: could not get IP for '$VM'" >&2; exit 1 }

ssh -T "${USER}@${IP}" << ENDSSH
cat > \$HOME/bootstrap.sh << 'ENDSCRIPT'
DOTFILES_REPO="$DOTFILES_REPO" DOTFILES_BRANCH=$BRANCH /bin/zsh -c "\$(curl -fsSL "https://raw.githubusercontent.com/${DOTFILES_GITHUB_USER:?set DOTFILES_GITHUB_USER}/.dotfiles-bare/$BRANCH/bin/bootstrap-dotfiles.zsh")"
ENDSCRIPT
chmod +x \$HOME/bootstrap.sh
echo "Ready — open Terminal in the VM and run: zsh ~/bootstrap.sh"
ENDSSH
