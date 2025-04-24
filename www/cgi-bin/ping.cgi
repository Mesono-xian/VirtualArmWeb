#!/bin/sh
echo "Content-type: text/plain"
echo ""

host=$(echo "$QUERY_STRING" | awk -F= '{print $2}')
host=$(echo "$host" | sed 's/%2E/./g' | sed 's/%2D/-/g')

echo "Ping 目标：$host"
echo "----------------------"

if echo "$host" | grep -Eq "^[a-zA-Z0-9.\-]+$"; then
    /bin/ping -c 4 "$host"
else
    echo "❌ 无效的主机名"
fi
