# 注意
- ユーザーには日本語で応答してください
- GitHub へのアクセスには gh コマンドを使ってください。認証されていなければ gh auth login で認証してください

# 設定ファイルの変更について
- dotfilesはchezmoiで管理されています（ソースディレクトリ: `~/.local/share/chezmoi/`）
- 設定ファイルを変更・追加する際は、必ず chezmoi のソースディレクトリ側を編集してから `chezmoi apply` を実行してください
- 直接ホームディレクトリ配下のファイルを編集しないでください
- 対象の例: `~/.claude/`、`~/.config/`、`~/.zshrc`、`~/.zshenv` など

# Package Management
- This system uses Nix home-manager (not Homebrew) for package management
- Programming language runtimes (node, deno, python, etc.) are managed by mise — do NOT add them to nix configs
- After modifying home-manager config, run `home-manager switch --flake ~/.local/share/chezmoi --impure` to apply, then commit

# Dotfiles
- Dotfiles are managed via chezmoi — edit source files in the chezmoi source dir, not the deployed locations
- Obsidian vault lives in iCloud (not ~/Documents/obsidian) — confirm the exact path before writing notes

# Git について
- commit メッセージは conventional commits のルールに準拠してください。詳しくは以下の仕様を参照してください。
  - https://www.conventionalcommits.org/en/v1.0.0/#specification
  - https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional
- Commits should be GPG-signed
- Do not run `gh` commands or upload screenshots/PRs unless explicitly asked — the user prefers to handle PR submission themselves
