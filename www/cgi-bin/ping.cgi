#!/bin/sh

echo "Content-type: text/plain"
echo ""

host=$(echo "$QUERY_STRING" | awk -F= '{print $2}')
echo "Received host: $host"
echo "----"

# 检查 host 格式
if echo "$host" | grep -Eq "^[a-zA-Z0-9.\-]+$"; then
    /bin/ping -c 4 "$host"
else
    echo "无效的主机名"
fi
