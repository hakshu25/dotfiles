---
name: chezmoi
description: >
  chezmoiで管理されているdotfilesの追加・編集・確認を行うスキル。
  設定ファイルを変更・追加する際は必ずこのスキルを使う。
  「.zshrcを編集して」「fish configを変更して」「設定ファイルを追加して」「chezmoiに追加して」
  「dotfilesを更新して」など、設定ファイルへの変更を伴う作業すべてでこのスキルを使う。
---

# chezmoi スキル

dotfilesはchezmoiで管理されている。設定ファイルへの変更は**必ずsourceディレクトリ側**で行い、`chezmoi apply`で反映する。

## 基本情報

- **sourceディレクトリ**: `~/.local/share/chezmoi/`
- **管理ファイル確認**: `chezmoi managed`
- **リモート**: `https://github.com/hakshu25/dotfiles`

## ファイルパス変換ルール

chezmoiのsourceディレクトリでは、ファイル名にプレフィックスが付く：

| ホームディレクトリのパス | sourceディレクトリのパス |
|---|---|
| `~/.zshrc` | `~/.local/share/chezmoi/dot_zshrc` |
| `~/.zshenv` | `~/.local/share/chezmoi/dot_zshenv` |
| `~/.vimrc` | `~/.local/share/chezmoi/dot_vimrc` |
| `~/.claude/CLAUDE.md` | `~/.local/share/chezmoi/dot_claude/CLAUDE.md` |
| `~/.claude/skills/*/SKILL.md` | `~/.local/share/chezmoi/dot_claude/skills/*/SKILL.md` |
| `~/.config/fish/config.fish` | `~/.local/share/chezmoi/dot_config/fish/config.fish` |
| `~/.config/ghostty/config` | `~/.local/share/chezmoi/dot_config/ghostty/config` |
| `~/.config/nvim/` | `~/.local/share/chezmoi/dot_config/nvim/` |

**ルール**: ドットで始まるファイル・ディレクトリは `dot_` プレフィックスに変換。それ以外はそのまま。

---

## 操作パターン

### 既存ファイルを編集する

```bash
# 1. sourceディレクトリのファイルを編集（直接ホームを触らない）
# 例: ~/.zshrc を編集したい場合
# → ~/.local/share/chezmoi/dot_zshrc を編集する

# 2. ホームディレクトリへ反映
chezmoi apply

# 3. コミット・プッシュ
cd ~/.local/share/chezmoi
git add <変更したファイル>
git commit -m "..."
git push
```

### 新しいファイルをchezmoiに追加する

```bash
# 1. chezmoi add でsourceに取り込む
chezmoi add ~/.some/new/file

# 2. コミット・プッシュ
cd ~/.local/share/chezmoi
git add .
git commit -m "..."
git push
```

### 状態を確認する

```bash
# 管理ファイル一覧
chezmoi managed

# 変更差分（sourceとホームの差）
chezmoi diff

# sourceとホームどちらが新しいか
chezmoi status
```

---

## コミットメッセージ

conventional commitsに準拠する：
- 設定の追加: `feat: add <tool> config`
- 設定の変更: `chore: update <tool> config`
- スキル追加: `feat: add <name> skill`
- ルール追加: `docs: add rule for <topic>`

---

## 注意事項

- **直接 `~/` 配下のファイルを編集しない**。必ずsourceディレクトリ側を編集してから `chezmoi apply`
- `chezmoi apply` は対象ファイルを指定できる: `chezmoi apply ~/.zshrc`（全体に適用したくない場合）
- 新規ディレクトリごと追加する場合: `chezmoi add ~/.config/new-tool/`
