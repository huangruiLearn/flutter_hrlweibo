import 'dart:io';

import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/toast_util.dart';
import 'package:path/path.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _mEtController = new TextEditingController();
  List<File> mFileList = List();
  File mSelectedImageFile;
  List<MultipartFile> mSubmitFileList = List();

  @override
  Widget build(BuildContext context) {
    print('fileList的内容: $mFileList');
    if (mSelectedImageFile != null) {
      mFileList.add(mSelectedImageFile);
    }
    mSelectedImageFile = null;

    //相机拍照或图库选择照片布局
    _renderBottomMenuItem(title, ImageSource source) {
      var item = Container(
        height: 60.0,
        child: Center(child: Text(title)),
      );
      return InkWell(
        child: item,
        onTap: () {
          Navigator.of(context).pop();
          ImagePicker.pickImage(source: source).then((result) {
            setState(() {
              mSelectedImageFile = result;
              print("执行刷新:");
            });
          });
        },
      );
    }

    //弹出底部选择图片方式弹出框
    Widget _bottomSheetBuilder(BuildContext context) {
      return Container(
          height: 182.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
            child: Column(
              children: <Widget>[
                _renderBottomMenuItem("相机拍照", ImageSource.camera),
                Divider(
                  height: 2.0,
                ),
                _renderBottomMenuItem("图库选择照片", ImageSource.gallery)
              ],
            ),
          ));
    }

    // 选择弹出相机拍照或者从图库选择图片
    pickImage(ctx) {
      // 如果已添加了9张图片，则提示不允许添加更多
      num size = mFileList.length;
      if (size >= 9) {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text("最多只能添加9张图片！"),
        ));
        return;
      }
      showModalBottomSheet<void>(
          context: context, builder: _bottomSheetBuilder);
    }

    //底部布局
    Widget mFootView() {
      return new Container(
        color: Color(0xFFF9F9F9),
        //alignment:new Alignment(x, y)
        child: new Align(
          alignment: FractionalOffset.bottomCenter,
          child: new Padding(
            padding: EdgeInsets.all(10),
            child: new Row(children: <Widget>[
              new Expanded(
                child: InkWell(
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'icon_picture.png',
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
                  onTap: () {},
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
                  onTap: () {},
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
                flex: 1,
              ),
            ]),
          ),
        ),
      );
    }

    //头部布局
    Widget mHeadView() {
      return Container(
        color: Color(0xffFAFAFA),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Text('取消', style: TextStyle(fontSize: 16, color: Colors.black)),
              Expanded(
                  child: Center(
                child: Text('意见反馈',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              )),
              new InkWell(
                child: Text('发送',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                onTap: () {
                  mSubmitFileList.clear();
                  for (int i = 0; i < mFileList.length; i++) {
                    mSubmitFileList.add(MultipartFile.fromFileSync(
                        mFileList.elementAt(i).path));
                  }
                  FormData formData = FormData.fromMap({
                    "description": _mEtController.text,
                    "files": mSubmitFileList
                  });
                  request(ServiceUrl.feedback, formData: formData).then((val) {
                    int code = val['status'];
                    String msg = val['msg'];
                    if (code == 200) {
                      ToastUtil.show('提交成功!');
                      setState(() {
                        mFileList.clear();
                        mSubmitFileList.clear();
                        _mEtController.clear();
                      });
                    } else {
                      ToastUtil.show(msg);
                    }
                  });
                },
              )
            ],
          ),
        ),
      );
    }

    //输入框和九宫格布局
    Widget mBodyView() {
      return Expanded(
        //expande就是listview有多大就有多大,container就是container多大listview就有多大
        child: ListView(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: 150,
              ),
              color: Color(0xffffffff),
              margin: EdgeInsets.only(top: 15),
              child: TextField(
                controller: _mEtController,
                maxLines: 5,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "快说点儿什么吧......",
                  hintStyle: TextStyle(color: Color(0xff999999), fontSize: 16),
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            //getBody()
            GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 3,
              children: List.generate(mFileList.length + 1, (index) {
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
                      // 添加图片
                      pickImage(context);
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

    return SafeArea(
        child: Scaffold(
      body: Container(
          color: Colors.white,
          height: double.maxFinite,
          child: new Column(
            children: <Widget>[
              mHeadView(),
              mBodyView(),
              mFootView(),
            ],
          )),
    ));
  }
}
