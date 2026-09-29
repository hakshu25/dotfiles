# dotfiles

macOS (Apple Silicon) 用の dotfiles。役割分担は次のとおり。

| 対象 | 管理ツール |
|------|-----------|
| 設定ファイル | [chezmoi](https://www.chezmoi.io/) |
| CLI ツール | [Nix](https://nixos.org/) + [Home Manager](https://github.com/nix-community/home-manager)（`home-manager/home.nix`） |
| GUI アプリ・フォント・一部の依存 | [Homebrew](https://brew.sh/) + [brew-file](https://github.com/rcmdnk/homebrew-file)（`Brewfile`） |
| 言語ランタイム（node, deno, python など） | [mise](https://mise.jdx.dev/)（`dot_config/mise/config.toml`） |

## セットアップ

Homebrew と Nix は `install.sh` が未インストールなら自動で入れる。

```bash
# 1. dotfiles を取得（chezmoi はワンショットで実行）
sh -c "$(curl -fsLS get.chezmoi.io)" -- init hakshu25

# 2. 全体セットアップ
cd ~/.local/share/chezmoi
make all
```

`make all` は次を順に実行する。個別に実行してもよい。

| ターゲット | 内容 |
|-----------|------|
| `make install` | Homebrew・Nix のインストール、`Brewfile` の適用、`home-manager switch` |
| `make init` | `chezmoi apply`、pre-commit フックの有効化、ログインシェルを fish に変更 |
| `make install-fisher` | `fish_plugins` に書かれた fish プラグインをインストール |
| `make install-vim-plug` | Vim プラグインをインストール |
| `make install-nix` | `home-manager switch` だけを実行 |

### 手動で必要な作業

- `herdr integration install`：Claude Code の herdr 連携フックを入れる（`~/.claude/hooks/` は管理外）
- `gh auth login`：GitHub の認証

## 管理しているファイル

| ソース | 展開先 | 説明 |
|--------|--------|------|
| `dot_config/fish/` | `~/.config/fish/` | fish の設定・関数・`fish_plugins` |
| `dot_config/nvim/` | `~/.config/nvim/` | Neovim（lazy.nvim） |
| `dot_vimrc` | `~/.vimrc` | Vim（vim-plug） |
| `dot_config/ghostty/` | `~/.config/ghostty/` | Ghostty |
| `dot_config/zellij/` | `~/.config/zellij/` | Zellij |
| `dot_config/aerospace/` | `~/.config/aerospace/` | AeroSpace（タイル型ウィンドウマネージャ） |
| `dot_config/starship.toml` | `~/.config/starship.toml` | Starship プロンプト |
| `dot_config/mise/` | `~/.config/mise/` | mise のグローバルツール |
| `dot_gitconfig`, `dot_config/git/` | `~/.gitconfig`, `~/.config/git/` | Git の設定・グローバル ignore |
| `dot_config/gh/` | `~/.config/gh/` | GitHub CLI（認証情報の `hosts.yml` は含めない） |
| `dot_claude/` | `~/.claude/` | Claude Code の設定・スキル・statusline |

リポジトリ専用で `$HOME` には展開しないもの（`.chezmoiignore`）:

| ファイル | 説明 |
|----------|------|
| `flake.nix`, `flake.lock`, `home-manager/` | Nix / Home Manager の設定 |
| `Brewfile` | Homebrew パッケージ |
| `install.sh`, `Makefile` | セットアップ用スクリプト |
| `.githooks/pre-commit` | コミット時に gitleaks で秘密情報を検査 |
| `.github/workflows/` | 毎週 `flake.lock` を更新する PR を作成 |

fish の `fish_variables` と fisher が入れるプラグイン本体は、マシンごとの状態なので管理しない。

## よく使うコマンド

```bash
# 設定を編集して反映
chezmoi edit ~/.config/fish/config.fish
chezmoi apply

# ホーム側で変わったファイルをソースに取り込む
chezmoi re-add ~/.claude/settings.json

# ソースとホームの差分・状態
chezmoi diff
chezmoi status

# パッケージを更新（flake.lock を更新して適用）
nix flake update
home-manager switch --flake .
```
