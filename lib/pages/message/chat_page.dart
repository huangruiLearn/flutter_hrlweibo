import 'dart:io';
import 'dart:ui' as ui show Codec, FrameInfo, Image;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/MessageNormal.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/messgae/chat_bottom.dart';
import 'package:flutter_hrlweibo/widget/messgae/expanded_viewport.dart';
import 'package:uuid/uuid.dart';

export 'package:flutter_hrlweibo/widget/messgae/message_item.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController listScrollController = new ScrollController();
  List<HrlMessage> mlistMessage = new List();

  //https://stackoverflow.com/questions/50733840/trigger-a-function-from-a-widget-to-a-state-object/50739019#50739019
  final changeNotifier = new StreamController.broadcast();
  AudioPlayer mAudioPlayer = AudioPlayer();
  bool isPalyingAudio = false;
  String mPalyingPosition = "";
  bool isShowLoading = false;
  bool isBottomLayoutShowing = false;

  @override
  void dispose() {
    changeNotifier.close();
    super.dispose();
  }

  getHistroryMessage() {
    print("获取历史消息");
    List<HrlMessage> mHistroyListMessage = new List();
    final HrlTextMessage mMessgae = new HrlTextMessage();
    mMessgae.text = "测试消息";
    mMessgae.msgType = HrlMessageType.text;
    mMessgae.isSend = false;
    mHistroyListMessage.add(mMessgae);
    mHistroyListMessage.add(mMessgae);
    final HrlImageMessage mMessgaeImg = new HrlImageMessage();
    mMessgaeImg.msgType = HrlMessageType.image;
    mMessgaeImg.isSend = false;
    mMessgaeImg.thumbUrl =
        "https://c-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.thumb.700_0.jpeg";
    mHistroyListMessage.add(mMessgaeImg);
    mlistMessage.addAll(mHistroyListMessage);
  }

  //文本消息
  sendTextMsg(String hello) {
    final HrlTextMessage mMessgae = new HrlTextMessage();
    mMessgae.text = hello;
    mMessgae.msgType = HrlMessageType.text;
    mMessgae.isSend = true;
    mlistMessage.add(mMessgae);
  }

  @override
  void initState() {
    super.initState();
    getHistroryMessage();
    listScrollController.addListener(() {
      if (listScrollController.position.pixels ==
          listScrollController.position.maxScrollExtent) {
        isShowLoading = true;
        setState(() {});
        Future.delayed(Duration(seconds: 2), () {
          getHistroryMessage();
          isShowLoading = false;
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new WillPopScope(
      onWillPop: () {
        FocusScope.of(context).requestFocus(FocusNode());
        changeNotifier.sink.add(null);
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Color(0xffffffff),
              leading: IconButton(
                  iconSize: 30,
                  icon: Image.asset(
                    Constant.ASSETS_IMG + 'icon_back.png',
                    width: 23.0,
                    height: 23.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                '用户名',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              elevation: 0,
              centerTitle: true,
              actions: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: InkWell(
                      child: Center(
                        child: Text(
                          '设置',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      onTap: () {},
                    )),
              ],
            ),
            preferredSize: Size.fromHeight(50)),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffEDEDED),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              /*   Expanded(
          child:Column(
            children: <Widget>[*/

              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    //  点击顶部空白处触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                    changeNotifier.sink.add(null);
                  },
                  child: new ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Scrollable(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: listScrollController,
                      axisDirection: AxisDirection.up,
                      viewportBuilder: (context, offset) {
                        return ExpandedViewport(
                          offset: offset,
                          axisDirection: AxisDirection.up,
                          slivers: <Widget>[
                            SliverExpanded(),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (c, i) {
                                  final GlobalKey<ChatMessageItemState>
                                      mMessageItemKey = GlobalKey();
                                  mMessageItemKey.currentState
                                      ?.methodInChild(false, "");
                                  ChatMessageItem mChatItem = ChatMessageItem(
                                    key: mMessageItemKey,
                                    mMessage: mlistMessage[i],
                                    onAudioTap: (String str) {
                                      if (isPalyingAudio) {
                                        isPalyingAudio = false;
                                        mMessageItemKey.currentState
                                            ?.methodInChild(
                                                false, mPalyingPosition);
                                        mAudioPlayer
                                            .release(); // manually release when no longer needed
                                        mPalyingPosition = "";
                                        setState(() {});
                                      } else {
                                        Future<int> result = mAudioPlayer
                                            .play(str, isLocal: true);
                                        mAudioPlayer.onPlayerCompletion
                                            .listen((event) {
                                          mMessageItemKey.currentState
                                              ?.methodInChild(
                                                  false, mPalyingPosition);
                                          isPalyingAudio = false;
                                          mPalyingPosition = "";
                                        });

                                        isPalyingAudio = true;
                                        mPalyingPosition = mlistMessage[i].uuid;
                                        mMessageItemKey.currentState
                                            ?.methodInChild(
                                                true, mPalyingPosition);
                                      }
                                    },
                                  );
                                   return mChatItem;
                                },
                                childCount: mlistMessage.length,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: isShowLoading
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 50,
                                      child: Center(
                                        child: SizedBox(
                                          width: 25.0,
                                          height: 25.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  : new Container(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              /*  ],
          )*/
              //   ),

              ChatBottomInputWidget(
                  shouldTriggerChange: changeNotifier.stream,
                  onSendCallBack: (value) {
                    print("发送的文字:" + value);
                    final HrlTextMessage mMessgae = new HrlTextMessage();
                    mMessgae.uuid = Uuid().v4() + "";
                    mMessgae.text = value;
                    mMessgae.msgType = HrlMessageType.text;
                    mMessgae.isSend = true;
                    mMessgae.state = HrlMessageState.sending;
                    mlistMessage.insert(0, mMessgae);
                    listScrollController.animateTo(0.00,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeOut);
                    setState(() {});
                    Future.delayed(new Duration(seconds: 1), () {
                      mMessgae.state = HrlMessageState.send_succeed;
                      setState(() {});
                    });
                  },
                  onImageSelectCallBack: (value) {
                    File image = new File(
                        value.path); // Or any other way to get a File instance.
                    Future<ui.Image> decodedImage =
                        decodeImageFromList(image.readAsBytesSync());

                    decodedImage.then((result) {
                      print("图片的宽:" + "${result.width}");
                      print("图片的高:" + "${result.height}");
                    });
                    final HrlImageMessage mMessgae = new HrlImageMessage();
                    mMessgae.uuid = Uuid().v4() + "";
                    mMessgae.msgType = HrlMessageType.image;
                    mMessgae.isSend = true;
                    mMessgae.thumbPath = value.path;

                    mMessgae.state = HrlMessageState.sending;
                    mlistMessage.insert(0, mMessgae);
                    listScrollController.animateTo(0.00,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeOut);
                    setState(() {});
                    Future.delayed(new Duration(seconds: 1), () {
                      mMessgae.state = HrlMessageState.send_succeed;
                      setState(() {});
                    });
                  },
                  onAudioCallBack: (value, duration) {
                    final HrlVoiceMessage mMessgae = new HrlVoiceMessage();
                    mMessgae.uuid = Uuid().v4() + "";
                    mMessgae.msgType = HrlMessageType.voice;
                    mMessgae.isSend = true;
                    mMessgae.path = value.path;
                    mMessgae.duration = duration;
                    mMessgae.state = HrlMessageState.sending;
                    mlistMessage.insert(0, mMessgae);
                    listScrollController.animateTo(0.00,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeOut);
                    setState(() {});
                    Future.delayed(new Duration(seconds: 1), () {
                      mMessgae.state = HrlMessageState.send_succeed;
                      setState(() {});
                    });
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
