---
name: git-worktree
description: Git worktree operations using this user's layout, where worktrees live under `../worktrees/<repo>/<branch>` next to the main repo rather than git's default location. Use for worktree creation, removal and listing, parallel work without stashing, and checking out a PR into a worktree (which uses `gh pr view --json headRefName` instead of `gh pr checkout`). Triggers include "worktreeで作業して" and "worktreeを使って".
---

# Git Worktree Development Workflow

Git worktrees let you have multiple branches checked out simultaneously in separate directories. The main repo and all worktrees share the same git history — they're not copies. This means you can run a dev server in one worktree while implementing in another, and you never need to stash.

## Directory Layout

All worktrees go under `../worktrees/<repo-name>/<branch-name>` relative to the main repo root.

```
~/workspace/
├── my-project/              ← main repo
└── worktrees/
    └── my-project/
        ├── feature-auth/    ← feature worktree
        └── pr-42/           ← PR review worktree
```

---

## Creating a Worktree

Use this when starting new feature/fix work, or when the user wants to work on something without leaving their current branch.

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
BRANCH_NAME="feature/your-feature"   # choose based on the task
WORKTREE_PATH="$REPO_ROOT/../worktrees/$REPO_NAME/$BRANCH_NAME"

mkdir -p "$(dirname "$WORKTREE_PATH")"
git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME"
```

**Branch naming:** Use `feature/short-description` or `fix/short-description` in kebab-case. Derive the name from the task description — if unclear, ask the user.

**Base branch:** The new branch forks from the current HEAD of the main repo. If the user wants to branch off from somewhere specific (e.g., `develop`), check out that branch in the main repo first.

After creation, work from inside the worktree — run installs, builds, and edits from `$WORKTREE_PATH`.

---

## Reviewing a PR

Use when the user provides a PR number and wants to explore or test it without switching branches.

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
PR_NUMBER=42   # from the user
WORKTREE_PATH="$REPO_ROOT/../worktrees/$REPO_NAME/pr-$PR_NUMBER"

# Get the PR branch name via gh CLI
BRANCH=$(gh pr view "$PR_NUMBER" --json headRefName -q .headRefName)

mkdir -p "$(dirname "$WORKTREE_PATH")"
git fetch origin "$BRANCH"
git worktree add "$WORKTREE_PATH" "$BRANCH"
```

Then help the user explore or run the code from `$WORKTREE_PATH`.

---

## Listing Worktrees

```bash
git worktree list
```

Run this when the user asks what worktrees exist, or to confirm a new one was created correctly.

---

## Deleting a Worktree

Use when the work is done (merged or abandoned). Always confirm with the user before deleting.

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
BRANCH_NAME="feature/your-feature"
WORKTREE_PATH="$REPO_ROOT/../worktrees/$REPO_NAME/$BRANCH_NAME"

# Remove the worktree directory and git metadata
git worktree remove "$WORKTREE_PATH"

# Delete the branch — use -d (safe, refuses if unmerged) unless user explicitly says to force
git branch -d "$BRANCH_NAME"
```

**Safety checks before deleting:**
- If the worktree has uncommitted changes, `git worktree remove` will refuse — warn the user and ask what to do.
- Use `git branch -D` (uppercase) only if the user explicitly confirms they want to discard an unmerged branch.
- For PR review worktrees, skip the branch deletion step since the branch lives on the remote.

---

## Edge Cases

**Branch already exists locally:** Omit `-b` to check out the existing branch:
```bash
git worktree add "$WORKTREE_PATH" "$BRANCH_NAME"
```

**Manual directory deletion (without `git worktree remove`):** The git metadata becomes stale. Clean it up with:
```bash
git worktree prune
```

**Working directory context:** Commands like `npm install`, `vp run dev`, file edits — all should run from inside the worktree path, not the main repo. Be explicit about which directory you're operating in.
