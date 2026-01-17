# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理しているdotfilesリポジトリです。

## 必要条件

- macOS
- [Homebrew](https://brew.sh/)

## セットアップ

### 1. chezmoiのインストール

```bash
brew install chezmoi
```

### 2. dotfilesの取得と適用

```bash
# リポジトリをクローンして適用
chezmoi init --apply <github-username>
```

### 3. 全体セットアップ（推奨）

Makefileを使用して、パッケージのインストールからdotfilesの適用まで一括で実行できます。

```bash
chezmoi cd
make all
```

#### 個別に実行する場合

```bash
chezmoi cd

# パッケージのインストール（Homebrew）
make install

# dotfilesの適用
make init

# Fisherプラグインのインストール
make install-fisher

# vim-plugプラグインのインストール
make install-vim-plug
```

## 管理しているファイル

| ファイル/ディレクトリ | 説明 |
|----------------------|------|
| `dot_config/fish/` | Fish shell設定 |
| `dot_config/nvim/` | Neovim設定 |
| `dot_config/ghostty/` | Ghosttyターミナル設定 |
| `dot_config/starship.toml` | Starshipプロンプト設定 |
| `dot_vimrc` | Vim設定 |
| `dot_zshrc` | Zsh設定 |
| `dot_zshenv` | Zsh環境変数 |
| `dot_claude/` | Claude Code設定 |
| `Brewfile` | Homebrewパッケージリスト |
| `com.googlecode.iterm2.plist` | iTerm2設定 |

## よく使うchezmoiコマンド

```bash
# 変更を適用
chezmoi apply

# 差分を確認
chezmoi diff

# ファイルを追加
chezmoi add ~/.config/example

# 管理対象ファイルを編集
chezmoi edit ~/.config/example

# ソースディレクトリに移動
chezmoi cd
```

## 主要なツール

### シェル
- Fish shell（デフォルト）
- Zsh

### ターミナル
- Ghostty
- iTerm2

### エディタ
- Neovim
- Vim
- Visual Studio Code

### 開発ツール
- mise（ランタイムバージョン管理）
- ghq + peco（リポジトリ管理）
- fzf（ファジー検索）
- starship（プロンプト）