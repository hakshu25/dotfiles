# TypeScript 5.8 新機能調査結果（gemini-search スキル使用）

## 実行コマンド
```bash
gemini -p "TypeScript 5.8の新機能は？具体的な機能名と使い方を詳しく調べて" --yolo
```

## 結果

### 1. return文における条件式の細かな型チェック
条件式の各分岐をより厳密にチェック。以前は全体としてチェックが緩くなることがあったが、5.8から各分岐を個別に検証。

### 2. `--module nodenext` における ESM の `require()` サポート
Node.js 22で導入された「ESMをrequire()で読み込める機能」に対応。CJSプロジェクトからESMライブラリを段階的に導入しやすくなる。

### 3. `--erasableSyntaxOnly` フラグ
TypeScript特有の「実行時にコードが残る構文」(enum, namespace, パラメータープロパティ等)の使用を禁止するモード。
```json
{ "compilerOptions": { "erasableSyntaxOnly": true } }
```
Node.jsの `--experimental-strip-types` や高速トランスパイラと相性が良い。

### 4. `--module node18` の安定化
特定のNode.jsバージョン向けの固定された挙動を提供。`nodenext`と異なりNode.js 18の仕様に準拠した設定。

### 5. パフォーマンスの改善
- ファイルパス解決処理の最適化で読み込みが高速化
- `tsconfig.json`検証結果のキャッシュで`--watch`モードの再ビルドが高速化
- 大規模プロジェクトでのメモリ使用量が最大で数割削減
