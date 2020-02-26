交叉编译说明

## 从头构建
```
./cross-build.sh arm
or
./cross-build.sh arm64
```
成功后，程序和依赖库位于当前目录 output 目录。  

## 使用编译环境镜像
下载编译环境镜像：
```
docker pull latelee/mvs:arm32
or
docker pull latelee/mvs:arm64
```
注：该镜像的头文件和库在 /usr/local 目录下。  

运行容器，执行：
```
docker run -itd --name arm latelee/mvs:arm32 
or
docker run -itd --name arm64 latelee/mvs:arm64 
```

拷贝工程：
```
docker cp . arm/tmp
or
docker cp . arm64/tmp
```

进入容器并编译(为arm64为例）：
```
docker exec -it arm64 bash
cd /tmp/metaverse
mkdir -p build && cd build && cmake .. && make -j2 && make install
```

编译好的文件位于 /usr/local/bin 目录。  
退出容器：
```
exit
```
拷贝生成的文件：
```
docker cp arm64:/usr/local/lib .
docker cp arm64:/usr/local/bin .
```

## 其它
阿里云主机，1核心2GB：  
```
start at ~ 2.25 13:20
finish at ~ 2.26 17:00
```