# Linux命令行使用基础 #
## 实验环境 ##
- Ubuntu 18.04.4 Server LTS 64bit
- 双网卡：NAT(网络地址转换) + Host-Only(仅主机网络)
- asciinema

## 实验要求 ##
- 在asciinema注册一个账号，并在本地安装配置好asciinema
- 确保本地已经完成asciinema auth，并在asciinema成功关联了本地账号和在线账号
- 上传本人亲自动手完成的vimtutor操作全程录像
- 在自己的github仓库上新建markdown格式纯文本文件附上asciinema的分享URL

## 实验过程 ##
- lesson1：[https://asciinema.org/a/m2RgoLZ5446ZhQeR3R28WNf3T](https://asciinema.org/a/m2RgoLZ5446ZhQeR3R28WNf3T)
- lesson2：[https://asciinema.org/a/6xkwh3nPaTGgGCEbuMfVcRYlp](https://asciinema.org/a/6xkwh3nPaTGgGCEbuMfVcRYlp)
- lesson3：[https://asciinema.org/a/AY8GhaLHts7bV2zVd8piZ6Qx7](https://asciinema.org/a/AY8GhaLHts7bV2zVd8piZ6Qx7)
- lesson4：[https://asciinema.org/a/CrOOUCiK0gPkY6gS2vG1CQ2s2](https://asciinema.org/a/CrOOUCiK0gPkY6gS2vG1CQ2s2)
- lesson5：[https://asciinema.org/a/BTLO71bJGTkcxukCem65rB9O6](https://asciinema.org/a/BTLO71bJGTkcxukCem65rB9O6)
- lesson6：[https://asciinema.org/a/LsC5v1m29rSmP5X43CGr5iujC](https://asciinema.org/a/LsC5v1m29rSmP5X43CGr5iujC)
- lesson7：[https://asciinema.org/a/K45V72GwkTjfxdqIn4LqCBsyx](https://asciinema.org/a/K45V72GwkTjfxdqIn4LqCBsyx)

## 实验总结 ##
- 你了解vim有哪几种工作模式？
 - Normal mode
 - Visual mode
 - Insert mode
 - Replace mode
- Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？
 - 一次向下移动光标10行:10j
 - 快速移动到文件开始行:gg
 - 快速移动到文件结束行:G
 - 快速跳到文件中的第N行:NG
- Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？
 - 删除单个字符:x
 - 删除单个单词:dw
 - 从当前光标位置一直删除到行尾:d$
 - 删除单行:dd
 - 删除当前行开始向下数的N行:dNd
- 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？
 - 快速插入N个空行:
   - 插入到光标所在行的下方:10o
   - 插入到光标所在行的上方:10O
 - 快速输入80个-：80a-并按Esc
- 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？
 - 撤销最近一次编辑操作:u
 - 重做最近一次被撤销的操作:CTRL+R
- vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？
 - 剪切单个字符:x
 - 剪切单个单词:dw
 - 剪切单行:dd
 - 复制:v选中单个字符/单词/单行+y
 - 粘贴:p
- 为了编辑一段文本你能想到哪几种操作方式（按键序列）？
 - 从当前字符之前开始编辑：i
 - 从当前字符之后开始编辑：a
 - 在当前行的行尾开始编辑：A
 - 从当前行的下一行开始编辑：o
 - 从当前行的上一行开始编辑：O
 - 改变当前字符：c
- 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？
 - Ctrl+G
- 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？
 - 关键词搜索
   - /关键词 后回车
   - ?关键词 后回车
 - 设置忽略大小写的情况下进行匹配搜索：:set ic
 - 将匹配的搜索结果进行高亮显示: :set hls is
 - 对匹配到的关键词进行批量替换: :s/old/new/g
- 在文件中最近编辑过的位置来回快速跳转的方法？
 - 跳回之前修改的地方:Ctrl+o
 - 回退上面的跳动：Ctrl+i
- 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }
 - 光标移动到一个括号，按%会显示与之匹配的括号

## 遇到的困难 ##
- ubuntu版本低，导致源没更新（xenial），只能下载0.9.8版本的asciinema，此版本asciinema不支持上传，更新版本后也自动更新了源（bionic），从而下载了新版asciinema，版本号2.0.0.1，成功上传录屏。

## 参考资料 ##
- [asciinema版本问题](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=794298)
- [asciinema使用](https://asciinema.org/)