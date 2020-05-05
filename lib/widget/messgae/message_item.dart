import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/MessageNormal.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/messgae/bubble.dart';
import 'voice_animation.dart';

class ChatMessageItem extends StatefulWidget {
  HrlMessage mMessage;
  ValueSetter<String> onAudioTap;

  ChatMessageItem({Key key, this.mMessage, this.onAudioTap}) : super(key: key);

  @override
  ChatMessageItemState createState() => ChatMessageItemState();
}

class ChatMessageItemState extends State<ChatMessageItem> {
  List<String> mAudioAssetRightList = new List();
  List<String> mAudioAssetLeftList = new List();

  bool mIsPlayint = false;
  String mUUid = "";

  methodInChild(bool isPlay, String uid) {
    mIsPlayint = isPlay;
    mUUid = uid;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    mAudioAssetRightList.add(Constant.ASSETS_IMG + "audio_animation_list_right_1.png");
    mAudioAssetRightList.add(Constant.ASSETS_IMG + "audio_animation_list_right_2.png");
    mAudioAssetRightList.add(Constant.ASSETS_IMG + "audio_animation_list_right_3.png");

     mAudioAssetLeftList.add(Constant.ASSETS_IMG + "audio_animation_list_left_1.png");
    mAudioAssetLeftList.add(Constant.ASSETS_IMG + "audio_animation_list_left_2.png");
    mAudioAssetLeftList.add(Constant.ASSETS_IMG + "audio_animation_list_right_3.png");


  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: widget.mMessage.isSend
          ? getSentMessageLayout()
          : getReceivedMessageLayout(),
    );
  }

  Widget getmImageLayout(HrlImageMessage mMessgae) {
    Widget child;
    if (mMessgae.thumbPath != null && (!mMessgae.thumbPath.isEmpty)) {
      child =
          Image.file(File('${(widget.mMessage as HrlImageMessage).thumbPath}'));
    } else {
      child = Image.network(
        '${(widget.mMessage as HrlImageMessage).thumbUrl}',
        fit: BoxFit.fill,
      );
    }
    return child;
  }

  Widget getItemContent(HrlMessage mMessage) {
    switch (mMessage.msgType) {
      case HrlMessageType.image:
        return Container(
          /* width:mImgWidth,
          height: mImgHeight,*/
          constraints: BoxConstraints(
            maxWidth: 400,
            maxHeight: 150,
          ),
          child: getmImageLayout(widget.mMessage as HrlImageMessage),
        );
        break;
      case HrlMessageType.text:
        return Text(
          '${(widget.mMessage as HrlTextMessage).text}',
          softWrap: true,
          style: TextStyle(fontSize: 14.0, color: Colors.black),
        );
        break;
      case HrlMessageType.voice:
        bool isStop = true;
         if (mUUid == widget.mMessage.uuid) {
          if (!mIsPlayint) {
            isStop = true;
          } else {
            isStop = false;
          }
        } else {
          isStop = true;
        }

        //    print("是否停止:"+isStop.toString()+"widget.mUUid=:"+widget.mUUid );
        return GestureDetector(
          onTap: () {
            //  int result = await mAudioPlayer.play((widget.mMessage as HrlVoiceMessage).path, isLocal: true);
            widget.onAudioTap((widget.mMessage as HrlVoiceMessage).path);
          },
          child: VoiceAnimationImage(
            mMessage.isSend?mAudioAssetRightList:mAudioAssetLeftList,
            width: 100,
            height: 30,
            isStop: isStop,
            //&&(widget.mUUid==widget.mMessage.uuid)
          ),
        );
        break;
    }
  }

  /*playLocal() async {
    int result = await mAudioPlayer.play((widget.mMessage as HrlVoiceMessage).path, isLocal: true);
    //  int result = await mAudioPlayer.play("https://github.com/luanpotter/audioplayers");
    print("播放的路径："+"${(widget.mMessage as HrlVoiceMessage).path}"+"播放的结果:"+"${result}");
    mAudioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
         isPalying = false;
       });
    });
    setState(() {
      isPalying = true;
    });


  }*/

  BubbleStyle getItemBundleStyle(HrlMessage mMessage) {
    BubbleStyle styleSendText = BubbleStyle(
      nip: BubbleNip.rightText,
      color: Color(0xffCCEAFF),
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(left: 50.0),
      padding: BubbleEdges.only(top: 8, bottom: 10, left: 15, right: 10),
    );
    BubbleStyle styleSendImg = BubbleStyle(
      nip: BubbleNip.noRight,
      color: Colors.transparent,
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(left: 50.0),
    );

    BubbleStyle styleReceiveText = BubbleStyle(
      nip: BubbleNip.leftText,
      color: Colors.white,
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(right: 50.0),
      padding: BubbleEdges.only(top: 8, bottom: 10, left: 10, right: 15),
    );

    BubbleStyle styleReceiveImg = BubbleStyle(
      nip: BubbleNip.noLeft,
      color: Colors.transparent,
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(left: 50.0),
    );

    switch (mMessage.msgType) {
      case HrlMessageType.image:
        return widget.mMessage.isSend ? styleSendImg : styleReceiveImg;
        break;
      case HrlMessageType.text:
        return widget.mMessage.isSend ? styleSendText : styleReceiveText;
        break;
      case HrlMessageType.voice:
        return widget.mMessage.isSend ? styleSendText : styleReceiveText;
        break;
    }
  }

  Widget getSentMessageLayout() {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: widget.mMessage.msgType==HrlMessageType.voice,
              child:  Container(
                child:  widget.mMessage.msgType==HrlMessageType.voice?Text((widget.mMessage as HrlVoiceMessage).duration.toString()+"'",style: TextStyle(fontSize: 14,color: Colors.black),):new Container(),
              ),
            ),


            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Bubble(
                style: getItemBundleStyle(widget.mMessage),
                // child:    Text(  '${(widget.mMessage as HrlTextMessage).text  }',  softWrap: true,style: TextStyle(fontSize: 14.0,color: Colors.black),),
                child: getItemContent(widget.mMessage),
              ),
              margin: EdgeInsets.only(
                bottom: 5.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://c-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.thumb.700_0.jpeg"),
                radius: 16.0,
              ),
            ),
          ],
        ));
  }

  Widget getReceivedMessageLayout() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          //  mainAxisAlignment:MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://c-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.thumb.700_0.jpeg"),
                radius: 16.0,
              ),
            ),
            Container(
               constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child:  Bubble(
                  style: getItemBundleStyle(widget.mMessage),
                  child: getItemContent(widget.mMessage),
                ),

              margin: EdgeInsets.only(
                bottom: 5.0,
              ),
            ),
          ],
        ));
  }
}


