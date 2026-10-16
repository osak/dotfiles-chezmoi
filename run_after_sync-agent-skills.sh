#!/bin/sh
set -eu

src="$HOME/.local/share/agent-skills"

command -v rsync >/dev/null 2>&1 || {
    echo "rsync is required to copy agent skills" >&2
    exit 1
}

# Check both clones before changing either agent's skill directory.
for skill in ai-doc-template document-shaping; do
    if [ ! -f "$src/$skill/SKILL.md" ]; then
        echo "Missing skill: $src/$skill/SKILL.md" >&2
        exit 1
    fi
done

for dest in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
    for skill in ai-doc-template document-shaping; do
        target="$dest/$skill"
        # Replace an existing skill symlink without modifying its referent.
        if [ -L "$target" ]; then
            rm -- "$target"
        fi
        mkdir -p "$target"
        # Dereference source symlinks so each agent gets independent real files.
        rsync -a --copy-links --exclude='.git/' "$src/$skill/" "$target/"
    done
done
