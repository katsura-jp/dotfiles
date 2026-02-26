# WezTerm Nightly チートシート

WezTerm nightly ビルドを前提とした設定の使い方ガイド。

## Leader Key / Prefix

WezTerm と tmux でペイン操作のサブキーを統一している。prefix だけが異なるので干渉しない。

`Ctrl+B` は tmux-aware: tmux 内では tmux に渡り、tmux 外では WezTerm の `Ctrl+A` と同じ操作ができる。

| | WezTerm | tmux |
|:--|:--|:--|
| **Prefix** | `Ctrl+A` / `Ctrl+B`* | `Ctrl+B` |
| 横分割 | prefix → `\|` | prefix → `\|` |
| 縦分割 | prefix → `-` | prefix → `-` |
| ペイン移動 | prefix → `h/j/k/l` or `矢印` | prefix → `h/j/k/l` |
| ペインズーム | prefix → `z` | prefix → `z` |
| リサイズ | prefix → `r` → `h/j/k/l` or `矢印`  | prefix → `r` → `h/j/k/l` or `矢印`  |
| 新しいタブ | prefix → `c` | prefix → `c` |
| 次のタブ | prefix → `n` | prefix → `n` |
| 前のタブ | prefix → `p` | prefix → `p` |
| タブ/セッション一覧 | prefix → `w` | prefix → `w` |
| ペインを閉じる | prefix → `x` | prefix → `x` |

## キーバインド一覧

### タブ操作

| キー | 操作 |
|:--|:--|
| `Ctrl+T` | 新しいタブを開く |
| `Ctrl+Shift+W` | 現在のペインを閉じる (確認あり) |
| `Ctrl+Shift+{` | 前のタブに移動 |
| `Ctrl+Shift+}` | 次のタブに移動 |
| `Alt+1` ~ `Alt+9` | タブ1~9に直接移動 |
| `Alt+0` | 最後のタブに移動 |

### ペイン操作 (Leader key)

| キー | 操作 |
|:--|:--|
| `Ctrl+A` → `\|` | 横に分割 (左右) |
| `Ctrl+A` → `-` | 縦に分割 (上下) |
| `Ctrl+A` → `h/j/k/l` or `矢印` | ペイン移動 (左/下/上/右) |
| `Ctrl+A` → `z` | ペインのズーム切り替え (最大化/元に戻す) |
| `Ctrl+A` → `x` | ペインを閉じる (確認あり) |
| `Ctrl+A` → `r` | リサイズモードに入る |

### リサイズモード

`Ctrl+A` → `r` でリサイズモードに入ると、以下のキーで繰り返しリサイズできる。3秒操作なしか `Esc` で抜ける。

| キー | 操作 |
|:--|:--|
| `←` / `h` | 左に縮小 |
| `→` / `l` | 右に拡大 |
| `↑` / `k` | 上に拡大 |
| `↓` / `j` | 下に縮小 |
| `Esc` | リサイズモードを終了 |

### Workspace

| キー | 操作 |
|:--|:--|
| `Alt+S` | Workspace 一覧を fuzzy 検索で表示・切り替え |
| `Alt+N` | 新しい Workspace を名前を入力して作成・切り替え |

Workspace はプロジェクト単位でタブ群をグループ化する機能。右のステータスバーに現在の Workspace 名が表示される。

### Quick Select

| キー | 操作 |
|:--|:--|
| `Ctrl+Shift+Space` | Quick Select モード (URL, hash, パス等を選択) |
| `Ctrl+P` | URL だけを Quick Select して開く |

Quick Select モードに入ると、画面内のパターンにマッチするテキストにラベルが表示される。ラベルを入力するとクリップボードにコピーされる。大文字で入力するとコピー&ペーストされる。

自動検出されるパターン:
- URL (`https://...`)
- Git ハッシュ (`a1b2c3d`)
- ファイルパス (`/path/to/file`)
- メールアドレス (`user@example.com`)

### コマンドパレット & その他

| キー | 操作 |
|:--|:--|
| `Alt+Shift+P` | コマンドパレット (全機能を fuzzy 検索) |
| `Ctrl+U` | 背景透過の切り替え |
| `Shift+↑` / `Shift+↓` | 1行スクロール |
| `Shift+Enter` | ESC+Enter を送信 |
| `Ctrl+Shift+X` | Copy Mode (vim風テキスト選択) |
| `Ctrl+Shift+U` | Unicode/絵文字ピッカー |
| `Ctrl+Click` | リンクをブラウザで開く |

### Copy Mode

`Ctrl+Shift+X` で Copy Mode に入ると vim 風のキー操作でテキストを選択できる。

| キー | 操作 |
|:--|:--|
| `h/j/k/l` | カーソル移動 |
| `w` / `b` | 単語単位で移動 |
| `0` / `$` | 行頭 / 行末 |
| `g` / `G` | 先頭 / 末尾 |
| `v` | 文字選択モード |
| `V` | 行選択モード |
| `Ctrl+V` | 矩形選択モード |
| `y` | コピーして終了 |
| `Esc` / `q` | キャンセル |

## Nightly 限定機能

この設定では以下の nightly 限定機能を有効化している:

| 設定 | 説明 |
|:--|:--|
| `window_content_alignment` | ウィンドウ内コンテンツを中央揃え |
| `quick_select_remove_styling` | Quick Select 時に装飾を除去して視認性向上 |
| `show_close_tab_button_in_tabs` | タブの閉じるボタンを非表示 |
| `macos_fullscreen_extend_behind_notch` | フルスクリーンでノッチ裏まで表示領域を拡張 |

## レンダリング

WebGpu フロントエンド (Metal バックエンド) を使用。macOS では OpenGL より安定・高速。

もし描画に問題が出た場合は `front_end` を `'OpenGL'` または `'Software'` に変更する。

## ステータスバー

右側に以下が powerline スタイルで表示される:

```
 Workspace名  日付 時刻  バッテリー%
```

## Tips

- `wezterm show-keys --lua` で現在の全キーバインドを確認できる
- `wezterm show-keys --lua --key-table copy_mode` で Copy Mode のキーバインドを確認
- 設定ファイルを保存すると自動リロードされる (再起動不要)
- `wezterm cli list` で全ペイン一覧を表示
