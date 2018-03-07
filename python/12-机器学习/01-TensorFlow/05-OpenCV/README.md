# OpenCV

[http://opencv.org/](http://opencv.org/)

OpenCV是一个基于BSD许可（开源）发行的跨平台计算机视觉库，

## 安装

[一个参考](http://blog.csdn.net/github_33934628/article/details/53122208)

### MacOS安装

[另一个参考(虽然好像没参考上)](http://lib.csdn.net/article/python/62439)

```python
brew tap homebrew/science
brew install opencv

# 安装之后会提示, 需要执行某些命令, 根据提示执行命令
# cd /usr/local/lib/python2.7/site-packages
# echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> homebrew.pth

使用虚拟环境可能需要将 cv2.so 链接到虚拟环境site-packages目录下
ln -s /usr/local/Cellar/opencv/2.4.10/lib/python2.7/site-packages/cv.py cv.py
ln -s /usr/local/Cellar/opencv/2.4.10/lib/python2.7/site-packages/cv2.so cv2.so

最后使用如下命令验证
import cv
import cv2
```

```shell
# 待验证, 是否可以使用conda来管理
RUN conda install -yc conda-forge opencv
```

- [https://conda.io](https://conda.io/docs/index.html)
- [Installation](https://conda.io/docs/user-guide/install/index.html)
