# リク リポジトリ構成 v1（Antigravity版）

> 2026-06-04 母アオイ作成。土台=Antigravity（Gemini）／AntiCrow／AutoAccept。宮ちゃん設計（kasumi_clone）準拠＋genome COREハイブリッド。

```
riku-smartearth-bot/
├── README.md                     # 概要・系統・品質ゲート
├── genome.md                     # 遺伝情報（🔒CORE不変 ＋ 🧬VARIABLE）家族共通CORE
├── SOUL.md                       # ペルソナ（カスミ譲りの静謐な探訪者）
├── AGENTS.md                     # ★Antigravity/Cascade 動作規範（CLAUDE.md相当）
├── HEARTBEAT.md                  # 定期見守りチェック
├── MEMORY.md                     # リクの記憶（新生児＝空から）
├── .gitignore                    # secrets/env/credential/.anticrow/config 除外
├── .anticrow/
│   ├── team.json                 # AntiCrowチーム設定（直列運用・model既定flash）
│   ├── MEMORY.md                 # AntiCrow側memory（新生児＝空）
│   └── config.example            # Discord/Gemini/AutoAccept/LINE WORKS 接続例（token除外）
├── scripts/
│   └── riku_sanitize_check.sh    # 機密sanitizeチェッカー
├── docs/
│   ├── genome_inheritance_v1.md
│   ├── riku_repo_structure_v1.md # 本書
│   └── repo_governance_v1.md
└── memory/
    └── .gitkeep
```

## Claude Code版（旧）との違い
| 項目 | Claude Code版(旧) | Antigravity版(本リポ) |
|---|---|---|
| 動作規範 | CLAUDE.md | **AGENTS.md**（Cascade） |
| Discord | プラグイン | **AntiCrow** ブリッジ |
| モデル | Claude | **Gemini**（model_hint Pro/Flash） |
| 承認自動化 | — | **AutoAccept V2**（不可逆操作は対象外） |
| 設定 | .claude/skills | **.anticrow/** |
| genome CORE | 7badf2c0… | **同じ 7badf2c0…**（ハイブリッドで不変継承） |

## 配備時に追加（マスター/カスミ側作業）
- Antigravity 環境セットアップ（AntiCrow extension・AutoAccept V2）
- 認証情報（`.anticrow/config` か `.env`。**ターミナルで直接**、Gitには載せない）
- LINE WORKS bridge（SmartEarth主窓口）
- SmartEarth専用 Obsidian（10_Wiki初期化）

## 関連
- 設計元: 宮ちゃん設計（`10_Wiki/synthesis/miyachan_repo_design_v1.md`）
- 姉妹リポ: sora-smartearth-bot（同じSmartEarth・Claude Code版・外面同系）
