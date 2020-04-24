# 实验三 Systemd入门 #
## 实验要求 ##
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
- 完整实验操作过程通过asciinema进行录像并上传，文档通过github上传

## 实验环境 ##
- Ubuntu 18.04 Server 64bit

## 实验过程 ##
- 系统管理
[![asciicast](https://asciinema.org/a/tuodcRD0st5o69dKTzS7MQPgm.svg)](https://asciinema.org/a/tuodcRD0st5o69dKTzS7MQPgm)
- Unit
[![asciicast](https://asciinema.org/a/uXGI1gjpaTGiwPFgKBlIxPwz4.svg)](https://asciinema.org/a/uXGI1gjpaTGiwPFgKBlIxPwz4)
- Unit的配置文件
[![asciicast](https://asciinema.org/a/ylqyVHNmaIRhPmcOJMLJTIrGV.svg)](https://asciinema.org/a/ylqyVHNmaIRhPmcOJMLJTIrGV)
- Target
[![asciicast](https://asciinema.org/a/q1RgXDwjL5bTPkffhMwvG1wH3.svg)](https://asciinema.org/a/q1RgXDwjL5bTPkffhMwvG1wH3)
- 日志管理
[![asciicast](https://asciinema.org/a/JNaTpbSOJd0JPDNbFPaoMnhvn.svg)](https://asciinema.org/a/JNaTpbSOJd0JPDNbFPaoMnhvn)
- 实战篇
[![asciicast](https://asciinema.org/a/HN9iA7c4TeY3Dn67oGv59cTWu.svg)](https://asciinema.org/a/HN9iA7c4TeY3Dn67oGv59cTWu)

# 自查清单 #
- 如何添加一个用户并使其具备sudo执行程序的权限？
```
sudo adduser newuser
sudo usermod -G sudo newuser
```
- 如何将一个用户添加到一个用户组？
```
sudo usermod -G usergroup username
#usergroup用户组名，username用户名
```
- 如何查看当前系统的分区表和文件系统详细信息？
```
sudo fdisk -l
cat /etc/fstab
```
- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
```
sudo lvextend -L +5g foo/bar	# 给卷组foo中的逻辑卷bar增加5g的空间
sudo lvextend -L -5g foo/bar	# 给卷组foo中的逻辑卷bar减少5g的空间
```
- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？
```
修改NetworkManager.service配置文件的service区块，修改ExecStartPost及ExecStopPost字段，分别改为对应配置文件的路径及名称
```
- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？
```
将该脚本的配置文件中的service区块的restart字段值设置为always
```

## 参考文献 ##
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)