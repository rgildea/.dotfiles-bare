<!-- markdownlint-disable MD029-->
# Installation

1. Run this to install the tools and software:

>```/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/rgildea/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"```

2. Follow the prompt to sign in to 1Password. You will need your email address, password, and Secret Key the first time you use a machine.
3. Open **Settings -> Developer** and ensure the ssh-agent is enabled.
4. Either copy the configuration code snippet and paste it into `$HOME/.ssh/config`, or let 1Password do it for you.

## Terminal Setup

### iTerm.app

Open **iTerm -> Settings -> General -> Settings**, and choose **Load Settings from a custom folder or URL**. Choose the user home directory as the location.

*iTerm fonts will be configured by the bootstrap script via `p10k configure`*

### Terminal.app

Open Terminal → Preferences → Profiles → Text, click Change under Font and select `MesloLGS NF family`.
