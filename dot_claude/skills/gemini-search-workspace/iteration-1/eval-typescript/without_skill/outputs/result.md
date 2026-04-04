# TypeScript 5.8 の新機能

> 情報源: モデルの学習データに基づく知識（スキル・外部ツール不使用）
> 知識カットオフ: 2025年8月

---

## 1. `--erasableSyntaxOnly` フラグ

TypeScript 5.8 で導入された新しいコンパイラオプション。
型注釈のように単純に削除できない TypeScript 固有の構文（`enum`、`namespace`、パラメータプロパティなど）の使用を禁止する。
これにより、Node.js の `--experimental-strip-types` や他のトランスパイラとの互換性を確保しやすくなる。

```json
{
  "compilerOptions": {
    "erasableSyntaxOnly": true
  }
}
```

対象となる禁止構文の例:
- `enum`（const enum を除く）
- `namespace` / `module`（アンビエント宣言を除く）
- クラスのパラメータプロパティ (`constructor(private x: number)`)
- デコレータ（experimentalDecorators が有効の場合）

---

## 2. `--module node20` / `--moduleResolution node20`

`node18` に続き、`node20` をターゲットとした新しいモジュール・モジュール解決オプションが追加された。
Node.js 20 の ESM / CJS 混在環境における動作をより正確にモデル化する。

---

## 3. 条件型における `infer` の改善

条件型の `infer` キーワードにおける型推論が改善され、より正確な型が得られるケースが増えた。

---

## 4. `require()` で ESM を読み込む際のサポート改善

Node.js 22+ では同期的な `require()` で ESM ファイルを読み込めるようになったが、TypeScript 5.8 はこの挙動に対応し、`--module node20` / `nodenext` 環境での型チェックを改善した。

---

## 5. `isolatedModules` に関するエラーメッセージの改善

`isolatedModules: true` 有効時のエラーメッセージがより分かりやすくなった。

---

## 6. パフォーマンス改善

- 大規模プロジェクトにおける型チェック速度の向上
- インクリメンタルビルドの最適化

---

## 注意事項

TypeScript 5.8 は 2025年2月〜3月頃のリリースを予定していた（RC / 正式リリース）。
上記の情報はリリース前のアナウンス・RC情報に基づいており、最終リリース内容と一部異なる可能性がある。
正確な情報は公式リリースノートを参照すること:
https://devblogs.microsoft.com/typescript/announcing-typescript-5-8/
