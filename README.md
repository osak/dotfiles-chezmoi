Dotfiles
========

# Setup
```
# Install chezmoi (Mac)
brew install chezmoi

# Checkout and deploy dotfiles
chezmoi init --apply https://github.com/osak/dotfiles-chezmoi.git

# Generate SSH keys
ssh-keygen -t ed25519 -b 521

## Externally: Add the SSH key to GitHub

# Deploy private ssh configs
git clone git@github.com:osak/xxx.git ~/.ssh/config.private.d
```

# Manage
## Sync with remote
```
chezmoi update
```

## Add file
```
chezmoi add .tmux.conf
```

## Remove file
```
chezmoi forget .tmux.conf
```

## Show diff
```
chezmoi diff
```

## Commit changes
```
chezmoi cd
git commit -a -m 'foo'
```
