# TensorFlow Serving

[GitHub](https://github.com/tensorflow/serving)

<!-- TOC -->

- [TensorFlow Serving](#tensorflow-serving)
    - [介绍](#介绍)
    - [下载安装](#下载安装)
        - [先决条件](#先决条件)
            - [Bazel (only if compiling source code)](#bazel-only-if-compiling-source-code)
            - [gRPC](#grpc)
            - [一些依赖包](#一些依赖包)
            - [TensorFlow Serving Python API PIP package](#tensorflow-serving-python-api-pip-package)
        - [通过apt-get安装](#通过apt-get安装)
            - [可用二进制包](#可用二进制包)
            - [安装ModelServer](#安装modelserver)
        - [通过源码安装](#通过源码安装)
            - [克隆TensorFlow Serving 仓库](#克隆tensorflow-serving-仓库)
            - [安装依赖](#安装依赖)
            - [构建](#构建)
            - [Optimized build](#optimized-build)
            - [持续构建](#持续构建)
    - [使用docker部署TensorFlow Serving](#使用docker部署tensorflow-serving)

<!-- /TOC -->

## 介绍

TensorFlow Serving is an open-source software library for serving machine learning models. It deals with the inference aspect of machine learning, taking models after training and managing their lifetimes, providing clients with versioned access via a high-performance, reference-counted lookup table.

## 下载安装

### 先决条件

编译或使用`TensorFlow Serving`, 需要安装一些依赖.

#### Bazel (only if compiling source code)

`TensorFlow Serving`依赖`Bazel` 0.4.5 或更高. You can find the Bazel installation instructions [here](http://bazel.build/docs/install.html).

If you have the prerequisites for Bazel, those instructions consist of the following steps:

1. Download the relevant binary from [here](https://github.com/bazelbuild/bazel/releases). Let's say you downloaded bazel-0.4.5-installer-linux-x86_64.sh. You would execute:

```shell
cd ~/Downloads
chmod +x bazel-0.4.5-installer-linux-x86_64.sh
./bazel-0.4.5-installer-linux-x86_64.sh --user
```

2. Set up your environment. Put this in your ~/.bashrc.

```shell
export PATH="$PATH:$HOME/bin"
```

#### gRPC

Our tutorials use [gRPC](http://www.grpc.io/) (1.0.0 or higher) as our RPC framework. You can find the installation instructions [here](https://github.com/grpc/grpc/tree/master/src/python/grpcio).

#### 一些依赖包

```shell
sudo apt-get update && sudo apt-get install -y \
        build-essential \
        curl \
        libcurl3-dev \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        zip \
        zlib1g-dev
```

TensorFlow依赖可能会改变, 所以注意关注 [build instructions](https://www.tensorflow.org/install/install_sources). 注意`apt-get install` 和 `pip install` 命令, 你可能需要运行.

#### TensorFlow Serving Python API PIP package

运行python客户端代码, 不需要安装`Bazel`, 使用如下命令安装`tensorflow-serving-api`

```shell
pip install tensorflow-serving-api
```

### 通过apt-get安装

#### 可用二进制包

TensorFlow Serving ModelServer 有两种变体:

**tensorflow-model-server**: 针对使用一些特定指令的编译器的平台(比如SSE4和AVX指令的平台)进行过完整的优化. 这应该是大多数用户的首选, 但是在一些老的机器上可能无法工作.

**tensorflow-model-server-universal**: 基本优化编译而成, 但不包含特定平台的指令集, 所以在大多数(不是全部)机器上都可以正常工作. 如果使用 `tensorflow-model-server` 无法工作, 请使用该版本. 注意两个二进制包名是相同的, 如果已经安装过 `tensorflow-model-server`, 请先运行一下命令进行卸载:

```shell
sudo apt-get remove tensorflow-model-server
```

#### 安装ModelServer

1. 添加TensorFlow Serving 源 (如没有添加)

```shell
echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | sudo tee /etc/apt/sources.list.d/tensorflow-serving.list

curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | sudo apt-key add -
```

1. 安装升级TensorFlow ModelServer

```shell
sudo apt-get update && sudo apt-get install tensorflow-model-server
```

安装完毕后, 可以使用 `tensorflow_model_server`命令调用.

可以使用如下命令升级`tensorflow-model-server`到新版本:

```shell
sudo apt-get upgrade tensorflow-model-server
```

注意: 在上面的命令中, 如果你的处理器不支持AVX 指令, 使用 `tensorflow-model-server-universal` 代替`tensorflow-model-server` .

### 通过源码安装

#### 克隆TensorFlow Serving 仓库

```shell
git clone --recurse-submodules https://github.com/tensorflow/serving
cd serving
```

使用`--recurse-submodules`参数获取`TensorFlow`, `gRPC`和其他`TensorFlow Serving`依赖的库. 注意, 这将安装`TensorFlow Serving`的最新master分之. 如果你想安装指定分支 (如发布分支),通过 `-b <branchname>`参数指定 `git clone` 分支.

#### 安装依赖

按照本文先决条件部分, 安装相关依赖项. 配置`TensorFlow`, 运行

```shell
cd tensorflow
./configure
cd ..
```

如果在安装`TensorFlow`或相关依赖项遇到任何问题都可以查阅 [TensorFlow install instructions](https://www.tensorflow.org/install/).

#### 构建

`TensorFlow Serving`使用`Bazel`构建. 使用`Bazel`命令构建个人目标或者完整源码树.

构建完整代码数, 执行:

```shell
bazel build -c opt tensorflow_serving/...
```

二进制包将放置在`bazel-bin`目录, 可以使用如下命令执行:

```shell
bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server
```

测试你的安装, 执行:

```shell
bazel test -c opt tensorflow_serving/...
```

通过查看 [basic tutorial](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/g3doc/serving_basic.md) and [advanced tutorial](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/g3doc/serving_advanced.md) 获取运行`TensorFlow Serving` 更深入的例子.

#### Optimized build

针对一些使用特殊指令集(比如AVX)的平台, 可以进行编译参数优化, 可以显著提高性能. 无论你在文档哪里看到`bazel build` , 你都可以添加参数 `-c opt --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-O3` (或参数的子集). 例如:

```shell
bazel build -c opt --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-O3 tensorflow_serving/...
```

注意: 这些指令集不是在所有机器上都可用, 尤其是处理器比较老的机器, 所以使用上述完整的参数可能无法工作, 你可以尝试里面的部分参数, 或使用基本参数 `-c opt` , 该参数可以保证在所有机器上可用.

#### 持续构建

我们的 [持续构建](http://ci.tensorflow.org/view/Serving/job/serving-master-cpu/) 使用 TensorFlow [ci_build](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/ci_build) 基础设施(基于docker), 可以简化开发过程. 你需要的工具是`git` 和 `docker`. 不需要手动安装所有依赖项.

```shell
git clone --recursive https://github.com/tensorflow/serving
cd serving
CI_TENSORFLOW_SUBMODULE_PATH=tensorflow tensorflow/tensorflow/tools/ci_build/ci_build.sh CPU bazel test //tensorflow_serving/...
```

注意: `serving` 目录映射到容器内. 你可以在容器外使用你喜欢的编辑器进行开发, 当你运行该构建的时候, 它将对你所有的更改进行构建.

**文档地址** [https://github.com/tensorflow/serving/blob/master/tensorflow_serving/g3doc/setup.md](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/g3doc/setup.md)

## 使用docker部署TensorFlow Serving

[参考](https://yangjinjie.github.io/notes/cloud/docker/使用docker部署TensorFlow%20Serving.html)
