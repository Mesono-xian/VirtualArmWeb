# VirtualArmWeb
华中科技大学电信学院嵌入式Linux课程设计

基于虚拟Arm开发板，运行web服务器实现简单的功能

v1 实现简单的html动态网页，显示本机ip地址以及ping外网

v2 优化了html的显示，将ping的结果直接显示在当前页面上

v3 优化html的显示和交互，实现同步虚拟arm和宿主机的时间并显示到网页中，能够在网页在线执行简单的脚本代码

## 操作说明
1. 首先需要为宿主机（运行linux的X86机器）和虚拟平台（运行linux的虚拟ARM）配置其相应的dns，保证使用虚拟平台能够`ping`通如`baidu.com`等的外部网站
2. 运行预先编写好的同步宿主机和虚拟平台时间的脚本，使得在虚拟平台中运行`date`命令，显示当前正确时间、日期等信息
3. 在虚拟平台共享的`mnt`路径内切换至`final`文件夹，运行指令：`/mnt/final/lighttpd-1.4.75/install/sbin/lighttpd -f/mnt/final/lighttpd.conf`，然后在ubuntu虚拟机中打开浏览器，访问自己虚拟平台对应IP地址和正确端口（我个人是http://10.0.0.2:8080），打开index.html，即可进入最终的成果网页，实现功能
4. 如果需要退出构建的该web服务器，在`final`路径中运行`killall lighttpd`指令即可