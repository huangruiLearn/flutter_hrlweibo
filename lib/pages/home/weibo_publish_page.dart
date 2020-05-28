import "package:dio/dio.dart";
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/model/WeiboAtUser.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/extend_textfield/my_special_text_span_builder.dart';
import 'package:flutter_hrlweibo/widget/messgae/emoji_widget.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:path/path.dart' as path;

//发布微博界面
class WeiBoPublishPage extends StatefulWidget {
  WeiBoPublishPage({Key key}) : super(key: key);

  @override
  _WeiBoPublishPageState createState() => _WeiBoPublishPageState();
}

class _WeiBoPublishPageState extends State<WeiBoPublishPage> {
  _WeiBoPublishPageState({Key key});

  TextEditingController _mEtController = new TextEditingController();
  String mWeiBoSubmitText = "";

  bool mEmojiLayoutShow = false;
  bool mBottomLayoutShow = false;

  FocusNode focusNode = FocusNode();
  final GlobalKey globalKey = GlobalKey();
  double _softKeyHeight = SpUtil.getDouble(Constant.SP_KEYBOARD_HEGIHT, 200);
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  List<File> mFileList = List();
  File mSelectedImageFile;
  List<MultipartFile> mSubmitFileList = List();

  MySpecialTextSpanBuilder _mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
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

    _mEtController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("Second text field: ${_mEtController.text}");

    /* setState(() {

    });*/
  }

  @override
  Widget build(BuildContext context) {
    print("键盘高度是:" + _softKeyHeight.toString());
    print('fileList的内容: $mFileList');
    if (mSelectedImageFile != null) {
      mFileList.add(mSelectedImageFile);
    }
    mSelectedImageFile = null;

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
            buildBottom(),
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
    ));
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ))),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                children: <Widget>[
                  Text('发微博',
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
                  if (_mEtController.text.isEmpty) {
                    ToastUtil.show("内容不能为空!");
                    return;
                  }
                  mSubmitFileList.clear();
                  for (int i = 0; i < mFileList.length; i++) {
                    mSubmitFileList.add(MultipartFile.fromFileSync(
                        mFileList.elementAt(i).path));
                  }
                  FormData formData = FormData.fromMap({
                    "userId": "1",
                    "content": _mEtController.text,
                    "files": mSubmitFileList
                  });
                  DioManager.getInstance()
                      .post(ServiceUrl.publishWeiBo, formData, (data) {
                    ToastUtil.show('提交成功!');
                    setState(() {
                      mFileList.clear();
                      mSubmitFileList.clear();
                      _mEtController.clear();
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
    int mGridCount;
    if (mFileList.length == 0) {
      mGridCount = 0;
    } else if (mFileList.length > 0 && mFileList.length < 9) {
      mGridCount = mFileList.length + 1;
    } else {
      mGridCount = mFileList.length;
    }

    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 10.0, left: 10.0, right: 10, bottom: 20),
            constraints: new BoxConstraints(minHeight: 50.0),
            child:
                /*TextSpanField(
             // onChanged: (value) => this.setState(() => mWeiBoSubmitText = value),

              controller: _mEtController,
              maxLines: 5,
              rangeStyles: getTextFieldStyle(),
              focusNode: focusNode,
              style: TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration.collapsed(
                  hintText: "分享新鲜事",
                  hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
            ),*/
                ExtendedTextField(
              //    textSelectionControls: _myExtendedMaterialTextSelectionControls,
              specialTextSpanBuilder: _mySpecialTextSpanBuilder,
              controller: _mEtController,
              maxLines: 5,
              focusNode: focusNode,
              style: TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration.collapsed(
                  hintText: "分享新鲜事",
                  hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 3,
            children: List.generate(mGridCount, (index) {
              // 这个方法体用于生成GridView中的一个item
              var content;
              if (index == mFileList.length) {
                // 添加图片按钮
                var addCell = Center(
                    child: Image.asset(
                  Constant.ASSETS_IMG + 'mine_feedback_add_image.png',
                  width: double.infinity,
                  height: double.infinity,
                ));
                content = GestureDetector(
                  onTap: () {
                    // 如果已添加了9张图片，则提示不允许添加更多
                    num size = mFileList.length;
                    if (size >= 9) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("最多只能添加9张图片！"),
                      ));
                      return;
                    }
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((result) {
                      setState(() {
                        mSelectedImageFile = result;
                      });
                    });
                  },
                  child: addCell,
                );
              } else {
                // 被选中的图片
                content = Stack(
                  children: <Widget>[
                    Center(
                      child: Image.file(
                        mFileList[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          mFileList.removeAt(index);
                          mSelectedImageFile = null;
                          setState(() {});
                        },
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'mine_feedback_ic_del.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container(
                margin: const EdgeInsets.all(10.0),
                width: 80.0,
                height: 80.0,
                color: const Color(0xFFffffff),
                child: content,
              );
            }),
          )
        ],
      ),
    );
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }

  void _getWH() {
    if (globalKey == null) return;
    if (globalKey.currentContext == null) return;
    if (globalKey.currentContext.size == null) return;
    final containerWidth = globalKey.currentContext.size.width;
    final containerHeight = globalKey.currentContext.size.height;
    print('Container widht is $containerWidth, height is $containerHeight');
  }

  //输入框底部布局
  Widget buildBottom() {
    return Column(
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
                    onTap: () {
                      ImagePicker.pickImage(source: ImageSource.gallery)
                          .then((result) {
                        setState(() {
                          mSelectedImageFile = result;
                        });
                      });
                    },
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
                          //   _mEtController.text = _mEtController.text + "@" + mAtUser.nick+" ";
                          //   print("_mEtControllerfield的值:" + mWeiBoSubmitText);

                          _mEtController.text = _mEtController.text +
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

                          _mEtController.text = _mEtController.text +
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
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_emotion.png',
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
            key: globalKey,
            child: Visibility(
              visible: mEmojiLayoutShow,
              child: EmojiWidget(onEmojiClockBack: (value) {
                if (value == 0) {
                  _mEtController.clear();
                } else {
                  _mEtController.text =
                      _mEtController.text + "[/" + value.toString() + "]";
                }
              }),
            ),
            height: _softKeyHeight,
          ),
        ),
      ],
    );
  }
}
