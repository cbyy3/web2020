# web2020
This project includes two systems, the back-end management terminal and the client terminal.
本系统包括后台管理端和客户端两个部分,部署在CentOS 7.6上，借助了宝塔工具。

宝塔上需要安装如下软件：
(1) Apache 2.4.46
(2) MySQL 5.5.62
(3) PHP-7.2
(4) phpMyAdmin 5.0
(5) Redis 6.0.9
(6) redis数据管理工具 2.7

确保服务器和宝塔的安全组开放如下端口：
HTTP：80
HTTPS:443
宝塔：8888
RabbitMQ:5672、15672
jsonrpc:5050
MySQL:3306
Redis:6379

还需要部署rabbitMQ，并修改golang/src/backMain/backMain.go和golang/src/backDo/backDo.go文件中相应的内容。
修改完成后重新编译生成二进制文件。
注意修改redis的密码（本系统代码中为web2020）

————————————————————————————————————————————————————

后台管理端
在宝塔中新建tp5框架的站点。按照backend/src/ web.xihongshi.work/中的内容进行部署，注意config文件中的内容也要做相应的更改。

————————————————————————————————————————————————————

客户端
frontend/src/bxx/中共有9个文件，上传至站点下即可访问。
部署完成后首先运行一次frontend/src/bxx/ test.php，保证redis中变量的数值与数据库中一致。

————————————————————————————————————————————————————

Golang文件
订单生成文件：backMain.go（已编译为二进制文件：backMain）
订单处理文件：backDo.go（已编译为二进制文件：backDo）
将backMain文件和backDo文件上传至服务器
scp backMain root@ip:/opt/
scp backDo root@ip:/opt/
并运行
./backMain
./backDo
（如果遇到错误-bash: ./backMain: Permission denied，执行chmod 777 backMain）

————————————————————————————————————————————————————

数据库
将sql/src/web_xihongshi_w.sql导入数据库。
注意：数据库的名字为web_xihongshi_w
运行时若无法连接数据库，修改代码中的原数据库密码。
