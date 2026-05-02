---
name: nix-update
description: >
  NixのflakeとHome Managerを使ってインストール済みのパッケージとhome-manager自体を更新するスキル。
  「nixを更新して」「パッケージを更新して」「home-managerを更新して」「nix update」などと言われたら必ずこのスキルを使う。
---

# nix-update スキル

Nix flake + Home Manager 構成のパッケージ・home-manager 自体の更新を行う。

## 前提情報

- **flake.nixの場所**: `~/.local/share/chezmoi/` （chezmoiのsourceディレクトリ）
- **システム**: `aarch64-darwin`
- **nixpkgs**: `nixpkgs-unstable`
- **Home Manager設定**: `~/.local/share/chezmoi/home-manager/home.nix`

---

## 更新フロー

### ステップ1: 現在の状態を確認

```bash
cd ~/.local/share/chezmoi

# 現在のflake inputsのバージョンを確認
nix flake metadata
```

### ステップ2: flake.lock を更新

```bash
cd ~/.local/share/chezmoi

# 全inputsを最新に更新（nixpkgs + home-manager）
nix flake update
```

特定のinputだけ更新したい場合：
```bash
# nixpkgsだけ更新
nix flake update nixpkgs

# home-managerだけ更新
nix flake update home-manager
```

### ステップ3: 設定をビルド・確認（任意）

```bash
cd ~/.local/share/chezmoi

# 実際に適用する前にビルドだけ試す（dry-run）
nix build .#homeConfigurations.hakshu.activationPackage --dry-run
```

### ステップ4: Home Manager を適用

```bash
cd ~/.local/share/chezmoi

# 更新した設定を反映（パッケージのインストール・更新を含む）
home-manager switch --flake .
```

### ステップ5: 変更をコミット・プッシュ

```bash
cd ~/.local/share/chezmoi

git add flake.lock
git commit -m "chore: update nixpkgs and home-manager flake inputs"
git push
```

---

## よくある実行パターン

### 全部まとめて更新する（通常の更新）

```bash
cd ~/.local/share/chezmoi && \
  nix flake update && \
  home-manager switch --flake . && \
  git add flake.lock && \
  git commit -m "chore: update nixpkgs and home-manager flake inputs" && \
  git push
```

### 差分確認してから更新する（慎重な更新）

```bash
# 1. まずflake.lockだけ更新してメタデータ確認
cd ~/.local/share/chezmoi
nix flake update
nix flake metadata  # 変更されたinputsを確認

# 2. 問題なければhome-manager適用
home-manager switch --flake .

# 3. コミット
git add flake.lock
git commit -m "chore: update nixpkgs and home-manager flake inputs"
git push
```

---

## エラーハンドリング

### ビルドエラーが出た場合

```bash
# エラーログを詳細表示
home-manager switch --flake . --show-trace
```

### 更新を元に戻したい場合

```bash
# flake.lockを元に戻す（git で差し戻し）
cd ~/.local/share/chezmoi
git checkout flake.lock

# 前のgenerationに戻す
home-manager generations  # 一覧表示
home-manager switch --flake . --rollback
```

### nix コマンドが見つからない場合

```bash
# Nix がインストールされているか確認
which nix

# パスが通っていない場合
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

---

## 注意事項

- `nix flake update` は `~/.local/share/chezmoi/` で実行する（`flake.nix` がある場所）
- `home-manager switch` 後、**新しいターミナルセッションを開く**と更新されたパッケージが有効になる
- `flake.lock` の変更は必ずコミットする（再現性のため）
- nixpkgs-unstable を使っているため、稀に破壊的変更が含まれることがある。ビルドエラー時は `--show-trace` で詳細確認
