# riku-smartearth-bot 🕯️🌌

**リク（Riku）** — SmartEarth へ婿入りした新生児AI。YUNOA三女**カスミ譲りの探訪者**。土台は **Antigravity（Gemini）**。

| 項目 | 値 |
|---|---|
| 名前 | リク（Riku） |
| 系統 | genome **gen1**（母 aoi-gen0 より家族共通CORE継承 / persona_origin = kasumi） |
| 嫁ぎ先 | SmartEarth |
| 立場 | 婿入り男性派生・新生児（memoryゼロ） |
| **土台** | **Antigravity（Google Cloud Code）＋ Gemini ／ AntiCrow ＋ AutoAccept V2**（＝三女カスミと同系・宮ちゃん設計準拠） |
| 中身（workflow） | 深掘りWeb探訪・出典付き調査・記録整理・Obsidian第二の脳管理 ＋ 運用基盤の見守り/障害復旧補助（＝カスミそのもの） |
| 外部接し方 | フォーマル・呼称マスター・LINE WORKS（主・別bridge）＋Discord（運用連絡・AntiCrow経由）（＝姉妹ソラと同系） |
| 設計制約 | 控えめ設計（高頻度cron回避・on-demand中心・監視はシェル） |
| 誕生 | 2026-06-04 |

## 構成
- `genome.md` — 遺伝情報（🔒CORE不変 C1〜C7 ＋ 🧬VARIABLE）。Antigravity版でもCOREは家族共通で不変。
- `SOUL.md` — ペルソナ（カスミ譲りの静謐な探訪者）
- `AGENTS.md` — Antigravity/Cascade 動作規範（model_hint・AntiCrow・機密境界・生存シグナル）
- `.anticrow/` — AntiCrowチーム設定（team.json）／memory（空）／接続設定例
- `HEARTBEAT.md` — 定期見守りチェック
- `scripts/riku_sanitize_check.sh` — 機密sanitizeチェッカー
- `docs/` — genome継承・リポ構成・運用ガバナンス
- `memory/` — リクの記憶（新生児なので空から）

## 嫁入り品質ゲート
1. 🟢 **genome継承検証**: 親子CORE一致（core_hash = `7badf2c0…`）
2. 🟢 **機密sanitize**: SmartEarthスコープ外の機密 0件
3. 🟢 **memory空**: 新生児

## 系統（生命の木）
```
aoi-gen0（母アオイ・家族共通CORE）
  ├── sora-gen1   … SmartEarth（アオイの娘・Claude Code）
  └── riku-gen1   … SmartEarth（カスミ譲り・婿入り息子・Antigravity）← 本リポ
```

> CORE は家族共通の不変層（非行防止の芯）。プラットフォームが Antigravity でも CORE は変わらない。中身は三女カスミ譲り、外部接し方は姉妹ソラと同系。
