Kubernetes
==========

`Kubernetes <https://kubernetes.io/docs/home>`__ is an open source
system for managing containerized applications across multiple hosts,
providing basic mechanisms for deployment, maintenance, and scaling of
applications. The open source project is hosted by the Cloud Native
Computing Foundation (CNCF).

`What is
Kubernetes? <https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/>`__

参考资料
--------

-  `官方文档 <https://kubernetes.io/docs>`__
-  `feiskyer
   kubernetes-handbook <https://github.com/feiskyer/kubernetes-handbook>`__
-  `kubernetes
   feisky <https://kubernetes.feisky.xyz/introduction/cluster.html>`__
-  `kubernetes 中文文档 <https://www.kubernetes.org.cn/docs>`__

设计架构
--------

.. figure:: https://raw.githubusercontent.com/kubernetes/kubernetes/release-1.2/docs/design/architecture.png
   :alt: 架构图

   架构图

Kubernetes节点
--------------

核心组件

-  etcd 保存整个集群状态
-  apiserver 提供了资源操作的唯一入口, 并提供认证, 授权, 访问控制,
   API注册和发现等机制
-  controller manager 负责维护集群的状态, 比如故障检测, 自动扩展,
   滚动更新等
-  scheduler 负责资源的调度, 按照预定的调度策略将Pod调度到相应的机器上
-  kubelet 负责维护容器的生命周期,
   同时也负责Volume(CVI)和网络(CNI)的管理
-  Container runtime 负责镜像管理及Pod和容器的真正运行(CRI)
-  kube-proxy 负责Service提供cluster内部的服务发现和负载均衡

其他推荐的Add-ons

-  kube-dns 负责为整个集群提供DNS服务
-  Ingress Controller 为服务提供外网入口
-  Heapster 提供资源监控
-  Dashboard 提供GUI
-  Federation 提供跨可用区的集群
-  Fluentd-elasticsearch 提供集群日志采集, 存储与查询
