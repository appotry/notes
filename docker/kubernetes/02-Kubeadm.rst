Kubeadm
=======

Kubeadm解决TLS加密配置问题,
部署核心Kubernetes组件并确保新增节点可以很容易的加入集群.
集群通过RBAC等机制确保安全.

更多细节参考 https://github.com/kubernetes/kubeadm

安装
------------

`参考 Alibaba open source mirror site <https://opsx.alibaba.com/mirror>`_ 

Debian / Ubuntu
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: shell

    apt-get update && apt-get install -y apt-transport-https
    curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
    EOF  
    apt-get update
    apt-get install -y kubelet kubeadm kubectl

CentOS / RHEL / Fedora    
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: shell

    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
    EOF
    setenforce 0
    yum install -y kubelet kubeadm kubectl
    systemctl enable kubelet && systemctl start kubelet 

初始化Master
------------
