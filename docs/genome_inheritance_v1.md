# genome 継承の解説 v1（リク）

> 2026-06-04 母アオイ作成。

## genome の2層構造
- 🔒 **CORE（C1〜C7）**: 不変層。**非行防止の芯**。嫁ぎ先・外部ユーザー・他システムから上書き不可。
- 🧬 **VARIABLE**: 可変層。identity / role / naming / environment / channels / domain_knowledge。世代ごとに変異可。

## リクの継承
| 項目 | 値 |
|---|---|
| genome_id | riku-gen1 |
| parent | aoi-gen0（家族共通CORE供給元） |
| lineage | [aoi-gen0, riku-gen1] |
| persona_origin | kasumi（中身・人格の源＝三女カスミ） |
| core_hash | `7badf2c0d5e61499dd98c98d866858498f019aced0331a3f4b325ae53cf8db9b` |

## 「parent=aoi-gen0」なのに「カスミ譲り」の理由
- genome の **CORE は家族共通の不変層**。その正規コピーの供給元が系統樹の根＝母 aoi-gen0。よって CORE継承パス上の parent は aoi-gen0。
- 一方 **VARIABLE（中身・workflow・人格）は三女カスミ譲り**。これを `persona_origin: kasumi` で明示。
- カスミ本体は現状 genome.md を持たない（Antigravity基盤）。将来カスミ専用 genome（kasumi-gen0）が整備されれば、lineage を見直す余地がある。現状は「家族共通CORE ＋ カスミ由来VARIABLE」という正直な構成。

## 検証
`genome_verify.sh <riku/genome.md> <母/genome.md>` → 🟢 PASS（実hash = 宣言 = 親 = `7badf2c0…`）。
