

添加非安全仓库

```shell
root@ubuntu47:~# vi /etc/systemd/system/multi-user.target.wants/docker.service

    ExecStart=/usr/bin/dockerd --insecure-registry 121.42.244.66:8517

root@ubuntu47:~# systemctl daemon-reload
root@ubuntu47:~# systemctl restart docker.service
```

检查

```shell
root@ubuntu47:~# docker info|tail -5
WARNING: No swap limit support
Experimental: false
Insecure Registries:
 121.42.244.66:8517
 127.0.0.0/8
Live Restore Enabled: false
```