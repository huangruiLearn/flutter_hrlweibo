基于flutter的仿微博客户端

仿微博最新版本,还原微博80%的界面,总共涉及到了几十个界面和接口,用到了flutter中的大部分组件

分为首页 视频 发现 消息 我的五个模块 

登录的时候测试账号可以随便选一个

账号1:test1  密码:123

账号2:test2  密码:123

账号3:test3  密码:123

账号4:test4  密码:123

账号5:test5  密码:123

apk下载地址   https://www.pgyer.com/g95X   密码 123456

或者直接下载完项目找到apk目录下app-release.apk来安装
                   
每个模块对应的ui截图在下面 没有截全,可以下载apk或者直接运行项目看效果

感觉有帮助的话就给个start吧，我会持续更新完善这个项目！


 <br/>
 <br/>
 <br/>
 
 

**基础环境**

Flutter version 1.17.1

Dart version 2.8.2
<br/>
<br/>
 <br/>



 **首页模块:**
 
<img src="https://img-blog.csdnimg.cn/20200504224650925.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650951.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650950.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650906.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504224650902.jpg" width=200 height=450/>
<img src="https://img-blog.csdnimg.cn/20200504224650910.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650882.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650767.jpg" width=200 height=450/>
<img src="https://img-blog.csdnimg.cn/20200504224650682.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650815.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504224650652.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504224650825.jpg" width=200 height=450/>
<img src="https://img-blog.csdnimg.cn/20200504232551188.jpg" width=200 height=450/>

**视频模块:**

   <img src="https://img-blog.csdnimg.cn/20200504230046204.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/2020050423004610.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504230046175.jpg" width=200 height=450/>
  <img src="https://img-blog.csdnimg.cn/20200504230046183.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504230045948.jpg" width=200 height=450/>
 

 **发现模块:**
 
  <img src="https://img-blog.csdnimg.cn/20200504230628216.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504230628182.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504230628149.jpg" width=200 height=450/>
  <img src="https://img-blog.csdnimg.cn/20200504230628156.jpg" width=200 height=450/> 
   
 
**消息模块:**


  <img src="https://img-blog.csdnimg.cn/20200504231323925.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504231152810.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504231152837.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504231152808.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504231152876.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504231152827.jpg" width=200 height=450/>

  
**我的模块:**


  <img src="https://img-blog.csdnimg.cn/20200504232156561.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156552.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156594.jpg" width=200 height=450/><img src="https://img-blog.csdnimg.cn/20200504232156466.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156605.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156525.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156519.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156486.jpg" width=200 height=450/> <img src="https://img-blog.csdnimg.cn/20200504232156430.jpg" width=200 height=450/>



**主要使用到的一些三方库:**

|**第三方库**	   |**功能**  |**github地址**  |
|  ----  | ----  |----  |
| dio  | 网络请求 | https://github.com/flutterchina/dio|
| flutter_swiper  | 轮播图 | https://github.com/best-flutter/flutter_swiper |
| video_player  | 视频播发 |https://github.com/flutter/plugins/tree/master/packages/video_player|
| chewie  | 视频播放 | https://github:com/brianegan/chewie |
|  fluro  | 路由跳转 | https://github.com/theyakka/fluro |
| permission_handler  | 权限处理 | https://github.com/Baseflow/flutter-permission-handler|
| keyboard_visibility  | 键盘显示隐藏 |https://github.com/adee42/flutter_keyboard_visibility|
| audio_recorder  | 录音 | https://pub.flutter-io.cn/packages/audio_recorder |
|  audioplayers  | 声音播放 | https://github.com/luanpotter/audioplayers |
| extended_text_field  | @ #在textfield中的处理 | https://github.com/fluttercandies/extended_text_field |








