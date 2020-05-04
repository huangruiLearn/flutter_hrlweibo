import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:permission_handler/permission_handler.dart';

import 'emoji_widget.dart';
import 'extra_widget.dart';
import 'image_button.dart';
import 'record_button.dart';

String _initType = "text";

typedef void OnSend(String text);
typedef void OnImageSelect(File mFile);
typedef void OnAudioCallBack(File mAudioFile, int duration);

class ChatBottomInputWidget extends StatefulWidget {
  final OnSend onSendCallBack;

  final OnImageSelect onImageSelectCallBack;

  final OnAudioCallBack onAudioCallBack;

  final Stream shouldTriggerChange;

  const ChatBottomInputWidget({
    Key key,
    @required this.shouldTriggerChange,
    this.onSendCallBack,
    this.onImageSelectCallBack,
    this.onAudioCallBack,
  }) : super(key: key);

  @override
  _ChatBottomInputWidgetState createState() => _ChatBottomInputWidgetState();
}

class _ChatBottomInputWidgetState extends State<ChatBottomInputWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String mCurrentType = _initType;

  FocusNode focusNode = FocusNode();

  AnimationController _bottomHeightController;

  TextEditingController mEditController = TextEditingController();

  StreamController<String> inputContentStreamController =
      StreamController.broadcast();

  Stream<String> get inputContentStream => inputContentStreamController.stream;

  double _softKeyHeight = SpUtil.getDouble(Constant.SP_KEYBOARD_HEGIHT, 200);

  final GlobalKey globalKey = GlobalKey();

  bool mBottomLayoutShow = false;

  bool mAddLayoutShow = false;

  bool mEmojiLayoutShow = false;

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();

  StreamSubscription streamSubscription;

  void _getWH() {
    if (globalKey == null) return;
    if (globalKey.currentContext == null) return;
    if (globalKey.currentContext.size == null) return;
  }

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      _softKeyHeight = keyHeight;
      print("键盘高度是:" + _softKeyHeight.toString());
    } else {}
  }

  @override
  didUpdateWidget(ChatBottomInputWidget old) {
    super.didUpdateWidget(old);
    if (widget.shouldTriggerChange != old.shouldTriggerChange) {
      streamSubscription.cancel();
      streamSubscription =
          widget.shouldTriggerChange.listen((_) => hideBottomLayout());
    }
  }

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  void hideBottomLayout() {
    setState(() {
      this.mCurrentType = "text2";
      mBottomLayoutShow = false;
      mAddLayoutShow = false;
      mEmojiLayoutShow = false;
    });
  }

  @override
  void initState() {
    super.initState();
    streamSubscription =
        widget.shouldTriggerChange.listen((_) => hideBottomLayout());
     WidgetsBinding.instance.addObserver(this);
    //   focusNode.addListener(onFocus);
//    widget.controller.addListener(_onInputChange);
    mEditController.addListener(() {
      inputContentStreamController.add(mEditController.text);
    });
    _bottomHeightController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        print("mBottomLayoutShow:" +
            mBottomLayoutShow.toString() +
            "mEmojiLayoutShow:" +
            mEmojiLayoutShow.toString() +
            "mAddLayoutShow:" +
            mAddLayoutShow.toString());
        if (visible) {
          mBottomLayoutShow = true;

          if (mEmojiLayoutShow) {
            this.mCurrentType = "text2";
            // mEmojiLayoutShow = false;
            setState(() {});
          } else {
            setState(() {});
          }
        } else {
          if (mBottomLayoutShow) {
            if (mAddLayoutShow) {
            } else {
              if (!mEmojiLayoutShow) {
                mBottomLayoutShow = false;
                setState(() {});
              }
            }
          } else {}
        }
      },
    );
  }

  Future requestPermission() async {
    // 申请权限

    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(
            [PermissionGroup.storage, PermissionGroup.microphone]);

    // 申请结果

    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
      //  Fluttertoast.showToast(msg: "权限申请通过");

    } else {
      //Fluttertoast.showToast(msg: "权限申请被拒绝");

    }
  }

  @override
  Widget build(BuildContext context) {
    requestPermission();

    return Container(
      // height: keyHeight+60,
      color: Color(0xffF8F8F8),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildLeftButton(),
              Expanded(child: buildInputButton()),
              buildEmojiButton(),
              buildRightButton(),
            ],
          ),
          _buildBottomContainer(child: _buildBottomItems()),
        ],
      ),
    );
  }

  Widget buildLeftButton() {
    return mCurrentType == "voice" ? mKeyBoardButton() : mRecordButton();
  }

  Widget mRecordButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "voice";
        hideSoftKey();
        mBottomLayoutShow = false;
        mEmojiLayoutShow = false;
        setState(() {});
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_audio.png"),
    );
  }

  Widget mKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "text";
        showSoftKey();
        setState(() {});
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_keyboard.png"),
    );
  }

  Widget mVoiceButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RecordButton(onAudioCallBack: (value, duration) {
        widget.onAudioCallBack?.call(value, duration);
      }),
    );
  }

  Widget buildInputButton() {
    final voiceButton = mVoiceButton(context);
    final inputButton = Container(
      // height: 40,
      constraints: BoxConstraints(
        maxHeight: 80.0,
        minHeight: 40.0,
      ),

      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        //minLines: 1,
        style: TextStyle(fontSize: 16),
        focusNode: focusNode,
        controller: mEditController,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Offstage(
            child: voiceButton,
            offstage: mCurrentType != "voice",
          ),
          Offstage(
            child: inputButton,
            offstage: mCurrentType == "voice",
          ),
        ],
      ),
    );
  }

  Widget buildEmojiButton() {
    return mCurrentType != "emoji" ? mEmojiButton() : mEmojiKeyBoardButton();
  }

  Widget mEmojiButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "emoji";
        _getWH();
        setState(() {
          mBottomLayoutShow = true;
          mEmojiLayoutShow = true;
        });
        hideSoftKey();

        _getWH();
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_emoji.png"),
    );
  }

  Widget mEmojiKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        _getWH();
        this.mCurrentType = "text2";
        mBottomLayoutShow = true;
        mEmojiLayoutShow = false;
        setState(() {});
        showSoftKey();
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_keyboard.png"),
    );
  }

  Widget buildRightButton() {
    return StreamBuilder<String>(
      stream: this.inputContentStream,
      builder: (context, snapshot) {
        final sendButton = buildSend();
        final extraButton = ImageButton(
            image: new AssetImage(Constant.ASSETS_IMG + "ic_add.png"),
            onPressed: () {
              this.mCurrentType = "extra";
              if (mBottomLayoutShow) {
                if (mAddLayoutShow) {
                  showSoftKey();
                  mBottomLayoutShow = true;
                  mAddLayoutShow = false;
                  setState(() {});
                } else {
                  mBottomLayoutShow = true;
                  mAddLayoutShow = true;
                  hideSoftKey();
                  setState(() {});
                }
              } else {
                if (focusNode.hasFocus) {
                  hideSoftKey();
                  Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() {
                      mBottomLayoutShow = true;
                      mAddLayoutShow = true;
                    });
                  });
                } else {
                  mBottomLayoutShow = true;
                  mAddLayoutShow = true;
                  setState(() {});
                }
              }
            });
        CrossFadeState crossFadeState =
            checkShowSendButton(mEditController.text)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 0),
          crossFadeState: crossFadeState,
          firstChild: sendButton,
          secondChild: extraButton,
        );
      },
    );
  }

  Widget buildSend() {
    return Container(
      width: 60,
      height: 30,
      child: new RaisedButton(
        padding: EdgeInsets.all(0),
        color: Color(0xffFF8200),
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        disabledColor: Color(0xffFFD8AF),
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          widget.onSendCallBack?.call(mEditController.text.trim());
          mEditController.clear();
        },
        child: new Text(
          "发送",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  bool checkShowSendButton(String text) {
    if (mCurrentType == "voice") {
      return false;
    }
    if (text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }

  void changeBottomHeight(final double height) {
    if (height > 0) {
      _bottomHeightController.animateTo(1);
    } else {
      _bottomHeightController.animateBack(0);
    }
  }

  Widget _buildBottomContainer({Widget child}) {
    return Visibility(
      visible: mBottomLayoutShow,
      child: Container(
        key: globalKey,
        child: child,
        height: _softKeyHeight,
      ),
    );
  }

  Widget _buildBottomItems() {
    if (this.mCurrentType == "extra") {
      return Visibility(
          visible: mAddLayoutShow,
          child: new DefaultExtraWidget(onImageSelectBack: (value) {
            widget.onImageSelectCallBack?.call(value);
          }));
    } else if (mCurrentType == "emoji") {
      return Visibility(
        visible: mEmojiLayoutShow,
        child: EmojiWidget(onEmojiClockBack: (value) {
           if (0 == value) {
            mEditController.clear();
          } else {
            mEditController.text =
                mEditController.text + String.fromCharCode(value);
          }
        }),
      );
    } else {
      return Container();
    }
  }
}

class ChangeChatTypeNotification extends Notification {
  final String type;

  ChangeChatTypeNotification(this.type);
}
