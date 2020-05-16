# shell脚本编程基础 #
## 实验环境 ##
- Ubuntu 18.04

## 实验要求 ##
### 任务一 ###
用bash编写一个图片批处理脚本，实现以下功能：
- 支持命令行参数方式使用不同功能
- 支持对指定目录下所有支持格式的图片文件进行批处理
- 支持以下常见图片批处理功能的单独使用或组合使用
  - 支持对jpeg格式图片进行图片质量压缩
  - 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
  - 支持对图片批量添加自定义文本水印
  - 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
  - 支持将png/svg图片统一转换为jpg格式图片

### 任务二 ###
用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：
- [2014世界杯运动员数据](https://github.com/c4pr1c3/LinuxSysAdmin/blob/master/exp/chap0x04/worldcupplayerinfo.tsv)
  - 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
  - 统计不同场上位置的球员数量、百分比
  - 名字最长的球员是谁？名字最短的球员是谁？
  - 年龄最大的球员是谁？年龄最小的球员是谁？

### 任务三 ###
用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：
- Web服务器访问日志
  - 统计访问来源主机TOP 100和分别对应出现的总次数
  - 统计访问来源主机TOP 100 IP和分别对应出现的总次数
  - 统计最频繁被访问的URL TOP 100
  - 统计不同响应状态码的出现次数和对应百分比
  - 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
  - 给定URL输出TOP 100访问来源主机

## 实验过程 ##
### 任务一 ###
- [代码](./code/task1.sh)
- 帮助信息:bash task1.sh -h
```
-h                         : 查看帮助信息
-f 文件名 -size 长宽 -o 输出文件夹: 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
-f 文件名 -w 文本水印 嵌入位置 -o 输出文件夹: 对图片批量添加自定义文本水印
-f 文件名 -rn -f|-b 前缀/后缀 -o 输出文件夹: 批量重命名统一添加文件名前缀或后缀
-f 文件名 -jpg -o 输出文件夹: 将png/svg图片统一转换为jpg格式图片
```
- 对图片进行80%图片质量压缩(./i为原图文件夹，./imgs为压缩后的图片文件夹)
```
bash -x task1.sh -f ./i -c 80% -o ./imgs
```
- 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
```
bash task1.sh -f ./i -size 200 -o ./imgs
```
- 支持对图片批量添加自定义文本水印
```
bash task1.sh -f ./i -w "cuc" 3,3 -o ./imgs
```
- 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
```
bash task1.sh -f ./i -rn -f "w" -o ./re
```
- 支持将png/svg图片统一转换为jpg格式图片
```
bash task1.sh -f ./img -jpg -o ./jpg
```

### 任务二 ###
- [代码](./code/task2.sh)
- 准备
```
sudo apt install wget
wget https://c4pr1c3.github.io/LinuxSysAdmin/exp/chap0x04/worldcupplayerinfo.tsv
```
- 帮助信息：bash task2.sh -h
```
-h 查看帮助信息
-f 文件名 -age [-range]:统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比[-max] :年龄最大的球员是谁[-min]: 年龄最小的球员是谁
-f 文件名 -position:统计不同场上位置的球员数量、百分比
-f 文件名 -name [-max]|[-min]:名字最长/最短的球员
```
- 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
```
bash task2.sh -f worldcupplayerinfo.tsv -age -range
```
```
统计不同年龄区间范围:
20岁以下的球员：9 人，占比 1.22 %
20岁以上30岁以下的球员：600 人，占比 81.63 %
30岁以上的球员：126 人，占比 17.14 %
```
- 统计不同场上位置的球员数量、百分比
```
bash task2.sh -f worldcupplayerinfo.tsv -position
```
```
Midfielder：268 人，占比为 36.41 %
Défenseur： 1 人，  占比为 .13 %
Defender：  236 人，占比为 32.06 %
Goalie：    96 人， 占比为 13.04 %
Forward：   135 人，占比为 18.34 %
```
- 名字最长的球员是谁？名字最短的球员是谁？
```
bash task2.sh -f worldcupplayerinfo.tsv -name -max
```
```
名字最长的是（以字节数计算）：27 字节
Francisco Javier Rodriguez
Lazaros Christodoulopoulos
Liassine Cadamuro-Bentaeba
# 名字最短的球员
bash task2.sh -f worldcupplayerinfo.tsv -name -min
名字最短的是（以字节数计算）：4 字节
Jô
```
- 年龄最大的球员是谁？年龄最小的球员是谁？
```
bash task2.sh -f worldcupplayerinfo.tsv -age -max
```
```
年龄最大为：42
名字是：
Faryd Mondragon
```
```
bash task2.sh -f worldcupplayerinfo.tsv -age -min
```
```
年龄最小为：18
名字是：
Fabrice Olinga
Luke Shaw
```

### 任务三 ###
- [代码](./code/task3.sh)
- 帮助信息：bash task3.sh -h
```
-h 查看帮助信息
-f 文件名 -host：统计访问来源主机TOP 100和分别对应出现的总次数
-f 文件名 -ip： 统计访问来源主机TOP 100 IP和分别对应出现的总次数
-f 文件名 -url：统计最频繁被访问的URL TOP 100
-f 文件名 -code：计不同响应状态码的出现次数和对应百分比
-f 文件名 -4code：分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
-f 文件名 -urlhost 指定url: 给定URL输出TOP 100访问来源主机
```
- 统计访问来源主机TOP 100和分别对应出现的总次数
```
bash task3.sh -f web_log.tsv -host
```
```
TOP1:   edams.ksc.nasa.gov             次数是：6530
TOP2:   piweba4y.prodigy.com             次数是：4846
TOP3:   piweba5y.prodigy.com             次数是：4607
TOP4:   piweba3y.prodigy.com             次数是：4416
TOP5:   www-d1.proxy.aol.com             次数是：3889
TOP6:   www-b2.proxy.aol.com             次数是：3534
TOP7:   www-b3.proxy.aol.com             次数是：3463
TOP8:   www-c5.proxy.aol.com             次数是：3423
TOP9:   www-b5.proxy.aol.com             次数是：3411
TOP10:   www-c2.proxy.aol.com             次数是：3407
TOP11:   www-d2.proxy.aol.com             次数是：3404
TOP12:   www-a2.proxy.aol.com             次数是：3337
TOP13:   news.ti.com             次数是：3298
TOP14:   www-d3.proxy.aol.com             次数是：3296
TOP15:   www-b4.proxy.aol.com             次数是：3293
TOP16:   www-c3.proxy.aol.com             次数是：3272
TOP17:   www-d4.proxy.aol.com             次数是：3234
TOP18:   www-c1.proxy.aol.com             次数是：3177
TOP19:   www-c4.proxy.aol.com             次数是：3134
TOP20:   intgate.raleigh.ibm.com             次数是：3123
TOP21:   www-c6.proxy.aol.com             次数是：3088
TOP22:   www-a1.proxy.aol.com             次数是：3041
TOP23:   mpngate1.ny.us.ibm.net             次数是：3011
TOP24:   e659229.boeing.com             次数是：2983
TOP25:   piweba1y.prodigy.com             次数是：2957
TOP26:   webgate1.mot.com             次数是：2906
TOP27:   www-relay.pa-x.dec.com             次数是：2761
TOP28:   beta.xerox.com             次数是：2318
TOP29:   poppy.hensa.ac.uk             次数是：2311
TOP30:   vagrant.vf.mmc.com             次数是：2237
TOP31:   palona1.cns.hp.com             次数是：1910
TOP32:   www-proxy.crl.research.digital.com             次数是：1793
TOP33:   koriel.sun.com             次数是：1762
TOP34:   derec             次数是：1681
TOP35:   trusty.lmsc.lockheed.com             次数是：1637
TOP36:   gw2.att.com             次数是：1623
TOP37:   cliffy.lfwc.lockheed.com             次数是：1563
TOP38:   inet2.tek.com             次数是：1503
TOP39:   disarray.demon.co.uk             次数是：1485
TOP40:   gw1.att.com             次数是：1467
TOP41:   interlock.turner.com             次数是：1395
TOP42:   sgigate.sgi.com             次数是：1354
TOP43:   bocagate.bocaraton.ibm.com             次数是：1336
TOP44:   piweba2y.prodigy.com             次数是：1324
TOP45:   gw3.att.com             次数是：1311
TOP46:   keyhole.es.dupont.com             次数是：1310
TOP47:   n1144637.ksc.nasa.gov             次数是：1297
TOP48:   erigate.ericsson.se             次数是：1216
TOP49:   gn2.getnet.com             次数是：1211
TOP50:   gwa.ericsson.com             次数是：1089
TOP51:   tiber.gsfc.nasa.gov             次数是：1079                         
TOP52:   bstfirewall.bst.bls.com             次数是：1017                     
TOP53:   spider.tbe.com             次数是：1013                              
TOP54:   gatekeeper.us.oracle.com             次数是：1010                    
TOP55:   www-c8.proxy.aol.com             次数是：995                         
TOP56:   whopkins.sso.az.honeywell.com             次数是：984                
TOP57:   news.dfrc.nasa.gov             次数是：966                           
TOP58:   proxy0.research.att.com             次数是：940                      
TOP59:   proxy.austin.ibm.com             次数是：925                         
TOP60:   www-c9.proxy.aol.com             次数是：902                         
TOP61:   bbuig150.unisys.com             次数是：901                          
TOP62:   corpgate.nt.com             次数是：899                              
TOP63:   sahp315.sandia.gov             次数是：890                           
TOP64:   amdext.amd.com             次数是：869                               
TOP65:   n1121796.ksc.nasa.gov             次数是：830                        
TOP66:   igate.uswest.com             次数是：825                             
TOP67:   gatekeeper.cca.rockwell.com             次数是：819                  
TOP68:   wwwproxy.sanders.com             次数是：815                         
TOP69:   gw4.att.com             次数是：814                                  
TOP70:   goose.sms.fi             次数是：812                                 
TOP71:   jericho3.microsoft.com             次数是：805                       
TOP72:   jericho2.microsoft.com             次数是：786                       
TOP73:   sdn_b6_f02_ip.dny.rockwell.com             次数是：782               
TOP74:   lamar.d48.lilly.com             次数是：778                          
TOP75:   heimdallp2.compaq.com             次数是：772                        
TOP76:   stortek1.stortek.com             次数是：771                         
TOP77:   mac998.kip.apple.com             次数是：759                         
TOP78:   tia1.eskimo.com             次数是：742                              
TOP79:   www-e1f.gnn.com             次数是：733                              
TOP80:   www-b1.proxy.aol.com             次数是：718                         
TOP81:   reddragon.ksc.nasa.gov             次数是：715                       
TOP82:   bambi.te.rl.ac.uk             次数是：701                            
TOP83:   rmcg.cts.com             次数是：701                                 
TOP84:   electron.mcc.com             次数是：697                             
TOP85:   pinta.csee.usf.edu             次数是：689                           
TOP86:   n1040681.ksc.nasa.gov             次数是：676                        
TOP87:   gatekeeper.mitre.org             次数是：670                         
TOP88:   hpcvsop.cv.hp.com             次数是：669                            
TOP89:   screen.lotus.com             次数是：667                             
TOP90:   metabelis.rmit.edu.au             次数是：666                        
TOP91:   orpheus.amdahl.com             次数是：657                           
TOP92:   proxy.bellatlantic.com             次数是：654                       
TOP93:   n1376232.ksc.nasa.gov             次数是：652                        
TOP94:   ftp-relay.mv.us.adobe.com             次数是：651                    
TOP95:   n1131455.ksc.nasa.gov             次数是：645                        
TOP96:   n1123413.ksc.nasa.gov             次数是：642                        
TOP97:   zooropa.res.cmu.edu             次数是：632                          
TOP98:   fkirchman.gsfc.nasa.gov             次数是：612                      
TOP99:   theopolis.orl.mmc.com             次数是：611                        
TOP100:   n1123543.ksc.nasa.gov             次数是：611   
```
- 统计访问来源主机TOP 100 IP和分别对应出现的总次数
```
bash task3.sh -f web_log.tsv -ip
```
```
TOP1:   163.206.89.4             次数是：4791
TOP2:   128.217.62.1             次数是：1435
TOP3:   163.205.1.19             次数是：1360
TOP4:   163.205.3.104             次数是：1292
TOP5:   163.205.156.16             次数是：1256
TOP6:   163.205.19.20             次数是：1252
TOP7:   128.217.62.2             次数是：1054
TOP8:   163.206.137.21             次数是：1015
TOP9:   128.159.122.110             次数是：949
TOP10:   128.159.132.56             次数是：848
TOP11:   128.159.144.83             次数是：808
TOP12:   128.159.111.141             次数是：798
TOP13:   163.205.11.31             次数是：776
TOP14:   163.205.16.75             次数是：762
TOP15:   128.159.122.137             次数是：711
TOP16:   163.205.23.76             次数是：691
TOP17:   206.27.25.1             次数是：672
TOP18:   198.83.19.44             次数是：647
TOP19:   199.1.50.225             次数是：641
TOP20:   163.205.23.93             次数是：624
TOP21:   139.169.174.102             次数是：610
TOP22:   163.205.121.3             次数是：600
TOP23:   140.229.116.37             次数是：598
TOP24:   141.102.82.127             次数是：591
TOP25:   163.206.140.4             次数是：586
TOP26:   163.206.104.34             次数是：573
TOP27:   204.62.245.32             次数是：567
TOP28:   128.159.122.38             次数是：565
TOP29:   128.217.62.224             次数是：563
TOP30:   128.159.122.107             次数是：563
TOP31:   128.159.122.180             次数是：553
TOP32:   128.159.123.58             次数是：549
TOP33:   163.205.154.11             次数是：544
TOP34:   192.112.22.119             次数是：532
TOP35:   163.205.16.100             次数是：518
TOP36:   199.201.186.103             次数是：503
TOP37:   128.159.146.40             次数是：503
TOP38:   128.159.122.160             次数是：494
TOP39:   192.77.40.4             次数是：486
TOP40:   193.143.192.106             次数是：482
TOP41:   152.163.192.5             次数是：480
TOP42:   163.205.23.71             次数是：478
TOP43:   139.169.30.50             次数是：475
TOP44:   128.159.122.144             次数是：469
TOP45:   163.234.140.22             次数是：466
TOP46:   163.205.150.22             次数是：463
TOP47:   128.217.61.184             次数是：457
TOP48:   163.205.23.72             次数是：451
TOP49:   198.83.19.40             次数是：448
TOP50:   128.159.122.14             次数是：446
TOP51:   199.201.186.104             次数是：443
TOP52:   128.217.61.15             次数是：443
TOP53:   198.83.19.47             次数是：443
TOP54:   128.159.121.34             次数是：441
TOP55:   128.159.121.41             次数是：438
TOP56:   160.205.119.27             次数是：435
TOP57:   163.205.154.17             次数是：432
TOP58:   128.159.122.15             次数是：432
TOP59:   152.163.192.38             次数是：432
TOP60:   128.159.135.73             次数是：423
TOP61:   128.159.135.38             次数是：423
TOP62:   152.163.192.35             次数是：421
TOP63:   128.159.76.128             次数是：415
TOP64:   152.163.192.71             次数是：413
TOP65:   128.159.63.159             次数是：412
TOP66:   163.205.12.100             次数是：409
TOP67:   133.53.64.33             次数是：404
TOP68:   152.163.192.70             次数是：402
TOP69:   128.159.121.64             次数是：397
TOP70:   129.239.68.160             次数是：396
TOP71:   152.163.192.36             次数是：391
TOP72:   128.32.196.94             次数是：389
TOP73:   163.205.16.90             次数是：389
TOP74:   163.205.1.18             次数是：385
TOP75:   163.206.136.1             次数是：384
TOP76:   147.147.191.43             次数是：383
TOP77:   163.205.16.104             次数是：374
TOP78:   152.163.192.69             次数是：374
TOP79:   193.178.53.180             次数是：373
TOP80:   128.217.63.27             次数是：371
TOP81:   130.110.74.81             次数是：367
TOP82:   204.69.0.27             次数是：366
TOP83:   163.206.130.46             次数是：365
TOP84:   152.163.192.67             次数是：359
TOP85:   163.205.54.76             次数是：357
TOP86:   152.163.192.7             次数是：356
TOP87:   198.83.19.43             次数是：354
TOP88:   128.159.137.43             次数是：350
TOP89:   147.74.110.61             次数是：348
TOP90:   163.205.23.44             次数是：345
TOP91:   128.159.168.162             次数是：343
TOP92:   158.27.59.88             次数是：336
TOP93:   152.163.192.3             次数是：336
TOP94:   128.159.145.21             次数是：335
TOP95:   163.205.166.15             次数是：335
TOP96:   163.205.2.180             次数是：332
TOP97:   128.217.61.98             次数是：329
TOP98:   152.163.192.66             次数是：328
TOP99:   163.205.2.35             次数是：324
TOP100:   163.205.3.38             次数是：324
```
- 统计最频繁被访问的URL TOP 100
```
bash task3.sh -f web_log.tsv -url
```
```
/images/NASA-logosmall.gif              次数: 97410
 /images/KSC-logosmall.gif               次数: 75337
 /images/MOSAIC-logosmall.gif            次数: 67448
 /images/USA-logosmall.gif               次数: 67068
 /images/WORLD-logosmall.gif             次数: 66444
 /images/ksclogo-medium.gif              次数: 62778
 /ksc.html               次数: 43687
 /history/apollo/images/apollo-logo1.gif                 次数: 37826
 /images/launch-logo.gif                 次数: 35138
 /               次数: 30346
 /images/ksclogosmall.gif                次数: 27810
 /shuttle/missions/sts-69/mission-sts-69.html            次数: 24606
 /shuttle/countdown/             次数: 24461
 /shuttle/missions/sts-69/count69.gif            次数: 24383
 /shuttle/missions/sts-69/sts-69-patch-small.gif                 次数: 23405
 /shuttle/missions/missions.html                 次数: 22453
 /images/launchmedium.gif                次数: 19877
 /htbin/cdt_main.pl              次数: 17247
 /shuttle/countdown/images/countclock.gif                次数: 12160
 /icons/menu.xbm                 次数: 12137
 /icons/blank.xbm                次数: 12057
 /software/winvn/winvn.html              次数: 10345
 /icons/image.xbm                次数: 10308
 /history/history.html           次数: 10134
 /history/apollo/images/footprint-logo.gif               次数: 10126
 /history/apollo/images/apollo-small.gif                 次数: 9439
 /history/apollo/images/footprint-small.gif              次数: 9230
 /software/winvn/winvn.gif               次数: 9037
 /history/apollo/apollo.html             次数: 8985
 /software/winvn/wvsmall.gif             次数: 8662
 /software/winvn/bluemarb.gif            次数: 8610
 /htbin/cdt_clock.pl             次数: 8583
 /shuttle/countdown/liftoff.html                 次数: 7865
 /shuttle/resources/orbiters/orbiters-logo.gif           次数: 7389
 /images/shuttle-patch-logo.gif          次数: 7261
 /history/apollo/apollo-13/apollo-13.html                次数: 7177
 /images/                次数: 7040
 /shuttle/countdown/video/livevideo2.gif                 次数: 7029
 /images/kscmap-tiny.gif                 次数: 6615
 /shuttle/technology/sts-newsref/stsref-toc.html                 次数: 6517
 /history/apollo/apollo-13/apollo-13-patch-small.gif             次数: 6309
 /shuttle/missions/sts-71/sts-71-patch-small.gif                 次数: 5613
 /shuttle/missions/sts-69/images/images.html             次数: 5264
 /icons/text.xbm                 次数: 5248
 /images/construct.gif           次数: 5093
 /images/shuttle-patch-small.gif                 次数: 4869
 /shuttle/missions/sts-69/movies/movies.html             次数: 4846
 /shuttle/missions/sts-70/sts-70-patch-small.gif                 次数: 4791
 /icons/unknown.xbm              次数: 4785
 /shuttle/missions/sts-69/liftoff.html           次数: 4559
 /facilities/lc39a.html          次数: 4464
 /shuttle/resources/orbiters/endeavour.html              次数: 4434
 /history/apollo/images/apollo-logo.gif          次数: 4365
 /shuttle/missions/sts-70/mission-sts-70.html            次数: 4066
 /images/lc39a-logo.gif          次数: 4024
 /shuttle/resources/orbiters/endeavour-logo.gif          次数: 3817
 /shuttle/technology/sts-newsref/sts_asm.html            次数: 3706
 /shuttle/countdown/countdown.html               次数: 3518
 /shuttle/missions/sts-71/movies/movies.html             次数: 3507
 /shuttle/countdown/video/livevideo.jpeg                 次数: 3377
 /history/apollo/apollo-11/apollo-11.html                次数: 3140
 /shuttle/missions/sts-71/mission-sts-71.html            次数: 3130
 /shuttle/missions/sts-70/images/images.html             次数: 3087
 /shuttle/missions/sts-71/images/images.html             次数: 2945
 /shuttle/missions/sts-73/mission-sts-73.html            次数: 2939
 /images/faq.gif                 次数: 2865
 /shuttle/technology/images/srb_mod_compare_1-small.gif          次数: 2864
 /shuttle/technology/images/srb_mod_compare_3-small.gif          次数: 2818
 /shuttle/technology/images/srb_mod_compare_6-small.gif          次数: 2715
 /history/apollo/apollo-11/apollo-11-patch-small.gif             次数: 2701
 /elv/elvpage.htm                次数: 2586
 /shuttle/missions/sts-73/sts-73-patch-small.gif                 次数: 2544
 /shuttle/countdown/video/sts-69-prelaunch-pad.gif               次数: 2385
 /shuttle/missions/51-l/mission-51-l.html                次数: 2343
 /images/launch-small.gif                次数: 2293
 /facilities/tour.html           次数: 2256
 /shuttle/missions/51-l/51-l-patch-small.gif             次数: 2201
 /images/kscmap-small.gif                次数: 2172
 /shuttle/resources/orbiters/challenger.html             次数: 2171
 /shuttle/missions/sts-71/movies/sts-71-launch.mpg               次数: 2159
 /shuttle/technology/sts-newsref/sts-lcc.html            次数: 2146
 /htbin/wais.pl          次数: 2133
 /facts/about_ksc.html           次数: 2120
 /history/mercury/mercury.html           次数: 2107
 /images/mercury-logo.gif                次数: 2040
 /elv/elvhead3.gif               次数: 1991
 /images/launchpalms-small.gif           次数: 1979
 /images/whatsnew.gif            次数: 1936
 /history/apollo/apollo-spacecraft.txt           次数: 1929
 /facilities/vab.html            次数: 1915
 /shuttle/resources/orbiters/columbia.html               次数: 1912
 /shuttle/countdown/lps/fr.html          次数: 1908
 /shuttle/resources/orbiters/challenger-logo.gif                 次数: 1904
 /images/ksclogo.gif             次数: 1892
 /whats-new.html                 次数: 1891
 /elv/endball.gif                次数: 1874
 /history/apollo/apollo-13/apollo-13-info.html           次数: 1869
 /shuttle/missions/sts-74/mission-sts-74.html            次数: 1868
 /elv/PEGASUS/minpeg1.gif                次数: 1845
 /elv/SCOUT/scout.gif            次数: 1835
```
- 统计不同响应状态码的出现次数和对应百分比
```
bash task3.sh -f web_log.tsv -code
```
```
200      次数:1398987   占比 :89.113923
304      次数:134146    占比 :8.544952
302      次数:26497     占比 :1.687830
404      次数:10055     占比 :0.640492
403      次数:17        占比 :0.010893
501      次数:27        占比 :0.001720
500      次数:3         占比 :0.000191
```
- 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
```
bash task3.sh -f web_log.tsv -4code
```
```
/pub/winvn/readme.txt                                   次数: 1337
/pub/winvn/release.txt                                  次数: 1185
/shuttle/missions/STS-69/mission-STS-69.html            次数: 683
/images/nasa-logo.gif                                   次数: 319
/shuttle/missions/sts-68/ksc-upclose.gif                次数: 253
/elv/DELTA/uncons.htm                                   次数: 209
/history/apollo/sa-1/sa-1-patch-small.gif               次数: 200
/://spacelink.msfc.nasa.gov                             次数: 166
/images/crawlerway-logo.gif                             次数: 160
/history/apollo/a-001/a-001-patch-small.gif             次数: 154
```
- 给定URL输出TOP 100访问来源主机
```
bash task3.sh -f web_log.tsv -urlhost /images/ksclogo-medium.gif
```
```
指定url:/images/ksclogo-medium.gif
edams.ksc.nasa.gov               次数: 866
 163.206.89.4                    次数: 231
 128.217.62.1                    次数: 216
 n1144637.ksc.nasa.gov           次数: 214
 163.205.19.20                   次数: 204
 163.205.3.104                   次数: 166
 piweba5y.prodigy.com            次数: 152
 piweba4y.prodigy.com            次数: 150
 piweba3y.prodigy.com            次数: 137
 n1121796.ksc.nasa.gov           次数: 136
 www-b2.proxy.aol.com            次数: 134
 www-b3.proxy.aol.com            次数: 130
 www-d1.proxy.aol.com            次数: 128
 piweba1y.prodigy.com            次数: 124
 www-d3.proxy.aol.com            次数: 123
 163.205.11.31                   次数: 123
 www-b5.proxy.aol.com            次数: 116
 www-d4.proxy.aol.com            次数: 114
 mpngate1.ny.us.ibm.net          次数: 114
 www-a1.proxy.aol.com            次数: 113
 163.205.23.76                   次数: 113
 www-d2.proxy.aol.com            次数: 112
 www-c3.proxy.aol.com            次数: 111
 www-c2.proxy.aol.com            次数: 111
 n1376232.ksc.nasa.gov           次数: 111
 128.159.144.83                  次数: 111
 www-c4.proxy.aol.com            次数: 110
 www-c5.proxy.aol.com            次数: 108
 www-b4.proxy.aol.com            次数: 108
 n1131455.ksc.nasa.gov           次数: 107
 www-c1.proxy.aol.com            次数: 106
 www-a2.proxy.aol.com            次数: 106
 n1040681.ksc.nasa.gov           次数: 106
 128.217.62.2                    次数: 106
 n1123413.ksc.nasa.gov           次数: 104
 163.205.23.93                   次数: 104
 163.205.16.75                   次数: 104
 www-c6.proxy.aol.com            次数: 102
 n1123543.ksc.nasa.gov           次数: 101
 163.205.121.3                   次数: 100
 128.159.132.56                  次数: 92
 n1031701.ksc.nasa.gov           次数: 91
 n1144796.ksc.nasa.gov           次数: 90
 163.206.104.34                  次数: 90
 derec                           次数: 89
 intgate.raleigh.ibm.com         次数: 88
 webgate1.mot.com                次数: 87
 163.205.154.11                  次数: 87
 n1142702.ksc.nasa.gov           次数: 86
 n1031729.ksc.nasa.gov           次数: 84
 163.205.16.100                  次数: 84
 poppy.hensa.ac.uk               次数: 83
 163.205.1.19                    次数: 83
 n1123724.ksc.nasa.gov           次数: 79
 n1121793.ksc.nasa.gov           次数: 79
 n1123209.ksc.nasa.gov           次数: 78
 163.205.23.72                   次数: 78
 n167331.ksc.nasa.gov            次数: 76
 n1031727.ksc.nasa.gov           次数: 75
 128.217.61.15                   次数: 73
 n1144636.ksc.nasa.gov           次数: 71
 n1032026.ksc.nasa.gov           次数: 71
 n1031857.ksc.nasa.gov           次数: 70
 163.206.140.4                   次数: 70
 163.205.23.71                   次数: 70
 128.159.135.73                  次数: 70
 n1031627.ksc.nasa.gov           次数: 69
 n1028722.ksc.nasa.gov           次数: 69
 n1028288.ksc.nasa.gov           次数: 69
 163.205.12.100                  次数: 68
 128.159.146.40                  次数: 67
 128.159.122.14                  次数: 67
 pl01265.ksc.nasa.gov            次数: 66
 n167440.ksc.nasa.gov            次数: 65
 192.77.40.4                     次数: 65
 n868370.ksc.nasa.gov            次数: 64
 n1032336.ksc.nasa.gov           次数: 64
 163.205.16.90                   次数: 64
 128.217.61.98                   次数: 64
 128.159.63.159                  次数: 64
 128.159.135.38                  次数: 63
 n1123732.ksc.nasa.gov           次数: 60
 163.205.23.44                   次数: 60
 redfish.ksc.nasa.gov            次数: 59
 bocagate.bocaraton.ibm.com      次数: 58
 163.205.2.180                   次数: 58
 128.159.168.162                 次数: 58
 128.159.121.41                  次数: 58
 n1377014.ksc.nasa.gov           次数: 57
 n1135966.ksc.nasa.gov           次数: 56
 192.112.22.119                  次数: 56
 163.205.150.22                  次数: 56
 n1121869.ksc.nasa.gov           次数: 55
 n1121985.ksc.nasa.gov           次数: 54
 n1028244.ksc.nasa.gov           次数: 54
 163.205.3.38                    次数: 54
 163.205.2.35                    次数: 54
 163.205.166.15                  次数: 54
 vagrant.vf.mmc.com              次数: 53
 palona1.cns.hp.com              次数: 53
```

## 心得总结 ##
- Shell语言与其他编程语言如C, Java, Python等一样也有变量/函数/运算符/if语句/循环控制等，通过此次实验对shell脚本的编程有了一个大概的了解，三个任务告诉了我们shell脚本如何运行以及如何运用它去完成工作，对此有了不错的收获。

## 参考资料 ##
- [shell脚本编程总结](https://www.iteye.com/blog/aoyouzi-2313256)
- [shell脚本基础概况](https://blog.csdn.net/liouyi250/article/details/82951973)