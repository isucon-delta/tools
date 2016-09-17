## phpのopcache
php_metrics=$(cat << EOS
#[plugin.metrics.memcached]
#command = "/usr/local/bin/mackerel-plugin-memcached"

#[plugin.metrics.php-apc]
#command = "/usr/local/bin/mackerel-plugin-php-apc"

[plugin.metrics.php-opcache]
command = "/usr/local/bin/mackerel-plugin-php-opcache"
EOS
)
echo "$php_metrics" | sudo tee -a /etc/mackerel-agent/mackerel-agent.conf

## nginxのメトリックス
nginx_metrics=$(cat << EOS
[plugin.metrics.nginx]
command = "/usr/local/bin/mackerel-plugin-nginx"
EOS
)
echo "$nginx_metrics" | sudo tee -a /etc/mackerel-agent/mackerel-agent.conf

### agentの再起動
sudo /etc/init.d/mackerel-agent restart
