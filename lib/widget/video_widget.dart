import 'package:flutter/material.dart';
 import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:video_player/video_player.dart';




class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl; //预览图片的地址
   final bool showProgressText; //是否显示进度文本
  VideoWidget(this.url,
      {Key key,
      this.previewImgUrl,
       this.showProgressText = true})
      : super(key: key);

  _VideoWidgetState state;

  @override
  State<StatefulWidget> createState() {
    state = _VideoWidgetState();
    return state;
  }

  updateUrl(String url) {
    state.setUrl(url);
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  VoidCallback listener;
  bool _showSeekBar = true;

  _VideoWidgetState() {
    listener = () {
      if (mounted) {
        setState(() {});
      }

    };
  }

  @override
  void initState() {
    super.initState();
    print('播放${widget.url}');
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        if(mounted){
          //初始化完成后，更新状态
          setState(() {});
          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(Duration(seconds: 0));
            setState(() {});
          }
        }
      });
    _controller.setLooping(true);
    _controller.addListener(listener);
  }



  @override
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
  }



  @override
  Widget build(BuildContext context) {

    final List<Widget> children = <Widget>[
      // getPreviewImg(),
       GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          setState(() {
            _showSeekBar = !_showSeekBar;
          });
        },
      ),
      getPlayController(),
    ];

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.passthrough,
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //释放播放器资源
  }

  Widget getPreviewImg() {
    /*return widget.previewImgUrl.isNotEmpty
        ?   Image.network( widget.previewImgUrl):null;*/
    return Image.network("https://ww4.sinaimg.cn/bmiddle/c5f4f0ecgy1g2pix22tf0j20c80hq1du.jpg");

  }

  getMinuteSeconds(var inSeconds) {
    if (inSeconds == null || inSeconds <= 0) {
      return '00:00';
    }
    var tmp = inSeconds ~/ Duration.secondsPerMinute;
    var minute;
    if (tmp < 10) {
      minute = '0$tmp';
    } else {
      minute = '$tmp';
    }

    var tmp1 = inSeconds % Duration.secondsPerMinute;
    var seconds;
    if (tmp1 < 10) {
      seconds = '0$tmp1';
    } else {
      seconds = '$tmp1';
    }
    return '$minute:$seconds';
  }

  getDurationText() {
    var txt;
    if (_controller.value.position == null ||
        _controller.value.duration == null) {
      txt = '00:00';
    } else {
      // txt =  '${getMinuteSeconds(_controller.value.position.inSeconds)}/${getMinuteSeconds(_controller.value.duration.inSeconds)}';
      txt =  '${getMinuteSeconds(_controller.value.duration.inSeconds-_controller.value.position.inSeconds)}';
    }
    return Container(
      margin: EdgeInsets.only(bottom: 8,right: 8),
       child: Text(
          '$txt',
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        )
    );
  }

  getPlayController() {
    return Offstage(
      offstage: !_showSeekBar,
      child: Stack(
        children: <Widget>[
          Align(
            child: IconButton(
                iconSize: 45.0,
                icon: Image.asset(Constant.ASSETS_IMG +
                    (_controller.value.isPlaying
                        ? 'ic_pause.png'
                        : 'ic_playing.png')),
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                }),
            alignment: Alignment.center,
          ),
          getProgressContent(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
                child: _controller.value.isBuffering
                    ? const CircularProgressIndicator()
                    : null),
          )
        ],
      ),
    );
  }

  ///更新播放的URL
  void setUrl(String url) {
    if(mounted){
      print('updateUrl');
      if (_controller != null) {
        _controller.removeListener(listener);
        _controller.pause();
      }
      _controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          //初始化完成后，更新状态
          setState(() {});
          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(Duration(seconds: 0));
            setState(() {});
          }
        });
      _controller.addListener(listener);
    }
  }

  Widget getProgressContent() {
    return ( widget.showProgressText
        ? Align(
            alignment: Alignment.bottomRight,
            child:   Offstage(

              child: getDurationText(),
              offstage: !widget.showProgressText,
            ),
          )
        : Container());
  }
}


