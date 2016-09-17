## 公式プラグインの導入
sudo apt-get install mackerel-agent-plugins mackerel-check-plugins

## nginxのプロセス監視とhttpアクセスステータス監視追加
plugin_checks=$(cat << EOS

[plugin.checks.check_nginx_worker]
command = "check-procs -p nginx --user www-data"

[plugin.checks.access_status]
command = '''
  check-log                      \
    --file /var/log/nginx/access.log            \
    --pattern 'HTTP/1\.[01]" [45][0-9][0-9] '   \
    --exclude 'GET .*?robots\.txt HTTP/1\.[01]' \
    --warning-over 3 --critical-over 10         \
    --return
'''
EOS
)
echo "$plugin_checks" | sudo tee -a /etc/mackerel-agent/mackerel-agent.conf

## mysqldの監視
sudo mysql -u root -e \
"create user 'monitor_user'@'127.0.0.1'; \
grant PROCESS, REPLICATION CLIENT on *.* to 'monitor_user'@'127.0.0.1'; \
flush privileges;"

mysql_metrics=$(cat << EOS

[plugin.metrics.mysql]
command = "/usr/local/bin/mackerel-plugin-mysql -username=monitor_user"
EOS
)
echo "$mysql_metrics" | sudo tee -a /etc/mackerel-agent/mackerel-agent.conf

### agentの再起動
sudo /etc/init.d/mackerel-agent restart
