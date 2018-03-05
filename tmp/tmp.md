# tmp

禁ping

```shell
iptables -A INPUT -p icmp --icmp-type 8 -s 0/0 -j DROP
```
