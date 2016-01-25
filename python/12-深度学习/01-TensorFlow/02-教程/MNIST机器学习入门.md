# MNIST机器学习入门

MNIST是一个入门级的计算机视觉数据集，它包含各种手写数字图片以及对应的标签.

## MNIST数据集

MNIST数据集的官网是[Yann LeCun's website](http://yann.lecun.com/exdb/mnist/)。

安装`tensorflow`后, 在对应目录下会有一个示例, 里面的`input_data.py`可以用于下载和安装这个数据集.

```shell
site-packages/tensorflow/examples/tutorials/mnist
```

执行如下代码, 会在运行`python shell`的目录进行解压

```python
(tensorflow) ➜  ~ python
Python 3.5.1 (default, Jul 24 2017, 08:38:39)
[GCC 4.2.1 Compatible Apple LLVM 8.1.0 (clang-802.0.42)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>>
>>> import tensorflow.examples.tutorials.mnist.input_data as input_data
>>> mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
Successfully downloaded train-images-idx3-ubyte.gz 9912422 bytes.
Extracting MNIST_data/train-images-idx3-ubyte.gz
Successfully downloaded train-labels-idx1-ubyte.gz 28881 bytes.
Extracting MNIST_data/train-labels-idx1-ubyte.gz
Successfully downloaded t10k-images-idx3-ubyte.gz 1648877 bytes.
Extracting MNIST_data/t10k-images-idx3-ubyte.gz
Successfully downloaded t10k-labels-idx1-ubyte.gz 4542 bytes.
Extracting MNIST_data/t10k-labels-idx1-ubyte.gz
```

退出终端可以看到如下内容

```shell
(tensorflow) ➜  ~ ls MNIST_data
t10k-images-idx3-ubyte.gz  t10k-labels-idx1-ubyte.gz  train-images-idx3-ubyte.gz train-labels-idx1-ubyte.gz
```

下载下来的数据集被分成两部分：60000行的训练数据集（`mnist.train`）和10000行的测试数据集（`mnist.test`）。这样的切分很重要，在机器学习模型设计时必须有一个单独的测试数据集不用于训练而是用来评估这个模型的性能，从而更加容易把设计的模型推广到其他数据集上（泛化）。