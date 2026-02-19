# CLI ツール チートシート

このリポジトリで導入しているCLIツールの使い方まとめ。

## eza (ls の置き換え)

```bash
ls          # ファイル一覧（アイコン付き）
ll          # 詳細表示 + git status
la          # 隠しファイル含む一覧
tree        # ツリー表示
tree -L 2   # 深さ2まで
```

## zoxide (cd の置き換え)

```bash
z foo       # "foo" を含む過去に訪れたディレクトリへジャンプ
z foo bar   # "foo" と "bar" 両方を含むディレクトリへ
zi          # fzf で対話的に選択
```

## wd (ディレクトリブックマーク, oh-my-zsh プラグイン)

```bash
wd add work     # 今いるディレクトリを "work" として登録
wd work         # "work" にジャンプ
wd list         # 一覧表示
wd rm work      # 削除
```

## fd (find の置き換え)

```bash
fd pattern          # ファイル名でパターン検索
fd -e py            # .py ファイルを検索
fd -t d             # ディレクトリのみ
fd -H pattern       # 隠しファイルも含む
fd pattern --exec rm  # 見つけたファイルを削除
```

## fzf (ファジーファインダー)

```bash
# キーバインド
Ctrl+R      # コマンド履歴をfzfで検索
Ctrl+T      # ファイルをfzfで選択してコマンドラインに挿入
Alt+C       # ディレクトリをfzfで選択してcd

# パイプで使う
cat file | fzf              # 行を選択
git branch | fzf            # ブランチを選択
ps aux | fzf                # プロセスを選択

# プレビュー付き（bat連携）
fzf --preview 'bat --color=always {}'
```

## bat (cat の置き換え)

```bash
bat file.py         # シンタックスハイライト付きで表示
bat -l json file    # 言語を指定
bat -p file         # プレーン表示（行番号なし）
bat --diff A.txt B.txt  # 差分表示
```

## delta (git diff の強化)

git に統合済み。特別なコマンドは不要。

```bash
git diff            # side-by-side + 行番号付きで表示
git log -p          # コミットログの差分も delta で表示
git show            # コミット詳細も delta で表示

# delta 単体で使う
diff a.txt b.txt | delta
```

## ghq (git リポジトリ管理)

```bash
ghq get <repo-url>  # リポジトリをクローン（~/ghq/ 配下に配置）
ghq list            # 管理中のリポジトリ一覧
repos               # fzf でリポジトリを選んでcd（エイリアス）
```

## jq (JSON 整形・クエリ)

```bash
cat data.json | jq '.'           # 整形表示
cat data.json | jq '.key'        # キーで抽出
cat data.json | jq '.items[]'    # 配列を展開
cat data.json | jq '.[] | select(.age > 20)'  # フィルタ
curl -s api/endpoint | jq '.'    # API レスポンスを整形
```

## mise (言語バージョン管理, asdf 後継)

```bash
mise ls               # インストール済みのツール一覧
mise use node@20      # Node.js 20 を使用（.mise.toml に記録）
mise install          # .mise.toml / .tool-versions に従ってインストール
mise ls-remote node   # 利用可能なバージョン一覧

# 初回セットアップ時: dotfiles の設定ファイルを trust する
mise trust $(realpath ~/.config/mise/config.toml)
```

## lazygit (Git TUI)

```bash
lg              # lazygit を起動（エイリアス）
```

lazygit 内の主なキー:
- `space` — ファイルをステージ/アンステージ
- `c` — コミット
- `p` — プッシュ
- `?` — ヘルプ

## starship (プロンプト)

設定ファイル: `~/.config/starship.toml`

```bash
starship explain    # 現在のプロンプトの各セグメントを説明
starship timings    # 各モジュールの描画時間
```
