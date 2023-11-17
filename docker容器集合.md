# docker容器集合



## docker 安装

```bash
sudo curl -fsSL get.docker.com  && sudo sh
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo chmod a+rw /var/run/docker.sock
```



##  docker 容器

### mysql容器

```bash
docker run \
      --name mysql  \
      --privileged=true \
      -p 3306:3306 \
      -v /home/mysql:/val/lib/mysql \
      -e MYSQL_ROOT_PASSWORD="1xxxmysql." \
      --restart=always \
      -d mysql:5.7
```



### mongodb容器



```bash
docker run  -d \
     --name mongodb \
     -v /data/mongo:/data/db \
     -p 27017:27017 \
     --restart=always \
     mongo
```

```bash
#进入 `mongo`
mongosh
#进入 admin 的数据库
use admin
#创建管理员用户
db.createUser(
   {
     user: "root",
     pwd: "111mongo.",
     roles: [ { role: "root", db: "admin" } ]
   }
 )
```



### alist安装

```bash
docker run -d --restart=always -v /opt/alist:/opt/alist/data -p 5244:5244 --name="alist" xhofe/alist:latest
```

获取alist密码

```bash
docker exec -it alist ./alist admin
```

###  中文版本的  portainer  

```bash
docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce
```

### jupyter镜像

-----------------------

#### 官方镜像

```
docker run -p 8090:8000 -d --name jupyterhub001  --restart=always jupyterhub/jupyterhub:latest
```

#### 个人镜像  (GPU) 

```bash
docker run -p 8000:8000 -d --name jupyterhub  --restart=always --gpus all muaimingjun/jupyterhub:1.2.0
```



### WireGuard 

#### 服务器端

```bash
docker run -d \
  --name=wg-easy \
  -e WG_HOST=xx.xxx.xx.xx  \ #(🚨这里输入服务器的公网IP)
  -e PASSWORD="xxxxx"  \ # (🚨这里输入你的密码)
  -e WG_DEFAULT_ADDRESS=10.0.8.x \ # （🚨默认IP地址）
  -e WG_DEFAULT_DNS=114.114.114.114 \ # （🚨默认DNS）
  -e WG_ALLOWED_IPS=10.0.8.0/24 \ # （🚨允许连接的IP段）
  -e WG_PERSISTENT_KEEPALIVE=25 \ # （🚨重连间隔）
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  weejewel/wg-easy
```

例子：

```bash
docker run -d \
  --name=wg-easy \
  -e WG_HOST=42.xxx.117.xxx  \
  -e PASSWORD="1ghjkl;'"  \
  -e WG_DEFAULT_ADDRESS=10.0.8.x \
  -e WG_DEFAULT_DNS=114.114.114.114 \
  -e WG_ALLOWED_IPS=10.0.8.0/24 \
  -e WG_PERSISTENT_KEEPALIVE=5 \
  -v /opt/wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  weejewel/wg-easy
```



#### 客户端

* windows 客户端下载  （科学上网）[Installation - WireGuard](https://www.wireguard.com/install/)

* 安卓客户端 [WireGuard | F-Droid - Free and Open Source Android App Repository](https://f-droid.org/en/packages/com.wireguard.android/)

* ubuntu 

* ```bash
  sudo apt install -y iptables wireguard openresolv
  chmod 600 /etc/wireguard/wg0.conf
  wg-quick up wg0
  wg-quick down wg0
  systemctl enable wg-quick@wg0.service
  systemctl start wg-quick@wg0.service
  wg show
  ```



### frp docker 

frp server 使用 1panal面板应用商店直接安装

配置文件

```bash
[common]
bind_port = 7000
# 启用面板
dashboard_port = 7500
# 面板登录名和密码
dashboard_user = admin
dashboard_pwd = xxxxxxx
# 使用http代理并使用8888端口进行穿透
vhost_http_port = 8889
# 使用https代理并使用9999端口进行穿透
vhost_https_port = 9999
# 日志路径
log_file = ./frps.log
# 日志级别
log_level = info
# 日志最大保存天数
log_max_days = 2
# 认证超时时间
authentication_timeout = 900
# 认证token，客户端需要和此对应
token=123123123
# 最大连接数
max_pool_count = 5
max_ports_per_client = 0
```

frp 客户端  

配置

```bash
 cat /opt/frpc/frpc.toml
[common]
server_addr=124.xx.xx.xx
server_port=7000
token=hxSoC6xxxxxx

[nas-ssh]
type=tcp
local_ip=127.0.0.1
local_port=22
remote_port=108xx

```

```bash
docker run --restart=always --network host -d -v /opt/frpc/frpc.toml:/etc/frp/frpc.toml --name frpc snowdreamtech/frpc
```

直播代录

```bash
docker run --restart=always --name  bililive-go  -v /opt/bililive/Videos:/srv/bililive -p 8080:8080 -d chigusa/bililive-go
```









docker wechat

```b
docker run -itd --name wechatbot --restart=always \
 -e APIKEY="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" \
 -e AUTO_PASS=false \
 -e SESSION_TIMEOUT=60s \
 -e MODEL=text-davinci-003 \
 -e MAX_TOKENS=512 \
 -e TEMPREATURE=0.9 \
 -e REPLY_PREFIX="我是来自 ChatGPT 回复:" \
 -e SESSION_CLEAR_TOKEN="下一个问题" \
 docker.mirrors.sjtug.sjtu.edu.cn/qingshui869413421/wechatbot:latest
 
 
 # 查看二维码
$ docker exec -it wechatbot bash 
$ tail -f -n 50 /app/run.log 
```

docker 备忘录

```bash
docker run --name reference -itd -p 9667:3000 wcjiang/reference:latest
```

docker ubuntu镜像

```bash
docker run -d -P --name test_sshd seth0r/ubuntu-sshd:20.04
# 查看端口
docker port test_sshd 22
# 用户：root 密码：root
```

chatgpt 一比一镜像网站

```bash
docker run -e PANDORA_CLOUD=cloud -e PANDORA_SERVER=0.0.0.0:8899 -p 8899:8899 -d pengzhile/pandora
```





