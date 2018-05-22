PIL
===

``PIL：Python Imaging Library``,
已经是Python平台事实上的图像处理标准库了。PIL功能非常强大，但API却非常简单易用。

由于PIL仅支持到\ ``Python 2.7``,
加上年久失修，于是一群志愿者在PIL的基础上创建了兼容的版本，名字叫
``Pillow``,
支持最新\ ``Python 3.x``\ ，又加入了许多新特性，因此，我们可以直接安装使用Pillow。

Pillow
------

http://pillow.readthedocs.io/en/latest/

https://github.com/python-pillow/Pillow

安装
~~~~

http://pillow.readthedocs.io/en/latest/installation.html

生成字母验证码
~~~~~~~~~~~~~~

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-
    # @Time    : 26/05/2017 10:31 AM
    # @Author  : yang

    from PIL import Image,ImageDraw,ImageFont,ImageFilter

    import random


    def rnd_char():
        return chr(random.randint(65,90))


    def rnd_color():
        return (random.randint(64,255), random.randint(64,255), random.randint(64,255))


    def rnd_color2():
        return (random.randint(32,127), random.randint(32,127), random.randint(32,127))

    # 240 * 60
    width = 60 * 4
    height = 60
    image = Image.new('RGB',(width,height),(255,255,255))

    # 创建Font对象
    font = ImageFont.truetype('Arial.ttf',36)
    # 创建Draw对象
    draw = ImageDraw.Draw(image)

    # 填充每个像素
    for x in range(width):
        for y in range(height):
            draw.point((x,y),fill=rnd_color())

    # 输出文字
    for t in range(4):
        draw.text((60 * t + 10,10),rnd_char(),font=font,fill=rnd_color2())

    # 模糊
    #image = image.filter(ImageFilter.BLUR)
    image.save('code.jpg','jpeg')

问题记录
--------

IOError: cannot open resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

这是因为PIL无法定位到字体文件的位置，可以根据操作系统提供绝对路径，比如

::

    '/Library/Fonts/Arial.ttf'
