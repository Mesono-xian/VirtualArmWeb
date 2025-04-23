#!/bin/sh

echo "Content-type: text/html"
echo ""

host=$(echo "$QUERY_STRING" | awk -F= '{print $2}')
result=""

# 检查 host 格式
if echo "$host" | grep -Eq "^[a-zA-Z0-9.\-]+$"; then
    result=$(/bin/ping -c 4 "$host")
else
    result="无效的主机名"
fi

echo "<html><body>"
echo "<script>window.location.href = '/index.html?ping-result=$(echo $result | sed 's/ /%20/g')';</script>"
echo "</body></html>"
