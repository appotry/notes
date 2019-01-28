helm
=============

.. code-block:: shell

    wget https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz

升级 tiller
--------------

.. code-block:: shell

    helm init --canary-image
    # 指定镜像
    helm init --tiller-image registry.cn-hangzhou.aliyuncs.com/acs/tiller:v2.12.0 --upgrade --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
    # 如果镜像不存在，使用
    helm init --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.12.0 --upgrade --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

