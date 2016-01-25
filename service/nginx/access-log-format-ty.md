# 日志：
使用json格式

```json
log_format json '{'
                '"remote_addr":"$remote_addr",'
                '"remote_user":"$remote_user",'
                '"time_local":"$time_local",'
                '"@timestamp":"$time_iso8601",'
                '"@source":"$server_addr",'
                '"request_method":"$request_method",'
                '"request":"$request",'
                '"uri":"$uri",'
                '"request_uri":"$request_uri",'
                '"status":$status,'
                '"body_bytes_sent":$body_bytes_sent,'
                '"http_referer":"$http_referer",'
                '"http_user_agent":"$http_user_agent",'
                '"http_x_forwarded_for":"$http_x_forwarded_for",'
                '"request_time":$request_time,'
                '"upstream_response_time":"$upstream_response_time",'
                '"upstream_status":"$upstream_status",'
                '"upstream_addr":"$upstream_addr"'
                '}';
   access_log  /var/log/nginx/access.log  json;
```

带request body

```json
  log_format json '{'
                '"remote_addr":"$remote_addr",'
                '"remote_user":"$remote_user",'
                '"request_body":"$request_body",'
                '"time_local":"$time_local",'
                '"@timestamp":"$time_iso8601",'
                '"@source":"$server_addr",'
                '"request_method":"$request_method",'
                '"request":"$request",'
                '"uri":"$uri",'
                '"request_uri":"$request_uri",'
                '"status":$status,'
                '"body_bytes_sent":$body_bytes_sent,'
                '"http_referer":"$http_referer",'
                '"http_user_agent":"$http_user_agent",'
                '"http_x_forwarded_for":"$http_x_forwarded_for",'
                '"request_time":$request_time,'
                '"upstream_response_time":"$upstream_response_time",'
                '"upstream_status":"$upstream_status",'
                '"upstream_addr":"$upstream_addr"'
                '}';

access_log  /var/log/nginx/access.log  json;
```