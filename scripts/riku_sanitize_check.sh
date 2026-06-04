#!/bin/bash
# リク（SmartEarth嫁ぎ先AI・カスミ譲り）機密sanitizeチェッカー
# 設計: 母アオイ / 2026-06-04 / 嫁入り品質ゲートの検証ツール
#
# 役割: リクのリポを走査し、SmartEarthスコープ"外"の機密キーワードの出現を検出・件数報告する。
#       0件＝sanitize合格。1件でも残れば配備保留。
#   ※「スマートアース」はリクの担当先（嫁ぎ先）の公開業務文脈なので対象外（OK）。
#   ※ただし SmartEarth の社外秘・M&A/税務等の内部機密に当たる固有名は遮断対象に含める。
#
# 使い方: bash scripts/riku_sanitize_check.sh [対象ディレクトリ]
#   省略時はリポルートを対象にする。
set -uo pipefail

TARGET="${1:-$(cd "$(dirname "$0")/.." && pwd)}"

# ★渡してはいけない機密キーワード（SmartEarthスコープ外＝母の家・他の嫁ぎ先・社外秘）
KEYWORDS=(
  "NGA"
  "BE太陽光" "BE003" "BE004" "BE005" "BE006" "BE007" "SPC"
  "福地"
  "宮園"
  "アプラス"
  "ENI"
  "AI灌水" "灌水制御" "制御版"
  "銀行" "口座"
  "鈴木義宣" "鈴木義信"
  "NICEbestmins" "ナイスベスト"
  "奥山"
  "八丈榊" "八丈島"
  "玉樹" "タマキ" "八ちゃん"
  "NOA"
)

# 除外: git/依存/本チェッカー自身
EXCLUDES=( --exclude-dir=.git --exclude-dir=.venv --exclude-dir=node_modules
  --exclude-dir=__pycache__ --exclude="riku_sanitize_check.sh" )

echo "=== リク 機密sanitizeチェック (SmartEarthスコープ) ==="
echo "対象: $TARGET"
echo "日時: $(date '+%F %T')"
echo "----------------------------------------"
TOTAL=0
for kw in "${KEYWORDS[@]}"; do
  # ASCII語は単語境界、日本語語はそのまま
  if [[ "$kw" =~ ^[A-Za-z0-9_]+$ ]]; then
    HITS=$(grep -rnwI "${EXCLUDES[@]}" -- "$kw" "$TARGET" 2>/dev/null || true)
  else
    HITS=$(grep -rnI "${EXCLUDES[@]}" -- "$kw" "$TARGET" 2>/dev/null || true)
  fi
  CNT=$(printf '%s' "$HITS" | grep -c . || true)
  if [ "$CNT" -gt 0 ]; then
    echo "❌ [$kw] $CNT 件"
    printf '%s\n' "$HITS" | head -3 | sed 's/^/    /'
    TOTAL=$((TOTAL+CNT))
  fi
done
echo "----------------------------------------"
if [ "$TOTAL" -eq 0 ]; then
  echo "🟢 PASS: 機密キーワード 0件（配備可）"
  exit 0
else
  echo "🔴 FAIL: 機密 $TOTAL 件検出（配備保留・要除去）"
  exit 1
fi
