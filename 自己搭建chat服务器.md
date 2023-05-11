# chatgpt 无需魔法无需花费使用教程

### 购买云服务器

最近发现了一个可以白嫖域名和证书的网站

https://www.rainyun.com/Mzk2NDM=_

[共建智能世界云底座-华为云 (huaweicloud.com)](https://www.huaweicloud.com/)

[阿里云-计算，为了无法计算的价值 (aliyun.com)](https://cn.aliyun.com/)

[腾讯云 产业智变·云启未来 - 腾讯 (tencent.com)](https://cloud.tencent.com/)

## 安装获取linux主机

首先，我们需要准备一台带有`docker`或者 `linux`（虚拟机、wsl2、云服务器）的主机 。

###  安装虚拟机

* 系统镜像： https://iso.mirrors.ustc.edu.cn/ubuntu-releases/focal/ubuntu-20.04.6-desktop-amd64.iso
* 虚拟机：https://pan.baidu.com/s/1puqnvcn6LNksBJls1jA_kQ?pwd=z748 

---------------------------------------

### 安装wsl2

安装wsl参考：[安装 WSL | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/wsl/install)

------------------------

##  安装管理面板

面板安装地址：[在线安装 - 1Panel 文档](https://1panel.cn/docs/installation/online_installation/)

* 设置中科大的国内镜像源：`sudo sed -i 's@//.*ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list`


* 如果没有 `curl`  安装一下 ： `sudo apt update && sudo apt install curl`

我们打开这个远程终端

```bash
curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
```

浏览器输入：ip:6789

## 安装免费的 chatgpt

## 强烈推荐

这里这个需要登录你的openai账号 然后在这地址获取你的key： [openai chatgpt key](https://platform.openai.com/overview) （需要魔法）

```
docker run -d -p 3000:3000 -e OPENAI_API_KEY="sk-xxxx" -e CODE="admin123" yidadaa/chatgpt-next-web
```

### 非免费 （推荐）

**这种方法可能需要魔法**

```bash
docker run --name chatgpt-web -d -p 3002:3002 --env OPENAI_API_KEY='' chatgpt-web
```

### 免费的 （不推荐）

这里这个需要登录你的openai账号 然后在这地址获取你的 token :  [获取token ](https://chat.openai.com/api/auth/session)   (需要魔法)

```bash
docker run --name chatgpt-web -d -p 3002:3002 --env OPENAI_ACCESS_TOKEN='' chatgpt-web
```

然后在你的浏览里面输入你的  ip:3002

即可使用。



















