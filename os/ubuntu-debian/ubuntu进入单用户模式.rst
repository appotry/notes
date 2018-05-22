ubuntu进入单用模式方法
======================

1. 按任意键停留在grub菜单
2. 选择 Advanced options for Ubuntu
3. 再选择：recovery mode 按e进入编辑状态
4. 将linux开头那行的“ro recovery nomodeset”改为 “rw single
   init=/bin/bash” (注意：ro 是只读模式，rw是读写模式。) 然后按Ctrl + x,
   进入单用户模式
