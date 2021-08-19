### コマンド

デプロイスクリプトの利用方法
```bash
cd [repository]

bash ./tools/deploy.sh [branch]

# ログ取得方法その1
bash ./tools/clear_logs.sh
(benchを回す)
bash ./tools/collect_logs.sh

# ログ取得方法その2(pprofあり)
bash ./tools/watch_benchmark.sh <profile_time>
(benchを回す)
```

collect_logs/watch_benchmarkの後変更タグとスコアを聞かれるので入力する（フォルダ名に追記する）

その他のコマンド
```bash
# pprofデータ収集
curl -s http://<ip>/debug/pprof/profile?seconds=60 > cpu.pprof
curl -s http://<ip>/debug/pprof/heap?seconds=60 > memory.pprof

# http://<ip>:81で閲覧
# pprofデータ表示ホストを立てる(フォアグラウンド)
go tool pprof -http=localhost:8081 cpu.pprof

# pprofデータ表示ホストを立てる(バックグラウンド)
pkill -f pprof
nohup go tool pprof -http=localhost:8081 ${utilhome}/log/${log_id}/pprof/cpu.pprof </dev/null &>/dev/null &
nohup go tool pprof -http=localhost:8082 ${utilhome}/log/${log_id}/pprof/memory.pprof </dev/null &>/dev/null &
```

### 設定ファイル

- 基本的に`tools/lib/default.sh`
