



## 基础环境



```bash 

sudo apt update && sudo  apt install nvidia-driver-535 curl neovim -y && curl -SLs get.docker.com | sudo bash 

sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo chmod a+rw /var/run/docker.sock

curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update

sudo apt-get install nvidia-container-runtime
sudo reboot
```



## CPU挖矿

构建镜像



```bash
docker build -t cpu  --build-arg version=1.8.5 -f ./cpu.dockerfile .
```

运行挖矿程序

```
# -e后面接的参数，name参数是你的矿工名字，token是你的token，num是使用到的线程数， --gpus all是使用全部gpu（你也可以指定使用某个GPU），-d gpu是指使用名为gpu的镜像
docker run -itd --name qubic-cpu --restart=always \
	-e name=work2-cpu \
	-e token=""  \
	-e num=12  \
	cpu
```



## GPU 挖矿

构建镜像

```bash
# gpu是镜像名，./gpu.dockerfile是你的dockerfile文件位置，cpu.dockerfile构建Cpu挖矿镜像，gpu.dockerfile构建GPU挖矿镜像
docker build -t gpu  --build-arg version=1.8.5 -f ./gpu.dockerfile .
```

运行挖矿程序

```bash 
# -e后面接的参数，name参数是你的矿工名字，token是你的token，num是使用到的线程数， --gpus all是使用全部gpu（你也可以指定使用某个GPU），-d gpu是指使用名为gpu的镜像
docker run -itd --name qubic-gpu  --gpus all --restart=always \
	-e name=work-gpu \
	-e token=""  \
	-e num=1  \
	gpu
```



## 卸载挖矿



###  cpu

```bash
docker rm -f qubic-cpu
```



### gpu

```bash
docker rm -f qubic-gpu
```







