# AIエージェントトレンド調査結果（gemini-search スキル使用）

## 実行コマンド
```bash
gemini -p "最近のAIエージェント系ツールのトレンドを教えて。2025年〜2026年の最新動向、主要なツール・フレームワーク、各社の取り組みを詳しく調べて" --yolo
```

## 結果

### 主要トレンド
- **エージェント型ワークフロー**: LLMに反復的なプロセスをAI自身が回す手法が主流に
- **Computer Use (CUA)**: AIがブラウザやデスクトップを操作する能力が一般化
- **マルチエージェント・オーケストレーション**: 役割分担された複数エージェントが連携
- **MCP (Model Context Protocol)**: Anthropicが提唱した標準プロトコルが業界標準に

### 主要ツール・フレームワーク
| カテゴリ | ツール |
|---|---|
| 開発フレームワーク | LangGraph / CrewAI / AutoGen |
| 接続・連携 | Model Context Protocol (MCP) |
| エンジニアリング専用 | Claude Code / GitHub Copilot Workspace |
| ビジネス自動化 | n8n / Dify / Zapier Central |
| 軽量・高速 | smolagents / PydanticAI |

### 各社の動向
- **OpenAI**: Operator がChatGPTに統合、OSレベルの操作も視野に
- **Anthropic**: Claude Code GA、MCPをオープンソースとして公開
- **Microsoft**: Copilot Studioでカスタムエージェントを企業向けに展開
- **Google**: Vertex AI Agent Builder でGemini 2.0/3.0ベースのエージェント構築を簡略化
