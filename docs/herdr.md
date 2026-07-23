# herdr チートシート

herdr は AI コーディングエージェント向けのターミナルワークスペースマネージャ（agent multiplexer）。
**このリポジトリでは tmux / WezTerm のマルチプレクサ機能に代わる標準ツールとする**
（tmux / WezTerm の設定はリモート・レガシー用途のために残している）。

- 公式: https://herdr.dev
- 設定: `config/herdr/config.toml` → `~/.config/herdr/config.toml`
- ログ: `~/.config/herdr/herdr.log`（+ `herdr-client.log`, `herdr-server.log`）

## インストール（macOS）

```bash
brew install herdr

# Claude Code 連携（agent の状態検知 hook を ~/.claude/ にインストール）
herdr integration install claude
```

### レビューワークフロー用の追加ツール

config.toml のキーバインド（後述）が前提にしているツール。新しいマシンでは合わせて入れる:

```bash
# hunk: agent の changeset をレビューする TUI diff ビューア (prefix → Alt+D)
brew install hunk        # brew がない環境では: npm i -g hunkdiff

# lazygit (prefix → Alt+G)
brew install lazygit

# file-viewer プラグイン: git-aware read-only ファイルビューア (prefix → f)
herdr plugin install smarzban/herdr-file-viewer
brew install glow git-delta bat   # file-viewer のレンダラー（無くてもプレーン表示で動く）
```

> プラグインは herdr **サーバー側**で動く。リモート（liat 系）でも使う場合は
> リモート側でも同様にインストールする。

## 基本操作

```bash
herdr                        # 永続セッションを起動 or アタッチ
herdr --session <name>       # 名前付きセッションを起動 or アタッチ
herdr session attach <name>  # 名前付きセッションにアタッチ
herdr status                 # client / server の状態確認
herdr server stop            # サーバ停止
herdr server reload-config   # config.toml の再読み込み（設定変更後に実行）
herdr update                 # 最新版へアップデート
herdr --remote <ssh-target>  # リモートの herdr サーバに SSH 経由でアタッチ
```

tmux 同様、server / client 構成で detach してもセッションは生き続ける。

## 概念

```
Session
└── Workspace (プロジェクト・作業単位。CWD を持つ)
    └── Tab
        └── Pane (shell や AI agent が動く)
```

サイドバーに workspace と agent の状態（実行中 / 入力待ち / 完了）が一覧表示され、
「どの Claude が手待ちか」を横断的に把握できる。

## キーバインド（デフォルト）

Prefix は `Ctrl+B`。WezTerm は `Ctrl+B` をバインドしないため、常に herdr に届く
（tmux をリモートで使う場合も同じ prefix）。

### Workspace

| キー | 操作 |
|:--|:--|
| prefix → `w` | workspace ピッカー |
| prefix → `g` | goto（ジャンプ） |
| prefix → `Shift+N` | 新規 workspace |
| prefix → `Shift+W` | workspace リネーム |
| prefix → `Shift+D` | workspace を閉じる |
| prefix → `Shift+G` | 新規 git worktree（workspace として開く） |

### Tab

| キー | 操作 |
|:--|:--|
| prefix → `c` | 新規タブ |
| prefix → `n` / `p` | 次 / 前のタブ |
| prefix → `1..9` | タブ 1〜9 に直接移動 |
| prefix → `Shift+T` | タブのリネーム |
| prefix → `Shift+X` | タブを閉じる |

### Pane

| キー | 操作 |
|:--|:--|
| prefix → `v` | 縦分割 |
| prefix → `-` | 横分割 |
| prefix → `h/j/k/l` | ペイン移動 |
| prefix → `z` | ズーム（最大化トグル） |
| prefix → `x` | ペインを閉じる |
| prefix → `r` | リサイズモード |
| prefix → `e` | スクロールバックをエディタで開く |
| prefix → `Shift+P` | ペインのリネーム |

### その他

| キー | 操作 |
|:--|:--|
| prefix → `?` | ヘルプ |
| prefix → `s` | 設定画面 |
| prefix → `b` | サイドバー表示切り替え |
| prefix → `q` | detach |
| prefix → `o` | 通知対象のペインへジャンプ |
| prefix → `Shift+R` | config 再読み込み |

### カスタム（config.toml で追加）

| キー | 操作 |
|:--|:--|
| prefix → `Alt+D` | `hunk diff --watch` を popup で（agent の diff レビュー） |
| prefix → `Alt+G` | lazygit を popup で |
| prefix → `f` | file-viewer をスプリットで開く |
| prefix → `[` / `]` | 前 / 次の agent へ移動 |
| prefix → `Alt+1..9` | agent 1〜9 に直接フォーカス |
| prefix → `Tab` | 直前のペインと往復 |

## Claude Code 連携

`herdr integration install claude` を実行すると、`~/.claude/hooks/herdr-agent-state.sh` が
インストールされ、`~/.claude/settings.json` の `SessionStart` hook に登録される。
これにより herdr が各ペイン内の Claude Code の状態（作業中 / 入力待ち / 完了）を検知し、

- サイドバーの agent 一覧に状態を表示
- バックグラウンド workspace の Claude が入力待ちになると通知（`[ui.toast]` 設定）
- `herdr server` 再起動後に Claude のセッションを自動復帰（`resume_agents_on_restore`）

が有効になる。

```bash
herdr integration status     # 連携の状態・バージョン確認
herdr integration install claude   # インストール / 更新（herdr update 後に再実行推奨）
```

> hook スクリプトは herdr が管理するファイルなので dotfiles では管理しない。
> 新しいマシンでは `brew install herdr && herdr integration install claude` を実行する。

### CLI からの agent 操作

Claude を複数並行で走らせるときは workspace を分け、CLI からも操作できる:

```bash
herdr agent list             # 動いている agent 一覧と状態
herdr workspace list         # workspace 一覧
herdr worktree list          # herdr 管理の git worktree 一覧
herdr wait --help            # agent の完了待ち（スクリプトから利用可）
herdr api --help             # socket API の生データ確認
```

## リモートセッション（liat 系など）

herdr のソケットはセッション単位: デフォルトは `~/.config/herdr/herdr.sock`、
名前付きセッションは `~/.config/herdr/sessions/<name>/herdr.sock`。
liat 系は home が NFS 共有のため、デフォルトソケットのままだと全ホストでパスが衝突する。
**ホスト名を名前付きセッションにして、ホスト専用ソケットにする**のが原則。

- ローカルから: `hd --remote liat300`（`.zshrc` の `hd` 関数が自動で `--session liat300` を付与）
- ssh 直ログイン時: `.zshrc` が Linux ホストで `HERDR_SESSION=$(hostname -s)` を export
  するので、素の `herdr` でも同じホスト専用セッションに揃う

ソケットの解決順: `--session` フラグ → `HERDR_SOCKET_PATH` → `HERDR_SESSION` → デフォルト。

なお `[remote] manage_ssh_config`（デフォルト true）により、`--remote` は keepalive と
SSH 接続の再利用（control socket）が自動で効く。

## 設定変更のワークフロー

1. `config/herdr/config.toml` を編集（dotfiles 側。シンボリックリンク済み）
2. `herdr server reload-config` で反映（または prefix → `Shift+R`）

## トラブルシューティング

```bash
herdr status                          # server が生きているか
tail -f ~/.config/herdr/herdr-server.log
herdr --no-session                    # server/client を使わない単体起動（脱出ハッチ）
herdr config reset-keys               # キーバインド設定をリセット（config はバックアップされる）
```
