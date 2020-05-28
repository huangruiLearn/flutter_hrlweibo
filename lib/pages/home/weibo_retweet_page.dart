import "package:dio/dio.dart";
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/model/WeiboAtUser.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/extend_textfield/my_special_text_span_builder.dart';
import 'package:flutter_hrlweibo/widget/messgae/emoji_widget.dart';
import 'package:flutter_hrlweibo/widget/weibo/match_text.dart';
import 'package:flutter_hrlweibo/widget/weibo/parsed_text.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

//转发界面
class RetWeetPage extends StatefulWidget {
  final WeiBoModel mModel;

  RetWeetPage({Key key, this.mModel}) : super(key: key);

  @override
  _RetWeetPageState createState() => _RetWeetPageState();
}

class _RetWeetPageState extends State<RetWeetPage> {
  TextEditingController mEtController = new TextEditingController();
  String mWeiBoSubmitText = "";
  bool mEmojiLayoutShow = false;
  bool mBottomLayoutShow = false;
  FocusNode mfocusNode = FocusNode();
  double mSoftKeyHeight = SpUtil.getDouble(Constant.SP_KEYBOARD_HEGIHT, 200);
  KeyboardVisibilityNotification mKeyboardVisibility =
      new KeyboardVisibilityNotification();
  MySpecialTextSpanBuilder mSpecialTextSpanBuilder = MySpecialTextSpanBuilder();
  final GlobalKey mGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _retweettitle(),
              _retweettosay(),
              _retweetcontent(),
              new Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                child: buildBottom(),
              ))
            ],
          ),
        ),
        onWillPop: () {
          print("点击返回键");
          if (mBottomLayoutShow) {
            setState(() {
              mBottomLayoutShow = false;
              mEmojiLayoutShow = false;
            });
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mKeyboardVisibility.addNewListener(
      onChange: (bool visible) {
        final keyHeight = MediaQuery.of(context).viewInsets.bottom;
        if (keyHeight != 0) {
          SpUtil.putDouble(Constant.SP_KEYBOARD_HEGIHT, keyHeight);
          mSoftKeyHeight = keyHeight;
        }
        if (visible) {
          mEmojiLayoutShow = false;
          if (!mBottomLayoutShow) {
            setState(() {
              mBottomLayoutShow = true;
            });
          }
        } else {
          if (!mEmojiLayoutShow) {
            setState(() {
              mBottomLayoutShow = false;
            });
          }
        }
      },
    );
  }

  Widget _retweettitle() {
    return Container(
      color: Color(0xFFFAFAFA),
      height: 55.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('取消',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                children: <Widget>[
                  Text('转发微博',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text(UserUtil.getUserInfo().nick,
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  if (mEtController.text.isEmpty) {
                    ToastUtil.show("内容不能为空!");
                    return;
                  }
                  FormData formData = FormData.fromMap({
                    "userId": UserUtil.getUserInfo().id,
                    "zfContent": mEtController.text,
                    "zfWeiBoId": widget.mModel.weiboId
                  });
                  DioManager.getInstance()
                      .post(ServiceUrl.forwardWeiBo, formData, (data) {
                    ToastUtil.show('提交成功!');
                    setState(() {
                      mEtController.clear();
                    });
                  }, (error) {
                    ToastUtil.show(error);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15.0),
                  padding: EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color(0xFFFF8200)),
                  child: Text('发送',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              )),
        ],
      ),
    );
  }

  Widget _retweettosay() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10, bottom: 20),
      constraints: new BoxConstraints(minHeight: 50.0),
      child: ExtendedTextField(
        specialTextSpanBuilder: mSpecialTextSpanBuilder,
        controller: mEtController,
        maxLines: 5,
        focusNode: mfocusNode,
        style: TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration.collapsed(
            hintText: "说说分享心得",
            hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
      ),
    );
  }

  Widget _retweetcontent() {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Color(0xFFF8F8F8),
          child: Row(
            children: <Widget>[
              new Container(
                child: Image.network(
                    widget.mModel.picurl.length == 0
                        ? widget.mModel.userInfo.headurl
                        : widget.mModel.picurl[0],
                    fit: BoxFit.fill,
                    width: 90,
                    height: 90),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '@' + widget.mModel.userInfo.nick,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    new Container(
                        margin: EdgeInsets.only(top: 5.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child:
                            /* Text('' + widget.mModel.content,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    )*/
                            ParsedText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: widget.mModel.content,
                          style: TextStyle(
                              height: 1.5, fontSize: 13, color: Colors.grey),
                          parse: <MatchText>[
                            MatchText(
                                pattern: r"\[(@[^:]+):([^\]]+)\]",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  RegExp customRegExp = RegExp(pattern);
                                  Match match = customRegExp.firstMatch(str);
                                  map['display'] = match.group(1);
                                  map['value'] = match.group(2);
                                  print("正则:" +
                                      match.group(1) +
                                      "---" +
                                      match.group(2));
                                  return map;
                                },
                                onTap: (url) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("$url clicked."),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                            MatchText(
                                pattern: '#.*?#',
                                //       pattern: r"\B#+([\w]+)\B#",
                                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  //  RegExp customRegExp = RegExp(pattern);
                                  //#fskljflsk:12#
                                  // Match match = customRegExp.firstMatch(str);

                                  /*  String idStr =str.substring(str.indexOf(";"),
                     (str.lastIndexOf("#")-1));*/

                                  String idStr = str.substring(
                                      str.indexOf(":") + 1,
                                      str.lastIndexOf("#"));
                                  String showStr = str
                                      .substring(str.indexOf("#"),
                                          str.lastIndexOf("#") + 1)
                                      .replaceAll(":" + idStr, "");
                                  map['display'] = showStr;
                                  map['value'] = idStr;
                                  //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                                  return map;
                                },
                                onTap: (url) async {
                                  print("点击的id:" + url);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("点击的id:" + url),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                            MatchText(
                              pattern: '(\\[/).*?(\\])',
                              //       pattern: r"\B#+([\w]+)\B#",
                              //   pattern: r"\[(#[^:]+):([^#]+)\]",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              renderText: ({String str, String pattern}) {
                                Map<String, String> map = Map<String, String>();
                                print("表情的正则:" + str);
                                String mEmoji2 = "";
                                try {
                                  String mEmoji = str.replaceAll(
                                      RegExp('(\\[/)|(\\])'), "");
                                  int mEmojiNew = int.parse(mEmoji);
                                  mEmoji2 = String.fromCharCode(mEmojiNew);
                                } on Exception catch (_) {
                                  mEmoji2 = str;
                                }
                                map['display'] = mEmoji2;

                                return map;
                              },
                            ),
                            MatchText(
                                pattern: '全文',
                                //       pattern: r"\B#+([\w]+)\B#",
                                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                                style: TextStyle(
                                  color: Color(0xff5B778D),
                                  fontSize: 15,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  map['display'] = '全文';
                                  map['value'] = '全文';
                                  return map;
                                },
                                onTap: (url) async {
                                  print("点击的id:" + url);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("点击的id:" + url),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  //输入框底部布局
  Widget buildBottom() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            color: Color(0xffF9F9F9),
            padding: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10),
            child: Row(
              /* mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,*/
              children: <Widget>[
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_image.webp',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {},
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_mention.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      Routes.navigateTo(
                              context, '${Routes.weiboPublishAtUsrPage}')
                          .then((result) {
                        WeiboAtUser mAtUser = result as WeiboAtUser;
                        if (mAtUser != null) {
                          mWeiBoSubmitText = mWeiBoSubmitText +
                              "[@" +
                              mAtUser.nick +
                              ":" +
                              mAtUser.id +
                              "]";

                          mEtController.text = mEtController.text +
                              "[@" +
                              mAtUser.nick +
                              ":" +
                              mAtUser.id +
                              "]";
                          //   _mEtController.buildTextSpan()
                          // _mEtController.text=_mEtController.text+"#aaaa#" ;
                        }
                      });
                    },
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_topic.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      Routes.navigateTo(
                              context, '${Routes.weiboPublishTopicPage}')
                          .then((result) {
                        WeiBoTopic mTopic = result;

                        if (mTopic != null) {
                          // _mEtController.text = _mEtController.text +  "#" +   mTopic.topicdesc +  "#"+"";

                          mEtController.text = mEtController.text +
                              "#" +
                              mTopic.topicdesc +
                              ":" +
                              mTopic.topicid +
                              "#";

                          //   _mEtController.buildTextSpan()
                          // _mEtController.text=_mEtController.text+"#aaaa#" ;
                        }
                      });
                    },
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_gif.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {},
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(
                    child: mEmojiLayoutShow
                        ? Image.asset(
                            Constant.ASSETS_IMG + 'ic_keyboard2.webp',
                            width: 25.0,
                            height: 25.0,
                          )
                        : Image.asset(
                            Constant.ASSETS_IMG + "icon_emotion.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                    onTap: () {
                      _getWH();
                      setState(() {
                        if (mEmojiLayoutShow) {
                          mBottomLayoutShow = true;
                          mEmojiLayoutShow = false;
                          showSoftKey();
                        } else {
                          mBottomLayoutShow = true;
                          mEmojiLayoutShow = true;
                          hideSoftKey();
                        }
                      });

                      _getWH();
                    },
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_add.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            )),
        Visibility(
          visible: mBottomLayoutShow,
          child: Container(
            key: mGlobalKey,
            child: Visibility(
              visible: mEmojiLayoutShow,
              child: EmojiWidget(onEmojiClockBack: (value) {
                if (value == 0) {
                  mEtController.clear();
                } else {
                  mEtController.text =
                      mEtController.text + "[/" + value.toString() + "]";
                }
              }),
            ),
            height: mSoftKeyHeight,
          ),
        ),
      ],
    );
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(mfocusNode);
  }

  void hideSoftKey() {
    mfocusNode.unfocus();
  }

  void _getWH() {
    if (mGlobalKey == null) return;
    if (mGlobalKey.currentContext == null) return;
    if (mGlobalKey.currentContext.size == null) return;
    final containerWidth = mGlobalKey.currentContext.size.width;
    final containerHeight = mGlobalKey.currentContext.size.height;
    print('Container widht is $containerWidth, height is $containerHeight');
  }
}
