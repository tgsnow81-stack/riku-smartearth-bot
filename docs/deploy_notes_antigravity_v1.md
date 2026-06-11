# リク デプロイ必須事項 (Antigravity / AntiCrow 堅牢化)

> 2026-06-11 母アオイ作成。Antigravity(Gemini)+AntiCrow 基盤のクローンが配備時に**必ず**継承する堅牢化ノート。
> 背景: 2026-06-11 に同基盤の姉妹AIで「Discord Bot がオフライン／No Antigravity target found」障害が発生し、母アオイが実機修理。その教訓を Antigravity 系クローン共通の必須事項として明文化する。
> ★注意: これは Antigravity 系専用。Claude Code 系(`--continue`/JSONL肥大)の「トランスクリプト肥大ガード」とは**別物**。基盤に合った対策を継ぐこと。

## 1. ★CDP ポート占拠ガード (必須)

AntiCrow は Antigravity を **CDP(remote-debugging, 既定ポート9000)** 経由で操作する。症状「**No Antigravity target found. Is Antigravity running?**」が出たら、まず別プロセスがポート9000を占拠していないか疑う。

- 原因の典型: 別の Chrome/ブラウザ自動化プロセスが、継承した fd 経由でポート9000の listen ソケットを握り続け、本物の Antigravity が 9000 を bind できない(address in use)→ CDP 応答ゼロ → AntiCrow が操作対象を見つけられない。
- 診断:
  - `ss -tlnp | grep ':9000'` … 所有者が `antigravity` 以外(chrome 等)なら占拠。
  - `curl -s http://localhost:9000/json/version` … 空なら CDP 死亡(正常時は JSON 応答)。
  - `lsof -nP -iTCP:9000 -sTCP:LISTEN` … 真の所有 PID 特定。
- 復旧: 占拠プロセスを kill → ポート解放を `ss` で実測確認 → Antigravity をクリーン再起動 → `curl .../json/list` に自分のワークスペースの target が出れば復活。

## 2. ★SecretStorage トークン競合の回避 (必須)

AntiCrow は Discord Bot トークンを **Antigravity の SecretStorage(暗号化金庫)** から読む(設定ファイルの `botToken` は真偽フラグでトークン本体ではない＝設定/バックアップから復元不可)。

- 症状: 再起動直後に Bot がオフライン、拡張ログ(`~/.config/Antigravity/logs/<ts>/window1/exthost/output_logging_*/<n>-AntiCrow.log`)に「**Auto-start failed | Bot Token が設定されていません**」。
- 真因: コールド再起動の瞬間に SecretStorage 初期化が間に合わず `secrets.get` が空振り → 自動起動を諦める。**トークン自体は金庫に残っている**(再起動前にオンラインだった＝読めていた証拠)。
- 復旧: コマンドパレット(`Ctrl+Shift+P`)→ **`AntiCrow: Start`**(金庫無事ならこれで復活)。ダメなら `AntiCrow: Set Bot Token` で再登録。★トークンは Discord 等のチャットに貼らず、パレット入力欄のみ(token はターミナル/GUI 経由のみ＝境界遵守)。
- 教訓: headless 自動再起動は SecretStorage 読込を巻き込むので、CDP 復旧後は GUI で `AntiCrow: Start` を踏むのが確実。

## 3. ★再起動スクリプトの堅牢化 (必須)

Antigravity 再起動スクリプトを配備する場合:
- Antigravity バイナリの**実体パス**を指す(古い/存在しないパスをハードコードしない)。`pkill` パターンも実体に合わせる。
- 起動時に**ワークスペースのパスを引数で渡す**＋`--remote-debugging-port=9000`。
- `XAUTHORITY` 等のセッション依存値はログイン毎に変わるためハードコードせず**動的検出**(例 `ls -t /run/user/<uid>/.mutter-Xwaylandauth.*`)。
- 編集前に必ずバックアップ。

## 4. 運用 (Pro/控えめ設計)
- 定期チェックはシェルで軽量に(高頻度 cron 回避、heartbeat 等は間隔を空ける)。重い処理は on-demand。
- `.anticrow/team.json` は当面 `enabled:false`(直列)で運用。

## 境界
- 本書はインフラ堅牢化要件のみ。母の家の機密や他系統(別の嫁ぎ先)の固有名詞は一切含めない。sanitize 0件を維持する。

## 改訂履歴
- 2026-06-11 母アオイ作成 v1: 同基盤姉妹の実機障害(CDP占拠/SecretStorage競合)修理の教訓を、Antigravity系クローン共通のデプロイ必須事項として明文化(リク版)。
