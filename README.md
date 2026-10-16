Dotfiles
========

# Setup
```
# Install chezmoi (Mac)
brew install chezmoi rsync

# Checkout and deploy dotfiles
chezmoi init --apply https://github.com/osak/dotfiles-chezmoi.git

# Generate SSH keys
ssh-keygen -t ed25519 -b 521

## Externally: Add the SSH key to GitHub

# Deploy private ssh configs
git clone git@github.com:osak/xxx.git ~/.ssh/config.private.d
```

# Agent skills

`.chezmoiexternal.toml` manages clones of
[ai-doc-template](https://github.com/osak/ai-doc-template) and
[document-shaping](https://github.com/osak/document-shaping) under
`~/.local/share/agent-skills/<skill>/`.

After the external repositories are applied, `run_after_sync-agent-skills.sh`
copies each skill into both `~/.claude/skills/<skill>/` and
`~/.agents/skills/<skill>/`. Each agent gets independent real files, including
the skill's assets and references, without Git metadata or symlinks to the clones.
Existing symlinks at these two skill names are replaced with real directories.

Git and rsync must be available. Clones are refreshed every 24 hours; to force
an immediate refresh and copy, run:

```sh
chezmoi apply --refresh-externals
```

The copy runs on every `chezmoi apply`; rsync skips unchanged files. These two
skill directories are managed copies, so make edits in the source repositories.
Other skill directories are untouched. The copy does not use `--delete`, so files
removed upstream remain in the copies until removed manually.

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
