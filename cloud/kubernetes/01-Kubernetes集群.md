# Kubernetes集群

## 简单创建及测试

对于初学或者简单验证测试的用户, 可以使用下面几种方法

### minikube

[minikube](https://github.com/kubernetes/minikube)

#### 安装

macOS

    brew cask install minikube

Linux

    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

Windows

    Download the [minikube-windows-amd64.exe](https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe) file, rename it to `minikube.exe` and add it to your path.

#### Requirements

* kubectl
* macOS
    * Hyperkit driver, xhyve driver, VirtualBox, or VMware Fusion
* Linux
    * VirtualBox or KVM
    * NOTE: Minikube also supports a --vm-driver=none option that runs the Kubernetes components on the host and not in a VM. Docker is required to use this driver but no hypervisor. If you use --vm-driver=none, be sure to specify a bridge network for docker. Otherwise it might change between network restarts, causing loss of connectivity to your cluster.
* Windows
    * VirtualBox or Hyper-V
* VT-x/AMD-v virtualization must be enabled in BIOS
* Internet connection on first run

[驱动插件安装](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md)

#### Hyperkit driver

The Hyperkit driver will eventually replace the existing xhyve driver. It is built from the minikube source tree, and uses moby/hyperkit as a Go library.

To install the hyperkit driver:

```shell
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& chmod +x docker-machine-driver-hyperkit \
&& sudo mv docker-machine-driver-hyperkit /usr/local/bin/ \
&& sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit \
&& sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
```

启动

```shell
$ minikube start --vm-driver hyperkit

Starting local Kubernetes v1.9.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
```

查看状态

```shell
$ kubectl cluster-info
Kubernetes master is running at https://192.168.64.2:8443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

### play-with-k8s

[play-with-k8s](https://labs.play-with-k8s.com/)

### Katacoda playground

[Katacoda playground](https://www.katacoda.com/courses/kubernetes/playground)提供了一个免费的2节点Kuberentes体验环境，网络基于WeaveNet，并且会自动部署整个集群。但要注意，刚打开Katacoda playground页面时集群有可能还没初始化完成，可以在master节点上运行launch.sh等待集群初始化完成。

部署并访问`kubernetes dashboard`的方法：

```shell
# 在master node上面运行
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl proxy --address='0.0.0.0' --port=8080 --accept-hosts='^*$'&
```

然后点击Terminal Host 1右边的➕，从弹出的菜单里选择View HTTP port 8080 on Host 1，即可打开Kubernetes的API页面。在该网址后面增加/ui即可访问dashboard。

[katacoda courses kubernetes](https://www.katacoda.com/courses/kubernetes)

## Kubernetes部署

[Kubernetes 部署指南](https://github.com/feiskyer/kubernetes-handbook/blob/master/deploy/index.md)
