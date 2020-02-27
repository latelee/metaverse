
Cross compile mvs using Docker

you nned to change to **root** when executing the flowing command.

## env
check versin first, linux kerne and docker version:
```
host docker >= 17.05.0-ce
host kernel >= 4.8
```

install qemu:
```
apt-get install qemu-user-staic
```

## way1
Clone the mvs source.  
then enter mvs source directory, then run:  
```
./cross-build.sh // form arm 64 (eg: aarch64, armv8(and abover))
```
When everything ok, the binary file and .so/.a file will be found in output directory.

## way2
Clone the mvs source.  
then enter mvs source directory.

pull docker image(with built library):
```
docker pull latelee/mvs:arm64
```
the head file(eg, boost), and share file(eg, libxxx.so) locate in /usr/local .

run the docker image:
```
docker run -itd --name arm64 latelee/mvs:arm64 
```

copy mvs source: 
```
docker cp ../metaverse/  arm64:/tmp
```

go into container(arm64 for example):
```
docker exec -it arm64 bash
cd /tmp/metaverse
mkdir -p build && cd build && cmake .. && make -j2 && make install
```
When everything ok, mvsd file will be found in /usr/local/bin .
exit container:
```
exit
```
then copy the file: 
```
docker cp arm64:/usr/local/lib .
docker cp arm64:/usr/local/bin .
```

## other
1 cpu core, 2GB memory host, build time:  
```
start at ~ 2.25 13:20
finish at ~ 2.26 17:00
```
when you need run script background, run:
```
nohup bash cross-build.sh &
```
check nohup.out for log information.