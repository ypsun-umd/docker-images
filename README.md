# docker-images: Custom dockers for UMD LHCb group
## hep_ml
* On Linux:
```
docker run --rm -it -v <src_path>:/data -v $XAUTHORITY:/home/physicist/.Xauthority -e DISPLAY -e UID=$(id -u) -e GID=$(id -g) --net=host ypsunumd/hep_ml
```
