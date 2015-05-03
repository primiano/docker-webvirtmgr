
## Webvirtmgr Dockerfile

1. Install [Docker](https://www.docker.com/).

2. Pull the image from Docker Hub

```
$ docker pull primiano/docker-webvirtmgr
$ sudo groupadd -g 1010 webvirtmgr
$ sudo useradd -u 1010 -g webvirtmgr -s /sbin/nologin -d /data/vm webvirtmgr
$ sudo chown -R webvirtmgr:webvirtmgr /data/vm
```

### Usage

```
$ docker run -d -p 8080:8080 -p 6080:6080 --name webvirtmgr -v /data/vm:/var/local/webvirtmgr -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock primiano/docker-webvirtmgr
```

